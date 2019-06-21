package com.pall.mts.module.tool;

import com.alibaba.excel.ExcelReader;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.alibaba.excel.metadata.BaseRowModel;
import com.alibaba.excel.metadata.Sheet;
import com.alibaba.excel.metadata.Table;
import com.alibaba.excel.support.ExcelTypeEnum;
import com.google.common.io.Files;
import com.pall.mts.repository.entity.dataconfig.TableHeaderConfigEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.thymeleaf.util.StringUtils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;

public class PrintTableHeaderSql {
    private static final Logger logger = LoggerFactory.getLogger(PrintTableHeaderSql.class);
    /**
     * StringList 解析监听器
     */
    private static class StringExcelListener extends AnalysisEventListener {
        /**
         * 自定义用于暂时存储data
         * 可以通过实例获取该值
         */
        private Map<String,List<List<String>>> datas = new HashMap<>();

        /**
         * 每解析一行都会回调invoke()方法
         * @param object
         * @param context
         */
        @Override
        public void invoke(Object object, AnalysisContext context) {
            List<String> stringList= (List<String>) object;
            String sheetName=context.getCurrentSheet().getSheetName();
            sheetName=sheetName.split(" ")[0];
            if(datas.get(sheetName)==null){
                datas.put(sheetName,new ArrayList<List<String>>());
            }
            datas.get(sheetName).add(stringList);
            //数据存储到list，供批量处理，或后续自己业务逻辑处理。
           // datas.add(stringList);
            //根据自己业务做处理
        }

        @Override
        public void doAfterAllAnalysed(AnalysisContext context) {
            //解析结束销毁不用的资源
            //注意不要调用datas.clear(),否则getDatas为null
        }

        public Map<String,List<List<String>>> getDatas() {
            return datas;
        }

        public void setDatas(Map<String,List<List<String>>> datas) {
            this.datas = datas;
        }
    }

    /**
     * 使用 StringList 来读取Excel
     * @param inputStream Excel的输入流
     * @param excelTypeEnum Excel的格式(XLS或XLSX)
     * @return 返回 StringList 的列表
     */
    public static Map<String,List<List<String>>> readExcelWithStringList(InputStream inputStream, ExcelTypeEnum excelTypeEnum) {
        StringExcelListener listener = new StringExcelListener();
        ExcelReader excelReader = new ExcelReader(inputStream, null, listener);
        List<Sheet> sheets=excelReader.getSheets();
        for (Sheet sheet:sheets){
            excelReader.read(sheet);
        }
        return  listener.getDatas();
    }

    /**
     * 使用 StringList 来写入Excel
     * @param outputStream Excel的输出流
     * @param data 要写入的以StringList为单位的数据
     * @param table 配置Excel的表的属性
     * @param excelTypeEnum Excel的格式(XLS或XLSX)
     */
    public static void writeExcelWithStringList(OutputStream outputStream, List<List<String>> data, Table table, ExcelTypeEnum excelTypeEnum) {
        //这里指定不需要表头，因为String通常表头已被包含在data里
        ExcelWriter writer = new ExcelWriter(outputStream, excelTypeEnum,false);
        //写第一个sheet, sheet1  数据全是List<String> 无模型映射关系,无表头
        Sheet sheet1 = new Sheet(0, 0);
        writer.write0(data, sheet1,table);
        writer.finish();
    }
    public static List<TableHeaderConfigEntity> assemblyTableHeader(Map<String,List<List<String>>> datas,int tableMenuid) {
        List<TableHeaderConfigEntity> lists=new ArrayList();
        if(!Objects.isNull(datas)){
            for(String tableName:datas.keySet()){
                if(!Objects.isNull(datas.get(tableName)) && datas.get(tableName).size()>=2){
                    TableHeaderConfigEntity tableHeaderConfigEntity0=null;
                    for(int col=1 ;col<datas.get(tableName).get(1).size();col++){
                        TableHeaderConfigEntity tableHeaderConfigEntity=new TableHeaderConfigEntity();
                        String header1="";
                        String header0="";
                        try{
                            header1=datas.get(tableName).get(1).get(col);
                            header0=datas.get(tableName).get(0).get(col);
                        }catch (Exception e){
                            logger.error("template error:tableName="+tableName+"，header1="+header1+"header0="+header0,e.getCause());
                            continue;
                        }

                        if(StringUtils.isEmpty(header0)){
                            if(!Objects.isNull(tableHeaderConfigEntity0)){
                                tableHeaderConfigEntity0.setCols(tableHeaderConfigEntity0.getCols()+1);
                            }
                        }else{
                            tableHeaderConfigEntity0=new TableHeaderConfigEntity();
                            tableHeaderConfigEntity0.setMenuid(tableMenuid);
                            tableHeaderConfigEntity0.setTableName(tableName);
                            tableHeaderConfigEntity0.setLineNum(1);
                            tableHeaderConfigEntity0.setColNum(col);
                            tableHeaderConfigEntity0.setSort(-1);
                            tableHeaderConfigEntity0.setRows(1);
                            tableHeaderConfigEntity0.setCols(1);
                            tableHeaderConfigEntity0.setDataType(-1);
                            tableHeaderConfigEntity0.setFieldName("");
                            tableHeaderConfigEntity0.setInvisible(0);
                            tableHeaderConfigEntity0.setHeadline(header0);
                            tableHeaderConfigEntity0.setDescription("");
                            lists.add(tableHeaderConfigEntity0);
                        }
                        tableHeaderConfigEntity.setMenuid(tableMenuid);
                        tableHeaderConfigEntity.setTableName(tableName);
                        tableHeaderConfigEntity.setLineNum(2);
                        tableHeaderConfigEntity.setColNum(col);
                        tableHeaderConfigEntity.setSort(-1);
                        tableHeaderConfigEntity.setRows(1);
                        tableHeaderConfigEntity.setCols(1);
                        tableHeaderConfigEntity.setDataType(-1);
                        if(!Objects.isNull(tableHeaderConfigEntity0)){
                            tableHeaderConfigEntity.setFieldName(tableHeaderConfigEntity0.getHeadline()+"|"+header1);
                        }
                        tableHeaderConfigEntity.setInvisible(0);
                        tableHeaderConfigEntity.setHeadline(header1);
                        tableHeaderConfigEntity.setDescription("");
                        lists.add(tableHeaderConfigEntity);
                    }
                }
            }
        }
        return lists;
    }
    public static void printTableHeader(Set<String>tableNames,List<TableHeaderConfigEntity> tableHeaderConfigEntitys,String tableDeleteSql,String tableInsertSql,String downloadFilePath){
        StringBuilder sb=new StringBuilder();
            if(!Objects.isNull(tableNames)){
                for(String tableName:tableNames){
                    sb.append(tableDeleteSql);
                    sb.append("'");
                    sb.append(tableName);
                    sb.append("';\r\n");
                }
            }
        if(!Objects.isNull(tableHeaderConfigEntitys)){
            for(TableHeaderConfigEntity tableHeaderConfigEntity:tableHeaderConfigEntitys){
                sb.append(tableInsertSql);
                sb.append("(");
                sb.append(tableHeaderConfigEntity.getMenuid());
                sb.append(",'");
                sb.append(tableHeaderConfigEntity.getTableName());
                sb.append("',");
                sb.append(tableHeaderConfigEntity.getLineNum());
                sb.append(",");
                sb.append(tableHeaderConfigEntity.getColNum());
                sb.append(",");
                sb.append(tableHeaderConfigEntity.getSort()==-1?"NULL":tableHeaderConfigEntity.getSort());
                sb.append(",");
                sb.append(tableHeaderConfigEntity.getRows());
                sb.append(",");
                sb.append(tableHeaderConfigEntity.getCols());
                sb.append(",");
                sb.append(tableHeaderConfigEntity.getDataType()==-1?"NULL":tableHeaderConfigEntity.getDataType());
                sb.append(",'");
                sb.append(tableHeaderConfigEntity.getFieldName());
                sb.append("',");
                sb.append(tableHeaderConfigEntity.getInvisible());
                sb.append(",'");
                sb.append(tableHeaderConfigEntity.getHeadline());
                sb.append("','");
                sb.append(tableHeaderConfigEntity.getDescription()==null?"":tableHeaderConfigEntity.getDescription());
                sb.append("'");
                sb.append(");\r\n");
            }
        }
        try {
            Files.write(sb.toString().getBytes(),new File(downloadFilePath));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

package com.pall.portal.common.tools;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.ReflectionUtils;

import com.pall.portal.common.support.excel.ExcelDataNode;
import com.pall.portal.common.support.excel.ExcelHeaderNode;
import com.pall.portal.init.TableDataConfigInitiator;

public class ExcelTools {
	/*
	 * 封装Excel数据信息
	 * @param tableName 表格对应的配置表名
	 * @param objEntitys需要遍历的对象信息
	 * @param currentRowNum excel写入记录的行位置
	 * @return 
	 */
	public static Map<Integer,List<ExcelDataNode>> getExcelDatas(String tableName,List<?> objEntitys,int currentRowNum){
		Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
		Map<String,ExcelHeaderNode> fieldNameBindMap=TableDataConfigInitiator.getExcelFieldBindConfig(tableName);
	   	 for(Object objEntity:objEntitys){
	   		 List<ExcelDataNode> excelDataNodes=new ArrayList<ExcelDataNode>();
	   		 Field[] fields= objEntity.getClass().getDeclaredFields();
	   		 for(Field field:fields){
	   			 if(null!=fieldNameBindMap.get(field.getName().toLowerCase())){
	   				 field.setAccessible(true); 
	   				 ExcelDataNode excelDataNode=new ExcelDataNode();
	   				 excelDataNode.setColNum(fieldNameBindMap.get(field.getName().toLowerCase()).getColNum());
	   				 ReflectionUtils.getField(field, objEntity);
	   				 Object obj=ReflectionUtils.getField(field, objEntity);
	   				 excelDataNode.setData(obj==null?"":String.valueOf(obj));
		        		 excelDataNodes.add(excelDataNode);
	   			 }
	   		 }
	   		 rowdatas.put(currentRowNum, excelDataNodes);
	   		 currentRowNum++;
	   	 }
	   	 return rowdatas;
	}
}

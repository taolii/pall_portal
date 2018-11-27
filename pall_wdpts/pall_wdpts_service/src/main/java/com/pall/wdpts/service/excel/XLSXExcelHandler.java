package com.pall.wdpts.service.excel;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Repository;

import com.alibaba.druid.util.StringUtils;
import com.pall.wdpts.common.constants.KeyConstants;
import com.pall.wdpts.common.support.excel.ExcelDataNode;
import com.pall.wdpts.common.support.excel.ExcelHeaderNode;
/*
 * excel 2007以上数据格式处理类
 */
@Repository("xlsxExcelHandler")
public class XLSXExcelHandler implements IExcelHandler{

	@Override
	public Workbook getExcelWorkbook(String sheetName,Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap, Map<Integer,List<ExcelDataNode>> rowdatas) {
		Workbook workbook=getWorkbook();
		XSSFSheet sheet=null;
		if(!StringUtils.isEmpty(sheetName)){
			sheet=(XSSFSheet)workbook.createSheet(sheetName);
		}else{
			sheet=(XSSFSheet)workbook.createSheet();
		}
		//创建Sheet表头
		createTableHeader(workbook,sheet,excelheadlinesMap);
		
		//生成数据行记录信息
		createTableRecord(workbook,sheet,rowdatas);
		return workbook;
	}
	private void setSheetStyle(Workbook workbook,XSSFSheet sheet,String styleType,Set<Integer> rowdatas,int startColNum,int lastColNum){
		CellStyle cellStyle=getCellStyle(workbook,styleType);
		//设置单元格样式
    	for(Integer rownum:rowdatas){
    		//创建行对象
            XSSFRow row = sheet.getRow(rownum-1);
    		for (int j=startColNum-1;j<lastColNum;j++) {
   			 	XSSFCell cell=row.getCell(j);
   			 	if(cell==null)cell=row.createCell(j);
   			 	cell.setCellStyle(cellStyle);
            }
    	}
	}
	@Override
	public CellStyle getCellStyle(Workbook workbook,String cellTypeName) {
		if(workbook==null)workbook=getWorkbook();
		CellStyle configCellStyle=workbook.createCellStyle();
		if(KeyConstants.EXCEL_CELL_STYLE_HEADLINE_CONFIGNAME_XLSX.equals(cellTypeName)){
			configCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		    configCellStyle.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
			configCellStyle.setFillBackgroundColor(HSSFColor.SKY_BLUE.index);
		}
		configCellStyle.setBorderBottom(BorderStyle.valueOf((short)1));
		configCellStyle.setBorderTop(BorderStyle.valueOf((short)1));  
		configCellStyle.setBorderRight(BorderStyle.valueOf((short)1));  
		configCellStyle.setBorderBottom(BorderStyle.valueOf((short)1));  
		configCellStyle.setBorderLeft(BorderStyle.valueOf((short)1));  
				 
		configCellStyle.setAlignment(HorizontalAlignment.CENTER);
		configCellStyle.setBottomBorderColor(HSSFColor.GREEN.index);
		configCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);;
		configCellStyle.setWrapText(true);// 指定单元格自动换行 
		return configCellStyle;
	}

	@Override
	public Workbook getWorkbook() {
		return new XSSFWorkbook();
	}
	/** 
     * 生成表头数据 
     * @param sheet 工作簿 
     * @param excelheadlinesMap 表头对象 
     */  
    private  void createTableHeader(Workbook workbook,XSSFSheet sheet,Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap) {
    	int startColNum=1000;
    	int lastColNum=0;
    	for(Integer rownum:excelheadlinesMap.keySet()){
    		//创建行对象
            XSSFRow row = sheet.createRow(rownum-1);
    		for (ExcelHeaderNode excelHeaderNode:excelheadlinesMap.get(rownum)) {
    			if(startColNum>excelHeaderNode.getColNum()){
    				startColNum=excelHeaderNode.getColNum();
    			}
    			if(lastColNum<excelHeaderNode.getColNum()){
    				lastColNum=excelHeaderNode.getColNum();
    			}
   			 	XSSFCell cell=row.createCell(excelHeaderNode.getColNum()-1);
                cell.setCellValue(excelHeaderNode.getHeadline());
                sheet.setColumnWidth(excelHeaderNode.getColNum()-1, 14*256);  
       			if(excelHeaderNode.getCellspan()>1){
       				for(int j=0;j<excelHeaderNode.getCellspan()-1;j++){
       					cell=row.createCell(excelHeaderNode.getColNum()+j);
       	                cell.setCellValue("");
       				}
       			}
       			if(excelHeaderNode.getCellspan()>1 || excelHeaderNode.getRowspan()>1){
    				CellRangeAddress range=new CellRangeAddress(excelHeaderNode.getRowNum()-1,excelHeaderNode.getRowNum()+excelHeaderNode.getRowspan()-2,excelHeaderNode.getColNum()-1,excelHeaderNode.getColNum()+excelHeaderNode.getCellspan()-2);  
    				sheet.addMergedRegion(range);
    			}
            }
    		
    	}
    	setSheetStyle(workbook,sheet,KeyConstants.EXCEL_CELL_STYLE_HEADLINE_CONFIGNAME_XLSX,excelheadlinesMap.keySet(),startColNum,lastColNum);
    }  
    /** 
     * 生成数据记录信息
     * @param sheet 工作簿 
     * @param rowdatas 行记录信息 
     */  
    private  void createTableRecord(Workbook workbook,XSSFSheet sheet, Map<Integer,List<ExcelDataNode>> rowdatas) {
    	 int startColNum=1000;
     	int lastColNum=0;
        for (Integer rowNum:rowdatas.keySet()) {
        	//创建行对象
            XSSFRow row = sheet.createRow(rowNum);
        	for(ExcelDataNode excelDataNode:rowdatas.get(rowNum)){
        		if(lastColNum<excelDataNode.getColNum()){
    				lastColNum=excelDataNode.getColNum();
    			}
        		if(startColNum>excelDataNode.getColNum()){
    				startColNum=excelDataNode.getColNum();
    			}
                XSSFCell cell=row.createCell(excelDataNode.getColNum()-1);
                if(StringUtils.isEmpty(excelDataNode.getData())){
                	 cell.setCellValue("");
                }else{
                	 cell.setCellValue(excelDataNode.getData());
                }
                //cell.setCellStyle(getCellStyle(workbook,KeyConstants.EXCEL_CELL_STYLE_DATA_CONFIGNAME_XLSX));
        	}
        }
        setSheetStyle(workbook,sheet,KeyConstants.EXCEL_CELL_STYLE_DATA_CONFIGNAME_XLSX,rowdatas.keySet(),startColNum,lastColNum);
    }  
}

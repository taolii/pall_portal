package com.pall.wdpts.service.excel;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFDrawing;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFShape;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Repository;

import com.alibaba.druid.util.StringUtils;
import com.google.common.io.Files;
import com.pall.wdpts.common.constants.KeyConstants;
import com.pall.wdpts.common.support.excel.ExcelHeaderNode;
/*
 * excel 2007以上数据格式处理类
 */
@Repository("xlsxTemplateHandler")
public class XLSXTemplateHandler implements IExcelTemplateHandler{

	@Override
	public Workbook getWorkbook(File targetTemplateFile) throws Exception{
		return WorkbookFactory.create(targetTemplateFile);
	}
	
	@Override
	public File copyExcelTemplate(String sourceTemplateFilePath, String targetFilePath, String targetFileName)
			throws IOException {
		Resource configStyleResource=new ClassPathResource(sourceTemplateFilePath);
		File targetFile=new File(targetFilePath+File.separator+targetFileName);
		Files.copy(configStyleResource.getFile(), targetFile);
		return targetFile;
	}
	@Override
	public Workbook getExcelWorkbook(String sheetName, Map<Integer, List<ExcelHeaderNode>> excelTemplateMap) throws Exception{
		return getExcelWorkbook(new XSSFWorkbook(),sheetName,excelTemplateMap);
	}
	@Override
	public Workbook getExcelWorkbook(Workbook workbook, String sheetName,Map<Integer, List<ExcelHeaderNode>> excelTemplateMap)throws Exception {
		XSSFSheet sheet=null;
		if(!StringUtils.isEmpty(sheetName)){
			sheet=(XSSFSheet)workbook.createSheet(sheetName);
		}else{
			sheet=(XSSFSheet)workbook.createSheet();
		}
		Map<String,Integer> tempMap=createExcelTemplate(workbook,sheet,excelTemplateMap);
		if(null!=tempMap && tempMap.size()>0){
			setExcelStyle(excelTemplateMap,workbook,sheet,tempMap.get("startColNum"),tempMap.get("lastColNum"));
		}
		return workbook;
	}

	@Override
	public Workbook getExcelWorkbook(File targetTemplateFile, String sheetName,
			Map<Integer, List<ExcelHeaderNode>> excelTemplateMap)throws Exception {
		return getExcelWorkbook(getWorkbook(targetTemplateFile),sheetName,excelTemplateMap);
	}
	/*
	 * 根据配置信息，创建excel模板
	 * @param workbook excel对象
	 * @param sheet sheet对象
	 * @param configCellStyle 单元格样式
	 * @param excelTemplateMap excel模板对象信息
	 * @return 
	 */
	private Map<String,Integer> createExcelTemplate(Workbook workbook,XSSFSheet sheet,Map<Integer,List<ExcelHeaderNode>> excelTemplateMap){
		int startColNum=1000;
    	int lastColNum=0;
    	if(excelTemplateMap==null) return null;
    	for(Integer rownum:excelTemplateMap.keySet()){
    		//创建行对象
            XSSFRow row = sheet.createRow(rownum-1);
    		for (ExcelHeaderNode excelHeaderNode:excelTemplateMap.get(rownum)) {
    			if(startColNum>excelHeaderNode.getColNum()){
    				startColNum=excelHeaderNode.getColNum();
    			}
    			if(lastColNum<excelHeaderNode.getColNum()){
    				lastColNum=excelHeaderNode.getColNum();
    			}
   			 	XSSFCell cell=row.createCell(excelHeaderNode.getColNum()-1);
                if(excelHeaderNode.getInvisible()==KeyConstants.EXCEL_INSERT_DAILSWITCH_EXPORT_TYPE && excelHeaderNode.getImageBytes()!=null && excelHeaderNode.getImageBytes().length>0){
                	insertPicture(workbook,sheet,cell,excelHeaderNode.getImageBytes());
				}else{
					cell.setCellValue(excelHeaderNode.getHeadline());
				}
       			if(excelHeaderNode.getCellspan()>1){
       				for(int j=0;j<excelHeaderNode.getCellspan()-1;j++){
       					cell=row.createCell(excelHeaderNode.getColNum()+j);
       	                cell.setCellValue("");
       	                //setCommonCellStyle(workbook,cell);
       				}
       			}
       			if(excelHeaderNode.getCellspan()>1 || excelHeaderNode.getRowspan()>1){
    				CellRangeAddress range=new CellRangeAddress(excelHeaderNode.getRowNum()-1,excelHeaderNode.getRowNum()+excelHeaderNode.getRowspan()-2,excelHeaderNode.getColNum()-1,excelHeaderNode.getColNum()+excelHeaderNode.getCellspan()-2);  
    				sheet.addMergedRegion(range);
    			}
            }
    	}
    	Map<String,Integer> sheetMap=new HashMap<String,Integer>();
    	sheetMap.put("startColNum", startColNum);
    	sheetMap.put("lastColNum", lastColNum);
    	return sheetMap;
	}
	/*
	 * 插入图片信息
	 */
	private void insertPicture(Workbook workbook,XSSFSheet sheet,XSSFCell cell,byte[] byteArray){
		int pictureId = workbook.addPicture(byteArray, XSSFWorkbook.PICTURE_TYPE_PNG);
		XSSFDrawing patriarch = sheet.createDrawingPatriarch();
		XSSFClientAnchor anchor = new XSSFClientAnchor();
		anchor.setCol1(cell.getColumnIndex());
		anchor.setRow1(cell.getRowIndex());
		anchor.setDx1(0);
		anchor.setDy1(0);
		anchor.setDx2(0);
		anchor.setDy2(0);
		Picture pict =patriarch.createPicture(anchor, pictureId); 
		pict.resize(2,1);
	}
	/*
	 * 设置单元格通用样式
	 * @param configCellStyle 样式对象
	 * @param cell 单元格对象
	 * @return 
	 */
	private CellStyle setTemplateCellStyle(Workbook workbook,XSSFCell cell) {
		CellStyle configCellStyle=cell.getCellStyle();
		if(configCellStyle==null){
			configCellStyle=workbook.createCellStyle();
		}
		configCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    configCellStyle.setFillForegroundColor(HSSFColor.SKY_BLUE.index);
		configCellStyle.setFillBackgroundColor(HSSFColor.SKY_BLUE.index);
		setTemplateFont(workbook,configCellStyle);
		cell.setCellStyle(configCellStyle);
		return configCellStyle;
	}
	/*
	 * 设置单元格通用样式
	 * @param configCellStyle 样式对象
	 * @param cell 单元格对象
	 * @return 
	 */
	private void setTemplateFont(Workbook workbook,CellStyle configCellStyle){
		Font font = workbook.createFont();
        font.setFontHeightInPoints((short)24);
        font.setBold(true);
        font.setBoldweight(Font.BOLDWEIGHT_BOLD); 
        configCellStyle.setFont(font);
	}
	/*
	 * 设置单元格通用样式
	 * @param configCellStyle 样式对象
	 * @param cell 单元格对象
	 * @return 
	 */
	private CellStyle setCommonCellStyle(Workbook workbook,XSSFCell cell) {
		CellStyle configCellStyle=workbook.createCellStyle();
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
	/*
	 * 设置Excel模板样式
	 * @param workbook excel对象
	 * @param sheet sheet对象
	 * @param configCellStyle 单元格样式
	 * @param excelTemplateMap excel模板对象信息
	 * @param startColNum excel模板起始列
	 * @param lastColNum excel模板最后列
	 * @return 
	 */
	private void setExcelStyle(Map<Integer,List<ExcelHeaderNode>> excelTemplateMap,Workbook workbook,XSSFSheet sheet, int startColNum,int lastColNum) {
		if(excelTemplateMap==null || sheet==null)return ;
		//设置单元格样式
    	for(Integer rownum:excelTemplateMap.keySet()){
    		//创建行对象
            XSSFRow row = sheet.getRow(rownum-1);
            row.setHeight((short)(30*50));
    		row.setHeightInPoints((float)40);
    		for (int j=startColNum-1;j<lastColNum;j++) {
   			 	XSSFCell cell=row.getCell(j);
   			 	if(cell==null){
   			 		cell=row.createCell(j);
	                cell.setCellValue("");
   			 	}
   			 	cell.setCellStyle(setCommonCellStyle(workbook,cell));
            }
    	}
    	for (int j=startColNum-1;j<lastColNum;j++) {
    		sheet.setColumnWidth(j, 4766);
        }
	}
	
}

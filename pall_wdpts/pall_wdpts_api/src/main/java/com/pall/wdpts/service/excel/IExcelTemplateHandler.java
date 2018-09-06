package com.pall.wdpts.service.excel;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import com.pall.wdpts.common.support.excel.ExcelHeaderNode;
@Service
public interface IExcelTemplateHandler{
	/*
	 * 获取拷贝模板对象到临时下载目录
	 * @param sourceTemplateFilePath 原模板文件路径
	 * @param targetFilePath 目标文件路径
	 * @param targetFileName 目标文件名
	 * @return
	 */
	public File  copyExcelTemplate(String sourceTemplateFilePath,String targetFilePath,String targetFileName) throws IOException;
	/*
	 * 根据目标模板文件获取工作簿
	 * @param targetTemplateFile目标模板文件
	 * @return 
	 */
	public Workbook getWorkbook(File targetTemplateFile)throws Exception;
	/*
	 * 根据模板配置信息获取工作簿
	 * @param sheetName excel sheet名称
	 * @param excelTemplateMap excel模板配置信息
	 * @return 
	 */
	public Workbook getExcelWorkbook(String sheetName,Map<Integer,List<ExcelHeaderNode>> excelTemplateMap)throws Exception;
	/*
	 * 根据模板配置信息获取工作簿
	 * @param workbook excel对象
	 * @param sheetName excel sheet名称
	 * @param excelTemplateMap excel模板配置信息
	 * @return 
	 */
	public Workbook getExcelWorkbook(Workbook workbook,String sheetName,Map<Integer,List<ExcelHeaderNode>> excelTemplateMap)throws Exception;
	/*
	 * 根据模板配置信息获取工作簿
	 * @param targetTemplateFile目标模板文件
	 * @param sheetName excel sheet名称
	 * @param excelTemplateMap excel模板配置信息
	 * @return 
	 */
	public Workbook getExcelWorkbook(File targetTemplateFile,String sheetName,Map<Integer,List<ExcelHeaderNode>> excelTemplateMap)throws Exception;
}

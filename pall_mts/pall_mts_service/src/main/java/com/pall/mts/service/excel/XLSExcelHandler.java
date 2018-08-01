package com.pall.mts.service.excel;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Repository;

import com.pall.mts.common.support.excel.ExcelDataNode;
import com.pall.mts.common.support.excel.ExcelHeaderNode;
import com.pall.mts.init.CellStyleConfigInitiator;
import com.pall.mts.service.excel.IExcelHandler;
/*
 * excel 2007以下数据格式处理类
 */
@Repository("xlsExcelHandler")
public class XLSExcelHandler implements IExcelHandler{

	@Override
	public Workbook getExcelWorkbook(String sheetName,Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap, Map<Integer,List<ExcelDataNode>> rowdatas) {
		
		return null;
	}

	@Override
	public CellStyle getCellStyle(Workbook workbook, String cellTypeName) {
		if(workbook==null)workbook=getWorkbook();
		
		return CellStyleConfigInitiator.getCellStyle(cellTypeName, workbook.createCellStyle(), workbook.createFont());
	}

	@Override
	public Workbook getWorkbook() {
		return new HSSFWorkbook();
	}

	
}

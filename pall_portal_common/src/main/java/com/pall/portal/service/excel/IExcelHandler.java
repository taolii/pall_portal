package com.pall.portal.service.excel;

import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import com.pall.portal.common.support.excel.ExcelDataNode;
import com.pall.portal.common.support.excel.ExcelHeaderNode;
@Service
public interface IExcelHandler {
	/*
	 * 根据数据源生成excel
	 * @param sheetName sheet名称
	 * @param excelheadlinesMap excel标题头数据
	 * @param rowdatas excel行记录信息
	 * @return
	 */
	public Workbook getExcelWorkbook(String sheetName,Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap,Map<Integer,List<ExcelDataNode>> rowdatas);
	/*
	 * 获取单元格样式
	 * @param Workbook 工作簿对象
	 * @param cellTypeName 样式类型名 (头部样式名:headline和数据记录名 data)
	 * @return
	 */
	public CellStyle getCellStyle(Workbook workbook,String cellTypeName);
	/*
	 * 获取工作簿对象
	 */
	public Workbook getWorkbook();
}

package com.pall.mts.common.support.excel;

public class ExcelHeaderNode implements Comparable<ExcelHeaderNode>{
	/*
	 * 列号
	 */
    private int colNum;
    /*
	 * 行号
	 */
    private int rowNum;
    /*
     * 标题名
     */
    private String headline;
    /*
     * 占用行
     */
    private int rowspan;
    /*
     * 占用列
     */
    private int cellspan;
    /*
     * 属性名
     */
    private String fieldName;
    /*
     * 缺损类型
     */
    private int defectType;
    /*
	 * 是否可见
	 */
	private int invisible;
    /*
     * 单元格样式
     */
	public int getColNum() {
		return colNum;
	}
	public void setColNum(int colNum) {
		this.colNum = colNum;
	}
	public int getRowNum() {
		return rowNum;
	}
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
	public String getHeadline() {
		return headline;
	}
	public void setHeadline(String headline) {
		this.headline = headline;
	}
	public int getRowspan() {
		return rowspan;
	}
	public void setRowspan(int rowspan) {
		this.rowspan = rowspan;
	}
	public int getCellspan() {
		return cellspan;
	}
	public void setCellspan(int cellspan) {
		this.cellspan = cellspan;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	
	public int getInvisible() {
		return invisible;
	}
	public void setInvisible(int invisible) {
		this.invisible = invisible;
	}
	
	public int getDefectType() {
		return defectType;
	}
	public void setDefectType(int defectType) {
		this.defectType = defectType;
	}
	public int compareTo(ExcelHeaderNode  excelHeaderNode) {
		/*
		 * 行比较
		 */
		if(this.getRowNum()>excelHeaderNode.getRowNum()){
			return 1;
		}else if(this.getRowNum()<excelHeaderNode.getRowNum()){
			return -1;
		}else{
			/*
			 * 行相同比较列
			 */
			if(this.getColNum()>excelHeaderNode.getColNum()){
				return 1;
			}else if(this.getColNum()<excelHeaderNode.getColNum()){
				return -1;
			}else{
				return 0;
			}
		}
		
	}
 }  

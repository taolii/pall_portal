package com.pall.mts.repository.entity.dataconfig;

public class TableHeaderConfigEntity implements Comparable<TableHeaderConfigEntity> {
	/*
	 * 菜单id
	 */
	private int menuid;
	/*
	 * 表名
	 */
	private String tableName;
	/*
	 * 行号
	 */
	private int lineNum;
	/*
	 * 列号
	 */
	private int colNum;
	/*
	 * 标题占用行数
	 */
	private int rows;
	/*
	 * 标题占用列数
	 */
	private int cols;
	/*
	 * 同行同列标题的顺序
	 */
	private int sort;
	/*
	 * 数据类型 标题动态配置信息，来源于数据字典配置表
	 */
	private int dataid;
	/*
     * 缺损类型
     */
    private int dataType;
	/*
	 * 绑定对象属性名
	 */
	private String fieldName;
	/*
	 * 是否可见
	 */
	private int invisible;
	/*
	 * 标题名
	 */
	private String headline;
	/*
	 * 描述
	 */
	private String description;
	public int getMenuid() {
		return menuid;
	}
	public void setMenuid(int menuid) {
		this.menuid = menuid;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public int getLineNum() {
		return lineNum;
	}
	public void setLineNum(int lineNum) {
		this.lineNum = lineNum;
	}
	public int getColNum() {
		return colNum;
	}
	public void setColNum(int colNum) {
		this.colNum = colNum;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getCols() {
		return cols;
	}
	public void setCols(int cols) {
		this.cols = cols;
	}
	
	public int getDataid() {
		return dataid;
	}
	public void setDataid(int dataid) {
		this.dataid = dataid;
	}
	public String getHeadline() {
		return headline;
	}
	public void setHeadline(String headline) {
		this.headline = headline;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	
	public int getDataType() {
		return dataType;
	}
	public void setDataType(int dataType) {
		this.dataType = dataType;
	}
	public int compareTo(TableHeaderConfigEntity  tableHeaderConfig) {
		/*
		 * 行比较
		 */
		if(this.getLineNum()>tableHeaderConfig.getLineNum()){
			return 1;
		}else if(this.getLineNum()<tableHeaderConfig.getLineNum()){
			return -1;
		}else{
			/*
			 * 行相同比较列
			 */
			if(this.getColNum()>tableHeaderConfig.getColNum()){
				return 1;
			}else if(this.getColNum()<tableHeaderConfig.getColNum()){
				return -1;
			}else{
				/*
				 * 列相同看排序结果
				 */
				if(this.sort>tableHeaderConfig.getSort()){
					return 1;
				}else if(this.sort<tableHeaderConfig.getSort()){
					return -1;
				}else{
					/*
					 * 排序相同，则根据dataid排序
					 */
					if(this.dataid>tableHeaderConfig.getDataid()){
						return 1;
					}else if(this.dataid<tableHeaderConfig.getDataid()){
						return -1;
					}else{
						return 0;
					}
				}
			}
		}
		
	}
}

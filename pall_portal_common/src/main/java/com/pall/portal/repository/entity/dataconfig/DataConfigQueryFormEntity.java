package com.pall.portal.repository.entity.dataconfig;
/*
 * 用户列表查询对象
 */
public class DataConfigQueryFormEntity {
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	/*
	 * 每页记录数
	 */
	private int pageSize;
	/*
	 * 配置名称
	 */
	private String configName;
	/*
	 * 数据类型 1 抛光缺损信息
	 */
	private int dataType;
	public int getStartPageNum() {
		return startPageNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public int getDataType() {
		return dataType;
	}
	public void setDataType(int dataType) {
		this.dataType = dataType;
	}
	public int getDraw() {
		return draw;
	}
	public void setDraw(int draw) {
		this.draw = draw;
	}
	public String getConfigName() {
		return configName;
	}
	public void setConfigName(String configName) {
		this.configName = configName;
	}
	
}

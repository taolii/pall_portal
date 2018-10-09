package com.pall.wdpts.repository.entity.trackinglist;
/*
 * 水箱装配配置查询对象
 */
public class CisternSettingFormQueryEntity {
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
	 * 料号/PN
	 */
	private String cisternPn;
	private String csid;
	public int getStartPageNum() {
		return startPageNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	public int getDraw() {
		return draw;
	}
	public void setDraw(int draw) {
		this.draw = draw;
	}
	public String getCisternPn() {
		return cisternPn;
	}
	public void setCisternPn(String cisternPn) {
		this.cisternPn = cisternPn;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getCsid() {
		return csid;
	}
	public void setCsid(String csid) {
		this.csid = csid;
	}
	
}

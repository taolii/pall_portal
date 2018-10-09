package com.pall.wdpts.repository.entity.trackinglist;
/*
 * Dsp装配配置查询对象
 */
public class DspSettingFormQueryEntity {
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
	private String dspPn;
	private String dsid;
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
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getDspPn() {
		return dspPn;
	}
	public void setDspPn(String dspPn) {
		this.dspPn = dspPn;
	}
	public String getDsid() {
		return dsid;
	}
	public void setDsid(String dsid) {
		this.dsid = dsid;
	}
	
	
}

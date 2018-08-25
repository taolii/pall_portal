package com.pall.wdpts.repository.entity.trackinglist;
/*
 * 预处理装配配置查询对象
 */
public class PreprocessingSettingFormQueryEntity {
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
	private String preprocessingPn;
	private String psid;
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
	public String getPreprocessingPn() {
		return preprocessingPn;
	}
	public void setPreprocessingPn(String preprocessingPn) {
		this.preprocessingPn = preprocessingPn;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getPsid() {
		return psid;
	}
	public void setPsid(String psid) {
		this.psid = psid;
	}
	
}

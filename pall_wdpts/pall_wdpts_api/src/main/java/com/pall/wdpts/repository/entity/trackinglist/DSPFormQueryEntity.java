package com.pall.wdpts.repository.entity.trackinglist;
/*
 * DSP装配查询对象
 */
public class DSPFormQueryEntity {
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	/*
	 * DSP装配流程跟踪单唯一标示
	 */
	private String dspID;
	/*
	 * 装配日期
	 */
	private String startAssembleTime;
	/*
	 * 装配日期
	 */
	private String endAssembleTime;
	/*
	 * 型号/PN
	 */
	private String dspPn;
	/*
	 * 序列号/Serial NO
	 */
	private String serialNo;
	/*
	 * 工单号/WO
	 */
	private String workorderNo;
	/*
	 * DSP型号/Model
	 */
	private String dspModel;
	/*
	 * 每页记录数
	 */
	private int pageSize;
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
	public String getStartAssembleTime() {
		return startAssembleTime;
	}
	public void setStartAssembleTime(String startAssembleTime) {
		this.startAssembleTime = startAssembleTime;
	}
	public String getEndAssembleTime() {
		return endAssembleTime;
	}
	public void setEndAssembleTime(String endAssembleTime) {
		this.endAssembleTime = endAssembleTime;
	}
	public String getDspPn() {
		return dspPn;
	}
	public void setDspPn(String dspPn) {
		this.dspPn = dspPn;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getWorkorderNo() {
		return workorderNo;
	}
	public void setWorkorderNo(String workorderNo) {
		this.workorderNo = workorderNo;
	}
	public String getDspModel() {
		return dspModel;
	}
	public void setDspModel(String dspModel) {
		this.dspModel = dspModel;
	}
	public String getDspID() {
		return dspID;
	}
	public void setDspID(String dspID) {
		this.dspID = dspID;
	}
	
}

package com.pall.portal.repository.entity.workflow;

/*
 * 化学镀膜APS查询对象
 */
public class PlatedFilmQueryFormEntity {
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
	 * 涂层日期
	 */
	private String coatingTime;
	/*
	 * 镀膜日期
	 */
	private String pfTime;
	/*
	 * input LOT#
	 */
	private String inputLotNum;
	/*
	 * 光纤的料号及批次号,Fixture#
	 */
	private String fixtureNum;
	/*
	 * 哪一瓶化学溶剂 APS Bottle
	 */
	private String apsBottle;
	/*
	 * Output LOT#
	 */
	private String outputLotNum;
	
	/*
	 * 零件号
	 */
	private String partNum;
	/*
	 * 工单号
	 */
	private String workOrderNum;
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
	public String getCoatingTime() {
		return coatingTime;
	}
	public void setCoatingTime(String coatingTime) {
		this.coatingTime = coatingTime;
	}
	public String getPfTime() {
		return pfTime;
	}
	public void setPfTime(String pfTime) {
		this.pfTime = pfTime;
	}
	public String getInputLotNum() {
		return inputLotNum;
	}
	public void setInputLotNum(String inputLotNum) {
		this.inputLotNum = inputLotNum;
	}
	public String getFixtureNum() {
		return fixtureNum;
	}
	public void setFixtureNum(String fixtureNum) {
		this.fixtureNum = fixtureNum;
	}
	public String getApsBottle() {
		return apsBottle;
	}
	public void setApsBottle(String apsBottle) {
		this.apsBottle = apsBottle;
	}
	public String getOutputLotNum() {
		return outputLotNum;
	}
	public void setOutputLotNum(String outputLotNum) {
		this.outputLotNum = outputLotNum;
	}
	public String getPartNum() {
		return partNum;
	}
	public void setPartNum(String partNum) {
		this.partNum = partNum;
	}
	public String getWorkOrderNum() {
		return workOrderNum;
	}
	public void setWorkOrderNum(String workOrderNum) {
		this.workOrderNum = workOrderNum;
	}
	
}

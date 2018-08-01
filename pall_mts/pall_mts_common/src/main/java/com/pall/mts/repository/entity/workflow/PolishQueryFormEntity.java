package com.pall.mts.repository.entity.workflow;

/*
 * 抛光查询对象
 */
public class PolishQueryFormEntity {
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
	 * 唯一标示
	 */
	private String polishID;
	/*
	 * 领料日期
	 */
	private String pickingTime;
	/*
	 * 抛光时间
	 */
	private String polishTime;
	/*
	 * 抛光时间
	 */
	private String startPolishTime;
	/*
	 * 抛光时间
	 */
	private String endPolishTime;
	/*
	 * 供应商来料LOT#
	 */
	private String inputLotNum;
	/*
	 * polish 完成后产生的LOT#
	 */
	private String polishLotNum;
	/*
	 * 光纤的料号及批次号
	 */
	private String fixtureNumber;
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
	public String getPickingTime() {
		return pickingTime;
	}
	public void setPickingTime(String pickingTime) {
		this.pickingTime = pickingTime;
	}
	public String getPolishTime() {
		return polishTime;
	}
	public void setPolishTime(String polishTime) {
		this.polishTime = polishTime;
	}
	public String getInputLotNum() {
		return inputLotNum;
	}
	public void setInputLotNum(String inputLotNum) {
		this.inputLotNum = inputLotNum;
	}
	public String getFixtureNumber() {
		return fixtureNumber;
	}
	public void setFixtureNumber(String fixtureNumber) {
		this.fixtureNumber = fixtureNumber;
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
	public String getStartPolishTime() {
		return startPolishTime;
	}
	public void setStartPolishTime(String startPolishTime) {
		this.startPolishTime = startPolishTime;
	}
	public String getEndPolishTime() {
		return endPolishTime;
	}
	public void setEndPolishTime(String endPolishTime) {
		this.endPolishTime = endPolishTime;
	}
	public String getPolishID() {
		return polishID;
	}
	public void setPolishID(String polishID) {
		this.polishID = polishID;
	}
	public String getPolishLotNum() {
		return polishLotNum;
	}
	public void setPolishLotNum(String polishLotNum) {
		this.polishLotNum = polishLotNum;
	}
	
}

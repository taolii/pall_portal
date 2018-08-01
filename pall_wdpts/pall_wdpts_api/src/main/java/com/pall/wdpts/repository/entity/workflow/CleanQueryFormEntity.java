package com.pall.wdpts.repository.entity.workflow;

/*
 * 清洁查询对象
 */
public class CleanQueryFormEntity {
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
	private String cleanID;
	/*
	 * 清洁日期
	 */
	private String cleanTime;
	/*
	 * 清洁日期
	 */
	private String startCleanTime;
	/*
	 * 清洁日期
	 */
	private String endCleanTime;
	/*
	 * Clean LOT#
	 */
	private String cleanLotNum;
	
	/*
	 * 零件号
	 */
	private String partNum;
	/*
	 * 光纤的料号及批次号
	 */
	private String fixtureNumber;
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
	public String getCleanTime() {
		return cleanTime;
	}
	public void setCleanTime(String cleanTime) {
		this.cleanTime = cleanTime;
	}
	public String getCleanLotNum() {
		return cleanLotNum;
	}
	public void setCleanLotNum(String cleanLotNum) {
		this.cleanLotNum = cleanLotNum;
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
	public String getStartCleanTime() {
		return startCleanTime;
	}
	public void setStartCleanTime(String startCleanTime) {
		this.startCleanTime = startCleanTime;
	}
	public String getEndCleanTime() {
		return endCleanTime;
	}
	public void setEndCleanTime(String endCleanTime) {
		this.endCleanTime = endCleanTime;
	}
	public String getCleanID() {
		return cleanID;
	}
	public void setCleanID(String cleanID) {
		this.cleanID = cleanID;
	}
	public String getFixtureNumber() {
		return fixtureNumber;
	}
	public void setFixtureNumber(String fixtureNumber) {
		this.fixtureNumber = fixtureNumber;
	}
	
}

package com.pall.wdpts.repository.entity.report;

/*
 * 组装报废汇总查询对象
 */
public class AssemblyScrapSummaryQueryFormEntity {
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
	 * 交付日期
	 */
	private String startDeliveryTime;
	private String endDeliveryTime;
	
	/*
	 * Output LOT#
	 */
	private String outputLotNum;
	/*
	 * 光纤的料号及批次号,Fixture#
	 */
	private String fixtureNum;
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
	public String getStartDeliveryTime() {
		return startDeliveryTime;
	}
	public void setStartDeliveryTime(String startDeliveryTime) {
		this.startDeliveryTime = startDeliveryTime;
	}
	public String getEndDeliveryTime() {
		return endDeliveryTime;
	}
	public void setEndDeliveryTime(String endDeliveryTime) {
		this.endDeliveryTime = endDeliveryTime;
	}
	public String getOutputLotNum() {
		return outputLotNum;
	}
	public void setOutputLotNum(String outputLotNum) {
		this.outputLotNum = outputLotNum;
	}
	public String getFixtureNum() {
		return fixtureNum;
	}
	public void setFixtureNum(String fixtureNum) {
		this.fixtureNum = fixtureNum;
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

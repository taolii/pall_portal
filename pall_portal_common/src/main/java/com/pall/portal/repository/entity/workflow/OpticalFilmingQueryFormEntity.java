package com.pall.portal.repository.entity.workflow;

/*
 * 光学镀膜查询对象
 */
public class OpticalFilmingQueryFormEntity {
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	/*
	 * 每页记录数
	 */
	private int pageSize;
	private String opfID;
	/*
	 * 镀膜日期
	 */
	private String startOptTime;
	/*
	 * 镀膜日期
	 */
	private String endOptTime;
	/*
	 * 镀膜日期
	 */
	private String optTime;
	/*
	 * input LOT#
	 */
	private String inputLotNum;
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
	 * 供应商信息
	 */
	private String supplier;
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
	public String getOptTime() {
		return optTime;
	}
	public void setOptTime(String optTime) {
		this.optTime = optTime;
	}
	public String getInputLotNum() {
		return inputLotNum;
	}
	public void setInputLotNum(String inputLotNum) {
		this.inputLotNum = inputLotNum;
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
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	public String getStartOptTime() {
		return startOptTime;
	}
	public void setStartOptTime(String startOptTime) {
		this.startOptTime = startOptTime;
	}
	public String getEndOptTime() {
		return endOptTime;
	}
	public void setEndOptTime(String endOptTime) {
		this.endOptTime = endOptTime;
	}
	public String getOpfID() {
		return opfID;
	}
	public void setOpfID(String opfID) {
		this.opfID = opfID;
	}
	
}

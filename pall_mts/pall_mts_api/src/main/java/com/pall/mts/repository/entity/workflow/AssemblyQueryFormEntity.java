package com.pall.mts.repository.entity.workflow;

/*
 * 光学镀膜查询对象
 */
public class AssemblyQueryFormEntity {
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
	private String assemblyID;
	private String filterTrayLotNum;
	/*
	 * TRAY#
	 */
	private String trayLotNum;
	/*
	 * HUB#
	 */
	private String hubLotNum;
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
	 * 工单号
	 */
	private String workOrderNum;
	/*
	 * drop down T01….T17  是TRAY#
	 */
	private String remark;
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
	public String getTrayLotNum() {
		return trayLotNum;
	}
	public void setTrayLotNum(String trayLotNum) {
		this.trayLotNum = trayLotNum;
	}
	public String getHubLotNum() {
		return hubLotNum;
	}
	public void setHubLotNum(String hubLotNum) {
		this.hubLotNum = hubLotNum;
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getAssemblyID() {
		return assemblyID;
	}
	public void setAssemblyID(String assemblyID) {
		this.assemblyID = assemblyID;
	}
	public String getFilterTrayLotNum() {
		return filterTrayLotNum;
	}
	public void setFilterTrayLotNum(String filterTrayLotNum) {
		this.filterTrayLotNum = filterTrayLotNum;
	}
	
}

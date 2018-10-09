package com.pall.wdpts.repository.entity.trackinglist;
/*
 * 水箱装配查询对象
 */
public class CisternFormQueryEntity {
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
	 * 水箱装配流程跟踪单唯一标示
	 */
	private String cisternID;
	/*
	 * 装配日期
	 */
	private String startAssembleTime;
	/*
	 * 装配日期
	 */
	private String endAssembleTime;
	/*
	 * 料号/PN
	 */
	private String cisternPn;
	/*
	 * 序列号/Serial NO
	 */
	private String serialNo;
	/*
	 * 工单号/WO
	 */
	private String workorderNo;
	/*
	 * 水箱型号/Model
	 */
	private String cisternModel;
	/*
	 * 组件名称
	 */
	private String componentName;
	/*
	 * 组件型号
	 */
	private String componentNo;
	/*
	 * 客户订单信息
	 */
	private String cOrderID;
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
	public String getCisternID() {
		return cisternID;
	}
	public void setCisternID(String cisternID) {
		this.cisternID = cisternID;
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
	public String getCisternPn() {
		return cisternPn;
	}
	public void setCisternPn(String cisternPn) {
		this.cisternPn = cisternPn;
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
	public String getCisternModel() {
		return cisternModel;
	}
	public void setCisternModel(String cisternModel) {
		this.cisternModel = cisternModel;
	}
	public String getComponentName() {
		return componentName;
	}
	public void setComponentName(String componentName) {
		this.componentName = componentName;
	}
	public String getComponentNo() {
		return componentNo;
	}
	public void setComponentNo(String componentNo) {
		this.componentNo = componentNo;
	}
	public String getcOrderID() {
		return cOrderID;
	}
	public void setcOrderID(String cOrderID) {
		this.cOrderID = cOrderID;
	}
	
}
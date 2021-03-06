package com.pall.wdpts.repository.entity.trackinglist;
/*
 * 主机装配查询对象
 */
public class MainframeFormQueryEntity {
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	/*
	 * 主机装配流程跟踪单唯一标示
	 */
	private String mainframeID;
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
	private String mainframePn;
	/*
	 * 序列号/Serial NO
	 */
	private String serialNo;
	/*
	 * 工单号/WO
	 */
	private String workorderNo;
	/*
	 * 主机型号/Model
	 */
	private String mainframeModel;
	/*
	 * 组件名称
	 */
	private String componentName;
	/*
	 * 组件型号
	 */
	private String componentNo;
	/*
	 * 序列号记录
	 */
	private String serialNoRecord;
	/*
	 * 自检名称
	 */
	private String selfcheckName;
	/*
	 * 自检内容
	 */
	private String selfcheckContent;
	/*
	 * 客户订单信息
	 */
	private String cOrderID;
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
	public String getMainframeID() {
		return mainframeID;
	}
	public void setMainframeID(String mainframeID) {
		this.mainframeID = mainframeID;
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
	public String getMainframePn() {
		return mainframePn;
	}
	public void setMainframePn(String mainframePn) {
		this.mainframePn = mainframePn;
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
	public String getMainframeModel() {
		return mainframeModel;
	}
	public void setMainframeModel(String mainframeModel) {
		this.mainframeModel = mainframeModel;
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
	public String getSelfcheckName() {
		return selfcheckName;
	}
	public void setSelfcheckName(String selfcheckName) {
		this.selfcheckName = selfcheckName;
	}
	public String getSelfcheckContent() {
		return selfcheckContent;
	}
	public void setSelfcheckContent(String selfcheckContent) {
		this.selfcheckContent = selfcheckContent;
	}
	public String getcOrderID() {
		return cOrderID;
	}
	public void setcOrderID(String cOrderID) {
		this.cOrderID = cOrderID;
	}
	public String getSerialNoRecord() {
		return serialNoRecord;
	}
	public void setSerialNoRecord(String serialNoRecord) {
		this.serialNoRecord = serialNoRecord;
	}
	
	
}

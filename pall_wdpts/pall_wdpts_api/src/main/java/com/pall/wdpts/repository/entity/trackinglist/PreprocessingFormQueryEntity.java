package com.pall.wdpts.repository.entity.trackinglist;
/*
 * 预处理装配查询对象
 */
public class PreprocessingFormQueryEntity {
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	/*
	 * 预处理装配流程跟踪单唯一标示
	 */
	private String preprocessingID;
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
	private String preprocessingPn;
	/*
	 * 序列号/Serial NO
	 */
	private String serialNo;
	/*
	 * 工单号/WO
	 */
	private String workorderNo;
	/*
	 * 名称/Model
	 */
	private String preprocessingModel;
	/*
	 * 组件名称
	 */
	private String componentName;
	/*
	 * 组件型号
	 */
	private String componentNo;
	/*
	 * 自检名称
	 */
	private String selfcheckName;
	/*
	 * 自检内容
	 */
	private String selfcheckContent;
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
	public String getPreprocessingID() {
		return preprocessingID;
	}
	public void setPreprocessingID(String preprocessingID) {
		this.preprocessingID = preprocessingID;
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
	public String getPreprocessingPn() {
		return preprocessingPn;
	}
	public void setPreprocessingPn(String preprocessingPn) {
		this.preprocessingPn = preprocessingPn;
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
	public String getPreprocessingModel() {
		return preprocessingModel;
	}
	public void setPreprocessingModel(String preprocessingModel) {
		this.preprocessingModel = preprocessingModel;
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
	
}

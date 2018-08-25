package com.pall.wdpts.repository.entity.trackinglist;

import java.util.List;

/*
 * 主机装配对象
 */
public class MainframeEntity {
	/*
	 * 主机装配流程跟踪单唯一标示
	 */
	private String mainframeID;
	/*
	 * 装配日期
	 */
	private String assembleTime;
	/*
	 * 生产时间
	 */
	private String productionTime;
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
	 * 主机选配件/Option
	 */
	private String mainframeOption;
	/*
	 * 装配记录
	 */
	private List<MainframeAssembleEntity> assembleRecords;
	/*
	 * 送检记录
	 */
	private List<MainframeInspectEntity> inspectRecords;
	/*
	 * 异常记录
	 */
	private String exceptionRecord;
	/*
	 * 备注
	 */
	private String remarks;
	/*
	 * 送检人员
	 */
	private String inspectOperator;
	/*
	 * 送检日期
	 */
	private String inspectTime;
	/*
	 * 装配人员
	 */
	private String assembleOperator;
	/*
	 * 录入时间
	 */
	private String inputTime;
	/*
	 * 更新时间
	 */
	private String updateTime;
	/*
	 * 操作员id
	 */
	private Integer operatorid;
	/*
	 * 操作员名称
	 */
	private String operatorName;
	public String getMainframeID() {
		return mainframeID;
	}
	public void setMainframeID(String mainframeID) {
		this.mainframeID = mainframeID;
	}
	public String getAssembleTime() {
		return assembleTime;
	}
	public void setAssembleTime(String assembleTime) {
		this.assembleTime = assembleTime;
	}
	public String getProductionTime() {
		return productionTime;
	}
	public void setProductionTime(String productionTime) {
		this.productionTime = productionTime;
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
	public String getMainframeOption() {
		return mainframeOption;
	}
	public void setMainframeOption(String mainframeOption) {
		this.mainframeOption = mainframeOption;
	}
	public List<MainframeAssembleEntity> getAssembleRecords() {
		return assembleRecords;
	}
	public void setAssembleRecords(List<MainframeAssembleEntity> assembleRecords) {
		this.assembleRecords = assembleRecords;
	}
	public List<MainframeInspectEntity> getInspectRecords() {
		return inspectRecords;
	}
	public void setInspectRecords(List<MainframeInspectEntity> inspectRecords) {
		this.inspectRecords = inspectRecords;
	}
	public String getExceptionRecord() {
		return exceptionRecord;
	}
	public void setExceptionRecord(String exceptionRecord) {
		this.exceptionRecord = exceptionRecord;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getInspectOperator() {
		return inspectOperator;
	}
	public void setInspectOperator(String inspectOperator) {
		this.inspectOperator = inspectOperator;
	}
	public String getInspectTime() {
		return inspectTime;
	}
	public void setInspectTime(String inspectTime) {
		this.inspectTime = inspectTime;
	}
	public String getAssembleOperator() {
		return assembleOperator;
	}
	public void setAssembleOperator(String assembleOperator) {
		this.assembleOperator = assembleOperator;
	}
	public String getInputTime() {
		return inputTime;
	}
	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(Integer operatorid) {
		this.operatorid = operatorid;
	}
	public String getOperatorName() {
		return operatorName;
	}
	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

}

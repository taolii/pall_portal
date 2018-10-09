package com.pall.wdpts.repository.entity.trackinglist;

import java.util.List;

/*
 * 水箱装配对象
 */
public class CisternEntity {
	/*
	 * 水箱装配流程跟踪单唯一标示
	 */
	private Integer cisternID;
	/*
	 * 装配日期
	 */
	private String assembleTime;
	/*
	 * 生产时间
	 */
	private String productionTime;
	/*
	 * 客户订单信息
	 */
	private String cOrderID;
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
	 * 水箱选配件/Options
	 */
	private String cisternOption;
	/*
	 * 水箱选配件/Options
	 */
	private String cisternOption2;
	private String cisternOptions;
	/*
	 * 装配记录
	 */
	private List<CisternAssembleEntity> assembleRecords;
	/*
	 * 异常记录
	 */
	private String exceptionRecord;
	/*
	 * 备注
	 */
	private String remarks;
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
	
	public Integer getCisternID() {
		return cisternID;
	}
	public void setCisternID(Integer cisternID) {
		this.cisternID = cisternID;
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
	
	public List<CisternAssembleEntity> getAssembleRecords() {
		return assembleRecords;
	}
	public void setAssembleRecords(List<CisternAssembleEntity> assembleRecords) {
		this.assembleRecords = assembleRecords;
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
	public String getcOrderID() {
		return cOrderID;
	}
	public void setcOrderID(String cOrderID) {
		this.cOrderID = cOrderID;
	}
	public String getCisternOption() {
		return cisternOption;
	}
	public void setCisternOption(String cisternOption) {
		this.cisternOption = cisternOption;
	}
	public String getCisternOption2() {
		return cisternOption2;
	}
	public void setCisternOption2(String cisternOption2) {
		this.cisternOption2 = cisternOption2;
	}
	public String getCisternOptions() {
		return cisternOptions;
	}
	public void setCisternOptions(String cisternOptions) {
		this.cisternOptions = cisternOptions;
	}
	
}

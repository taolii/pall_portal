package com.pall.wdpts.repository.entity.trackinglist;

import java.util.List;

/*
 * Dsp装配对象
 */
public class DspEntity {
	/*
	 * Dsp装配流程跟踪单唯一标示
	 */
	private Integer dspID;
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
	 * 型号/PN
	 */
	private String dspPn;
	/*
	 * 序列号/Serial NO
	 */
	private String serialNo;
	/*
	 * 工单号/WO
	 */
	private String workorderNo;
	/*
	 * Dsp型号/Model
	 */
	private String dspModel;
	/*
	 * 装配记录
	 */
	private List<DspAssembleEntity> assembleRecords;
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
	
	public Integer getDspID() {
		return dspID;
	}
	public void setDspID(Integer dspID) {
		this.dspID = dspID;
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
	public String getDspPn() {
		return dspPn;
	}
	public void setDspPn(String dspPn) {
		this.dspPn = dspPn;
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
	public String getDspModel() {
		return dspModel;
	}
	public void setDspModel(String dspModel) {
		this.dspModel = dspModel;
	}
	public List<DspAssembleEntity> getAssembleRecords() {
		return assembleRecords;
	}
	public void setAssembleRecords(List<DspAssembleEntity> assembleRecords) {
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
	
}

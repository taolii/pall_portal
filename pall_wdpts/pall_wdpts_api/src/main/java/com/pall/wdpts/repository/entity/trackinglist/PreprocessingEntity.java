package com.pall.wdpts.repository.entity.trackinglist;

import java.util.List;

/*
 * 预处理装配对象
 */
public class PreprocessingEntity {
	/*
	 * 预处理装配流程跟踪单唯一标示
	 */
	private Integer preprocessingID;
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
	 * PT选配件/Option
	 */
	private String ptOptions;
	/*
	 * PT选配件/Option
	 */
	private String ptOption;
	/*
	 * PT选配件/Option
	 */
	private String ptOption2;
	/*
	 * 装配记录
	 */
	private List<PreprocessingAssembleEntity> assembleRecords;
	/*
	 * 送检记录
	 */
	private List<PreprocessingInspectEntity> inspectRecords;
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
	
	public Integer getPreprocessingID() {
		return preprocessingID;
	}
	public void setPreprocessingID(Integer preprocessingID) {
		this.preprocessingID = preprocessingID;
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
	public String getPtOption() {
		return ptOption;
	}
	public void setPtOption(String ptOption) {
		this.ptOption = ptOption;
	}
	
	public List<PreprocessingAssembleEntity> getAssembleRecords() {
		return assembleRecords;
	}
	public void setAssembleRecords(List<PreprocessingAssembleEntity> assembleRecords) {
		this.assembleRecords = assembleRecords;
	}
	public List<PreprocessingInspectEntity> getInspectRecords() {
		return inspectRecords;
	}
	public void setInspectRecords(List<PreprocessingInspectEntity> inspectRecords) {
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
	public String getPtOption2() {
		return ptOption2;
	}
	public void setPtOption2(String ptOption2) {
		this.ptOption2 = ptOption2;
	}
	public String getPtOptions() {
		return ptOptions;
	}
	public void setPtOptions(String ptOptions) {
		this.ptOptions = ptOptions;
	}
	public String getcOrderID() {
		return cOrderID;
	}
	public void setcOrderID(String cOrderID) {
		this.cOrderID = cOrderID;
	}
	
}

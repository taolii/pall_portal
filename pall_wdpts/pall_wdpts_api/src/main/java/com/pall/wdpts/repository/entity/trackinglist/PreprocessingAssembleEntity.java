package com.pall.wdpts.repository.entity.trackinglist;
/*
 * 预处理装配对象
 */
public class PreprocessingAssembleEntity {
	/*
	 * 预处理装配流程跟踪单唯一标示
	 */
	private Integer preprocessingID;
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
	 * 备注
	 */
	private String remarks;
	
	public Integer getPreprocessingID() {
		return preprocessingID;
	}
	public void setPreprocessingID(Integer preprocessingID) {
		this.preprocessingID = preprocessingID;
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
	public String getSerialNoRecord() {
		return serialNoRecord;
	}
	public void setSerialNoRecord(String serialNoRecord) {
		this.serialNoRecord = serialNoRecord;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
}

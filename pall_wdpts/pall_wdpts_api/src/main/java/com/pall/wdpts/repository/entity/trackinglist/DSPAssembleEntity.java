package com.pall.wdpts.repository.entity.trackinglist;
/*
 * DSP装配对象
 */
public class DSPAssembleEntity {
	/*
	 * DSP装配流程跟踪单唯一标示
	 */
	private String dspID;
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
	public String getDspID() {
		return dspID;
	}
	public void setDspID(String dspID) {
		this.dspID = dspID;
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

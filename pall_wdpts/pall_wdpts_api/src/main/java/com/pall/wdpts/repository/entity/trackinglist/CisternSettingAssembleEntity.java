package com.pall.wdpts.repository.entity.trackinglist;
/*
 * 水箱装配配置对象
 */
public class CisternSettingAssembleEntity {
	private int csid;
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
	
	public int getCsid() {
		return csid;
	}
	public void setCsid(int csid) {
		this.csid = csid;
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

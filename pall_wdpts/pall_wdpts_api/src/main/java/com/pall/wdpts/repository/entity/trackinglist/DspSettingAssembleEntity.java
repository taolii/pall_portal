package com.pall.wdpts.repository.entity.trackinglist;
/*
 * Dsp装配配置对象
 */
public class DspSettingAssembleEntity {
	private int dsid;
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
	
	public int getDsid() {
		return dsid;
	}
	public void setDsid(int dsid) {
		this.dsid = dsid;
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

package com.pall.wdpts.repository.entity.trackinglist;
/*
 * 主机送检配置对象
 */
public class MainframeSettingInspectEntity{
	
	private int msid;
	/*
	 * 自检名称
	 */
	private String selfcheckName;
	/*
	 * 自检内容
	 */
	private String selfcheckContent;
	/*
	 * 自检结果
	 */
	private String selfcheckResult;
	/*
	 * 备注
	 */
	private String remarks;
	
	
	public int getMsid() {
		return msid;
	}
	public void setMsid(int msid) {
		this.msid = msid;
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
	public String getSelfcheckResult() {
		return selfcheckResult;
	}
	public void setSelfcheckResult(String selfcheckResult) {
		this.selfcheckResult = selfcheckResult;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
}

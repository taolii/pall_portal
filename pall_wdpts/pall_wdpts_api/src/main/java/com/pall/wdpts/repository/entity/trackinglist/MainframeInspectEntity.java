package com.pall.wdpts.repository.entity.trackinglist;
/*
 * 主机装配送检对象
 */
public class MainframeInspectEntity {
	/*
	 * 主机装配流程跟踪单唯一标示
	 */
	private String mainframeID;
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
	public String getMainframeID() {
		return mainframeID;
	}
	public void setMainframeID(String mainframeID) {
		this.mainframeID = mainframeID;
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

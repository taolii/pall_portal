package com.pall.wdpts.repository.entity.trackinglist;
/*
 * 主机装配送检对象
 */
public class MainframeInspectEntity {
	/*
	 * 主机装配流程跟踪单唯一标示
	 */
	private Integer mainframeID;
	/*
	 * 自检名称
	 */
	private String selfcheckName;
	/*
	 * 自检内容
	 */
	private String selfcheckContent;
	/*
	 * 图片信息
	 */
	private byte[] imageByteArrays;
	/*
	 * 自检结果
	 */
	private String selfcheckResult;
	/*
	 * 备注
	 */
	private String remarks;
	
	public Integer getMainframeID() {
		return mainframeID;
	}
	public void setMainframeID(Integer mainframeID) {
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
	public byte[] getImageByteArrays() {
		return imageByteArrays;
	}
	public void setImageByteArrays(byte[] imageByteArrays) {
		this.imageByteArrays = imageByteArrays;
	}
	
}

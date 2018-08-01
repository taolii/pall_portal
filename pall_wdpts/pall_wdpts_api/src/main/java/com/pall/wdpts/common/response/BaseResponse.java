package com.pall.wdpts.common.response;

import java.util.List;

public class BaseResponse {
	/*
	 * 返回码
	 */
	private int resultCode;
	/*
	 * 返回描述
	 */
	private String resultMsg;
	/*
	 * 返回对象列表
	 */
	private List<?> returnObjects;
	
	
	public int getResultCode() {
		return resultCode;
	}
	public void setResultCode(int resultCode) {
		this.resultCode = resultCode;
	}
	public String getResultMsg() {
		return resultMsg;
	}
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	public List<?> getReturnObjects() {
		return returnObjects;
	}
	public void setReturnObjects(List<?> returnObjects) {
		this.returnObjects = returnObjects;
	}
	
	
}

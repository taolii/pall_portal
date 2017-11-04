package com.pall.portal.common.response;

import com.pall.portal.common.datatables.Entity.DatatablesView;

public class BaseTablesResponse {
	/*
	 * 返回码
	 */
	private int resultCode;
	/*
	 * 返回描述
	 */
	private String resultMsg;
	/*
	 * 返回列表信息
	 */
	private DatatablesView datatablesView;
	
	
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
	public DatatablesView getDatatablesView() {
		return datatablesView;
	}
	public void setDatatablesView(DatatablesView datatablesView) {
		this.datatablesView = datatablesView;
	}
	
}

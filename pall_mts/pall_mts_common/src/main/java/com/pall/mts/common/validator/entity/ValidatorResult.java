package com.pall.mts.common.validator.entity;
/*
 * 验证结果
 */
public class ValidatorResult {
	/*
	 * 属性名
	 */
	private String filedName;
	/*
	 * 验证结果描述
	 */
	private String message;
	
	public String getFiledName() {
		return filedName;
	}
	public void setFiledName(String filedName) {
		this.filedName = filedName;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
}

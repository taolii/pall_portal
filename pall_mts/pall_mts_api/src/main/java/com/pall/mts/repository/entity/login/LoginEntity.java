package com.pall.mts.repository.entity.login;
/*
 * 用户登录实体
 */
public class LoginEntity {
	/*
	 * 登录用户名
	 */
	private String loginName;
	/*
	 * 登录用户身份
	 */
	private String loginType;
	/*
	 * 登录用户密码
	 */
	private String loginPasswd;
	/*
	 * 登录验证码
	 */
	private String validCode;
	/*
	 * 会话保存验证码
	 */
	private String sessionValidCode;
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getLoginType() {
		return loginType;
	}
	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}
	public String getLoginPasswd() {
		return loginPasswd;
	}
	public void setLoginPasswd(String loginPasswd) {
		this.loginPasswd = loginPasswd;
	}
	public String getValidCode() {
		return validCode;
	}
	public void setValidCode(String validCode) {
		this.validCode = validCode;
	}
	public String getSessionValidCode() {
		return sessionValidCode;
	}
	public void setSessionValidCode(String sessionValidCode) {
		this.sessionValidCode = sessionValidCode;
	}
	
}

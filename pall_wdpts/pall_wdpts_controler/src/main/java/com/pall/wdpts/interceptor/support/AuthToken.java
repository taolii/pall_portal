package com.pall.wdpts.interceptor.support;

import java.util.Date;
import java.util.List;

import com.pall.wdpts.repository.entity.menu.TreeMenuInfo;
import com.pall.wdpts.repository.entity.user.UserEntity;

/*
 * 授权Token
 */
public class AuthToken {
	/*
	 * 会话名称
	 */
	public static final String SESSION_NAME="LOGIN_USER";
	public static final String VALID_CODE_NAME="VALID_CODE";
	/*
	 * 当前系统版本
	 */
	private String nowSystemVersion;
	/*
	 * 用户实体对象
	 */
	private UserEntity userEntity;
	/*
	 * 授权列表
	 */
	private List<String>AuthList;
	/*
	 * 登录时间
	 */
	private Date loginTime;
	/*
	 * 登录ip
	 */
	private String loginIP;
	/*
	 * 授权菜单列表
	 */
	private List<TreeMenuInfo> authMenus;

	public UserEntity getUserEntity() {
		return userEntity;
	}

	public void setUserEntity(UserEntity userEntity) {
		this.userEntity = userEntity;
	}
	public List<String> getAuthList() {
		return AuthList;
	}

	public void setAuthList(List<String> authList) {
		AuthList = authList;
	}

	public Date getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}

	public String getLoginIP() {
		return loginIP;
	}

	public void setLoginIP(String loginIP) {
		this.loginIP = loginIP;
	}

	public List<TreeMenuInfo> getAuthMenus() {
		return authMenus;
	}

	public void setAuthMenus(List<TreeMenuInfo> authMenus) {
		this.authMenus = authMenus;
	}

	public String getNowSystemVersion() {
		return nowSystemVersion;
	}

	public void setNowSystemVersion(String nowSystemVersion) {
		this.nowSystemVersion = nowSystemVersion;
	}
	
	
}

package com.pall.portal.repository.entity.user;

/*
 * 用户权限对象
 */
public class UserPermissionEntity {
	/*
	 * 操作员编号
	 */
	private int operatorid;
	/*
	 * 权限类型
	 */
	private int operatorType;
	/*
	 * 角色id
	 */
	private String roleid;
	public int getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(int operatorid) {
		this.operatorid = operatorid;
	}
	public int getOperatorType() {
		return operatorType;
	}
	public void setOperatorType(int operatorType) {
		this.operatorType = operatorType;
	}
	public String getRoleid() {
		return roleid;
	}
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}
	
}

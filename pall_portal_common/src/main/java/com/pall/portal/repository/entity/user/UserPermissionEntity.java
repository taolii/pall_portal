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
	 * 角色id
	 */
	private String roleid;
	public int getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(int operatorid) {
		this.operatorid = operatorid;
	}
	public String getRoleid() {
		return roleid;
	}
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}
	
}

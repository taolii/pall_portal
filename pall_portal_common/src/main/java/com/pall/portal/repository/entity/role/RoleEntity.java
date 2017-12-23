package com.pall.portal.repository.entity.role;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 系统角色对象
 */
public class RoleEntity {
	/*
	 * 数据配置id
	 */
	private int roleid;
	/*
	 * 描述名称
	 */
	@NotEmpty(message="{roleManage.form.valid.RoleEntity.roleName.NotEmpty}")
	private String roleName;
	/*
	 * 角色描述
	 */
	private String rDetail;
	public int getRoleid() {
		return roleid;
	}
	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getrDetail() {
		return rDetail;
	}
	public void setrDetail(String rDetail) {
		this.rDetail = rDetail;
	}
	
}
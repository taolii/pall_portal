package com.pall.portal.repository.entity.role;

/*
 * 角色组对象
 */
public class GroupRoleEntity {
	/*
	 * 角色对象
	 */
	private RoleEntity roleEntity;
	/*
	 * 是否选中
	 */
	private boolean checked;
	public RoleEntity getRoleEntity() {
		return roleEntity;
	}
	public void setRoleEntity(RoleEntity roleEntity) {
		this.roleEntity = roleEntity;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	
}

package com.pall.mts.repository.entity.role;

import java.util.List;

/*
 * 角色对象
 */
public class TreeRole {
	/*
	 * 父菜单对象
	 */
	private RoleEntity roleEntity;
	/*
	 *  子菜单集合
	 */
	private List<TreeRole> subRoleEntitys;
	public RoleEntity getRoleEntity() {
		return roleEntity;
	}
	public void setRoleEntity(RoleEntity roleEntity) {
		this.roleEntity = roleEntity;
	}
	public List<TreeRole> getSubRoleEntitys() {
		return subRoleEntitys;
	}
	public void setSubRoleEntitys(List<TreeRole> subRoleEntitys) {
		this.subRoleEntitys = subRoleEntitys;
	}
	
}

package com.pall.portal.repository.entity.menu;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 菜单对象
 */
public class MenuInfoEntity {
	/*
	 * 菜单编号
	 */
	private int menuid;
	/*
	 *  菜单名称
	 */
	@NotEmpty(message="{menumanage.form.valid.MenuInfoEntity.menuName.NotEmpty}")
	private String menuName;
	/*
	 * 菜单图标
	 */
	private String menuIcon;
	/*
	 * 菜单路径
	 */
	private String menuUrl;
	/*
	 * 叶子节点与否 1 叶子节点 0 目录
	 */
	private int leaf;
	/*
	 * 节点是否可用 0 可用 1 不可用
	 */
	private int disabled;
	/*
	 * 父菜单编号
	 */
	private int pmenuid;
	/*
	 * 同级菜单顺序
	 */
	private int sort;
	/*
	 * 描述信息
	 */
	private String description;
	public int getMenuid() {
		return menuid;
	}
	public void setMenuid(int menuid) {
		this.menuid = menuid;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuIcon() {
		return menuIcon;
	}
	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}
	public String getMenuUrl() {
		return menuUrl;
	}
	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getPmenuid() {
		return pmenuid;
	}
	public void setPmenuid(int pmenuid) {
		this.pmenuid = pmenuid;
	}
	public int getLeaf() {
		return leaf;
	}
	public void setLeaf(int leaf) {
		this.leaf = leaf;
	}
	public int getDisabled() {
		return disabled;
	}
	public void setDisabled(int disabled) {
		this.disabled = disabled;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
}

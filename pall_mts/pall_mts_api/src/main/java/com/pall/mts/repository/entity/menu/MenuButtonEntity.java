package com.pall.mts.repository.entity.menu;

/*
 * 菜单按钮对象
 */
public class MenuButtonEntity {
	private String mbid;
	/*
	 * 菜单编号
	 */
	private Integer menuid;
	/*
	 *  菜单名称
	 */
	private String menuName;
	/*
	 * 菜单类型 1 为菜单 2为按钮
	 */
	private String menuType;
	/*
	 * 叶子节点与否 1 叶子节点 0 目录
	 */
	private Integer leaf;
	/*
	 * 父菜单编号
	 */
	private Integer pmenuid;
	public Integer getMenuid() {
		return menuid;
	}
	public void setMenuid(Integer menuid) {
		this.menuid = menuid;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuType() {
		return menuType;
	}
	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}
	public Integer getPmenuid() {
		return pmenuid;
	}
	public void setPmenuid(Integer pmenuid) {
		this.pmenuid = pmenuid;
	}
	public String getMbid() {
		return mbid;
	}
	public void setMbid(String mbid) {
		this.mbid = mbid;
	}
	public Integer getLeaf() {
		return leaf;
	}
	public void setLeaf(Integer leaf) {
		this.leaf = leaf;
	}
	
}

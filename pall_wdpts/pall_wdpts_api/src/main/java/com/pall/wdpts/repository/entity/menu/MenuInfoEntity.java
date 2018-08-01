package com.pall.wdpts.repository.entity.menu;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

/*
 * 菜单对象
 */
public class MenuInfoEntity {
	/*
	 * 菜单编号
	 */
	private Integer menuid;
	/*
	 *  菜单名称
	 */
	@NotBlank(message="{menumanage.form.valid.MenuInfoEntity.menuName.NotEmpty}")
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
	private Integer leaf;
	/*
	 * 节点是否可用 0 可用 1 不可用
	 */
	private Integer disabled;
	/*
	 * 父菜单编号
	 */
	private Integer pmenuid;
	/*
	 * 父菜单编号
	 */
	private String pmenuName;
	/*
	 * 同级菜单顺序
	 */
	private Integer sort;
	/*
	 * 描述信息
	 */
	@Length(min=0, max=100, message="{menuManage.form.valid.menuInfoEntity.description.stringlength}")  
	private String description;
	
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
	
	public Integer getLeaf() {
		return leaf;
	}
	public void setLeaf(Integer leaf) {
		this.leaf = leaf;
	}
	public Integer getDisabled() {
		return disabled;
	}
	public void setDisabled(Integer disabled) {
		this.disabled = disabled;
	}
	public void setPmenuid(Integer pmenuid) {
		this.pmenuid = pmenuid;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getPmenuName() {
		return pmenuName;
	}
	public void setPmenuName(String pmenuName) {
		this.pmenuName = pmenuName;
	}
}

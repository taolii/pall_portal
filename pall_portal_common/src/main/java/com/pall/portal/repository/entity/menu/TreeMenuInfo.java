package com.pall.portal.repository.entity.menu;

import java.util.List;

/*
 * 菜单对象
 */
public class TreeMenuInfo {
	/*
	 * 父菜单对象
	 */
	private MenuInfoEntity pmenuInfo;
	/*
	 *  子菜单集合
	 */
	private List<TreeMenuInfo> subMenuInfos;
	public MenuInfoEntity getPmenuInfo() {
		return pmenuInfo;
	}
	public void setPmenuInfo(MenuInfoEntity pmenuInfo) {
		this.pmenuInfo = pmenuInfo;
	}
	public List<TreeMenuInfo> getSubMenuInfos() {
		return subMenuInfos;
	}
	public void setSubMenuInfos(List<TreeMenuInfo> subMenuInfos) {
		this.subMenuInfos = subMenuInfos;
	}
	
}

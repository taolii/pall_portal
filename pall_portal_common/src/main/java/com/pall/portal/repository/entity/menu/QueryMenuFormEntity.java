package com.pall.portal.repository.entity.menu;
/*
 * 菜单查询对象
 */
public class QueryMenuFormEntity {
	/*
	 *  菜单名称
	 */
	private String menuName;
	private String pMenuid;
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	/*
	 * 每页记录数
	 */
	private int pageSize;
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public int getStartPageNum() {
		return startPageNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	public int getDraw() {
		return draw;
	}
	public void setDraw(int draw) {
		this.draw = draw;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getpMenuid() {
		return pMenuid;
	}
	public void setpMenuid(String pMenuid) {
		this.pMenuid = pMenuid;
	}
	
}

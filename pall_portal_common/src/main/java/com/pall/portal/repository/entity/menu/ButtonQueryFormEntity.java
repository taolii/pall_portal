package com.pall.portal.repository.entity.menu;

/*
 * 按钮查询对象
 */
public class ButtonQueryFormEntity {
	
	private String menuid;
	/*
	 * 按钮英文名称
	 */
	private String btnEName;
	/*按钮中文名称
	 * 
	 */
	private String btnCName;
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	/*
	 * 每页记录数
	 */
	private int pageSize;
	public String getMenuid() {
		return menuid;
	}
	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}
	
	public String getBtnEName() {
		return btnEName;
	}
	public void setBtnEName(String btnEName) {
		this.btnEName = btnEName;
	}
	public String getBtnCName() {
		return btnCName;
	}
	public void setBtnCName(String btnCName) {
		this.btnCName = btnCName;
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
	
}

package com.pall.mts.repository.entity.workflow;

/*
 * 光学镀膜查询对象
 */
public class TwiceChemicalReagentMixtureQueryFormEntity {
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	/*
	 * 每页记录数
	 */
	private int pageSize;
	private String crID;
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
	public String getCrID() {
		return crID;
	}
	public void setCrID(String crID) {
		this.crID = crID;
	}
	
}

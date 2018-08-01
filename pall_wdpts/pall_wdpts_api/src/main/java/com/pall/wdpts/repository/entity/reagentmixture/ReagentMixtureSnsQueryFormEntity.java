package com.pall.wdpts.repository.entity.reagentmixture;
/*
 * 试剂混合查询对象
 */
public class ReagentMixtureSnsQueryFormEntity {
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	private String rmid;
	private String mainReagent;
	private String reagentsName;
	/*
	 * 每页记录数
	 */
	private int pageSize;
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
	public String getRmid() {
		return rmid;
	}
	public void setRmid(String rmid) {
		this.rmid = rmid;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getMainReagent() {
		return mainReagent;
	}
	public void setMainReagent(String mainReagent) {
		this.mainReagent = mainReagent;
	}
	public String getReagentsName() {
		return reagentsName;
	}
	public void setReagentsName(String reagentsName) {
		this.reagentsName = reagentsName;
	}
	
}

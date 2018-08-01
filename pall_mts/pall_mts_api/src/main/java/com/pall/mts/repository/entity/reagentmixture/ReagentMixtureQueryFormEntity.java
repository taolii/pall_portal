package com.pall.mts.repository.entity.reagentmixture;
/*
 * 试剂混合查询对象
 */
public class ReagentMixtureQueryFormEntity {
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	private String rmid;
	/*
	 * 每页记录数
	 */
	private int pageSize;
	/*
	 * 试剂配制开始时间
	 */
	private String startConfigTime;
	/*
	 * 试剂配制结束时间
	 */
	private String endConfigTime;
	/*
	 * 主试剂
	 */
	private String mainReagent;
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
	public String getStartConfigTime() {
		return startConfigTime;
	}
	public void setStartConfigTime(String startConfigTime) {
		this.startConfigTime = startConfigTime;
	}
	public String getEndConfigTime() {
		return endConfigTime;
	}
	public void setEndConfigTime(String endConfigTime) {
		this.endConfigTime = endConfigTime;
	}
	public String getMainReagent() {
		return mainReagent;
	}
	public void setMainReagent(String mainReagent) {
		this.mainReagent = mainReagent;
	}
	public String getRmid() {
		return rmid;
	}
	public void setRmid(String rmid) {
		this.rmid = rmid;
	}
	
}

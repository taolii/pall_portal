package com.pall.mts.repository.entity.reagentmixture;

/*
 * 试剂混合对象
 */
public class ReagentMixtureEntitySns {
	
	/*
	 * 试剂编号
	 */
	private int rmid;
	/*
	 * 子试剂编号
	 */
	private int srmid;
	/*
	 * 试剂属性名
	 */
	private String reagentsFieldName;
	/*
	 * 试剂名称
	 */
	private String reagentsName;
	private String mainReagent;
	/*
	 * 试剂编号
	 */
	private String reagentsSn;
	public int getRmid() {
		return rmid;
	}
	public void setRmid(int rmid) {
		this.rmid = rmid;
	}
	public String getReagentsName() {
		return reagentsName;
	}
	public void setReagentsName(String reagentsName) {
		this.reagentsName = reagentsName;
	}
	public String getReagentsSn() {
		return reagentsSn;
	}
	public void setReagentsSn(String reagentsSn) {
		this.reagentsSn = reagentsSn;
	}
	public String getReagentsFieldName() {
		return reagentsFieldName;
	}
	public void setReagentsFieldName(String reagentsFieldName) {
		this.reagentsFieldName = reagentsFieldName;
	}
	public String getMainReagent() {
		return mainReagent;
	}
	public void setMainReagent(String mainReagent) {
		this.mainReagent = mainReagent;
	}
	public int getSrmid() {
		return srmid;
	}
	public void setSrmid(int srmid) {
		this.srmid = srmid;
	}
	
}

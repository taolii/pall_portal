package com.pall.wdpts.repository.entity.workflow;

/*
 * 化学混合试剂信息
 */
public class TwiceChemicalCompoundReagentsEntity {
	/*
	 * 化学试剂唯一标示
	 */
	private Integer crID;
	private Integer srmid;
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
	public Integer getCrID() {
		return crID;
	}
	public String getReagentsFieldName() {
		return reagentsFieldName;
	}
	public void setReagentsFieldName(String reagentsFieldName) {
		this.reagentsFieldName = reagentsFieldName;
	}
	public String getReagentsName() {
		return reagentsName;
	}
	public void setReagentsName(String reagentsName) {
		this.reagentsName = reagentsName;
	}
	public String getMainReagent() {
		return mainReagent;
	}
	public void setMainReagent(String mainReagent) {
		this.mainReagent = mainReagent;
	}
	public String getReagentsSn() {
		return reagentsSn;
	}
	public void setReagentsSn(String reagentsSn) {
		this.reagentsSn = reagentsSn;
	}
	public void setCrID(Integer crID) {
		this.crID = crID;
	}
	public Integer getSrmid() {
		return srmid;
	}
	public void setSrmid(Integer srmid) {
		this.srmid = srmid;
	}
	
}

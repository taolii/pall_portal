package com.pall.portal.repository.entity.workflow;

/*
 * 化学混合试剂信息
 */
public class ChemicalCompoundReagentsEntity {
	/*
	 * 化学试剂唯一标示
	 */
	private Integer crID;
	/*
	 * 混合试剂名称
	 */
	private String compoundReagentsName;
	/*
	 * 混合试剂编号
	 */
	private String compoundReagentsSN;
	public Integer getCrID() {
		return crID;
	}
	public void setCrID(Integer crID) {
		this.crID = crID;
	}
	public String getCompoundReagentsName() {
		return compoundReagentsName;
	}
	public void setCompoundReagentsName(String compoundReagentsName) {
		this.compoundReagentsName = compoundReagentsName;
	}
	public String getCompoundReagentsSN() {
		return compoundReagentsSN;
	}
	public void setCompoundReagentsSN(String compoundReagentsSN) {
		this.compoundReagentsSN = compoundReagentsSN;
	}
	
}

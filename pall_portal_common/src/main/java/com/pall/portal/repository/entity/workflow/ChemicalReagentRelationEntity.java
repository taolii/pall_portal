package com.pall.portal.repository.entity.workflow;

/*
 * 化学试剂关联关系信息
 */
public class ChemicalReagentRelationEntity {
	/*
	 * 混合试剂唯一标示
	 */
	private Integer crID;
	/*
	 * 组装站位OUTPUT LOT#
	 */
	private String assemblyOutputLotNum;
	/*
	 * 化学镀膜OUTPUT LOT#
	 */
	private String pfOutputLotNum;
	/*
	 * 光学镀膜OUTPUT LOT#
	 */
	private String ocOutputLotNum;
	public Integer getCrID() {
		return crID;
	}
	public void setCrID(Integer crID) {
		this.crID = crID;
	}
	public String getAssemblyOutputLotNum() {
		return assemblyOutputLotNum;
	}
	public void setAssemblyOutputLotNum(String assemblyOutputLotNum) {
		this.assemblyOutputLotNum = assemblyOutputLotNum;
	}
	public String getPfOutputLotNum() {
		return pfOutputLotNum;
	}
	public void setPfOutputLotNum(String pfOutputLotNum) {
		this.pfOutputLotNum = pfOutputLotNum;
	}
	public String getOcOutputLotNum() {
		return ocOutputLotNum;
	}
	public void setOcOutputLotNum(String ocOutputLotNum) {
		this.ocOutputLotNum = ocOutputLotNum;
	}
	
}

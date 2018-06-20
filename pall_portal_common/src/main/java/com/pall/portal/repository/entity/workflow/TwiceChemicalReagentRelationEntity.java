package com.pall.portal.repository.entity.workflow;

/*
 * 化学试剂关联关系信息
 */
public class TwiceChemicalReagentRelationEntity {
	/*
	 * 混合试剂唯一标示
	 */
	private Integer crID;
	/*
	 * tray#
	 */
	private String trayNum;
	/*
	 * tray#
	 */
	private String oldLotNum;
	/*
	 * T#
	 */
	private String oldTrayNum;
	/*
	 * PN#
	 */
	private String oldBioPatNum;
	public Integer getCrID() {
		return crID;
	}
	public void setCrID(Integer crID) {
		this.crID = crID;
	}
	public String getTrayNum() {
		return trayNum;
	}
	public void setTrayNum(String trayNum) {
		this.trayNum = trayNum;
	}
	public String getOldLotNum() {
		return oldLotNum;
	}
	public void setOldLotNum(String oldLotNum) {
		this.oldLotNum = oldLotNum;
	}
	public String getOldTrayNum() {
		return oldTrayNum;
	}
	public void setOldTrayNum(String oldTrayNum) {
		this.oldTrayNum = oldTrayNum;
	}
	public String getOldBioPatNum() {
		return oldBioPatNum;
	}
	public void setOldBioPatNum(String oldBioPatNum) {
		this.oldBioPatNum = oldBioPatNum;
	}
	
}

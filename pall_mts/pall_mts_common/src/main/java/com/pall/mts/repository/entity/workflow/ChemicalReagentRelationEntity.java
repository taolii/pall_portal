package com.pall.mts.repository.entity.workflow;

/*
 * 化学试剂关联关系信息
 */
public class ChemicalReagentRelationEntity {
	/*
	 * 混合试剂唯一标示
	 */
	private Integer crID;
	/*
	 * tray#
	 */
	private String trayLotNum;
	/*
	 * T#
	 */
	private String tLotNum;
	/*
	 * 组装站位OUTPUT LOT#
	 */
	private String assemblyLotNum;
	/*
	 * 化学镀膜OUTPUT LOT#
	 */
	private String apsLotNum;
	/*
	 * 光学镀膜OUTPUT LOT#
	 */
	private String ocLotNum;
	/*
	 * 清洁OUTPUT LOT#
	 */
	private String cleanLotNum;
	/*
	 * 抛光OUTPUT LOT#
	 */
	private String polishLotNum;
	/*
	 * Assembly BOM
	 */
	private String assemblyBom;
	/*
	 * 化学镀膜BOM
	 */
	private String apsBom;
	/*
	 *  光学镀膜BOM
	 */
	private String ocBom;
	/*
	 * 清洁BOM
	 */
	private String cleanBom;
	/*
	 * 抛光BOM
	 */
	private String polishBom;
	public Integer getCrID() {
		return crID;
	}
	public void setCrID(Integer crID) {
		this.crID = crID;
	}
	public String getTrayLotNum() {
		return trayLotNum;
	}
	public void setTrayLotNum(String trayLotNum) {
		this.trayLotNum = trayLotNum;
	}
	public String gettLotNum() {
		return tLotNum;
	}
	public void settLotNum(String tLotNum) {
		this.tLotNum = tLotNum;
	}
	public String getAssemblyLotNum() {
		return assemblyLotNum;
	}
	public void setAssemblyLotNum(String assemblyLotNum) {
		this.assemblyLotNum = assemblyLotNum;
	}
	public String getApsLotNum() {
		return apsLotNum;
	}
	public void setApsLotNum(String apsLotNum) {
		this.apsLotNum = apsLotNum;
	}
	public String getOcLotNum() {
		return ocLotNum;
	}
	public void setOcLotNum(String ocLotNum) {
		this.ocLotNum = ocLotNum;
	}
	public String getCleanLotNum() {
		return cleanLotNum;
	}
	public void setCleanLotNum(String cleanLotNum) {
		this.cleanLotNum = cleanLotNum;
	}
	public String getPolishLotNum() {
		return polishLotNum;
	}
	public void setPolishLotNum(String polishLotNum) {
		this.polishLotNum = polishLotNum;
	}
	public String getAssemblyBom() {
		return assemblyBom;
	}
	public void setAssemblyBom(String assemblyBom) {
		this.assemblyBom = assemblyBom;
	}
	public String getApsBom() {
		return apsBom;
	}
	public void setApsBom(String apsBom) {
		this.apsBom = apsBom;
	}
	public String getOcBom() {
		return ocBom;
	}
	public void setOcBom(String ocBom) {
		this.ocBom = ocBom;
	}
	public String getCleanBom() {
		return cleanBom;
	}
	public void setCleanBom(String cleanBom) {
		this.cleanBom = cleanBom;
	}
	public String getPolishBom() {
		return polishBom;
	}
	public void setPolishBom(String polishBom) {
		this.polishBom = polishBom;
	}
	
}

package com.pall.portal.repository.entity.workflow;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 化学试剂信息
 */
public class TwiceChemicalReagentEntity {
	/*
	 * 唯一标示
	 */
	@NotNull(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.crid.NotEmpty}",groups={SAVE.class})
	private Integer crID;
	/*
	 * old lot#
	 */
	private String oldLotNums;
	/*
	 * old tray lot#
	 */
	private String oldTrayNums;
	private String oldBioPatNums;
	/*
	 * 试剂混合物的批次，Lot
	 */
	@NotEmpty(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.lot.NotEmpty}",groups={SAVE.class,ADD.class})
	private String lot;
	/*
	 * BIO Pat Number
	 */
	private String bioPatNum;
	/*
	 * BIO BOM
	 */
	private String bioBom;
	/*
	 * 零件号
	 */
	private String partNum;
	/*
	 * tray#
	 */
	private String trayNums;
	/*
	 * 操作人员1
	 */
	private String crOperator1;
	/*
	 * 操作人员2
	 */
	private String crOperator2;
	/*
	 * 03-0067
	 */
	private String auxiliaryReagent1;
	/*
	 * 05-0079 1ug/ml BPA
	 */
	private String auxiliaryReagent2;
	/*
	 * 05-0080 6ug/ml HIgG
	 */
	private String auxiliaryReagent3;
	/*
	 * FIBER RAW MATERIAL
	 */
	
	private String rawMaterial;
	/*
	 * IN PUT DATE
	 */
	
	private String inPutDate;
	/*
	 * BIO 镀膜设备名称/每一个tray需要记录其对应在镀膜设备镀膜时放置的位置
	 */

	private String coatingStation;
	/*
	 * DOC.REV 依据文件及版本
	 */

	private String docRev;
	/*
	 * 良品数量
	 */
	@NotNull(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.goodsQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer goodsQty;
	/*
	 * 投入数量
	 */
	@NotNull(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.inputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer inputQty;
	/*
	 * Scrap QTY
	 */
	private Integer scrapQty;
	/*
	 * To PQC QTY
	 */
	private Integer toPqcQty;
	/*
	 * 重抽 Qty
	 */
	private Integer heavySmokeQty;
	/*
	 * 领用QTY
	 */
	private Integer receiveQty;
	/*
	 * 其他QTY
	 */
	private Integer toOtherQty;
	/*
	 * remark
	 */
	private String remark;
	/*
	 * 理论良率
	 */
	@NotNull(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.theoryYield.NotEmpty",groups={SAVE.class,ADD.class})
	private String theoryYield;
	/*
	 * 实际良率
	 */
	private String actualYield;
	/*
	 * 理论和实际良率比较
	 */
	private String theoryActualYield;
	/*
	 * 混合试剂信息
	 */
	private List<TwiceChemicalCompoundReagentsEntity> compoundReagents;
	/*
	 * 化学试剂与组装关系信息
	 */
	private List<TwiceChemicalReagentRelationEntity> chemicalReagentRelations;
	
	/*
	 * 录入时间
	 */
	private String inputTime;
	/*
	 * 更新时间
	 */
	private String updateTime;
	/*
	 * 操作员id
	 */
	private Integer operatorid;
	/*
	 * 操作员名称
	 */
	private String operatorName;
	
	
	public Integer getCrID() {
		return crID;
	}
	public void setCrID(Integer crID) {
		this.crID = crID;
	}
	public String getOldLotNums() {
		return oldLotNums;
	}
	public void setOldLotNums(String oldLotNums) {
		this.oldLotNums = oldLotNums;
	}
	public String getOldTrayNums() {
		return oldTrayNums;
	}
	public void setOldTrayNums(String oldTrayNums) {
		this.oldTrayNums = oldTrayNums;
	}
	public String getOldBioPatNums() {
		return oldBioPatNums;
	}
	public void setOldBioPatNums(String oldBioPatNums) {
		this.oldBioPatNums = oldBioPatNums;
	}
	public String getLot() {
		return lot;
	}
	public void setLot(String lot) {
		this.lot = lot;
	}
	public String getBioPatNum() {
		return bioPatNum;
	}
	public void setBioPatNum(String bioPatNum) {
		this.bioPatNum = bioPatNum;
	}
	public String getBioBom() {
		return bioBom;
	}
	public void setBioBom(String bioBom) {
		this.bioBom = bioBom;
	}
	public String getPartNum() {
		return partNum;
	}
	public void setPartNum(String partNum) {
		this.partNum = partNum;
	}
	public String getTrayNums() {
		return trayNums;
	}
	public void setTrayNums(String trayNums) {
		this.trayNums = trayNums;
	}
	public String getCrOperator1() {
		return crOperator1;
	}
	public void setCrOperator1(String crOperator1) {
		this.crOperator1 = crOperator1;
	}
	public String getCrOperator2() {
		return crOperator2;
	}
	public void setCrOperator2(String crOperator2) {
		this.crOperator2 = crOperator2;
	}
	public String getAuxiliaryReagent1() {
		return auxiliaryReagent1;
	}
	public void setAuxiliaryReagent1(String auxiliaryReagent1) {
		this.auxiliaryReagent1 = auxiliaryReagent1;
	}
	public String getAuxiliaryReagent2() {
		return auxiliaryReagent2;
	}
	public void setAuxiliaryReagent2(String auxiliaryReagent2) {
		this.auxiliaryReagent2 = auxiliaryReagent2;
	}
	public String getAuxiliaryReagent3() {
		return auxiliaryReagent3;
	}
	public void setAuxiliaryReagent3(String auxiliaryReagent3) {
		this.auxiliaryReagent3 = auxiliaryReagent3;
	}
	public String getRawMaterial() {
		return rawMaterial;
	}
	public void setRawMaterial(String rawMaterial) {
		this.rawMaterial = rawMaterial;
	}
	public String getInPutDate() {
		return inPutDate;
	}
	public void setInPutDate(String inPutDate) {
		this.inPutDate = inPutDate;
	}
	public String getCoatingStation() {
		return coatingStation;
	}
	public void setCoatingStation(String coatingStation) {
		this.coatingStation = coatingStation;
	}
	public String getDocRev() {
		return docRev;
	}
	public void setDocRev(String docRev) {
		this.docRev = docRev;
	}
	public Integer getGoodsQty() {
		return goodsQty;
	}
	public void setGoodsQty(Integer goodsQty) {
		this.goodsQty = goodsQty;
	}
	public Integer getInputQty() {
		return inputQty;
	}
	public void setInputQty(Integer inputQty) {
		this.inputQty = inputQty;
	}
	public Integer getScrapQty() {
		return scrapQty;
	}
	public void setScrapQty(Integer scrapQty) {
		this.scrapQty = scrapQty;
	}
	public Integer getToPqcQty() {
		return toPqcQty;
	}
	public void setToPqcQty(Integer toPqcQty) {
		this.toPqcQty = toPqcQty;
	}
	public Integer getHeavySmokeQty() {
		return heavySmokeQty;
	}
	public void setHeavySmokeQty(Integer heavySmokeQty) {
		this.heavySmokeQty = heavySmokeQty;
	}
	public Integer getReceiveQty() {
		return receiveQty;
	}
	public void setReceiveQty(Integer receiveQty) {
		this.receiveQty = receiveQty;
	}
	public Integer getToOtherQty() {
		return toOtherQty;
	}
	public void setToOtherQty(Integer toOtherQty) {
		this.toOtherQty = toOtherQty;
	}
	public String getTheoryYield() {
		return theoryYield;
	}
	public void setTheoryYield(String theoryYield) {
		this.theoryYield = theoryYield;
	}
	public String getActualYield() {
		return actualYield;
	}
	public void setActualYield(String actualYield) {
		this.actualYield = actualYield;
	}
	public String getTheoryActualYield() {
		return theoryActualYield;
	}
	public void setTheoryActualYield(String theoryActualYield) {
		this.theoryActualYield = theoryActualYield;
	}
	public List<TwiceChemicalCompoundReagentsEntity> getCompoundReagents() {
		return compoundReagents;
	}
	public void setCompoundReagents(List<TwiceChemicalCompoundReagentsEntity> compoundReagents) {
		this.compoundReagents = compoundReagents;
	}
	public List<TwiceChemicalReagentRelationEntity> getChemicalReagentRelations() {
		return chemicalReagentRelations;
	}
	public void setChemicalReagentRelations(List<TwiceChemicalReagentRelationEntity> chemicalReagentRelations) {
		this.chemicalReagentRelations = chemicalReagentRelations;
	}
	public String getInputTime() {
		return inputTime;
	}
	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(Integer operatorid) {
		this.operatorid = operatorid;
	}
	public String getOperatorName() {
		return operatorName;
	}
	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

	public interface ADD{};  
	public interface SAVE{};
}

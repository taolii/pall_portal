package com.pall.portal.repository.entity.workflow;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 化学试剂信息
 */
public class ChemicalReagentEntity {
	/*
	 * 唯一标示
	 */
	@NotNull(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.crid.NotEmpty}",groups={SAVE.class})
	private Integer crID;
	/*
	 * 试剂混合物的批次，Lot
	 */
	@NotEmpty(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.lot.NotEmpty}",groups={SAVE.class,ADD.class})
	private String lot;
	/*
	 * FIBER RAW MATERIAL
	 */
	@NotEmpty(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.rawMaterial.NotEmpty}",groups={SAVE.class,ADD.class})
	private String rawMaterial;
	/*
	 * IN PUT DATE
	 */
	@NotEmpty(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.inPutDate.NotEmpty}",groups={SAVE.class,ADD.class})
	private String inPutDate;
	/*
	 * BIO 镀膜设备名称/每一个tray需要记录其对应在镀膜设备镀膜时放置的位置
	 */
	@NotNull(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.coatingStation.NotEmpty}",groups={SAVE.class,ADD.class})
	private String coatingStation;
	/*
	 * DOC.REV 依据文件及版本
	 */
	@NotNull(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.docRev.NotEmpty}",groups={SAVE.class,ADD.class})
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
	 * 理论良率
	 */
	@NotNull(message="{chemicalReagentManage.form.valid.chemicalReagentEntity.theoryYield.NotEmpty",groups={SAVE.class,ADD.class})
	private double theoryYield;
	/*
	 * 实际良率
	 */
	private double actualYield;
	/*
	 * 理论和实际良率比较
	 */
	private double theoryActualYield;
	/*
	 * 混合试剂信息
	 */
	private List<ChemicalCompoundReagentsEntity> compoundReagents;
	/*
	 * 化学试剂与组装关系信息
	 */
	private List<ChemicalReagentRelationEntity> chemicalReagentRelations;
	/*
	 * 组装站位OUTPUT LOT#
	 */
	private String assemblyOutputLotNums;
	/*
	 * 化学镀膜OUTPUT LOT#
	 */
	private String pfOutputLotNums;
	/*
	 * 光学镀膜OUTPUT LOT#
	 */
	private String ocOutputLotNums;
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
	public String getLot() {
		return lot;
	}
	public void setLot(String lot) {
		this.lot = lot;
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
	public double getTheoryYield() {
		return theoryYield;
	}
	public void setTheoryYield(double theoryYield) {
		this.theoryYield = theoryYield;
	}
	public double getActualYield() {
		return actualYield;
	}
	public void setActualYield(double actualYield) {
		this.actualYield = actualYield;
	}
	public double getTheoryActualYield() {
		return theoryActualYield;
	}
	public void setTheoryActualYield(double theoryActualYield) {
		this.theoryActualYield = theoryActualYield;
	}
	public List<ChemicalCompoundReagentsEntity> getCompoundReagents() {
		return compoundReagents;
	}
	public void setCompoundReagents(List<ChemicalCompoundReagentsEntity> compoundReagents) {
		this.compoundReagents = compoundReagents;
	}
	public List<ChemicalReagentRelationEntity> getChemicalReagentRelations() {
		return chemicalReagentRelations;
	}
	public void setChemicalReagentRelations(List<ChemicalReagentRelationEntity> chemicalReagentRelations) {
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
	
	public String getAssemblyOutputLotNums() {
		return assemblyOutputLotNums;
	}
	public void setAssemblyOutputLotNums(String assemblyOutputLotNums) {
		this.assemblyOutputLotNums = assemblyOutputLotNums;
	}
	public String getPfOutputLotNums() {
		return pfOutputLotNums;
	}
	public void setPfOutputLotNums(String pfOutputLotNums) {
		this.pfOutputLotNums = pfOutputLotNums;
	}
	public String getOcOutputLotNums() {
		return ocOutputLotNums;
	}
	public void setOcOutputLotNums(String ocOutputLotNums) {
		this.ocOutputLotNums = ocOutputLotNums;
	}

	public interface ADD{};  
	public interface SAVE{};
}

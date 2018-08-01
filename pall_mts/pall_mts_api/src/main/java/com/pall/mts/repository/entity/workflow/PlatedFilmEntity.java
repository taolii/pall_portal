package com.pall.mts.repository.entity.workflow;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 化学镀膜APS对象
 */
public class PlatedFilmEntity {
	/*
	 * 唯一标示
	 */
	@NotNull(message="{platedfilmManage.form.valid.OpticalCoatingEntity.pfID.NotEmpty}",groups={SAVE.class})
	private Integer pfID;
	/*
	 * 涂层日期
	 */
	@NotEmpty(message="{platedfilmManage.form.valid.OpticalCoatingEntity.coatingTime.NotEmpty}",groups={SAVE.class,ADD.class})
	private String coatingTime;
	/*
	 * 镀膜日期
	 */
	//@NotEmpty(message="{platedfilmManage.form.valid.OpticalCoatingEntity.coatingTime.NotEmpty}",groups={SAVE.class,ADD.class})
	private String pfTime;
	/*
	 * input LOT#
	 */
	@NotEmpty(message="{platedfilmManage.form.valid.OpticalCoatingEntity.inputLotNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String inputLotNum;
	/*
	 * input Qty(pcs)
	 */
	@NotNull(message="{platedfilmManage.form.valid.OpticalCoatingEntity.inputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer inputQty;
	/*
	 * 光纤的料号及批次号,Fixture#
	 */
	@NotNull(message="{platedfilmManage.form.valid.OpticalCoatingEntity.fixtureNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String fixtureNum;
	/*
	 * 光纤的料号及批次号,Fixture属性
	 */
	@NotNull(message="{platedfilmManage.form.valid.OpticalCoatingEntity.fixtureAttribute.NotEmpty}",groups={SAVE.class,ADD.class})
	private String fixtureAttribute;
	
	/*
	 * 哪一瓶化学溶剂 APS Bottle
	 */

	private String apsBottle;
	/*
	 * Output LOT#
	 */
	@NotNull(message="{platedfilmManage.form.valid.OpticalCoatingEntity.outputLotNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String outputLotNum;
	/*
	 * output Qty(pcs)
	 */
	@NotNull(message="{platedfilmManage.form.valid.OpticalCoatingEntity.outputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer outputQty;
	/*
	 * 碎片数量Scrap Qty(pcs)
	 */
	private Integer scrapQty;
	/*
	 * Under IQC Qty(pcs)
	 */
	
	private Integer underIQCQty;
	/*
	 * Under IQC Qty(pcs)
	 */
	
	private String sfBomNum;
	/*
	 * Under IQC Qty(pcs)
	 */
	
	private String[] sfBoms;
	/*
	 * Q-NUM
	 */
	private Integer qNum;
	/*
	 * K-NUM
	 */
	private Integer kNum;
	/*
	 * QC Use Qty(pcs)
	 */
	private Integer qcUseQty;
	/*
	 * Functional Test Qty(pcs)
	 */
	private Integer functionalTestQty;
	/*
	 * To HUB Qty(pcs)
	 */
	private Integer toHUBQty;
	/*
	 * REMAIN QTY
	 */
	private Integer remainQty;
	/*
	 * APS condition
	 */
	private String apsCondition;
	/*
	 * 零件号
	 */
	@NotEmpty(message="{platedfilmManage.form.valid.OpticalCoatingEntity.partNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String partNum;
	/*
	 * 工单号
	 */
	@NotEmpty(message="{platedfilmManage.form.valid.OpticalCoatingEntity.workOrderNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String workOrderNum;
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
	
	public Integer getPfID() {
		return pfID;
	}
	public void setPfID(Integer pfID) {
		this.pfID = pfID;
	}
	public String getCoatingTime() {
		return coatingTime;
	}
	public void setCoatingTime(String coatingTime) {
		this.coatingTime = coatingTime;
	}
	public String getPfTime() {
		return pfTime;
	}
	public void setPfTime(String pfTime) {
		this.pfTime = pfTime;
	}
	public String getInputLotNum() {
		return inputLotNum;
	}
	public void setInputLotNum(String inputLotNum) {
		this.inputLotNum = inputLotNum;
	}
	public Integer getInputQty() {
		return inputQty;
	}
	public void setInputQty(Integer inputQty) {
		this.inputQty = inputQty;
	}
	public String getFixtureNum() {
		return fixtureNum;
	}
	public void setFixtureNum(String fixtureNum) {
		this.fixtureNum = fixtureNum;
	}
	public String getFixtureAttribute() {
		return fixtureAttribute;
	}
	public void setFixtureAttribute(String fixtureAttribute) {
		this.fixtureAttribute = fixtureAttribute;
	}
	public String getApsBottle() {
		return apsBottle;
	}
	public void setApsBottle(String apsBottle) {
		this.apsBottle = apsBottle;
	}
	public String getOutputLotNum() {
		return outputLotNum;
	}
	public void setOutputLotNum(String outputLotNum) {
		this.outputLotNum = outputLotNum;
	}
	public Integer getOutputQty() {
		return outputQty;
	}
	public void setOutputQty(Integer outputQty) {
		this.outputQty = outputQty;
	}
	public Integer getScrapQty() {
		return scrapQty;
	}
	public void setScrapQty(Integer scrapQty) {
		this.scrapQty = scrapQty;
	}
	public Integer getUnderIQCQty() {
		return underIQCQty;
	}
	public void setUnderIQCQty(Integer underIQCQty) {
		this.underIQCQty = underIQCQty;
	}
	public String getSfBomNum() {
		return sfBomNum;
	}
	public void setSfBomNum(String sfBomNum) {
		this.sfBomNum = sfBomNum;
	}
	public Integer getqNum() {
		return qNum;
	}
	public void setqNum(Integer qNum) {
		this.qNum = qNum;
	}
	public Integer getkNum() {
		return kNum;
	}
	public void setkNum(Integer kNum) {
		this.kNum = kNum;
	}
	public Integer getQcUseQty() {
		return qcUseQty;
	}
	public void setQcUseQty(Integer qcUseQty) {
		this.qcUseQty = qcUseQty;
	}
	public Integer getFunctionalTestQty() {
		return functionalTestQty;
	}
	public void setFunctionalTestQty(Integer functionalTestQty) {
		this.functionalTestQty = functionalTestQty;
	}
	public Integer getToHUBQty() {
		return toHUBQty;
	}
	public void setToHUBQty(Integer toHUBQty) {
		this.toHUBQty = toHUBQty;
	}
	public Integer getRemainQty() {
		return remainQty;
	}
	public void setRemainQty(Integer remainQty) {
		this.remainQty = remainQty;
	}
	public String getApsCondition() {
		return apsCondition;
	}
	public void setApsCondition(String apsCondition) {
		this.apsCondition = apsCondition;
	}
	public String getPartNum() {
		return partNum;
	}
	public void setPartNum(String partNum) {
		this.partNum = partNum;
	}
	public String getWorkOrderNum() {
		return workOrderNum;
	}
	public void setWorkOrderNum(String workOrderNum) {
		this.workOrderNum = workOrderNum;
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
	
	public String[] getSfBoms() {
		return sfBoms;
	}
	public void setSfBoms(String[] sfBoms) {
		this.sfBoms = sfBoms;
	}

	public interface ADD{};  
	public interface SAVE{};
}

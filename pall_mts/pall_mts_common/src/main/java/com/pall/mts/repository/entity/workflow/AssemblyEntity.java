package com.pall.mts.repository.entity.workflow;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 清洁信息
 */
public class AssemblyEntity {
	/*
	 * 唯一标示
	 */
	@NotNull(message="{assemblyManage.form.valid.assemblyEntity.assemblyID.NotEmpty}",groups={SAVE.class})
	private Integer assemblyID;
	/*
	 * 交付日期
	 */
	private String deliveryTime;
	/*
	 * TRAY#
	 */
	@NotEmpty(message="{assemblyManage.form.valid.assemblyEntity.trayLotNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String trayLotNum;
	/*
	 * input LOT#
	 */
	@NotEmpty(message="{assemblyManage.form.valid.assemblyEntity.inputLotNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String inputLotNum;
	/*
	 * input Qty(pcs)
	 */
	@NotNull(message="{assemblyManage.form.valid.assemblyEntity.inputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer inputQty;
	/*
	 * 光纤的料号及批次号,Fixture#
	 */
	@NotNull(message="{assemblyManage.form.valid.assemblyEntity.fixtureNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String fixtureNum;
	/*
	 * HUB#
	 */

	private String hubLotNum;
	/*
	 * Output LOT#
	 */
	@NotNull(message="{assemblyManage.form.valid.assemblyEntity.outputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private String outputLotNum;
	/*
	 * output Qty(pcs)
	 */
	@NotNull(message="{assemblyManage.form.valid.assemblyEntity.outputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer outputQty;
	/*
	 * 碎片数量Scrap Qty(pcs)
	 */
	private Integer scrapQty;
	/*
	 * 缺损信息
	 */
	private List<DefectEntity> defects;
	
	/*
	 * 零件号
	 */
	@NotEmpty(message="{assemblyManage.form.valid.assemblyEntity.partNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String partNum;
	/*
	 * 工单号
	 */
	@NotEmpty(message="{assemblyManage.form.valid.assemblyEntity.workOrderNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String workOrderNum;
	/*
	 * drop down T01….T17  是TRAY#
	 */
	
	private String remark;
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
	private String[] assemblyBom;
	private String assemblyBoms;
	/*
	 * 装夹工作人员
	 */
	private String clampingCP;
	/*
	 * 拆夹工作人员
	 */
	private String clampDownTheCP;
	
	
	
	public Integer getAssemblyID() {
		return assemblyID;
	}
	public void setAssemblyID(Integer assemblyID) {
		this.assemblyID = assemblyID;
	}
	public String getDeliveryTime() {
		return deliveryTime;
	}
	public void setDeliveryTime(String deliveryTime) {
		this.deliveryTime = deliveryTime;
	}
	public String getTrayLotNum() {
		return trayLotNum;
	}
	public void setTrayLotNum(String trayLotNum) {
		this.trayLotNum = trayLotNum;
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
	public String getHubLotNum() {
		return hubLotNum;
	}
	public void setHubLotNum(String hubLotNum) {
		this.hubLotNum = hubLotNum;
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
	public List<DefectEntity> getDefects() {
		return defects;
	}
	public void setDefects(List<DefectEntity> defects) {
		this.defects = defects;
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	
	public String[] getAssemblyBom() {
		return assemblyBom;
	}
	public void setAssemblyBom(String[] assemblyBom) {
		this.assemblyBom = assemblyBom;
	}
	public String getAssemblyBoms() {
		return assemblyBoms;
	}
	public void setAssemblyBoms(String assemblyBoms) {
		this.assemblyBoms = assemblyBoms;
	}
	public String getClampingCP() {
		return clampingCP;
	}
	public void setClampingCP(String clampingCP) {
		this.clampingCP = clampingCP;
	}
	public String getClampDownTheCP() {
		return clampDownTheCP;
	}
	public void setClampDownTheCP(String clampDownTheCP) {
		this.clampDownTheCP = clampDownTheCP;
	}

	public interface ADD{};  
	public interface SAVE{};
}

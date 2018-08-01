package com.pall.mts.repository.entity.workflow;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 光学镀膜信息
 */
public class OpticalCoatingEntity {
	/*
	 * 唯一标示
	 */
	@NotNull(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.opfid.NotEmpty}",groups={SAVE.class})
	private Integer opfID;
	/*
	 * 镀膜日期
	 */
	@NotEmpty(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.optTime.NotEmpty}",groups={SAVE.class,ADD.class})
	private String optTime;
	
	/*
	 * input LOT#
	 */
	@NotEmpty(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.inputLotNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String inputLotNum;
	/*
	 * input Qty(pcs)
	 */
	@NotNull(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.inputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer inputQty;
	/*
	 * 光纤的料号及批次号,Fixture#
	 */
	@NotNull(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.fixtureNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String fixtureNum;
	/*
	 * Output LOT#
	 */
	@NotNull(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.outputLotNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String outputLotNum;
	/*
	 * output Qty(pcs)
	 */
	@NotNull(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.outputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer outputQty;
	/*
	 * 碎片数量Scrap Qty(pcs)
	 */
	private Integer scrapQty;
	/*
	 * QC Use Qty(pcs)
	 */
	@NotNull(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.qcUseQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer qcUseQty;
	/*
	 * To APS coating Qty(pcs)
	 */
	@NotNull(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.toOtherQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer toOtherQty;
	/*
	 * 缺损信息
	 */
	private List<DefectEntity> defects;
	
	/*
	 * 零件号
	 */
	@NotEmpty(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.partNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String partNum;
	/*
	 * 工单号
	 */
	@NotEmpty(message="{opticalfilmingManage.form.valid.OpticalCoatingEntity.workOrderNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String workOrderNum;
	/*
	 * 供应商信息
	 */
	private String supplier;
	/*
	 * Optical Coating bom
	 */
	private String ocBom;
	/*
	 * Optical Coating bom
	 */
	private String[] ocBoms;
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
	
	public Integer getOpfID() {
		return opfID;
	}
	public void setOpfID(Integer opfID) {
		this.opfID = opfID;
	}
	public String getOptTime() {
		return optTime;
	}
	public void setOptTime(String optTime) {
		this.optTime = optTime;
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
	public Integer getQcUseQty() {
		return qcUseQty;
	}
	public void setQcUseQty(Integer qcUseQty) {
		this.qcUseQty = qcUseQty;
	}
	
	public Integer getToOtherQty() {
		return toOtherQty;
	}
	public void setToOtherQty(Integer toOtherQty) {
		this.toOtherQty = toOtherQty;
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
	
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}

	public String getOcBom() {
		return ocBom;
	}
	public void setOcBom(String ocBom) {
		this.ocBom = ocBom;
	}
	
	public String[] getOcBoms() {
		return ocBoms;
	}
	public void setOcBoms(String[] ocBoms) {
		this.ocBoms = ocBoms;
	}

	public interface ADD{};  
	public interface SAVE{};
}

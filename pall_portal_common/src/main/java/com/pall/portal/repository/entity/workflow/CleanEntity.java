package com.pall.portal.repository.entity.workflow;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

import com.pall.portal.repository.entity.workflow.PolishEntity.ADD;
import com.pall.portal.repository.entity.workflow.PolishEntity.SAVE;

/*
 * 清洗信息
 */
public class CleanEntity {
	/*
	 * 唯一标示
	 */
	@NotNull(message="{cleanmanage.form.valid.CleanEntity.cleanID.NotEmpty}",groups={SAVE.class})
	private Integer cleanID;
	/*
	 * 清洗日期
	 */
	@NotEmpty(message="{cleanmanage.form.valid.CleanEntity.cleanTime.NotEmpty}",groups={SAVE.class,ADD.class})
	private String cleanTime;
	/*
	 * 光纤的料号及批次号
	 */
	@NotEmpty(message="{cleanmanage.form.valid.CleanEntity.fixtureNumber.NotEmpty}",groups={SAVE.class,ADD.class})
	private String fixtureNumber;
	/*
	 * polish 完成后产生的LOT#
	 */
	@NotEmpty(message="{cleanmanage.form.valid.CleanEntity.inputLotNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String inputLotNum;
	/*
	 * 抛光数量
	 */
	@NotNull(message="{cleanmanage.form.valid.CleanEntity.inputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer inputQty;
	/*
	 * clean Bom
	 */
	private String cleanBom;
	/*
	 * clean Bom
	 */
	private String[] cleanBoms;
	/*
	 * Clean LOT#
	 */
	@NotEmpty(message="{cleanmanage.form.valid.CleanEntity.cleanLotNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String cleanLotNum;
	/*
	 * 碎片数量
	 */
	private Integer scrapQty;
	/*
	 * 输出数量
	 */
	@NotNull(message="{cleanmanage.form.valid.CleanEntity.outputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer outputQty;
	/*
	 * 缺损信息
	 */
	private List<DefectEntity> defects;
	/*
	 * to other qty
	 */
	private Integer toOtherQty;
	/*
	 * 合格率
	 */
	private double yield;
	
	/*
	 * 零件号
	 */
	@NotEmpty(message="{cleanmanage.form.valid.CleanEntity.partNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String partNum;
	/*
	 * 工单号
	 */
	@NotEmpty(message="{cleanmanage.form.valid.CleanEntity.workOrderNum.NotEmpty}",groups={SAVE.class,ADD.class})
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
	
	
	public Integer getCleanID() {
		return cleanID;
	}
	public void setCleanID(Integer cleanID) {
		this.cleanID = cleanID;
	}
	public String getCleanTime() {
		return cleanTime;
	}
	public void setCleanTime(String cleanTime) {
		this.cleanTime = cleanTime;
	}
	public String getCleanLotNum() {
		return cleanLotNum;
	}
	public void setCleanLotNum(String cleanLotNum) {
		this.cleanLotNum = cleanLotNum;
	}
	public Integer getScrapQty() {
		return scrapQty;
	}
	public void setScrapQty(Integer scrapQty) {
		this.scrapQty = scrapQty;
	}
	public Integer getOutputQty() {
		return outputQty;
	}
	public void setOutputQty(Integer outputQty) {
		this.outputQty = outputQty;
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
	public double getYield() {
		return yield;
	}
	public void setYield(double yield) {
		this.yield = yield;
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
	
	public String getFixtureNumber() {
		return fixtureNumber;
	}
	public void setFixtureNumber(String fixtureNumber) {
		this.fixtureNumber = fixtureNumber;
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
	public String getCleanBom() {
		return cleanBom;
	}
	public void setCleanBom(String cleanBom) {
		this.cleanBom = cleanBom;
	}

	public String[] getCleanBoms() {
		return cleanBoms;
	}
	public void setCleanBoms(String[] cleanBoms) {
		this.cleanBoms = cleanBoms;
	}

	public interface ADD{};  
	public interface SAVE{};
}

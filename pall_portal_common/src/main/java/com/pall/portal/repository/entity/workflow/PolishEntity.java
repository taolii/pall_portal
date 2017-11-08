package com.pall.portal.repository.entity.workflow;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 抛光信息
 */
public class PolishEntity {
	/*
	 * 唯一标示
	 */
	@NotNull(message="{polshmanage.form.valid.PolishEntity.polishID.NotEmpty}",groups={SAVE.class})
	private Integer polishID;
	/*
	 * 领料日期
	 */
	@NotEmpty(message="{polshmanage.form.valid.PolishEntity.pickingTime.NotEmpty}",groups={SAVE.class,ADD.class})
	private String pickingTime;
	/*
	 * 抛光时间
	 */
	@NotEmpty(message="{polshmanage.form.valid.PolishEntity.polishTime.NotEmpty}",groups={SAVE.class,ADD.class})
	private String polishTime;
	/*
	 * 供应商来料LOT#
	 */
	@NotEmpty(message="{polshmanage.form.valid.PolishEntity.inputLotNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String inputLotNum;
	/*
	 * 抛光数量
	 */
	@NotNull(message="{polshmanage.form.valid.PolishEntity.inputQty.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer inputQty;
	/*
	 * 光纤的料号及批次号
	 */
	@NotEmpty(message="{polshmanage.form.valid.PolishEntity.fixtureNumber.NotEmpty}",groups={SAVE.class,ADD.class})
	private String fixtureNumber;
	/*
	 * 测量值，多个测量值以逗号分隔
	 */
	private String measuredValues;
	/*
	 * 抛磨盘序列号
	 */
	
	private String throwMillstoneNum;
	/*
	 * 抛磨盘位置
	 */
	private String throwMillstonePosition;
	/*
	 * 缺损信息
	 */
	private List<DefectEntity> defects;
	/*
	 * 抽检总数
	 */
	@NotNull(message="{polshmanage.form.valid.PolishEntity.casualInspectionNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private Integer casualInspectionNum;
	/*
	 * 合格率
	 */
	private double yield;
	/*
	 * polish 完成后产生的LOT#
	 */
	@NotEmpty(message="{polshmanage.form.valid.PolishEntity.polishLotNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String polishLotNum;
	/*
	 * 零件号
	 */
	@NotEmpty(message="{polshmanage.form.valid.PolishEntity.partNum.NotEmpty}",groups={SAVE.class,ADD.class})
	private String partNum;
	/*
	 * 工单号
	 */
	@NotEmpty(message="{polshmanage.form.valid.PolishEntity.workOrderNum.NotEmpty}",groups={SAVE.class,ADD.class})
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
	
	public Integer getPolishID() {
		return polishID;
	}
	public void setPolishID(Integer polishID) {
		this.polishID = polishID;
	}
	public String getPickingTime() {
		return pickingTime;
	}
	public void setPickingTime(String pickingTime) {
		this.pickingTime = pickingTime;
	}
	public String getPolishTime() {
		return polishTime;
	}
	public void setPolishTime(String polishTime) {
		this.polishTime = polishTime;
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
	public String getFixtureNumber() {
		return fixtureNumber;
	}
	public void setFixtureNumber(String fixtureNumber) {
		this.fixtureNumber = fixtureNumber;
	}
	public String getThrowMillstoneNum() {
		return throwMillstoneNum;
	}
	public void setThrowMillstoneNum(String throwMillstoneNum) {
		this.throwMillstoneNum = throwMillstoneNum;
	}
	public String getThrowMillstonePosition() {
		return throwMillstonePosition;
	}
	public void setThrowMillstonePosition(String throwMillstonePosition) {
		this.throwMillstonePosition = throwMillstonePosition;
	}
	public List<DefectEntity> getDefects() {
		return defects;
	}
	public void setDefects(List<DefectEntity> defects) {
		this.defects = defects;
	}
	public Integer getCasualInspectionNum() {
		return casualInspectionNum;
	}
	public void setCasualInspectionNum(Integer casualInspectionNum) {
		this.casualInspectionNum = casualInspectionNum;
	}
	public double getYield() {
		return yield;
	}
	public void setYield(double yield) {
		this.yield = yield;
	}
	public String getPolishLotNum() {
		return polishLotNum;
	}
	public void setPolishLotNum(String polishLotNum) {
		this.polishLotNum = polishLotNum;
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
	
	public String getMeasuredValues() {
		return measuredValues;
	}
	public void setMeasuredValues(String measuredValues) {
		this.measuredValues = measuredValues;
	}

	public interface ADD{};  
	public interface SAVE{};
}

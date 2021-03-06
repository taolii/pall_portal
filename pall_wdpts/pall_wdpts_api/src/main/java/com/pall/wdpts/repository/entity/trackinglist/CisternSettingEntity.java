package com.pall.wdpts.repository.entity.trackinglist;

import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 水箱配置对象
 */
public class CisternSettingEntity {
	private Integer csid;
	/*
	 * 料号/PN
	 */
	@NotEmpty(message="{cisternSetting.form.cisternPn.NotEmpty}",groups={SAVE.class,ADD.class})
	private String cisternPn;
	/*
	 * 水箱型号/Model
	 */
	private String cisternModel;
	/*
	 * 水箱选配件/Options
	 */
	private String cisternOption;
	/*
	 * 水箱选配件/Options
	 */
	private String cisternOption2;
	private String cisternOptions;
	/*
	 * 水箱装配配置对象
	 */
	private List<CisternSettingAssembleEntity> cisternSettingAssembles;
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
	
	
	public Integer getCsid() {
		return csid;
	}
	public void setCsid(Integer csid) {
		this.csid = csid;
	}
	public String getCisternPn() {
		return cisternPn;
	}
	public void setCisternPn(String cisternPn) {
		this.cisternPn = cisternPn;
	}
	public List<CisternSettingAssembleEntity> getCisternSettingAssembles() {
		return cisternSettingAssembles;
	}
	public void setCisternSettingAssembles(List<CisternSettingAssembleEntity> cisternSettingAssembles) {
		this.cisternSettingAssembles = cisternSettingAssembles;
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
	
	public String getCisternModel() {
		return cisternModel;
	}
	public void setCisternModel(String cisternModel) {
		this.cisternModel = cisternModel;
	}
	public String getCisternOption() {
		return cisternOption;
	}
	public void setCisternOption(String cisternOption) {
		this.cisternOption = cisternOption;
	}
	public String getCisternOption2() {
		return cisternOption2;
	}
	public void setCisternOption2(String cisternOption2) {
		this.cisternOption2 = cisternOption2;
	}
	public String getCisternOptions() {
		return cisternOptions;
	}
	public void setCisternOptions(String cisternOptions) {
		this.cisternOptions = cisternOptions;
	}

	public interface ADD{};  
	public interface SAVE{};
}

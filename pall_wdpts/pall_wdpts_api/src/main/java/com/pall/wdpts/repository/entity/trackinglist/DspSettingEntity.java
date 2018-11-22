package com.pall.wdpts.repository.entity.trackinglist;

import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * Dsp配置对象
 */
public class DspSettingEntity {
	private Integer dsid;
	/*
	 * 料号/PN
	 */
	@NotEmpty(message="{dspSetting.form.dspPn.NotEmpty}",groups={SAVE.class,ADD.class})
	private String dspPn;
	/*
	 * Dsp型号/Model
	 */
	private String dspModel;
	/*
	 * Dsp装配配置对象
	 */
	private List<DspSettingAssembleEntity> dspSettingAssembles;
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
	
	public Integer getDsid() {
		return dsid;
	}
	public void setDsid(Integer dsid) {
		this.dsid = dsid;
	}
	public String getDspPn() {
		return dspPn;
	}
	public void setDspPn(String dspPn) {
		this.dspPn = dspPn;
	}
	public List<DspSettingAssembleEntity> getDspSettingAssembles() {
		return dspSettingAssembles;
	}
	public void setDspSettingAssembles(List<DspSettingAssembleEntity> dspSettingAssembles) {
		this.dspSettingAssembles = dspSettingAssembles;
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
	
	public String getDspModel() {
		return dspModel;
	}
	public void setDspModel(String dspModel) {
		this.dspModel = dspModel;
	}

	public interface ADD{};  
	public interface SAVE{};
}

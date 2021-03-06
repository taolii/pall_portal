package com.pall.wdpts.repository.entity.trackinglist;

import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 预处理配置对象
 */
public class PreprocessingSettingEntity {
	private Integer psid;
	/*
	 * 料号/PN
	 */
	@NotEmpty(message="{preprocessingSetting.form.preprocessingPn.NotEmpty}",groups={SAVE.class,ADD.class})
	private String preprocessingPn;
	/*
	 * 名称/Model
	 */
	private String preprocessingModel;
	/*
	 * PT选配件/Option
	 */
	private String ptOptions;
	/*
	 * PT选配件/Option
	 */
	private String ptOption;
	/*
	 * PT选配件/Option
	 */
	private String ptOption2;
	/*
	 * 预处理送检配置对象
	 */
	private List<PreprocessingSettingInspectEntity> preprocessingSettingInspects;
	/*
	 * 预处理装配配置对象
	 */
	private List<PreprocessingSettingAssembleEntity> preprocessingSettingAssembles;
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
	
	
	public Integer getPsid() {
		return psid;
	}
	public void setPsid(Integer psid) {
		this.psid = psid;
	}
	public String getPreprocessingPn() {
		return preprocessingPn;
	}
	public void setPreprocessingPn(String preprocessingPn) {
		this.preprocessingPn = preprocessingPn;
	}
	public List<PreprocessingSettingInspectEntity> getPreprocessingSettingInspects() {
		return preprocessingSettingInspects;
	}
	public void setPreprocessingSettingInspects(List<PreprocessingSettingInspectEntity> preprocessingSettingInspects) {
		this.preprocessingSettingInspects = preprocessingSettingInspects;
	}
	public List<PreprocessingSettingAssembleEntity> getPreprocessingSettingAssembles() {
		return preprocessingSettingAssembles;
	}
	public void setPreprocessingSettingAssembles(List<PreprocessingSettingAssembleEntity> preprocessingSettingAssembles) {
		this.preprocessingSettingAssembles = preprocessingSettingAssembles;
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

	public String getPreprocessingModel() {
		return preprocessingModel;
	}
	public void setPreprocessingModel(String preprocessingModel) {
		this.preprocessingModel = preprocessingModel;
	}
	public String getPtOptions() {
		return ptOptions;
	}
	public void setPtOptions(String ptOptions) {
		this.ptOptions = ptOptions;
	}
	public String getPtOption() {
		return ptOption;
	}
	public void setPtOption(String ptOption) {
		this.ptOption = ptOption;
	}
	public String getPtOption2() {
		return ptOption2;
	}
	public void setPtOption2(String ptOption2) {
		this.ptOption2 = ptOption2;
	}

	public interface ADD{};  
	public interface SAVE{};
}

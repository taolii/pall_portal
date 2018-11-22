package com.pall.wdpts.repository.entity.trackinglist;

import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 主机配置对象
 */
public class MainframeSettingEntity {
	private Integer msid;
	/*
	 * 料号/PN
	 */
	@NotEmpty(message="{mainframeSetting.form.mainframePn.NotEmpty}",groups={SAVE.class,ADD.class})
	private String mainframePn;
	/*
	 * 主机型号/Model
	 */
	private String mainframeModel;
	/*
	 * 主机选配件/Option
	 */
	private String mainframeOption;
	/*
	 * 主机选配件/Option
	 */
	private String mainframeOption2;
	/*
	 * 主机选配件/Option
	 */
	private String mainframeOptions;
	/*
	 * 主机送检配置对象
	 */
	private List<MainframeSettingInspectEntity> mainframeSettingInspects;
	/*
	 * 主机装配配置对象
	 */
	private List<MainframeSettingAssembleEntity> mainframeSettingAssembles;
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
	
	
	public Integer getMsid() {
		return msid;
	}
	public void setMsid(Integer msid) {
		this.msid = msid;
	}
	public String getMainframePn() {
		return mainframePn;
	}
	public void setMainframePn(String mainframePn) {
		this.mainframePn = mainframePn;
	}
	public List<MainframeSettingInspectEntity> getMainframeSettingInspects() {
		return mainframeSettingInspects;
	}
	public void setMainframeSettingInspects(List<MainframeSettingInspectEntity> mainframeSettingInspects) {
		this.mainframeSettingInspects = mainframeSettingInspects;
	}
	public List<MainframeSettingAssembleEntity> getMainframeSettingAssembles() {
		return mainframeSettingAssembles;
	}
	public void setMainframeSettingAssembles(List<MainframeSettingAssembleEntity> mainframeSettingAssembles) {
		this.mainframeSettingAssembles = mainframeSettingAssembles;
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
	
	public String getMainframeModel() {
		return mainframeModel;
	}
	public void setMainframeModel(String mainframeModel) {
		this.mainframeModel = mainframeModel;
	}
	public String getMainframeOption() {
		return mainframeOption;
	}
	public void setMainframeOption(String mainframeOption) {
		this.mainframeOption = mainframeOption;
	}
	public String getMainframeOption2() {
		return mainframeOption2;
	}
	public void setMainframeOption2(String mainframeOption2) {
		this.mainframeOption2 = mainframeOption2;
	}
	public String getMainframeOptions() {
		return mainframeOptions;
	}
	public void setMainframeOptions(String mainframeOptions) {
		this.mainframeOptions = mainframeOptions;
	}

	public interface ADD{};  
	public interface SAVE{};
}

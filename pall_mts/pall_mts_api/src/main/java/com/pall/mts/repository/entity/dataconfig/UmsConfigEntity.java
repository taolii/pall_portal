package com.pall.mts.repository.entity.dataconfig;
/*
 * 系统同一配置对象
 */
public class UmsConfigEntity {
	/*
	 * 配置项编号
	 */
	private String configid;
	/*
	 * 配置项名称
	 */
	private String configName;
	/*
	 * 配置项子系统类型：1-PUBLIC;2-polish;3-clean;
	 */
	private int configType;
	/*
	 * 配置项取值
	 */
	private String configValue;
	/*
	 * 配置项正则表达式
	 */
	private String configExpression;
	/*
	 * 否可以修改：1-可以更改；2-不可以更改
	 */
	private int allowModify;
	public String getConfigid() {
		return configid;
	}
	public void setConfigid(String configid) {
		this.configid = configid;
	}
	public String getConfigName() {
		return configName;
	}
	public void setConfigName(String configName) {
		this.configName = configName;
	}
	public int getConfigType() {
		return configType;
	}
	public void setConfigType(int configType) {
		this.configType = configType;
	}
	public String getConfigValue() {
		return configValue;
	}
	public void setConfigValue(String configValue) {
		this.configValue = configValue;
	}
	public String getConfigExpression() {
		return configExpression;
	}
	public void setConfigExpression(String configExpression) {
		this.configExpression = configExpression;
	}
	public int getAllowModify() {
		return allowModify;
	}
	public void setAllowModify(int allowModify) {
		this.allowModify = allowModify;
	}
	
}

package com.pall.mts.repository.entity.dataconfig;

import org.hibernate.validator.constraints.NotEmpty;

/*
 * 数据配置表配置对象
 */
public class DataConfigEntity {
	/*
	 * 数据配置id
	 */
	private int dataid;
	/*
	 * 数据类型
	 */
	private String dataType;
	private boolean checked;
	/*
	 * 操作员id
	 */
	private int operatorid;
	/*
	 * 创建时间
	 */
	private String createTime;
	/*
	 * 更新时间
	 */
	private String updateTime;
	/*
	 * 配置名
	 */
	@NotEmpty(message="{dataconfigmanage.form.valid.DataConfigEntity.configname.NotEmpty}")
	private String configName;
	/*
	 * 描述
	 */
	private String description;
	public int getDataid() {
		return dataid;
	}
	public void setDataid(int dataid) {
		this.dataid = dataid;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public int getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(int operatorid) {
		this.operatorid = operatorid;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getConfigName() {
		return configName;
	}
	public void setConfigName(String configName) {
		this.configName = configName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}

package com.pall.mts.repository.entity.dataconfig;

/*
 * 数据配置表配置类型对象
 */
public class DataConfigTypeEntity {
	/*
	 * 配置类型
	 */
	private String dataType;
	/*
	 * 配置类型映射名
	 */
	private String dataTypeName;
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getDataTypeName() {
		return dataTypeName;
	}
	public void setDataTypeName(String dataTypeName) {
		this.dataTypeName = dataTypeName;
	}
	
}

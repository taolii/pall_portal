package com.pall.mts.repository.entity.workflow;
/*
 * 缺损记录信息
 */
public class DefectEntity {
	/*
	 * 缺损关联id(如 defect_type为1 则defectid代表polish表唯一标示)
	 */
	private int defectID;
	/*
	 * 缺损类型 1:polish 2:clean
	 */
	private String defectType;
	/*
	 * 数据字典表唯一标示
	 */
	private int dataid;
	/*
	 * 缺损名
	 */
	private String defectName;
	/*
	 * 绑定属性名
	 */
	private String fieldName;
	/*
	 * 缺损值
	 */
	private int defectValue;
	public int getDefectID() {
		return defectID;
	}
	public void setDefectID(int defectID) {
		this.defectID = defectID;
	}
	public String getDefectType() {
		return defectType;
	}
	public void setDefectType(String defectType) {
		this.defectType = defectType;
	}
	public int getDataid() {
		return dataid;
	}
	public void setDataid(int dataid) {
		this.dataid = dataid;
	}
	public String getDefectName() {
		return defectName;
	}
	public void setDefectName(String defectName) {
		this.defectName = defectName;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public int getDefectValue() {
		return defectValue;
	}
	public void setDefectValue(int defectValue) {
		this.defectValue = defectValue;
	}
	
}

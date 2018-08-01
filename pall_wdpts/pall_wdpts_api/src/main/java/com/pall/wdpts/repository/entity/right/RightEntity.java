package com.pall.wdpts.repository.entity.right;

/*
 * 系统权限对象
 */
public class RightEntity {
	/*
	 * 权限配置id
	 */
	private int rightid;
	/*
	 * 权限类型
	 */
	private Integer rightType;
	/*
	 * 数据权限id
	 */
	private Integer dataid;
	/*
	 * 权限描述
	 */
	private String description;
	public int getRightid() {
		return rightid;
	}
	public void setRightid(int rightid) {
		this.rightid = rightid;
	}
	public Integer getRightType() {
		return rightType;
	}
	public void setRightType(Integer rightType) {
		this.rightType = rightType;
	}
	public Integer getDataid() {
		return dataid;
	}
	public void setDataid(Integer dataid) {
		this.dataid = dataid;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}

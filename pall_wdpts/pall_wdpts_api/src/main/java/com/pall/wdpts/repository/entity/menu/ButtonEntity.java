package com.pall.wdpts.repository.entity.menu;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

/*
 * 按钮对象
 */
public class ButtonEntity {
	/*
	 * 按钮id
	 */
	private Integer btnid;
	/*
	 * 菜单编号
	 */
	@NotBlank(message="{buttonManage.form.valid.buttonEntity.menuid.NotEmpty}")
	private String menuid;
	/*
	 * 菜单名称
	 */
	private String menuName;
	
	/*
	 * 按钮英文名称
	 */
	@NotBlank(message="{buttonManage.form.valid.buttonEntity.btnEName.NotEmpty}")
	private String btnEName;
	/*
	 * 按钮中文名称
	 */
	@NotBlank(message="{buttonManage.form.valid.buttonEntity.btnCName.NotEmpty}")
	private String btnCName;
	/*
	 * 按钮样式
	 */
	private String btnClass;
	/*
	 * 按钮图标样式
	 */
	private String btnIconClass;
	/*
	 * 描述信息
	 */
	@Length(min=0, max=100, message="{buttonManage.form.valid.buttonEntity.stringlength}")  
	private String description;
	
	public String getMenuid() {
		return menuid;
	}
	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}
	public String getBtnEName() {
		return btnEName;
	}
	public void setBtnEName(String btnEName) {
		this.btnEName = btnEName;
	}
	public String getBtnClass() {
		return btnClass;
	}
	public void setBtnClass(String btnClass) {
		this.btnClass = btnClass;
	}
	public String getBtnIconClass() {
		return btnIconClass;
	}
	public void setBtnIconClass(String btnIconClass) {
		this.btnIconClass = btnIconClass;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getBtnCName() {
		return btnCName;
	}
	public void setBtnCName(String btnCName) {
		this.btnCName = btnCName;
	}
	
	public Integer getBtnid() {
		return btnid;
	}
	public void setBtnid(Integer btnid) {
		this.btnid = btnid;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	
}

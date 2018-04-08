package com.pall.portal.repository.entity.user;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;

/*
 * 用户实体对象
 */
public class UserEntity {
	/*
	 * 操作员编号
	 */
	private int operatorid;
	/*
	 * 操作员名称
	 */
	@NotBlank(message="{usermanage.form.valid.UserEntity.name.NotEmpty}",groups={ADD.class,SAVE.class})
	private String name;
	/*
	 * 用户账号
	 */
	@NotBlank(message="{usermanage.form.valid.UserEntity.account.NotEmpty}",groups={ADD.class,SAVE.class})
	@Length(min=4,max=18, message="{usermanage.form.valid.UserEntity.account.Length}",groups={ADD.class,SAVE.class}) 
	private String account;
	/*
	 * 登录密码 
	 */
	@NotBlank(message="{usermanage.form.valid.UserEntity.password.NotEmpty}",groups={ADD.class})
	@Length(min=4,max=18, message="{usermanage.form.valid.UserEntity.password.Length}",groups={ADD.class,SAVE.class}) 
	private String password;
	/*
	 * 性别0为男，1为女
	 */
	//@NotBlank(message = "{usermanage.form.valid.UserEntity.sex.NotEmpty}",groups={ADD.class})  
	private String sex;
	/*
	 * 职务
	 */
	private String position;
	/*
	 * 部门
	 */
	private int deptid;
	/*
	 * 手机
	 */
	@NotBlank(message="{usermanage.form.valid.UserEntity.mobile.NotEmpty}",groups={ADD.class,SAVE.class})
	//@Pattern(regexp="^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$",message="{usermanage.form.valid.UserEntity.mobile.Pattern}",groups={ADD.class,SAVE.class}) 
	private String mobile;
	/*
	 * 电子信箱
	 */
	@NotBlank(message="{usermanage.form.valid.UserEntity.email.NotEmpty}",groups={ADD.class,SAVE.class})
	@Email(message="{usermanage.form.valid.UserEntity.email.Pattern}",groups={ADD.class,SAVE.class}) 
	private String email;
	/*
	 * 角色组列表
	 */
	private String[] roleList;
	/*
	 * 省份代码
	 */
	private String provinceid;
	/*
	 * 1：系统管理员 2:普通用户
	 */
	@Range(min =1,max = 2, message ="{usermanage.form.valid.UserEntity.operatorType.Range}",groups={ADD.class}) 
	private Integer operatorType;
	/*
	 * 用户状态：1、暂停；2、正常；3、锁定；4、失效；5、删除
	 */
	private int status;
	/*
	 * 管理员初次登陆需更改密码标记 0、不需要 1、需要更改
	 */
	private int updatePwdFlag;
	/*
	 * 创建时间
	 */
	private String createTime;
	/*
	 * 修改时间
	 */
	private String updateTime;
	
	
	public int getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(int operatorid) {
		this.operatorid = operatorid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getDeptid() {
		return deptid;
	}
	public void setDeptid(int deptid) {
		this.deptid = deptid;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String[] getRoleList() {
		return roleList;
	}
	public void setRoleList(String[] roleList) {
		this.roleList = roleList;
	}
	public String getProvinceid() {
		return provinceid;
	}
	public void setProvinceid(String provinceid) {
		this.provinceid = provinceid;
	}
	public Integer getOperatorType() {
		return operatorType;
	}
	public void setOperatorType(Integer operatorType) {
		this.operatorType = operatorType;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getUpdatePwdFlag() {
		return updatePwdFlag;
	}
	public void setUpdatePwdFlag(int updatePwdFlag) {
		this.updatePwdFlag = updatePwdFlag;
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
	public interface ADD{};  
	public interface SAVE{};
}

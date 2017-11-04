package com.pall.portal.repository.entity.user;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

/*
 * 修改用户密码对象
 */

public class ModifyUPwdEntity {
	/*
	 * 操作员id
	 */
	@NotEmpty(message="{usermanage.form.valid.ModifyUPwdEntity.operatorid.NotEmpty}",groups={ADMIN.class,COMMON.class})
	private String operatorid;
	/*
	 * 登录账号
	 */
	@NotEmpty(message="{usermanage.form.valid.ModifyUPwdEntity.account.NotEmpty}",groups={ADMIN.class,COMMON.class})
	@Length(min=4,max=18, message="{usermanage.form.valid.ModifyUPwdEntity.account.Length}",groups={ADMIN.class,COMMON.class}) 
	private String account;
	/*
	 * 登录密码
	 */
	@NotEmpty(message="{usermanage.form.valid.ModifyUPwdEntity.password.NotEmpty}",groups={COMMON.class})
	@Length(min=4,max=18, message="{usermanage.form.valid.ModifyUPwdEntity.password.Length}",groups={COMMON.class}) 
	private String password;
	/*
	 * 新密码
	 */
	@NotEmpty(message="{usermanage.form.valid.ModifyUPwdEntity.newPwd.NotEmpty}",groups={ADMIN.class,COMMON.class})
	@Length(min=4,max=18, message="{usermanage.form.valid.ModifyUPwdEntity.newPwd.Length}",groups={ADMIN.class,COMMON.class}) 
	private String newPwd;
	/*
	 * 新密码确认
	 */
	@NotEmpty(message="{usermanage.form.valid.ModifyUPwdEntity.ensureNewPwd.NotEmpty}",groups={ADMIN.class,COMMON.class})
	@Length(min=4,max=18, message="{usermanage.form.valid.ModifyUPwdEntity.ensureNewPwd.Length}",groups={ADMIN.class,COMMON.class})
	private String ensureNewPwd;
	public String getNewPwd() {
		return newPwd;
	}
	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}
	public String getEnsureNewPwd() {
		return ensureNewPwd;
	}
	public void setEnsureNewPwd(String ensureNewPwd) {
		this.ensureNewPwd = ensureNewPwd;
	}
	
	
	public String getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(String operatorid) {
		this.operatorid = operatorid;
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

	public interface ADMIN{};  
	public interface COMMON{};
}

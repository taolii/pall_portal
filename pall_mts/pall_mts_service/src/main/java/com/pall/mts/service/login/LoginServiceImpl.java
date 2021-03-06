package com.pall.mts.service.login;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Repository;

import com.alibaba.druid.util.StringUtils;
import com.pall.mts.common.constants.IResponseConstants;
import com.pall.mts.common.i18n.ResourceUtils;
import com.pall.mts.common.response.BaseResponse;
import com.pall.mts.repository.entity.login.LoginEntity;
import com.pall.mts.repository.entity.user.UserEntity;
import com.pall.mts.service.login.LoginService;
import com.pall.mts.service.user.UserManageService;

@Repository
public class LoginServiceImpl implements LoginService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	@Autowired
	private UserManageService userManageService;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseResponse isLogin(LoginEntity loginEntity) {
		BaseResponse baseResponse=null;
		try {
			//校验
			/*if(StringUtils.isEmpty(loginEntity.getSessionValidCode())){
				baseResponse=new BaseResponse();
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(messageSource.getMessage("user.login.error.islogin.nogetsession.validcode", null, LocaleContextHolder.getLocale()));
				return baseResponse;
			}*/
			/*if(!loginEntity.getSessionValidCode().equalsIgnoreCase(loginEntity.getValidCode())){
				baseResponse=new BaseResponse();
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(messageSource.getMessage("user.login.error.islogin.check.validcode.nopass", null, LocaleContextHolder.getLocale()));
				return baseResponse;
			}*/
			if(StringUtils.isEmpty(loginEntity.getLoginName()) || StringUtils.isEmpty(loginEntity.getLoginPasswd())){
				baseResponse=new BaseResponse();
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("user.login.error.usernameorpassword", null, LocaleContextHolder.getLocale()));
				return baseResponse;
			}
			baseResponse=userManageService.findUserByUserName(null,loginEntity.getLoginName());
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				UserEntity userEntity=(UserEntity)baseResponse.getReturnObjects().get(0);
				if(loginEntity.getLoginPasswd().equals(userEntity.getPassword())){
					return baseResponse;
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("user.login.error.usernameorpassword", null, LocaleContextHolder.getLocale()));
					return baseResponse;
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("user.login.error.islogin.exception"),e);
			baseResponse=new BaseResponse();
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("user.login.error.islogin.exception", null, LocaleContextHolder.getLocale()));
		}
		return baseResponse;
	}
	public void setUserManageService(UserManageService userManageService) {
		this.userManageService = userManageService;
	}
	
}

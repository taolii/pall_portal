package com.pall.mts.service.login;

import org.springframework.stereotype.Service;

import com.pall.mts.common.response.BaseResponse;
import com.pall.mts.repository.entity.login.LoginEntity;

@Service
public interface LoginService {
	/*
	 * 用户登录验证接口
	 * @param loginEntity 登录实体对象
	 * @return 返回登录验证结果 0 登录成功，否则失败
	 */
	public BaseResponse isLogin(LoginEntity loginEntity);
}

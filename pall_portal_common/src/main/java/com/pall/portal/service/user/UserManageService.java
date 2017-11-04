package com.pall.portal.service.user;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.repository.entity.user.ModifyUPwdEntity;
import com.pall.portal.repository.entity.user.UserEntity;
import com.pall.portal.repository.entity.user.UserQueryFormEntity;
/*
 * 用户管理服务
 */
@Service
public interface UserManageService {
	/*
	 * 根据条件查询用户信息
	 * @param userName 用户名
	 * @param operatorid操作员id
	 * @return 查询结果
	 */
	public BaseResponse findUserByUserName(String operatorid,String  userName) throws Exception;
	/*
	 * 根据条件查询用户列表
	 * @param userQueryFormEntity 用户列表查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse findUserList(UserQueryFormEntity  userQueryFormEntity) throws Exception;
	/*
	 * 添加用户
	 * @param userEntity 添加用户信息
	 * @return 添加结果
	 */
	public BaseResponse addUser(UserEntity userEntity) throws Exception;
	/*
	 * 修改用户信息
	 * @param userEntity 修改用户信息
	 * @return 修改结果
	 */
	public BaseResponse modifyUser(UserEntity userEntity) throws Exception;
	/*
	 * 修改用户信息
	 * @param aoperatorid 需要删除的用户操作员列表
	 * @return 删除结果
	 */
	public BaseResponse delUser(List<String> operatorids) throws Exception;
	/*
	 * 修改用户密码
	 * @param modifyUPwdEntity 密码修改信息
	 * @param isAdmin 是否是管理员修改
	 * @return 删除结果
	 */
	public BaseResponse modifyPwd(ModifyUPwdEntity modifyUPwdEntity,boolean isAdmin) throws Exception;
}

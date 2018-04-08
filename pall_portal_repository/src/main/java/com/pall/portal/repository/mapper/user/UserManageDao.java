package com.pall.portal.repository.mapper.user;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.portal.repository.entity.user.ModifyUPwdEntity;
import com.pall.portal.repository.entity.user.UserEntity;
import com.pall.portal.repository.entity.user.UserPermissionEntity;
import com.pall.portal.repository.entity.user.UserQueryFormEntity;
@Repository("userManageDao")
public interface UserManageDao {
	/*
	 * 根据条件查询用户信息
	 * @param userName 用户名
	 * @param operatorid操作员id
	 * @return 查询结果
	 */
	public UserEntity findUserByUserName(@Param("operatorid") String operatorid,@Param("userName") String  userName);
	/*
	 * 根据条件查询符合条件的用户总数
	 * @param userQueryFormEntity 用户查询对象
	 * @return 查询结果
	 */
	public int findUserTotalRecords(UserQueryFormEntity  userQueryFormEntity);
	/*
	 * 根据条件查询用户列表
	 * @param userQueryFormEntity 用户列表查询对象
	 * @return 查询结果
	 */
	public List<UserEntity> findUserList(UserQueryFormEntity  userQueryFormEntity);
	/*
	 * 添加用户
	 * @param userEntity 添加用户信息
	 * @return 添加结果
	 */
	public int addUser(UserEntity userEntity);
	/*
	 * 修改用户信息
	 * @param userEntity 修改用户信息
	 * @return 
	 */
	public int modifyUser(UserEntity userEntity);
	/*
	 * 修改用户信息
	 * @param operatorids 删除操作员信息
	 * @return 
	 */
	public int delUser(@Param("operatorids") List<String> operatorids);
	/*
	 * 修改用户密码
	 * @param modifyUPwdEntity 密码修改信息
	 * @return 
	 */
	public int modifyPwd(ModifyUPwdEntity modifyUPwdEntity);
	/*
	 * 添加用户权限
	 * @param userPermissionEntity 用户角色赋权对象
	 * @return 
	 */
	public int addUserPermission(UserPermissionEntity userPermissionEntity);
	/*
	 * 删除用户权限
	 * @param operatorids 根据操作员id删除用户权限
	 * @return 
	 */
	public int delUserPermission(@Param("operatorids") List<String> operatorids);
	/*
	 * 根据条件查询用户角色信息
	 * @param operatorid操作员id
	 * @return 查询结果
	 */
	public List<UserPermissionEntity> findUserPermission(@Param("operatorid") String operatorid);
}

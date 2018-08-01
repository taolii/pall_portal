package com.pall.mts.service.role;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.mts.common.response.BaseResponse;
import com.pall.mts.common.response.BaseTablesResponse;
import com.pall.mts.repository.entity.role.RoleEntity;
import com.pall.mts.repository.entity.role.RoleQueryFormEntity;

/*
 * 角色管理服务
 */
@Service
public interface RoleManageService {
	/*
	 * 根据条件查询角色信息
	 * @param roleQueryFormEntity 角色列表查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryRoleList(RoleQueryFormEntity  roleQueryFormEntity) throws Exception;
	/*
	 * 根据条件获取树形角色
	 * @param proleid 父角色id
	 * @return 查询结果
	 */
	public BaseResponse getTreeRole(String proleid) throws Exception;
	/*
	 * 删除角色信息
	 * @param roleids 需要删除的角色列表
	 * @return 删除结果
	 */
	public BaseResponse delRole(List<String> roleids) throws Exception;
	/*
	 * 新增角色信息
	 * @param roleEntity 角色对象
	 * @return 结果
	 */
	public BaseResponse addRole(RoleEntity roleEntity) throws Exception;
	/*
	 * 修改角色信息
	 * @param roleEntity 角色对象
	 * @return 结果
	 */
	public BaseResponse modRole(RoleEntity roleEntity) throws Exception;
	
}

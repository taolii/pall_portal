package com.pall.wdpts.repository.mapper.role;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pall.wdpts.repository.entity.role.RoleEntity;
import com.pall.wdpts.repository.entity.role.RoleQueryFormEntity;
/*
 * 角色数据访问层
 */
public interface RoleManageDao {
	/*
	 * 根据条件查询角色信息
	 * @param roleQueryFormEntity 角色列表查询对象
	 * @return 查询结果
	 */
	public List<RoleEntity> queryRoleList(RoleQueryFormEntity  roleQueryFormEntity);
	/*
	 * 根据条件查询角色总记录数
	 * @param roleQueryFormEntity 角色列表查询对象
	 * @return 查询结果
	 */
	public int queryRoleTotalRecords(RoleQueryFormEntity  roleQueryFormEntity);
	/*
	 * 删除角色信息
	 * @param roleids 删除角色信息
	 * @return 
	 */
	public int delRole(@Param("roleids") List<String> roleids);
	/*
	 * 新增角色信息
	 * @param roleEntity 角色对象
	 * @return 结果
	 */
	public int addRole(RoleEntity roleEntity);
	/*
	 * 修改角色信息
	 * @param roleEntity 角色对象
	 * @return 结果
	 */
	public int modRole(RoleEntity roleEntity);
	/*
	 * 根据条件查询树形角色信息
	 * @param proleid 父角色id
	 * @return 查询结果
	 */
	public List<RoleEntity> getTreeRole(@Param("proleid") String proleid);
}

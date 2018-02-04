package com.pall.portal.repository.mapper.right;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pall.portal.repository.entity.right.RightEntity;
import com.pall.portal.repository.entity.right.RightQueryFormEntity;
/*
 * 权限数据访问层
 */
public interface RightManageDao {
	/*
	 * 根据条件查询权限信息
	 * @param rightQueryFormEntity 权限列表查询对象
	 * @return 查询结果
	 */
	public List<RightEntity> queryRightList(RightQueryFormEntity  rightQueryFormEntity);
	/*
	 * 根据条件查询权限总记录数
	 * @param rightQueryFormEntity 权限列表查询对象
	 * @return 查询结果
	 */
	public int queryRightTotalRecords(RightQueryFormEntity  rightQueryFormEntity);
	/*
	 * 删除权限信息
	 * @param rightids 删除权限信息
	 * @return 
	 */
	public int delRight(@Param("rightids") List<String> rightids);
	/*
	 * 新增权限信息
	 * @param rightEntity 权限对象
	 * @return 结果
	 */
	public int addRight(RightEntity rightEntity);
	/*
	 * 修改权限信息
	 * @param rightEntity 权限对象
	 * @return 结果
	 */
	public int modRight(RightEntity rightEntity);
}

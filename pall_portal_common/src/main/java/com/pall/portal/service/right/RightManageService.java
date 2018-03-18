package com.pall.portal.service.right;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.repository.entity.right.RightEntity;
import com.pall.portal.repository.entity.right.RightQueryFormEntity;

/*
 * 权限管理服务
 */
@Service
public interface RightManageService {
	/*
	 * 根据条件查询权限信息
	 * @param rightQueryFormEntity 权限列表查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryRightList(RightQueryFormEntity  rightQueryFormEntity) throws Exception;
	/*
	 * 删除权限信息
	 * @param rightids 需要删除的权限列表
	 * @param rightTypes 权限类型集合
	 * @return 删除结果
	 */
	public BaseResponse delRight(List<String> rightids,List<String> rightTypes) throws Exception;
	/*
	 * 新增权限信息
	 * @param rightEntity 权限对象
	 * @return 结果
	 */
	public BaseResponse addRight(RightEntity rightEntity) throws Exception;
	/*
	 * 修改权限信息
	 * @param rightEntity 权限对象
	 * @return 结果
	 */
	public BaseResponse modRight(RightEntity rightEntity) throws Exception;
	
}

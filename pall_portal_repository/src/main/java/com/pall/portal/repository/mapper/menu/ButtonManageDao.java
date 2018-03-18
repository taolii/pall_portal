package com.pall.portal.repository.mapper.menu;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.repository.entity.menu.ButtonEntity;
import com.pall.portal.repository.entity.menu.ButtonQueryFormEntity;
@Repository("buttonManageDao")
public interface ButtonManageDao {
	/*
	 * 根据条件查询按钮信息
	 * @param buttonQueryFormEntity 按钮列表查询对象
	 * @return 查询结果
	 */
	public List<ButtonEntity> queryButtonList(ButtonQueryFormEntity  buttonQueryFormEntity);
	/*
	 * 根据条件查询菜单按钮总记录数
	 * @param buttonQueryFormEntity 按钮列表查询对象
	 * @return 查询结果
	 */
	public int queryButtonTotalRecords(ButtonQueryFormEntity  buttonQueryFormEntity);
	/*
	 * 新增按钮信息
	 * @param buttonEntity 按钮对象
	 * @return 结果
	 */
	public int addButton(ButtonEntity buttonEntity) throws Exception;
	/*
	 * 修改按钮信息
	 * @param buttonEntity 按钮对象
	 * @return 结果
	 */
	public int modButton(ButtonEntity buttonEntity) throws Exception;
	/*
	 * 根据菜单id删除按钮信息
	 * @param menuids 菜单列表
	 * @return 删除结果
	 */
	public BaseResponse delButton(@Param("menuids") List<String> menuids,@Param("btnids") List<String> btnids);
	
}

package com.pall.portal.repository.mapper.menu;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.portal.repository.entity.menu.MenuInfoEntity;
import com.pall.portal.repository.entity.menu.QueryMenuFormEntity;
@Repository("menuManageDao")
public interface MenuManageDao {
	/*
	 * 根据条件菜单信息
	 * @param pmenuid 父菜单编号
	 * @param operatorid 操作员id
	 * @return 查询结果
	 */
	public List<MenuInfoEntity> getMenusByPMenuid(@Param("pmenuid") int  pmenuid,@Param("operatorid") String operatorid);
	/*
	 * 根据条件查询菜单信息
	 * @param queryMenuFormEntity 菜单列表查询对象
	 * @return 查询结果
	 */
	public List<MenuInfoEntity> queryMenuList(QueryMenuFormEntity  queryMenuFormEntity);
	/*
	 * 根据条件查询菜单信息
	 * @param pmenuid 父菜单id
	 * @return 查询结果
	 */
	public List<MenuInfoEntity> getTreeMenu(@Param("pmenuid") String pmenuid);
	/*
	 * 根据条件查询菜单总记录数
	 * @param queryMenuFormEntity 菜单列表查询对象
	 * @return 查询结果
	 */
	public int queryMenuTotalRecords(QueryMenuFormEntity  queryMenuFormEntity);
	/*
	 * 删除菜单信息
	 * @param menuids 删除菜单信息
	 * @return 
	 */
	public int delMenu(@Param("menuids") List<String> menuids);
	/*
	 * 新增菜单信息
	 * @param menuEntity 菜单对象
	 * @return 结果
	 */
	public int addMenu(MenuInfoEntity menuEntity);
	/*
	 * 修改菜单信息
	 * @param menuEntity 菜单对象
	 * @return 结果
	 */
	public int modMenu(MenuInfoEntity menuEntity);
	/*
	 * 根据菜单id获取菜单信息
	 * @param menuEntity 菜单对象
	 * @return 查询结果
	 */
	public MenuInfoEntity findMenuById(MenuInfoEntity menuEntity);
}

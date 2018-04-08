package com.pall.portal.service.menu;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.repository.entity.menu.MenuInfoEntity;
import com.pall.portal.repository.entity.menu.QueryMenuFormEntity;

/*
 * 菜单管理服务
 */
@Service
public interface MenuManageService {
	/*
	 * 根据条件菜单信息
	 * @param pmenuid 父菜单编号
	 * @param operatorid 操作员id
	 * @return 查询结果
	 */
	public BaseResponse getMenusByPMenuid(int  pmenuid,String operatorid)throws Exception;
	/*
	 * 根据条件查询菜单信息
	 * @param roleQueryFormEntity 菜单列表查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryMenuList(QueryMenuFormEntity  queryMenuFormEntity) throws Exception;
	/*
	 * 根据条件获取树形菜单
	 * @param pmenuid 父菜单id
	 * @return 查询结果
	 */
	public BaseResponse getTreeMenu(String pmenuid) throws Exception;
	/*
	 * 根据条件获取树形菜单按钮
	 * @param pmenuid 父菜单id
	 * @return 查询结果
	 */
	public BaseResponse getTreeMenuButton(String pmenuid) throws Exception;
	/*
	 * 删除菜单信息
	 * @param menuids 需要删除的菜单列表
	 * @return 删除结果
	 */
	public BaseResponse delMenu(List<String> menuids) throws Exception;
	/*
	 * 新增菜单信息
	 * @param menuEntity 菜单对象
	 * @return 结果
	 */
	public BaseResponse addMenu(MenuInfoEntity menuEntity) throws Exception;
	/*
	 * 修改菜单信息
	 * @param menuEntity 菜单对象
	 * @return 结果
	 */
	public BaseResponse modMenu(MenuInfoEntity menuEntity) throws Exception;
	/*
	 * 根据菜单id获取菜单信息
	 * @param menuEntity 菜单对象
	 * @return 查询结果
	 */
	public BaseResponse findMenuById(MenuInfoEntity menuEntity) throws Exception;
	
}

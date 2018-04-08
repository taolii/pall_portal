package com.pall.portal.service.menu;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.repository.entity.menu.ButtonEntity;
import com.pall.portal.repository.entity.menu.ButtonQueryFormEntity;

/*
 * 按钮管理服务
 */
@Service
public interface ButtonManageService {
	
	/*
	 * 根据菜单id删除按钮信息
	 * @param menuids 菜单列表
	 * @param btnids 按钮列表
	 * @return 删除结果
	 */
	public BaseResponse delButton(List<String> menuids,List<String>  btnids) throws Exception;
	/*
	 * 根据条件查询按钮信息
	 * @param buttonQueryFormEntity 按钮列表查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryButtonList(ButtonQueryFormEntity  buttonQueryFormEntity) throws Exception;
	/*
	 * 新增按钮信息
	 * @param buttonEntity 按钮对象
	 * @return 结果
	 */
	public BaseResponse addButton(ButtonEntity buttonEntity) throws Exception;
	/*
	 * 修改按钮信息
	 * @param buttonEntity 按钮对象
	 * @return 结果
	 */
	public BaseResponse modButton(ButtonEntity buttonEntity) throws Exception;
	/*
	 * 根据条件查询按钮信息
	 * @param  按钮列表查询对象
	 * @return 查询结果
	 */
	public BaseResponse getRightButton(String operatorid) throws Exception;
}

package com.pall.portal.service.menu;

import org.springframework.stereotype.Service;

import com.pall.portal.common.response.BaseResponse;

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
}

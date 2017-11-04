package com.pall.portal.repository.mapper.menu;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.portal.repository.entity.menu.MenuInfoEntity;
@Repository("menuManageDao")
public interface MenuManageDao {
	/*
	 * 根据条件菜单信息
	 * @param pmenuid 父菜单编号
	 * @param operatorid 操作员id
	 * @return 查询结果
	 */
	public List<MenuInfoEntity> getMenusByPMenuid(@Param("pmenuid") int  pmenuid,@Param("operatorid") String operatorid);
}

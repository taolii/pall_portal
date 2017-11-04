package com.pall.portal.service.menu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.repository.entity.menu.MenuInfoEntity;
import com.pall.portal.repository.entity.menu.TreeMenuInfo;
import com.pall.portal.repository.mapper.menu.MenuManageDao;
import com.pall.portal.service.menu.MenuManageService;
@Repository
public class MenuManageServiceImpl implements MenuManageService{
	@Autowired
	private MenuManageDao menuManageDao;
	@Override
	public BaseResponse getMenusByPMenuid(int pmenuid,String operatorid) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		List<MenuInfoEntity> menus=menuManageDao.getMenusByPMenuid(pmenuid,operatorid);
		if(menus!=null){
			List<TreeMenuInfo> treeMenuInfos=getSubMenus(menus,pmenuid);
			baseResponse.setReturnObjects(treeMenuInfos);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}else{
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
		}
		return baseResponse;
	}
	/*
	 * 递归获取子菜单
	 */
	private List<TreeMenuInfo> getSubMenus(List<MenuInfoEntity> menus,int pmenuid){
		List<TreeMenuInfo> treeMenuInfos=new ArrayList<TreeMenuInfo>();
		//同级菜单
		Map<Integer,TreeMenuInfo> levelmenuMap=new HashMap<Integer,TreeMenuInfo>();
		Map<Integer,List<MenuInfoEntity>> leftmenuMap=new HashMap<Integer,List<MenuInfoEntity>>();
		for(MenuInfoEntity menuInfo:menus){
			if(menuInfo.getPmenuid()==pmenuid){
				TreeMenuInfo treeMenuInfo=new TreeMenuInfo();
				treeMenuInfo.setPmenuInfo(menuInfo);
				treeMenuInfos.add(treeMenuInfo);
				levelmenuMap.put(menuInfo.getMenuid(), treeMenuInfo);
			}else{
				if(leftmenuMap.get(menuInfo.getPmenuid())==null){
					leftmenuMap.put(menuInfo.getPmenuid(), new ArrayList<MenuInfoEntity>());
					leftmenuMap.get(menuInfo.getPmenuid()).add(menuInfo);
				}else{
					leftmenuMap.get(menuInfo.getPmenuid()).add(menuInfo);
				}
			}
		}
		if(leftmenuMap.size()>0){
			for(int key:leftmenuMap.keySet()){
				levelmenuMap.get(key).setSubMenuInfos(getSubMenus(leftmenuMap.get(key),key));
			}
		}
		return treeMenuInfos;
	}
}

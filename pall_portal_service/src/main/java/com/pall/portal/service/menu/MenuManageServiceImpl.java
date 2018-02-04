package com.pall.portal.service.menu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.datatables.Entity.DatatablesView;
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.repository.entity.menu.MenuInfoEntity;
import com.pall.portal.repository.entity.menu.QueryMenuFormEntity;
import com.pall.portal.repository.entity.menu.TreeMenuInfo;
import com.pall.portal.repository.mapper.menu.MenuManageDao;
@Repository
public class MenuManageServiceImpl implements MenuManageService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private MenuManageDao menuManageDao;
	@Autowired
	private ResourceUtils resourceUtils;
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
	@Override
	public BaseTablesResponse queryMenuList(QueryMenuFormEntity queryMenuFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=menuManageDao.queryMenuTotalRecords(queryMenuFormEntity);
			//分页查询结果集
			List<MenuInfoEntity> menuEntitys=menuManageDao.queryMenuList(queryMenuFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(queryMenuFormEntity.getDraw());
			if(menuEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(menuEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("menumanage.service.queryMenuList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.service.queryMenuList.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delMenu(List<String> menuids) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			//删除当前节点菜单信息
			menuManageDao.delMenu(menuids);
			QueryMenuFormEntity  queryMenuFormEntity=new QueryMenuFormEntity();
			queryMenuFormEntity.setPageSize(Integer.MAX_VALUE);
			List<String> pmenuids=delSubMenu(queryMenuFormEntity);
			while(pmenuids!=null && pmenuids.size()>0){
				queryMenuFormEntity.setpMenuids(pmenuids);
				pmenuids=delSubMenu(queryMenuFormEntity);
			}
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("menumanage.service.delMenu.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.service.delMenu.exception")+e.toString());
		}
		return baseResponse;
	}
	/*
	 * 删除子菜单信息
	 */
	private List<String> delSubMenu(QueryMenuFormEntity  queryMenuFormEntity){
		List<MenuInfoEntity> menuEntitys=menuManageDao.queryMenuList(queryMenuFormEntity);
		List<String> menuids=null;
		if(menuEntitys!=null){
			menuids=new ArrayList<String>();
			for(MenuInfoEntity menuInfoEntity:menuEntitys){
				menuids.add(String.valueOf(menuInfoEntity.getMenuid()));
			}
			menuManageDao.delMenu(menuids);
		}
		return menuids;
	}
	@Override
	public BaseResponse addMenu(MenuInfoEntity menuEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=menuManageDao.addMenu(menuEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.dao.addMenu.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("menumanage.service.addMenu.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.service.addMenu.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse modMenu(MenuInfoEntity menuEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=menuManageDao.modMenu(menuEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.dao.modMenu.dao.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("menumanage.service.modMenu.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.service.modMenu.service.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse getTreeMenu(String pmenuid) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			List<MenuInfoEntity> menuEntitys=menuManageDao.getTreeMenu(pmenuid);
			if(menuEntitys!=null){
				List<TreeMenuInfo> treeMenuInfos=getSubMenus(menuEntitys,Integer.parseInt(pmenuid));
				baseResponse.setReturnObjects(treeMenuInfos);
			}
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("menumanage.service.queryMenuList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.service.queryMenuList.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse findMenuById(MenuInfoEntity menuEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			MenuInfoEntity tempMenuEntity=menuManageDao.findMenuById(menuEntity);
			if(tempMenuEntity!=null){
				List<MenuInfoEntity> menuInfoEntitys=new ArrayList<MenuInfoEntity>();
				menuInfoEntitys.add(tempMenuEntity);
				baseResponse.setReturnObjects(menuInfoEntitys);
			}
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("menumanage.service.findMenuById.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.service.findMenuById.exception")+e.toString());
		}
		return baseResponse;
	}
}

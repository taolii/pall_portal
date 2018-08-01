package com.pall.wdpts.service.menu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.constants.KeyConstants;
import com.pall.wdpts.common.datatables.Entity.DatatablesView;
import com.pall.wdpts.common.i18n.ResourceUtils;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.init.UmsConfigInitiator;
import com.pall.wdpts.repository.entity.menu.ButtonEntity;
import com.pall.wdpts.repository.entity.menu.ButtonQueryFormEntity;
import com.pall.wdpts.repository.entity.menu.MenuInfoEntity;
import com.pall.wdpts.repository.entity.menu.QueryMenuFormEntity;
import com.pall.wdpts.repository.entity.menu.TreeMenuInfo;
import com.pall.wdpts.repository.entity.right.RightEntity;
import com.pall.wdpts.repository.mapper.menu.ButtonManageDao;
import com.pall.wdpts.repository.mapper.menu.MenuManageDao;
import com.pall.wdpts.repository.mapper.right.RightManageDao;
@Repository
public class MenuManageServiceImpl implements MenuManageService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private MenuManageDao menuManageDao;
	@Autowired
	private ButtonManageDao buttonManageDao;
	@Autowired
	private RightManageDao rightManageDao;
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
		if(menus==null) return null;
		List<TreeMenuInfo> treeMenuInfos=new ArrayList<TreeMenuInfo>();
		//同级菜单
		Map<Integer,TreeMenuInfo> levelmenuMap=new HashMap<Integer,TreeMenuInfo>();
		List<MenuInfoEntity> leftMenus=new ArrayList<MenuInfoEntity>();
		for(MenuInfoEntity menuInfo:menus){
			if(menuInfo.getPmenuid()==pmenuid){
				TreeMenuInfo treeMenuInfo=new TreeMenuInfo();
				treeMenuInfo.setPmenuInfo(menuInfo);
				treeMenuInfos.add(treeMenuInfo);
				levelmenuMap.put(menuInfo.getMenuid(), treeMenuInfo);
			}else{
				leftMenus.add(menuInfo);
			}
		}
		if(null!=levelmenuMap && levelmenuMap.size()>0){
			for(int key:levelmenuMap.keySet()){
				levelmenuMap.get(key).setSubMenuInfos(getSubMenus(leftMenus,key));
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
	@Transactional(rollbackFor=Exception.class)
	public BaseResponse delMenu(List<String> menuids) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			ButtonQueryFormEntity buttonQueryFormEntity=new ButtonQueryFormEntity();
			buttonQueryFormEntity.setStartPageNum(0);
			buttonQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			List<ButtonEntity> buttonEntitys=buttonManageDao.queryButtonList(buttonQueryFormEntity);
			//删除权限信息
			if(buttonEntitys!=null && buttonEntitys.size()>0){
				List<String> dataids=new ArrayList<String>();
				for(ButtonEntity buttonEntity:buttonEntitys){
					dataids.add(String.valueOf(buttonEntity.getBtnid()));
				}
				rightManageDao.delRoleRight(dataids, null);
				rightManageDao.delRight(dataids, null);
			}
			buttonManageDao.delButton(menuids, null);
			//删除当前节点菜单信息
			menuManageDao.delMenu(menuids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("menumanage.service.delMenu.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.service.delMenu.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	@Transactional(rollbackFor=Exception.class)
	public BaseResponse addMenu(MenuInfoEntity menuEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=menuManageDao.addMenu(menuEntity);
			if(resultNum>0){
				//添加数据权限
				RightEntity rightEntity=new RightEntity();
				rightEntity.setDataid(menuEntity.getMenuid());
				rightEntity.setRightType(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.RIGHT_BUTTON_RIGHTTYPE)));
				resultNum=rightManageDao.addRight(rightEntity);
				if(resultNum>0){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.dao.addMenu.failed"));
				}
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
	@Override
	public BaseResponse getTreeMenuButton(String pmenuid) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			List<MenuInfoEntity> menuInfoEntitys=menuManageDao.getTreeMenuButton(pmenuid);
			if(menuInfoEntitys!=null){
				if(menuInfoEntitys!=null){
					List<TreeMenuInfo> treeMenuInfos=getSubMenus(menuInfoEntitys,Integer.parseInt(pmenuid));
					baseResponse.setReturnObjects(treeMenuInfos);
				}
			}
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("menumanage.service.queryMenuList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.service.queryMenuList.exception")+e.toString());
		}
		return baseResponse;
	}
}

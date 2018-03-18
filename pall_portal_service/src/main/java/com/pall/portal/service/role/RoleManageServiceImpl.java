package com.pall.portal.service.role;

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
import com.pall.portal.repository.entity.role.RoleEntity;
import com.pall.portal.repository.entity.role.RoleQueryFormEntity;
import com.pall.portal.repository.entity.role.TreeRole;
import com.pall.portal.repository.mapper.role.RoleManageDao;

/*
 * 角色管理服务
 */
@Repository
public class RoleManageServiceImpl implements RoleManageService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private RoleManageDao roleManageDao;
	
	@Override
	public BaseTablesResponse queryRoleList(RoleQueryFormEntity  roleQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=roleManageDao.queryRoleTotalRecords(roleQueryFormEntity);
			//分页查询结果集
			List<RoleEntity> roleEntitys=roleManageDao.queryRoleList(roleQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(roleQueryFormEntity.getDraw());
			if(roleEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(roleEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("rolemanage.service.queryRoleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("rolemanage.service.queryRoleList.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delRole(List<String> roleids)  throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			roleManageDao.delRole(roleids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("roleManage.service.delRole.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.service.delRole.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse addRole(RoleEntity roleEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=roleManageDao.addRole(roleEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.dao.addRole.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("roleManage.service.addRole.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.service.addRole.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse modRole(RoleEntity roleEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=roleManageDao.modRole(roleEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.dao.modRole.dao.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("roleManage.service.modRole.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.service.modRole.service.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse getTreeRole(String proleid) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			List<RoleEntity> roleEntitys=roleManageDao.getTreeRole(proleid);
			if(roleEntitys!=null){
				List<TreeRole> treeRoles=getSubRoles(roleEntitys,Integer.parseInt(proleid));
				baseResponse.setReturnObjects(treeRoles);
			}
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("roleManage.service.getTreeRole.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.service.getTreeRole.exception")+e.toString());
		}
		return baseResponse;
	}
	/*
	 * 递归获取子菜单
	 */
	private List<TreeRole> getSubRoles(List<RoleEntity> roles,int proleid){
		List<TreeRole> treeRoles=new ArrayList<TreeRole>();
		//同级菜单
		Map<Integer,TreeRole> levelroleMap=new HashMap<Integer,TreeRole>();
		Map<Integer,List<RoleEntity>> leftroleMap=new HashMap<Integer,List<RoleEntity>>();
		for(RoleEntity roleEntity:roles){
			if(roleEntity.getpRoleid()==proleid){
				TreeRole treeRole=new TreeRole();
				treeRole.setRoleEntity(roleEntity);
				treeRoles.add(treeRole);
				levelroleMap.put(roleEntity.getpRoleid(), treeRole);
			}else{
				if(leftroleMap.get(roleEntity.getpRoleid())==null){
					leftroleMap.put(roleEntity.getpRoleid(), new ArrayList<RoleEntity>());
					leftroleMap.get(roleEntity.getpRoleid()).add(roleEntity);
				}else{
					leftroleMap.get(roleEntity.getpRoleid()).add(roleEntity);
				}
			}
		}
		if(levelroleMap.size()>0){
			for(int key:levelroleMap.keySet()){
				levelroleMap.get(key).setSubRoleEntitys(getSubRoles(leftroleMap.get(key),key));
			}
		}
		return treeRoles;
	}
}

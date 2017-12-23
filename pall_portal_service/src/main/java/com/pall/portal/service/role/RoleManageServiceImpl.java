package com.pall.portal.service.role;

import java.util.List;

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
}

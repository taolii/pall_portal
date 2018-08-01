package com.pall.wdpts.service.user;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.druid.util.StringUtils;
import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.datatables.Entity.DatatablesView;
import com.pall.wdpts.common.i18n.ResourceUtils;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.user.UserEntity;
import com.pall.wdpts.repository.entity.user.UserPermissionEntity;
import com.pall.wdpts.repository.entity.user.UserPwdEntity;
import com.pall.wdpts.repository.entity.user.UserQueryFormEntity;
import com.pall.wdpts.repository.mapper.user.UserManageDao;

@Repository
public class UserManageServiceImpl implements UserManageService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	@Autowired
	private UserManageDao userManageDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseResponse findUserByUserName(String operatorid,String  userName) throws Exception { 
		BaseResponse baseResponse=new BaseResponse();
		UserEntity userEntity=userManageDao.findUserByUserName(operatorid,userName);
		if(userEntity!=null){
			//查询用户角色信息
			List<UserPermissionEntity> userPermissionEntitys=userManageDao.findUserPermission(operatorid);
			if(null!=userPermissionEntitys && userPermissionEntitys.size()>0){
				List<String> roleList=new ArrayList<String>();
				for(UserPermissionEntity userPermissionEntity:userPermissionEntitys){
					if(StringUtils.isEmpty(userPermissionEntity.getRoleid()))continue;
					roleList.add(userPermissionEntity.getRoleid());
				}
				if(roleList.size()>0){
					userEntity.setRoleList(roleList.toArray(new String[roleList.size()]));
				}
			}
			List<UserEntity> returnObjects=new ArrayList<UserEntity>();
			returnObjects.add(userEntity);
			baseResponse.setReturnObjects(returnObjects);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}else{
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.service.findUserByUserName.nofound"));
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
		}
		return baseResponse;
	}
	@Override
	@Transactional(rollbackFor=Exception.class)
	public BaseResponse addUser(UserEntity userEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			//判断用户是否重复
			UserEntity vuserEntity=userManageDao.findUserByUserName(null,userEntity.getAccount());
			if(vuserEntity!=null && !StringUtils.isEmpty(vuserEntity.getAccount())){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.addUser.service.dao.account.exists"));
			}else{
				int resultNum=userManageDao.addUser(userEntity);
				if(resultNum>0){
					if(null!=userEntity.getRoleList()&& userEntity.getRoleList().length>0){
						for(String roleid:userEntity.getRoleList()){
							if(StringUtils.isEmpty(roleid))continue;
							UserPermissionEntity userPermissionEntity=new UserPermissionEntity();
							userPermissionEntity.setOperatorid(userEntity.getOperatorid());
							userPermissionEntity.setRoleid(roleid);
							userManageDao.addUserPermission(userPermissionEntity);
						}
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.addUser.service.dao.failed"));
				}
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("usermanage.addUser.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.addUser.service.exception"));
		}
		return baseResponse;
	}

	@Override
	@Transactional(rollbackFor=Exception.class)
	public BaseResponse modifyUser(UserEntity userEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=userManageDao.modifyUser(userEntity);
			if(resultNum>0){
				if(userEntity.getOperatorType()==null){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					return baseResponse;
				}
				List<String> operatorids=new ArrayList<String>();
				operatorids.add(String.valueOf(userEntity.getOperatorid()));
				userManageDao.delUserPermission(operatorids);
				if(userEntity.getRoleList()!=null && userEntity.getRoleList().length>0){
					for(String roleid:userEntity.getRoleList()){
						if(StringUtils.isEmpty(roleid))continue;
						UserPermissionEntity userPermissionEntity=new UserPermissionEntity();
						userPermissionEntity.setOperatorid(userEntity.getOperatorid());
						userPermissionEntity.setRoleid(roleid);
						userManageDao.addUserPermission(userPermissionEntity);
					}
				}
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.modifyUser.dao.update.account.nofound"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("usermanage.modifyUser.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.modifyUser.service.exception"));
		}
		return baseResponse;
	}

	@Override
	@Transactional(rollbackFor=Exception.class)
	public BaseResponse delUser(List<String> operatorids) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			userManageDao.delUserPermission(operatorids);
			userManageDao.delUser(operatorids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("usermanage.delUser.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.delUser.service.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modifyPwd(UserPwdEntity userPwdEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			if(!"true".equals(userPwdEntity.getIsAdmin())){
				baseResponse = findUserByUserName(userPwdEntity.getOperatorid(),null);
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
					UserEntity userEntity=(UserEntity)baseResponse.getReturnObjects().get(0);
					if(!userPwdEntity.getPassword().equals(userEntity.getPassword())){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.modifyPwd.service.input.old.passwd.error"));
						return baseResponse;
					}
				}
			}
			if(!userPwdEntity.getNewPwd().equals(userPwdEntity.getEnsureNewPwd())){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.modifyPwd.service.inconformity.newandnewensure.passwd"));
			}else{
				userPwdEntity.setPassword(userPwdEntity.getNewPwd());
				int resultNum=userManageDao.modifyPwd(userPwdEntity);
				if(resultNum>0){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.modifyPwd.dao.update.account.nofound"));
				}
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("usermanage.modifyPwd.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.modifyPwd.service.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse findUserList(UserQueryFormEntity  userQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=userManageDao.findUserTotalRecords(userQueryFormEntity);
			//分页查询结果集
			List<UserEntity> userEntitys=userManageDao.findUserList(userQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(userQueryFormEntity.getDraw());
			if(userEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(userEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("usermanage.userManage.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.userManage.service.exception"));
		}
		return baseResponse;
	}
	
}

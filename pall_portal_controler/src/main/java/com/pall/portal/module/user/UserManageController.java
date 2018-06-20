package com.pall.portal.module.user;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.pall.portal.annotation.Token;
import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.constants.KeyConstants;
import com.pall.portal.common.exception.SystemException;
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.context.HolderContext;
import com.pall.portal.init.UmsConfigInitiator;
import com.pall.portal.interceptor.support.AuthToken;
import com.pall.portal.repository.entity.role.GroupRoleEntity;
import com.pall.portal.repository.entity.role.RoleEntity;
import com.pall.portal.repository.entity.role.RoleQueryFormEntity;
import com.pall.portal.repository.entity.user.UserEntity;
import com.pall.portal.repository.entity.user.UserEntity.ADD;
import com.pall.portal.repository.entity.user.UserEntity.SAVE;
import com.pall.portal.repository.entity.user.UserPwdEntity;
import com.pall.portal.repository.entity.user.UserPwdEntity.COMMON;
import com.pall.portal.repository.entity.user.UserQueryFormEntity;
import com.pall.portal.service.role.RoleManageService;
import com.pall.portal.service.user.UserManageService;
/*
 * 用户管理控制器
 */
@Controller
public class UserManageController{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	/*
	 * 用户管理服务
	 */
	@Autowired
	private UserManageService userManageService;
	/*
	 * 角色管理服务
	 */
	@Autowired
	private RoleManageService roleManageService;
	@Autowired
	private ResourceUtils resourceUtils;
	/*
	 * 用户管理
	 */
	@RequestMapping(value="user/userManage", method= RequestMethod.GET)
    public  String userManage(Model model, HttpServletRequest request) {
	   return "sysmanage/user/userManage";
    }
	@RequestMapping(value="user/userManage", method= RequestMethod.POST)
    public @ResponseBody String userManage(Model model,UserQueryFormEntity  userQueryFormEntity, HttpServletRequest request) {
		if(userQueryFormEntity.getPageSize()==0){
        	userQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
		try {
			baseResponse=userManageService.findUserList(userQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("usermanage.userManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.userManage.exception"));
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
	/*
	 * 显示用户添加页面
	 */
	@Token(flag=Token.READY)
	@RequestMapping(value="user/addUser", method= RequestMethod.GET)
    public  String addUser(Model model,HttpServletRequest request) {
		RoleQueryFormEntity roleQueryFormEntity=new RoleQueryFormEntity();
		roleQueryFormEntity.setStartPageNum(0);
		roleQueryFormEntity.setPageSize(Integer.MAX_VALUE);
		List<RoleEntity> roles=new ArrayList<RoleEntity>();
		try {
			BaseTablesResponse response=roleManageService.queryRoleList(roleQueryFormEntity);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==response.getResultCode()){
				roles.addAll((List<RoleEntity>)response.getDatatablesView().getData());
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("roleManage.controler.roleManage.exception"),e);
		}
		model.addAttribute("roles",roles);
		return "sysmanage/user/addUserInfo";
    }
	/*
	 * 添加用户
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="user/addUser", method= RequestMethod.POST)
    public  @ResponseBody String addUser(@Validated(ADD.class) UserEntity userEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				if(StringUtils.isEmpty(userEntity.getSex())){
					userEntity.setSex("0");
				}
				baseResponse=userManageService.addUser(userEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("usermanage.addUser.exeception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.addUser.exeception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 显示用户修改页面
	 */
	@Token(flag=Token.READY)
	@RequestMapping(value="user/personalInfoSettings", method= RequestMethod.GET)
    public  String personalInfoSettings(@RequestParam("operatorid") String operatorid,Model model) throws Exception{
		BaseResponse baseResponse=userManageService.findUserByUserName(operatorid,null);
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
			UserEntity userEntity=(UserEntity)baseResponse.getReturnObjects().get(0);
			model.addAttribute("userEntity", userEntity);
			return "sysmanage/user/personalInfoSettings";
		}else{
			throw new SystemException(baseResponse.getResultMsg());
		}
    }
	@Token(flag=Token.READY)
	@RequestMapping(value="user/modUser", method= RequestMethod.GET)
    public  String modUser(@RequestParam("operatorid") String operatorid,Model model) throws Exception{
		RoleQueryFormEntity roleQueryFormEntity=new RoleQueryFormEntity();
		roleQueryFormEntity.setStartPageNum(0);
		roleQueryFormEntity.setPageSize(Integer.MAX_VALUE);
		List<GroupRoleEntity> roles=new ArrayList<GroupRoleEntity>();
		try {
			BaseTablesResponse response=roleManageService.queryRoleList(roleQueryFormEntity);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==response.getResultCode()){
				for(RoleEntity role:(List<RoleEntity>)response.getDatatablesView().getData()){
					GroupRoleEntity groupRoleEntity=new GroupRoleEntity();
					groupRoleEntity.setRoleEntity(role);
					roles.add(groupRoleEntity);
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("roleManage.controler.roleManage.exception"),e);
		}
		model.addAttribute("operatorid", operatorid);
		BaseResponse baseResponse=userManageService.findUserByUserName(operatorid,null);
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
			UserEntity userEntity=(UserEntity)baseResponse.getReturnObjects().get(0);
			model.addAttribute("userEntity", userEntity);
			if(userEntity!=null && userEntity.getRoleList()!=null && userEntity.getRoleList().length>0){
				for(String roleid:userEntity.getRoleList()){
					for(GroupRoleEntity groupRoleEntity:roles){
						if(String.valueOf(groupRoleEntity.getRoleEntity().getRoleid()).equals(roleid)){
							groupRoleEntity.setChecked(true);
						}
					}
				}
			}
			model.addAttribute("roles",roles);
			return "sysmanage/user/modUserInfo";
		}else{
			throw new SystemException(baseResponse.getResultMsg());
		}
    }
	/*
	 * 修改用户信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="user/modifyUser", method= RequestMethod.POST)
    public  @ResponseBody String modifyUser(@Validated(SAVE.class) UserEntity userEntity,BindingResult result,Model model,HttpServletRequest request)throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				if(StringUtils.isEmpty(userEntity.getSex())){
					userEntity.setSex("0");
				}
				baseResponse=userManageService.modifyUser(userEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("usermanage.modifyUser.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.modifyUser.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除用户信息
	 */
	@RequestMapping(value="user/delUser", method= RequestMethod.POST)
    public @ResponseBody String delUser(@RequestParam("operatorids") String operatorids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aoperatorid=operatorids.split(",");
			List<String> operatoridl=Arrays.asList(aoperatorid);
			AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
			if(at!=null && at.getUserEntity()!=null){
				if(operatoridl.contains(String.valueOf(at.getUserEntity().getOperatorid()))){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.delUser.now.login.notdel"));
					return JSON.toJSONString(baseResponse);
				}
			}
			baseResponse=userManageService.delUser(operatoridl);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("usermanage.delUser.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.delUser.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	
	/*
	 * 显示个人用户密码修改页面
	 */
	@Token(flag=Token.READY)
	@RequestMapping(value="user/personalPwdSettings", method= RequestMethod.GET)
    public  String personalPwdSettings(@RequestParam("operatorid") String operatorid,Model model) throws Exception{
		BaseResponse baseResponse=userManageService.findUserByUserName(operatorid,null);
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
			UserEntity userEntity=(UserEntity)baseResponse.getReturnObjects().get(0);
			userEntity.setPassword("");
			model.addAttribute("userEntity", userEntity);
			return "sysmanage/user/personalPwdSettings";
		}else{
			throw new SystemException(baseResponse.getResultMsg());
		}
    }
	/*
	 * 提交用户修改密码结果
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="user/modifyPwd",method= RequestMethod.POST)
    public @ResponseBody String modifyPwd(@Validated(COMMON.class) UserPwdEntity userPwdEntity,BindingResult result,Model model,HttpServletRequest request){
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				baseResponse=userManageService.modifyPwd(userPwdEntity);
			}
			
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("usermanage.modifyPwd.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("usermanage.modifyPwd.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

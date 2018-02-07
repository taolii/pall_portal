package com.pall.portal.module.role;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
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
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.context.HolderContext;
import com.pall.portal.init.UmsConfigInitiator;
import com.pall.portal.repository.entity.menu.QueryMenuFormEntity;
import com.pall.portal.repository.entity.role.RoleEntity;
import com.pall.portal.repository.entity.role.RoleQueryFormEntity;
import com.pall.portal.service.role.RoleManageService;
/*
 * 角色管理控制器
 */
@Controller
public class RoleManageController{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	/*
	 * 角色管理服务
	 */
	@Autowired
	private RoleManageService roleManageService;
	@Autowired
	private ResourceUtils resourceUtils;
	/*
	 * 角色管理
	 */
	@RequestMapping(value="role/roleManage", method= RequestMethod.GET)
    public  String roleManage(Model model, HttpServletRequest request) {
	   return "sysmanage/role/roleManage";
    }
	
	@RequestMapping(value="role/roleManage", method= RequestMethod.POST)
    public @ResponseBody String roleManage(Model model,RoleQueryFormEntity  roleQueryFormEntity, HttpServletRequest request) {
        if(roleQueryFormEntity.getPageSize()==0){
        	roleQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
		try {
			baseResponse=roleManageService.queryRoleList(roleQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("roleManage.controler.roleManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.controler.roleManage.exception")+e.toString());
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
	/*
	 * 树形菜单
	 */
	@RequestMapping(value="role/treeRole", method= RequestMethod.POST)
    public @ResponseBody String treeRole(Model model,@RequestBody RoleQueryFormEntity  roleQueryFormEntity, HttpServletRequest request) {
        if(roleQueryFormEntity.getPageSize()<=0){
        	roleQueryFormEntity.setPageSize(Integer.MAX_VALUE);
        }
        BaseResponse baseResponse=new BaseResponse();
		try {
			if(StringUtils.isEmpty(roleQueryFormEntity.getRoleid())){
				roleQueryFormEntity.setRoleid(UmsConfigInitiator.getDataConfig(KeyConstants.DEFAULT_ROOT_MENU_ID));
			}
			baseResponse=roleManageService.getTreeRole(roleQueryFormEntity.getRoleid());
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("roleManage.controler.treeRole.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.controler.treeRole.exception")+e.toString());
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
	/*
	 * 删除角色信息
	 */
	@RequestMapping(value="role/delRole", method= RequestMethod.POST)
    public @ResponseBody String delRole(@RequestParam("roleids") String roleids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aRoleid=roleids.split(",");
			baseResponse=roleManageService.delRole(Arrays.asList(aRoleid));
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("roleManage.controler.delRole.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.controler.delRole.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 添加角色信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="role/addRole", method= RequestMethod.POST)
    public  @ResponseBody String addRole(@Valid RoleEntity roleEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				baseResponse=roleManageService.addRole(roleEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("roleManage.controler.addRole.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.controler.addRole.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 修改角色信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="role/modRole", method= RequestMethod.POST)
    public  @ResponseBody String modRole(@Valid RoleEntity roleEntity,BindingResult result,Model model,HttpServletRequest request)throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				baseResponse=roleManageService.modRole(roleEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("roleManage.controler.modRole.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("roleManage.controler.modRole.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

package com.pall.portal.module.menu;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import com.pall.portal.repository.entity.menu.MenuInfoEntity;
import com.pall.portal.repository.entity.menu.QueryMenuFormEntity;
import com.pall.portal.repository.entity.menu.TreeMenuInfo;
import com.pall.portal.service.menu.MenuManageService;
/*
 * 菜单管理控制器
 */
@Controller
public class MenuController {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private MenuManageService menuManageService;
	@RequestMapping(value="getAllmenus", method= RequestMethod.GET)
    public String list(Model model, Integer page, HttpServletRequest request) {
        return "main/main";
    }
	@Autowired
	private ResourceUtils resourceUtils;
	/*
	 * 菜单理
	 */
	@RequestMapping(value="menu/menuManage", method= RequestMethod.GET)
    public  String menuManage(Model model, HttpServletRequest request) {
	   return "sysmanage/menu/menuManage";
    }
	
	@RequestMapping(value="menu/menuManage", method= RequestMethod.POST)
    public @ResponseBody String menuManage(Model model,@RequestBody QueryMenuFormEntity  queryMenuFormEntity, HttpServletRequest request) {
        if(queryMenuFormEntity.getPageSize()<=0){
        	queryMenuFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
		try {
			baseResponse=menuManageService.queryMenuList(queryMenuFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("menuManage.controler.menuManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menuManage.controler.menuManage.exception")+e.toString());
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
	/*
	 * 获取菜单信息
	 */
	@RequestMapping(value="menu/findMenuById", method= RequestMethod.POST)
    public @ResponseBody String findMenuById(Model model,@RequestBody MenuInfoEntity menuInfoEntity, HttpServletRequest request) {
        BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=menuManageService.findMenuById(menuInfoEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("menuManage.controler.findMenuById.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menuManage.controler.findMenuById.exception")+e.toString());
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
	/*
	 * 树形菜单
	 */
	@RequestMapping(value="menu/treeMenu", method= RequestMethod.POST)
    public @ResponseBody String treeMenu(Model model,@RequestBody QueryMenuFormEntity  queryMenuFormEntity, HttpServletRequest request) {
        if(queryMenuFormEntity.getPageSize()<=0){
        	queryMenuFormEntity.setPageSize(Integer.MAX_VALUE);
        }
        BaseResponse baseResponse=new BaseResponse();
		try {
			if(StringUtils.isEmpty(queryMenuFormEntity.getpMenuid())){
				queryMenuFormEntity.setpMenuid(UmsConfigInitiator.getDataConfig(KeyConstants.DEFAULT_ROOT_MENU_ID));
			}
			baseResponse=menuManageService.getTreeMenu(queryMenuFormEntity.getpMenuid());
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("menuManage.controler.menuManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menuManage.controler.menuManage.exception")+e.toString());
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
	/*
	 * 删除菜单信息
	 */
	@RequestMapping(value="menu/delMenu", method= RequestMethod.POST)
    public @ResponseBody String delMenu(@RequestParam("menuids") String menuids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aMenuid=menuids.split(",");
			List<String> tempMenuid=new ArrayList<String>();
			//获取所有需要删除的菜单
			for(String menuid:aMenuid){
				if(tempMenuid.contains(menuid))continue;
				tempMenuid.add(menuid);
				baseResponse=menuManageService.getTreeMenu(menuid);
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
					tempMenuid.addAll(getTreeMenuid((List<TreeMenuInfo>)baseResponse.getReturnObjects()));
				}
			}
			baseResponse=menuManageService.delMenu(tempMenuid);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("menumanage.controler.delMenu.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.controler.delMenu.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 遍历所有菜单id
	 */
	private Set<String> getTreeMenuid(List<TreeMenuInfo> menus){
		Set<String> tempMenuid=new HashSet<String>();
		for(TreeMenuInfo treeMenuInfo:menus){
			tempMenuid.add(String.valueOf(treeMenuInfo.getPmenuInfo().getMenuid()));
			if(treeMenuInfo.getSubMenuInfos()!=null && treeMenuInfo.getSubMenuInfos().size()>0){
				tempMenuid.addAll(getTreeMenuid(treeMenuInfo.getSubMenuInfos()));
			}
		}
		return tempMenuid;
	}
	/*
	 * 添加数据字典
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="menu/addMenu", method= RequestMethod.POST)
    public  @ResponseBody String addMenu(@Valid MenuInfoEntity menuInfoEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				if(menuInfoEntity.getLeaf()==null){
					menuInfoEntity.setLeaf(0);
				}
				if(menuInfoEntity.getDisabled()==null){
					menuInfoEntity.setDisabled(0);;
				}
				baseResponse=menuManageService.addMenu(menuInfoEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("menumanage.controler.addMenu.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.controler.addMenu.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 修改菜单信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="menu/modMenu", method= RequestMethod.POST)
    public  @ResponseBody String modMenu(@Valid MenuInfoEntity menuInfoEntity,BindingResult result,Model model,HttpServletRequest request)throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				if(menuInfoEntity.getLeaf()==null){
					menuInfoEntity.setLeaf(0);
				}
				if(menuInfoEntity.getDisabled()==null){
					menuInfoEntity.setDisabled(0);;
				}
				baseResponse=menuManageService.modMenu(menuInfoEntity);
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
					baseResponse=menuManageService.findMenuById(menuInfoEntity);
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("menumanage.controler.modMenu.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.controler.modMenu.exception")+e.toString());
		}
		//baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 获取菜单按钮信息
	 */
	@RequestMapping(value="menu/getMenuButton", method= RequestMethod.POST)
    public @ResponseBody String getMenuButton(Model model,QueryMenuFormEntity  queryMenuFormEntity, HttpServletRequest request) {
		if(queryMenuFormEntity.getPageSize()<=0){
        	queryMenuFormEntity.setPageSize(Integer.MAX_VALUE);
        }
        BaseResponse baseResponse=new BaseResponse();
		try {
			if(StringUtils.isEmpty(queryMenuFormEntity.getpMenuid())){
				queryMenuFormEntity.setpMenuid(UmsConfigInitiator.getDataConfig(KeyConstants.DEFAULT_ROOT_MENU_ID));
			}
			baseResponse=menuManageService.getTreeMenuButton(queryMenuFormEntity.getpMenuid());
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("menuManage.controler.menuManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menuManage.controler.menuManage.exception")+e.toString());
			
		}
		logger.error(JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue));
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
}

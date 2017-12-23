package com.pall.portal.module.menu;

import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	 * 角色管理
	 */
	@RequestMapping(value="menu/menuManage", method= RequestMethod.GET)
    public  String menuManage(Model model, HttpServletRequest request) {
	   return "sysmanage/menu/menuManage";
    }
	
	@RequestMapping(value="menu/menuManage", method= RequestMethod.POST)
    public @ResponseBody String menuManage(Model model,QueryMenuFormEntity  queryMenuFormEntity, HttpServletRequest request) {
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
	 * 删除角色信息
	 */
	@RequestMapping(value="menu/delMenu", method= RequestMethod.POST)
    public @ResponseBody String delMenu(@RequestParam("roleids") String menuids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aMenuid=menuids.split(",");
			baseResponse=menuManageService.delMenu(Arrays.asList(aMenuid));
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("menumanage.controler.delMenu.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.controler.delMenu.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
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
				baseResponse=menuManageService.modMenu(menuInfoEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("menumanage.controler.modMenu.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("menumanage.controler.modMenu.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

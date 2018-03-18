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
import com.pall.portal.repository.entity.menu.ButtonEntity;
import com.pall.portal.repository.entity.menu.ButtonQueryFormEntity;
import com.pall.portal.service.menu.ButtonManageService;
/*
 * 按钮管理控制器
 */
@Controller
public class ButtonManageController{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	/*
	 * 按钮管理服务
	 */
	@Autowired
	private ButtonManageService buttonManageService;
	@Autowired
	private ResourceUtils resourceUtils;
	/*
	 * 按钮管理
	 */
	@RequestMapping(value="button/buttonManage", method= RequestMethod.GET)
    public  String rightManage(Model model, HttpServletRequest request) {
	   return "sysmanage/button/buttonManage";
    }
	
	@RequestMapping(value="button/buttonManage", method= RequestMethod.POST)
    public @ResponseBody String rightManage(Model model,ButtonQueryFormEntity  buttonQueryFormEntity, HttpServletRequest request) {
        if(buttonQueryFormEntity.getPageSize()==0){
        	buttonQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
		try {
			baseResponse=buttonManageService.queryButtonList(buttonQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("buttonManage.controler.buttonManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("buttonManage.controler.buttonManage.exception")+e.toString());
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
	/*
	 * 删除按钮信息
	 */
	@RequestMapping(value="button/delButton", method= RequestMethod.POST)
    public @ResponseBody String delButton(@RequestParam("btnids") String btnids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aBtnid=btnids.split(",");
			baseResponse=buttonManageService.delButton(null,Arrays.asList(aBtnid));
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("buttonManage.controler.delButton.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("buttonManage.controler.delButton.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 添加按钮信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="button/addButton", method= RequestMethod.POST)
    public  @ResponseBody String addButton(@Valid ButtonEntity buttonEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				baseResponse=buttonManageService.addButton(buttonEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("buttonManage.controler.addButton.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("buttonManage.controler.addButton.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 修改按钮信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="button/modButton", method= RequestMethod.POST)
    public  @ResponseBody String modButton(@Valid ButtonEntity buttonEntity,BindingResult result,Model model,HttpServletRequest request)throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				baseResponse=buttonManageService.modButton(buttonEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("buttonManage.controler.modButton.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("buttonManage.controler.modButton.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

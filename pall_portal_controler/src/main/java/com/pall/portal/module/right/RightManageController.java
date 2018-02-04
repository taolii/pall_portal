package com.pall.portal.module.right;

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
import com.pall.portal.repository.entity.right.RightEntity;
import com.pall.portal.repository.entity.right.RightQueryFormEntity;
import com.pall.portal.service.right.RightManageService;
/*
 * 权限管理控制器
 */
@Controller
public class RightManageController{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	/*
	 * 权限管理服务
	 */
	@Autowired
	private RightManageService rightManageService;
	@Autowired
	private ResourceUtils resourceUtils;
	/*
	 * 权限管理
	 */
	@RequestMapping(value="right/rightManage", method= RequestMethod.GET)
    public  String rightManage(Model model, HttpServletRequest request) {
	   return "sysmanage/right/rightManage";
    }
	
	@RequestMapping(value="right/rightManage", method= RequestMethod.POST)
    public @ResponseBody String rightManage(Model model,RightQueryFormEntity  rightQueryFormEntity, HttpServletRequest request) {
        if(rightQueryFormEntity.getPageSize()==0){
        	rightQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
		try {
			baseResponse=rightManageService.queryRightList(rightQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("rightManage.contrightr.rightManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("rightManage.contrightr.rightManage.exception")+e.toString());
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
	/*
	 * 删除权限信息
	 */
	@RequestMapping(value="right/delRight", method= RequestMethod.POST)
    public @ResponseBody String delRight(@RequestParam("rightids") String rightids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aRightid=rightids.split(",");
			baseResponse=rightManageService.delRight(Arrays.asList(aRightid));
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("rightManage.contrightr.delRight.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("rightManage.contrightr.delRight.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 添加角色信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="right/addRight", method= RequestMethod.POST)
    public  @ResponseBody String addRight(@Valid RightEntity rightEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				baseResponse=rightManageService.addRight(rightEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("rightManage.contrightr.addRight.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("rightManage.contrightr.addRight.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 修改权限信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="right/modRight", method= RequestMethod.POST)
    public  @ResponseBody String modRight(@Valid RightEntity rightEntity,BindingResult result,Model model,HttpServletRequest request)throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				baseResponse=rightManageService.modRight(rightEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("rightManage.contrightr.modRight.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("rightManage.contrightr.modRight.exception")+e.toString());
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

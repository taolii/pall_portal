package com.pall.wdpts.module.trackinglist;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.pall.wdpts.annotation.Token;
import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.constants.KeyConstants;
import com.pall.wdpts.common.i18n.ResourceUtils;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.common.support.excel.ExcelHeaderNode;
import com.pall.wdpts.common.tools.JSONTools;
import com.pall.wdpts.context.HolderContext;
import com.pall.wdpts.init.TableDataConfigInitiator;
import com.pall.wdpts.init.UmsConfigInitiator;
import com.pall.wdpts.interceptor.support.AuthToken;
import com.pall.wdpts.repository.entity.menu.ButtonEntity;
import com.pall.wdpts.repository.entity.trackinglist.DSPEntity;
import com.pall.wdpts.repository.entity.trackinglist.DSPFormQueryEntity;
import com.pall.wdpts.repository.entity.user.UserEntity.ADD;
import com.pall.wdpts.repository.entity.user.UserEntity.SAVE;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.trackinglist.DSPAssembleService;

/*
 * DSP装配流程跟踪单
 */
@Controller
public class DSPManageControler {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private ButtonManageService buttonManageService;
	@Autowired
	private DSPAssembleService dspAssembleService;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		
		return model;
	}
	/*
	 * DSP装配管理
	 */
	@RequestMapping(value="trackinglist/dspManage", method= RequestMethod.GET)
    public  String dspManage(Model model, HttpServletRequest request) {
		model=initConfigData(model);
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			try {
				BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					List<ButtonEntity> buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
					model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_TABLENAME));
		if(tableFieldBindMap!=null){
			tableFieldBinds.addAll(tableFieldBindMap.values());
		}
		Collections.sort(tableFieldBinds,new Comparator<ExcelHeaderNode>() {
			@Override
	        public int compare(ExcelHeaderNode o1, ExcelHeaderNode o2) {
				if(o1.getColNum()>o2.getColNum()){
					return 1;
				}else if(o1.getColNum()<o2.getColNum()){
					return -1;
				}else{
					return 0;
				}
	        }
		});
		model.addAttribute("tableFieldBinds", JSON.toJSONString(tableFieldBinds,SerializerFeature.WriteMapNullValue));
	   return "trackinglist/dsp/dspManage";
    }
	@RequestMapping(value="trackinglist/dspManage", method= RequestMethod.POST)
    public @ResponseBody String dspManage(Model model,DSPFormQueryEntity  dspFormQueryEntity, HttpServletRequest request) {
        if(dspFormQueryEntity.getPageSize()==0){
        	dspFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=dspAssembleService.queryDSPAssembleList(dspFormQueryEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> defectTypes=new ArrayList<String>();
				defectTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_TABLENAME));
				jsonData= JSONTools.defectsOverturnFiled(jsonData,defectTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("assemblyManage.controler.assemblyManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.controler.assemblyManage.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加DSP装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/addDSP", method= RequestMethod.GET)
    public   String addDSP(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		return "trackinglist/dsp/addDSP";
    }
	/*
	 * 添加DSP装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/addDSP", method= RequestMethod.POST)
    public  @ResponseBody String addDSP(@Validated(ADD.class) DSPEntity dspEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				baseResponse=dspAssembleService.addDSPAssemble(dspEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("polishmanage.controler.addPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.addPolish.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 修改DSP装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/modDSP", method= RequestMethod.GET)
    public   String modDSP(@RequestParam("polishid") String polishid,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
			
		
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "trackinglist/dsp/copyDSP";
		}else{
			return "trackinglist/dsp/modDSP";
		}
    }
	/*
	 * 修改DSP装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/modDSP", method= RequestMethod.POST)
    public  @ResponseBody String modDSP(@Validated(SAVE.class) DSPEntity dspEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				baseResponse=dspAssembleService.modifyDSPAssemble(dspEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("polishmanage.controler.addPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.addPolish.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除DSP装配信息
	 */
	@RequestMapping(value="trackinglist/delDSP", method= RequestMethod.POST)
    public @ResponseBody String delDSP(@RequestParam("dspIDs") String dspIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aodspID=dspIDs.split(",");
			List<Integer> tempDsp=new ArrayList<Integer>();
			for(String dspid:aodspID){
				tempDsp.add(Integer.parseInt(dspid));
			}
			baseResponse=dspAssembleService.delDSPAssemble(tempDsp);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("polishmanage.controler.delPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.delPolish.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出DSP装配信息
	 */
	@RequestMapping(value="trackinglist/exportDSP", method= RequestMethod.POST)
    public @ResponseBody String exportDSP(Model model,DSPFormQueryEntity  dspFormQueryEntity, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		
		return JSON.toJSONString(baseResponse);
    }
}

package com.pall.wdpts.module.setting;

import java.util.ArrayList;
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
import org.thymeleaf.util.ArrayUtils;
import org.thymeleaf.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.pall.wdpts.annotation.Token;
import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.constants.KeyConstants;
import com.pall.wdpts.common.datatables.Entity.DatatablesView;
import com.pall.wdpts.common.i18n.ResourceUtils;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.context.HolderContext;
import com.pall.wdpts.init.DataConfigInitiator;
import com.pall.wdpts.init.UmsConfigInitiator;
import com.pall.wdpts.interceptor.support.AuthToken;
import com.pall.wdpts.repository.entity.menu.ButtonEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingFormQueryEntity;
import com.pall.wdpts.repository.entity.user.UserEntity.ADD;
import com.pall.wdpts.repository.entity.user.UserEntity.SAVE;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.trackinglist.DspService;

/*
 * Dsp装配配置
 */
@Controller
public class DspSettingControler{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private ButtonManageService buttonManageService;
	@Autowired
	private DspService dspService;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		model.addAttribute("dspModelDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.SETTING_DSP_DATACONFIG_TYPE_DSPMODEL)));
		return model;
	}
	/*
	 * Dsp装配配置管理
	 */
	@RequestMapping(value="/setting/dspSetting", method= RequestMethod.GET)
    public  String dspSetting(Model model, HttpServletRequest request) {
		model=initConfigData(model);
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			List<ButtonEntity> buttonEntitys=null;
			try {
				/*BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_PREPROCESSING_ASSEMBLE_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
				}else{
					buttonEntitys=new ArrayList<ButtonEntity>();
				}*/
				buttonEntitys=new ArrayList<ButtonEntity>();
				model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	   return "setting/dsp/dspSetting";
    }
	@RequestMapping(value="/setting/dspSetting", method= RequestMethod.POST)
    public @ResponseBody String dspAssembleSetting(Model model,DspSettingFormQueryEntity  dspSettingFormQueryEntity, HttpServletRequest request) {
        if(dspSettingFormQueryEntity.getPageSize()==0){
        	dspSettingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=dspService.queryDspSettingList(dspSettingFormQueryEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dspAssembleSetting.Controler.dspAssembleSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dspAssembleSetting.Controler.dspAssembleSetting.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加Dsp装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/addDspSetting", method= RequestMethod.GET)
    public   String addDspSetting(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		return "setting/dsp/addDspSetting";
    }
	/*
	 * 添加Dsp装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/addDspSetting", method= RequestMethod.POST)
    public  @ResponseBody String addDspSetting(@Validated(ADD.class) DspSettingEntity dspSettingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					dspSettingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				dspSettingEntity.setDspSettingAssembles(getDspSettingAssembles(request));
				baseResponse=dspService.addDspSetting(dspSettingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dspSetting.Controler.addDspSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dspSetting.Controler.addDspSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 根据请求参数封装Dsp装配配置对象
	 * @param request 请求对象
	 * @return
	 */
	private List<DspSettingAssembleEntity> getDspSettingAssembles(HttpServletRequest request){
		String[] assembleids=request.getParameterValues("assembleid");
		List<DspSettingAssembleEntity> dspSettingAssembles=new ArrayList<DspSettingAssembleEntity>();
		if(!ArrayUtils.isEmpty(assembleids)){
			for(String assembleid:assembleids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+assembleid)) && StringUtils.isEmpty(request.getParameter("componentName_"+assembleid))
						&& StringUtils.isEmpty(request.getParameter("componentNo_"+assembleid)) && StringUtils.isEmpty(request.getParameter("selfcheckResult_"+assembleid))){
					continue;
				}
				DspSettingAssembleEntity dspSettingAssembleEntity=new DspSettingAssembleEntity();
				dspSettingAssembleEntity.setRemarks(request.getParameter("remarks_"+assembleid));
				dspSettingAssembleEntity.setComponentName(request.getParameter("componentName_"+assembleid));
				dspSettingAssembleEntity.setComponentNo(request.getParameter("componentNo_"+assembleid));
				dspSettingAssembleEntity.setSerialNoRecord(request.getParameter("serialNoRecord_"+assembleid));
				if(!StringUtils.isEmpty(dspSettingAssembleEntity.getComponentName())||!StringUtils.isEmpty(dspSettingAssembleEntity.getComponentNo())||!StringUtils.isEmpty(dspSettingAssembleEntity.getSerialNoRecord())||!StringUtils.isEmpty(dspSettingAssembleEntity.getRemarks())){
					dspSettingAssembles.add(dspSettingAssembleEntity);
				}
			}
		}
		return dspSettingAssembles;
	}
	/*
	 * 修改Dsp装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/modDspSetting", method= RequestMethod.GET)
    public   String modDspSetting(@RequestParam("dsid") String dsid,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		DspSettingEntity dspSettingEntity=null;
		try {
			dspSettingEntity=dspService.queryDspSetting(dsid);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dspAssemble.service.queryDspSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dspAssemble.service.queryDspSetting.exception"));
		}
		if(dspSettingEntity==null){
			dspSettingEntity=new DspSettingEntity();
		}
		model.addAttribute("dspSettingAssembles", JSON.toJSONString(dspSettingEntity.getDspSettingAssembles()));
		model.addAttribute("dspSettingEntity", dspSettingEntity);
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "setting/dsp/copyDspSetting";
		}else{
			return "setting/dsp/modDspSetting";
		}
    }
	/*
	 * 修改Dsp装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/modDspSetting", method= RequestMethod.POST)
    public  @ResponseBody String modDspSetting(@Validated(SAVE.class)  DspSettingEntity dspSettingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					dspSettingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				dspSettingEntity.setDspSettingAssembles(getDspSettingAssembles(request));
				baseResponse=dspService.modDspSetting(dspSettingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dspSetting.Controler.modDspSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dspSetting.Controler.modDspSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除Dsp装配配置信息
	 */
	@RequestMapping(value="/setting/delDspSetting", method= RequestMethod.POST)
    public @ResponseBody String delDspSetting(@RequestParam("dsids") String dsids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aodsid=dsids.split(",");
			List<Integer> tempDsids=new ArrayList<Integer>();
			for(String dsid:aodsid){
				tempDsids.add(Integer.parseInt(dsid));
			}
			baseResponse=dspService.delDspSetting(tempDsids);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dspSetting.Controler.delDspSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dspSetting.Controler.delDspSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	@RequestMapping(value="/setting/dspAssembleDetail", method= RequestMethod.POST)
    public @ResponseBody String dspAssembleDetail(Model model,DspSettingFormQueryEntity  dspSettingFormQueryEntity, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			if(StringUtils.isEmpty(dspSettingFormQueryEntity.getDsid()) && !StringUtils.isEmpty(dspSettingFormQueryEntity.getDspPn())){
				dspSettingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
				baseResponse=dspService.queryDspSettingList(dspSettingFormQueryEntity);
				if(baseResponse.getDatatablesView().getRecordsTotal()>0){
					DspSettingEntity dspSettingEntity=(DspSettingEntity)baseResponse.getDatatablesView().getData().get(0);
					dspSettingFormQueryEntity.setDsid(String.valueOf(dspSettingEntity.getDsid()));
					baseResponse=dspService.queryDspSettingAssembleList(dspSettingFormQueryEntity.getDsid());
					if(baseResponse!=null){
						baseResponse.setMainRecord(dspSettingEntity);
					}
				}else{
					DatatablesView datatablesViews=new DatatablesView();
					baseResponse.setDatatablesView(datatablesViews);
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}	
			}else{
				baseResponse=dspService.queryDspSettingAssembleList(dspSettingFormQueryEntity.getDsid());
			}
			
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dspSetting.Controler.dspAssembleDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dspSetting.Controler.dspAssembleDetail.exception"));
			
		}
		 return jsonData;
    }
}

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
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingInspectEntity;
import com.pall.wdpts.repository.entity.user.UserEntity.ADD;
import com.pall.wdpts.repository.entity.user.UserEntity.SAVE;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.trackinglist.PreprocessingService;

/*
 * 预处理装配配置
 */
@Controller
public class PreprocessingSettingControler {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private ButtonManageService buttonManageService;
	@Autowired
	private PreprocessingService preprocessingService;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		model.addAttribute("preprocessingModelDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.SETTING_PREPROCESSING_DATACONFIG_TYPE_PREPROCESSINGMODEL)));
		return model;
	}
	/*
	 * 预处理装配配置管理
	 */
	@RequestMapping(value="/setting/preprocessingSetting", method= RequestMethod.GET)
    public  String preprocessingSetting(Model model, HttpServletRequest request) {
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
	   return "setting/preprocessing/preprocessingSetting";
    }
	@RequestMapping(value="/setting/preprocessingSetting", method= RequestMethod.POST)
    public @ResponseBody String preprocessingSetting(Model model,PreprocessingSettingFormQueryEntity  preprocessingSettingFormQueryEntity, HttpServletRequest request) {
        if(preprocessingSettingFormQueryEntity.getPageSize()==0){
        	preprocessingSettingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=preprocessingService.queryPreprocessingSettingList(preprocessingSettingFormQueryEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessingSetting.Controler.preprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingSetting.Controler.preprocessingSetting.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加预处理装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/addPreprocessingSetting", method= RequestMethod.GET)
    public   String addPreprocessingSetting(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		return "setting/preprocessing/addPreprocessingSetting";
    }
	/*
	 * 添加预处理装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/addPreprocessingSetting", method= RequestMethod.POST)
    public  @ResponseBody String addPreprocessingSetting(@Validated(ADD.class) PreprocessingSettingEntity preprocessingSettingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					preprocessingSettingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				preprocessingSettingEntity.setPreprocessingSettingAssembles(getPreprocessingSettingAssembles(request));
				preprocessingSettingEntity.setPreprocessingSettingInspects(getPreprocessingSettingInspects(request));
				baseResponse=preprocessingService.addPreprocessingSetting(preprocessingSettingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessingSetting.Controler.addPreprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingSetting.Controler.addPreprocessingSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 根据请求参数封装预处理送检配置对象
	 * @param request 请求对象
	 * @return
	 */
	private List<PreprocessingSettingInspectEntity> getPreprocessingSettingInspects(HttpServletRequest request){
		String[] inspectids=request.getParameterValues("inspectid");
		List<PreprocessingSettingInspectEntity> preprocessingSettingInspects=new ArrayList<PreprocessingSettingInspectEntity>();
		if(!ArrayUtils.isEmpty(inspectids)){
			for(String inspectid:inspectids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+inspectid)) && StringUtils.isEmpty(request.getParameter("selfcheckContent_"+inspectid))
						&& StringUtils.isEmpty(request.getParameter("selfcheckName_"+inspectid)) && StringUtils.isEmpty(request.getParameter("selfcheckResult_"+inspectid))){
					continue;
				}
				PreprocessingSettingInspectEntity preprocessingSettingInspectEntity=new PreprocessingSettingInspectEntity();
				preprocessingSettingInspectEntity.setRemarks(request.getParameter("remarks_"+inspectid));
				preprocessingSettingInspectEntity.setSelfcheckContent(request.getParameter("selfcheckContent_"+inspectid));
				preprocessingSettingInspectEntity.setSelfcheckName(request.getParameter("selfcheckName_"+inspectid));
				preprocessingSettingInspectEntity.setSelfcheckResult(request.getParameter("selfcheckResult_"+inspectid));
				if(!StringUtils.isEmpty(preprocessingSettingInspectEntity.getSelfcheckContent())||!StringUtils.isEmpty(preprocessingSettingInspectEntity.getSelfcheckName())||!StringUtils.isEmpty(preprocessingSettingInspectEntity.getSelfcheckResult())||!StringUtils.isEmpty(preprocessingSettingInspectEntity.getRemarks())){
					preprocessingSettingInspects.add(preprocessingSettingInspectEntity);
				}
				
			}
		}
		return preprocessingSettingInspects;
	}
	/*
	 * 根据请求参数封装预处理装配配置对象
	 * @param request 请求对象
	 * @return
	 */
	private List<PreprocessingSettingAssembleEntity> getPreprocessingSettingAssembles(HttpServletRequest request){
		String[] assembleids=request.getParameterValues("assembleid");
		List<PreprocessingSettingAssembleEntity> preprocessingSettingAssembles=new ArrayList<PreprocessingSettingAssembleEntity>();
		if(!ArrayUtils.isEmpty(assembleids)){
			for(String assembleid:assembleids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+assembleid)) && StringUtils.isEmpty(request.getParameter("componentName_"+assembleid))
						&& StringUtils.isEmpty(request.getParameter("componentNo_"+assembleid)) && StringUtils.isEmpty(request.getParameter("selfcheckResult_"+assembleid))){
					continue;
				}
				PreprocessingSettingAssembleEntity preprocessingSettingAssembleEntity=new PreprocessingSettingAssembleEntity();
				preprocessingSettingAssembleEntity.setRemarks(request.getParameter("remarks_"+assembleid));
				preprocessingSettingAssembleEntity.setComponentName(request.getParameter("componentName_"+assembleid));
				preprocessingSettingAssembleEntity.setComponentNo(request.getParameter("componentNo_"+assembleid));
				preprocessingSettingAssembleEntity.setSerialNoRecord(request.getParameter("serialNoRecord_"+assembleid));
				if(!StringUtils.isEmpty(preprocessingSettingAssembleEntity.getComponentName())||!StringUtils.isEmpty(preprocessingSettingAssembleEntity.getComponentNo())||!StringUtils.isEmpty(preprocessingSettingAssembleEntity.getSerialNoRecord())||!StringUtils.isEmpty(preprocessingSettingAssembleEntity.getRemarks())){
					preprocessingSettingAssembles.add(preprocessingSettingAssembleEntity);
				}
			}
		}
		return preprocessingSettingAssembles;
	}
	/*
	 * 修改预处理装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/modPreprocessingSetting", method= RequestMethod.GET)
    public   String modPreprocessingSetting(@RequestParam("psid") String psid,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		PreprocessingSettingEntity preprocessingSettingEntity=null;
		try {
			preprocessingSettingEntity=preprocessingService.queryPreprocessingSetting(psid);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingSetting.exception"));
		}
		if(preprocessingSettingEntity==null){
			preprocessingSettingEntity=new PreprocessingSettingEntity();
		}
		model.addAttribute("preprocessingSettingAssembles", JSON.toJSONString(preprocessingSettingEntity.getPreprocessingSettingAssembles()));
		model.addAttribute("preprocessingSettingInspects", JSON.toJSONString(preprocessingSettingEntity.getPreprocessingSettingInspects()));
		model.addAttribute("preprocessingSettingEntity", preprocessingSettingEntity);
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "setting/preprocessing/copyPreprocessingSetting";
		}else{
			return "setting/preprocessing/modPreprocessingSetting";
		}
    }
	/*
	 * 修改预处理装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/modPreprocessingSetting", method= RequestMethod.POST)
    public  @ResponseBody String modPreprocessingSetting(@Validated(SAVE.class)  PreprocessingSettingEntity preprocessingSettingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					preprocessingSettingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				preprocessingSettingEntity.setPreprocessingSettingAssembles(getPreprocessingSettingAssembles(request));
				preprocessingSettingEntity.setPreprocessingSettingInspects(getPreprocessingSettingInspects(request));
				baseResponse=preprocessingService.modPreprocessingSetting(preprocessingSettingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessingSetting.Controler.modPreprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingSetting.Controler.modPreprocessingSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除预处理装配配置信息
	 */
	@RequestMapping(value="/setting/delPreprocessingSetting", method= RequestMethod.POST)
    public @ResponseBody String delPreprocessingSetting(@RequestParam("psids") String psids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aopsid=psids.split(",");
			List<Integer> tempPsids=new ArrayList<Integer>();
			for(String psid:aopsid){
				tempPsids.add(Integer.parseInt(psid));
			}
			baseResponse=preprocessingService.delPreprocessingSetting(tempPsids);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessingSetting.Controler.delPreprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingSetting.Controler.delPreprocessingSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	@RequestMapping(value="/setting/preprocessingInspectDetail", method= RequestMethod.POST)
    public @ResponseBody String preprocessingInspectDetail(Model model,PreprocessingSettingFormQueryEntity  preprocessingSettingFormQueryEntity, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			if(StringUtils.isEmpty(preprocessingSettingFormQueryEntity.getPsid()) && !StringUtils.isEmpty(preprocessingSettingFormQueryEntity.getPreprocessingPn())){
				preprocessingSettingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
				baseResponse=preprocessingService.queryPreprocessingSettingList(preprocessingSettingFormQueryEntity);
				if(baseResponse.getDatatablesView().getRecordsTotal()>0){
					PreprocessingSettingEntity preprocessingSettingEntity=(PreprocessingSettingEntity)baseResponse.getDatatablesView().getData().get(0);
					preprocessingSettingFormQueryEntity.setPsid(String.valueOf(preprocessingSettingEntity.getPsid()));
					baseResponse=preprocessingService.queryPreprocessingSettingInspectList(preprocessingSettingFormQueryEntity.getPsid());
					if(baseResponse!=null){
						baseResponse.setMainRecord(preprocessingSettingEntity);
					}
				}else{
					DatatablesView datatablesViews=new DatatablesView();
					baseResponse.setDatatablesView(datatablesViews);
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}	
			}else{
				baseResponse=preprocessingService.queryPreprocessingSettingInspectList(preprocessingSettingFormQueryEntity.getPsid());
			}
			
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessingSetting.Controler.preprocessingInspectDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingSetting.Controler.preprocessingInspectDetail.exception"));
			
		}
		 return jsonData;
    }
	@RequestMapping(value="/setting/preprocessingAssembleDetail", method= RequestMethod.POST)
    public @ResponseBody String preprocessingAssembleDetail(Model model,PreprocessingSettingFormQueryEntity  preprocessingSettingFormQueryEntity, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			if(StringUtils.isEmpty(preprocessingSettingFormQueryEntity.getPsid()) && !StringUtils.isEmpty(preprocessingSettingFormQueryEntity.getPreprocessingPn())){
				preprocessingSettingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
				baseResponse=preprocessingService.queryPreprocessingSettingList(preprocessingSettingFormQueryEntity);
				if(baseResponse.getDatatablesView().getRecordsTotal()>0){
					PreprocessingSettingEntity preprocessingSettingEntity=(PreprocessingSettingEntity)baseResponse.getDatatablesView().getData().get(0);
					preprocessingSettingFormQueryEntity.setPsid(String.valueOf(preprocessingSettingEntity.getPsid()));
					baseResponse=preprocessingService.queryPreprocessingSettingAssembleList(preprocessingSettingFormQueryEntity.getPsid());
					if(baseResponse!=null){
						baseResponse.setMainRecord(preprocessingSettingEntity);
					}
				}else{
					DatatablesView datatablesViews=new DatatablesView();
					baseResponse.setDatatablesView(datatablesViews);
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}	
			}else{
				baseResponse=preprocessingService.queryPreprocessingSettingAssembleList(preprocessingSettingFormQueryEntity.getPsid());
			}
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessingSetting.Controler.preprocessingAssembleDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingSetting.Controler.preprocessingAssembleDetail.exception"));
			
		}
		 return jsonData;
    }
}

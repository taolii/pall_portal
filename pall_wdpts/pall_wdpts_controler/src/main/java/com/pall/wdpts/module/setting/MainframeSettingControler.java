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
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingInspectEntity;
import com.pall.wdpts.repository.entity.user.UserEntity.ADD;
import com.pall.wdpts.repository.entity.user.UserEntity.SAVE;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.trackinglist.MainframeService;

/*
 * 主机装配配置
 */
@Controller
public class MainframeSettingControler{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private ButtonManageService buttonManageService;
	@Autowired
	private MainframeService mainframeService;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		model.addAttribute("mainframeModelDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.SETTING_MAINFRAME_DATACONFIG_TYPE_MAINFRAMEMODEL)));
		return model;
	}
	/*
	 * 主机装配配置管理
	 */
	@RequestMapping(value="/setting/mainframeSetting", method= RequestMethod.GET)
    public  String mainframeSetting(Model model, HttpServletRequest request) {
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
	   return "setting/mainframe/mainframeSetting";
    }
	@RequestMapping(value="/setting/mainframeSetting", method= RequestMethod.POST)
    public @ResponseBody String mainframeSetting(Model model,MainframeSettingFormQueryEntity  mainframeSettingFormQueryEntity, HttpServletRequest request) {
        if(mainframeSettingFormQueryEntity.getPageSize()==0){
        	mainframeSettingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=mainframeService.queryMainframeSettingList(mainframeSettingFormQueryEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframeSetting.Controler.mainframeSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframeSetting.Controler.mainframeSetting.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加主机装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/addMainframeSetting", method= RequestMethod.GET)
    public   String addMainframeSetting(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		return "setting/mainframe/addMainframeSetting";
    }
	/*
	 * 添加主机装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/addMainframeSetting", method= RequestMethod.POST)
    public  @ResponseBody String addMainframeSetting(@Validated(ADD.class) MainframeSettingEntity mainframeSettingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					mainframeSettingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				mainframeSettingEntity.setMainframeSettingAssembles(getMainframeSettingAssembles(request));
				mainframeSettingEntity.setMainframeSettingInspects(getMainframeSettingInspects(request));
				baseResponse=mainframeService.addMainframeSetting(mainframeSettingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframeSetting.Controler.addMainframeSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframeSetting.Controler.addMainframeSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 根据请求参数封装主机送检配置对象
	 * @param request 请求对象
	 * @return
	 */
	private List<MainframeSettingInspectEntity> getMainframeSettingInspects(HttpServletRequest request){
		String[] inspectids=request.getParameterValues("inspectid");
		List<MainframeSettingInspectEntity> mainframeSettingInspects=new ArrayList<MainframeSettingInspectEntity>();
		if(!ArrayUtils.isEmpty(inspectids)){
			for(String inspectid:inspectids){
				if(StringUtils.isEmpty(request.getParameter("inspect_remarks_"+inspectid)) && StringUtils.isEmpty(request.getParameter("selfcheckContent_"+inspectid))
						&& StringUtils.isEmpty(request.getParameter("selfcheckName_"+inspectid)) && StringUtils.isEmpty(request.getParameter("selfcheckResult_"+inspectid))){
					continue;
				}
				MainframeSettingInspectEntity mainframeSettingInspectEntity=new MainframeSettingInspectEntity();
				mainframeSettingInspectEntity.setRemarks(request.getParameter("inspect_remarks_"+inspectid));
				StringBuffer selfcheckContent=new StringBuffer();
				String tempcheckContent="";
				for(int j=1;j<9;j++){
					tempcheckContent=request.getParameter("selfcheckContent_"+inspectid+"_"+j);
					if(StringUtils.isEmpty(tempcheckContent)){
						selfcheckContent.append("0");
					}else{
						selfcheckContent.append(tempcheckContent);
					}
				}
				mainframeSettingInspectEntity.setSelfcheckContent(selfcheckContent.toString());
				mainframeSettingInspectEntity.setSelfcheckName(request.getParameter("selfcheckName_"+inspectid));
				mainframeSettingInspectEntity.setSelfcheckResult(request.getParameter("selfcheckResult_"+inspectid));
				if(!StringUtils.isEmpty(mainframeSettingInspectEntity.getSelfcheckContent())||!StringUtils.isEmpty(mainframeSettingInspectEntity.getSelfcheckName())||!StringUtils.isEmpty(mainframeSettingInspectEntity.getSelfcheckResult())||!StringUtils.isEmpty(mainframeSettingInspectEntity.getRemarks())){
					mainframeSettingInspects.add(mainframeSettingInspectEntity);
				}
				
			}
		}
		return mainframeSettingInspects;
	}
	/*
	 * 根据请求参数封装主机装配配置对象
	 * @param request 请求对象
	 * @return
	 */
	private List<MainframeSettingAssembleEntity> getMainframeSettingAssembles(HttpServletRequest request){
		String[] assembleids=request.getParameterValues("assembleid");
		List<MainframeSettingAssembleEntity> mainframeSettingAssembles=new ArrayList<MainframeSettingAssembleEntity>();
		if(!ArrayUtils.isEmpty(assembleids)){
			for(String assembleid:assembleids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+assembleid)) && StringUtils.isEmpty(request.getParameter("componentName_"+assembleid))
						&& StringUtils.isEmpty(request.getParameter("componentNo_"+assembleid)) && StringUtils.isEmpty(request.getParameter("selfcheckResult_"+assembleid))){
					continue;
				}
				MainframeSettingAssembleEntity mainframeSettingAssembleEntity=new MainframeSettingAssembleEntity();
				mainframeSettingAssembleEntity.setRemarks(request.getParameter("remarks_"+assembleid));
				mainframeSettingAssembleEntity.setComponentName(request.getParameter("componentName_"+assembleid));
				mainframeSettingAssembleEntity.setComponentNo(request.getParameter("componentNo_"+assembleid));
				mainframeSettingAssembleEntity.setSerialNoRecord(request.getParameter("serialNoRecord_"+assembleid));
				if(!StringUtils.isEmpty(mainframeSettingAssembleEntity.getComponentName())||!StringUtils.isEmpty(mainframeSettingAssembleEntity.getComponentNo())||!StringUtils.isEmpty(mainframeSettingAssembleEntity.getSerialNoRecord())||!StringUtils.isEmpty(mainframeSettingAssembleEntity.getRemarks())){
					mainframeSettingAssembles.add(mainframeSettingAssembleEntity);
				}
			}
		}
		return mainframeSettingAssembles;
	}
	/*
	 * 修改主机装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/modMainframeSetting", method= RequestMethod.GET)
    public   String modMainframeSetting(@RequestParam("msid") String msid,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		MainframeSettingEntity mainframeSettingEntity=null;
		try {
			mainframeSettingEntity=mainframeService.queryMainframeSetting(msid);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframeAssemble.service.queryMainframeSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframeAssemble.service.queryMainframeSetting.exception"));
		}
		if(mainframeSettingEntity==null){
			mainframeSettingEntity=new MainframeSettingEntity();
		}
		model.addAttribute("mainframeSettingAssembles", JSON.toJSONString(mainframeSettingEntity.getMainframeSettingAssembles()));
		model.addAttribute("mainframeSettingInspects", JSON.toJSONString(mainframeSettingEntity.getMainframeSettingInspects()));
		model.addAttribute("mainframeSettingEntity", mainframeSettingEntity);
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "setting/mainframe/copyMainframeSetting";
		}else{
			return "setting/mainframe/modMainframeSetting";
		}
    }
	/*
	 * 修改主机装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/modMainframeSetting", method= RequestMethod.POST)
    public  @ResponseBody String modMainframeSetting(@Validated(SAVE.class)  MainframeSettingEntity mainframeSettingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					mainframeSettingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				mainframeSettingEntity.setMainframeSettingAssembles(getMainframeSettingAssembles(request));
				mainframeSettingEntity.setMainframeSettingInspects(getMainframeSettingInspects(request));
				baseResponse=mainframeService.modMainframeSetting(mainframeSettingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframeSetting.Controler.modMainframeSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframeSetting.Controler.modMainframeSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除主机装配配置信息
	 */
	@RequestMapping(value="/setting/delMainframeSetting", method= RequestMethod.POST)
    public @ResponseBody String delMainframeSetting(@RequestParam("msids") String msids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aoMsid=msids.split(",");
			List<Integer> tempPsids=new ArrayList<Integer>();
			for(String msid:aoMsid){
				tempPsids.add(Integer.parseInt(msid));
			}
			baseResponse=mainframeService.delMainframeSetting(tempPsids);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframeSetting.Controler.delMainframeSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframeSetting.Controler.delMainframeSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	@RequestMapping(value="/setting/mainframeInspectDetail", method= RequestMethod.POST)
    public @ResponseBody String mainframeInspectDetail(Model model,MainframeSettingFormQueryEntity  mainframeSettingFormQueryEntity, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			if(StringUtils.isEmpty(mainframeSettingFormQueryEntity.getMsid()) && !StringUtils.isEmpty(mainframeSettingFormQueryEntity.getMainframePn())){
				mainframeSettingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
				baseResponse=mainframeService.queryMainframeSettingList(mainframeSettingFormQueryEntity);
				if(baseResponse.getDatatablesView().getRecordsTotal()>0){
					MainframeSettingEntity mainframeSettingEntity=(MainframeSettingEntity)baseResponse.getDatatablesView().getData().get(0);
					mainframeSettingFormQueryEntity.setMsid((String.valueOf(mainframeSettingEntity.getMsid())));
					baseResponse=mainframeService.queryMainframeSettingInspectList(mainframeSettingFormQueryEntity.getMsid());
					if(baseResponse!=null){
						baseResponse.setMainRecord(mainframeSettingEntity);
					}
				}else{
					DatatablesView datatablesViews=new DatatablesView();
					baseResponse.setDatatablesView(datatablesViews);
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}	
			}else{
				baseResponse=mainframeService.queryMainframeSettingInspectList(mainframeSettingFormQueryEntity.getMsid());
			}
			
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframeSetting.Controler.mainframeInspectDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframeSetting.Controler.mainframeInspectDetail.exception"));
			
		}
		 return jsonData;
    }
	@RequestMapping(value="/setting/mainframeAssembleDetail", method= RequestMethod.POST)
    public @ResponseBody String mainframeAssembleDetail(Model model,MainframeSettingFormQueryEntity  mainframeSettingFormQueryEntity, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			if(StringUtils.isEmpty(mainframeSettingFormQueryEntity.getMsid()) && !StringUtils.isEmpty(mainframeSettingFormQueryEntity.getMainframePn())){
				mainframeSettingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
				baseResponse=mainframeService.queryMainframeSettingList(mainframeSettingFormQueryEntity);
				if(baseResponse.getDatatablesView().getRecordsTotal()>0){
					MainframeSettingEntity mainframeSettingEntity=(MainframeSettingEntity)baseResponse.getDatatablesView().getData().get(0);
					mainframeSettingFormQueryEntity.setMsid((String.valueOf(mainframeSettingEntity.getMsid())));
					baseResponse=mainframeService.queryMainframeSettingAssembleList(mainframeSettingFormQueryEntity.getMsid());
					if(baseResponse!=null){
						baseResponse.setMainRecord(mainframeSettingEntity);
					}
				}else{
					DatatablesView datatablesViews=new DatatablesView();
					baseResponse.setDatatablesView(datatablesViews);
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}	
			}else{
				baseResponse=mainframeService.queryMainframeSettingAssembleList(mainframeSettingFormQueryEntity.getMsid());
			}
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframeSetting.Controler.mainframeAssembleDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframeSetting.Controler.mainframeAssembleDetail.exception"));
			
		}
		 return jsonData;
    }
}

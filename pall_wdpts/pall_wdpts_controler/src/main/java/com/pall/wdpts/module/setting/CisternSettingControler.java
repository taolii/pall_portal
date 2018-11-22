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
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingFormQueryEntity;
import com.pall.wdpts.repository.entity.user.UserEntity.ADD;
import com.pall.wdpts.repository.entity.user.UserEntity.SAVE;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.trackinglist.CisternService;

/*
 * 水箱装配配置
 */
@Controller
public class CisternSettingControler{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private ButtonManageService buttonManageService;
	@Autowired
	private CisternService cisternService;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		model.addAttribute("cisternModelDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.SETTING_CISTERN_DATACONFIG_TYPE_CISTERNMODEL)));
		return model;
	}
	/*
	 * 水箱装配配置管理
	 */
	@RequestMapping(value="/setting/cisternSetting", method= RequestMethod.GET)
    public  String cisternSetting(Model model, HttpServletRequest request) {
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
	   return "setting/cistern/cisternSetting";
    }
	@RequestMapping(value="/setting/cisternSetting", method= RequestMethod.POST)
    public @ResponseBody String cisternAssembleSetting(Model model,CisternSettingFormQueryEntity  cisternSettingFormQueryEntity, HttpServletRequest request) {
        if(cisternSettingFormQueryEntity.getPageSize()==0){
        	cisternSettingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=cisternService.queryCisternSettingList(cisternSettingFormQueryEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cisternAssembleSetting.Controler.cisternAssembleSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cisternAssembleSetting.Controler.cisternAssembleSetting.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加水箱装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/addCisternSetting", method= RequestMethod.GET)
    public   String addCisternSetting(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		return "setting/cistern/addCisternSetting";
    }
	/*
	 * 添加水箱装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/addCisternSetting", method= RequestMethod.POST)
    public  @ResponseBody String addCisternSetting(@Validated(ADD.class) CisternSettingEntity cisternSettingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					cisternSettingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				cisternSettingEntity.setCisternSettingAssembles(getCisternSettingAssembles(request));
				baseResponse=cisternService.addCisternSetting(cisternSettingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cisternSetting.Controler.addCisternSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cisternSetting.Controler.addCisternSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 根据请求参数封装水箱装配配置对象
	 * @param request 请求对象
	 * @return
	 */
	private List<CisternSettingAssembleEntity> getCisternSettingAssembles(HttpServletRequest request){
		String[] assembleids=request.getParameterValues("assembleid");
		List<CisternSettingAssembleEntity> cisternSettingAssembles=new ArrayList<CisternSettingAssembleEntity>();
		if(!ArrayUtils.isEmpty(assembleids)){
			for(String assembleid:assembleids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+assembleid)) && StringUtils.isEmpty(request.getParameter("componentName_"+assembleid))
						&& StringUtils.isEmpty(request.getParameter("componentNo_"+assembleid)) && StringUtils.isEmpty(request.getParameter("selfcheckResult_"+assembleid))){
					continue;
				}
				CisternSettingAssembleEntity cisternSettingAssembleEntity=new CisternSettingAssembleEntity();
				cisternSettingAssembleEntity.setRemarks(request.getParameter("remarks_"+assembleid));
				cisternSettingAssembleEntity.setComponentName(request.getParameter("componentName_"+assembleid));
				cisternSettingAssembleEntity.setComponentNo(request.getParameter("componentNo_"+assembleid));
				cisternSettingAssembleEntity.setSerialNoRecord(request.getParameter("serialNoRecord_"+assembleid));
				if(!StringUtils.isEmpty(cisternSettingAssembleEntity.getComponentName())||!StringUtils.isEmpty(cisternSettingAssembleEntity.getComponentNo())||!StringUtils.isEmpty(cisternSettingAssembleEntity.getSerialNoRecord())||!StringUtils.isEmpty(cisternSettingAssembleEntity.getRemarks())){
					cisternSettingAssembles.add(cisternSettingAssembleEntity);
				}
			}
		}
		return cisternSettingAssembles;
	}
	/*
	 * 修改水箱装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/modCisternSetting", method= RequestMethod.GET)
    public   String modCisternSetting(@RequestParam("csid") String csid,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		CisternSettingEntity cisternSettingEntity=null;
		try {
			cisternSettingEntity=cisternService.queryCisternSetting(csid);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cisternAssemble.service.queryCisternSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cisternAssemble.service.queryCisternSetting.exception"));
		}
		if(cisternSettingEntity==null){
			cisternSettingEntity=new CisternSettingEntity();
		}
		model.addAttribute("cisternSettingAssembles", JSON.toJSONString(cisternSettingEntity.getCisternSettingAssembles()));
		model.addAttribute("cisternSettingEntity", cisternSettingEntity);
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "setting/cistern/copyCisternSetting";
		}else{
			return "setting/cistern/modCisternSetting";
		}
    }
	/*
	 * 修改水箱装配配置信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="/setting/modCisternSetting", method= RequestMethod.POST)
    public  @ResponseBody String modCisternSetting(@Validated(SAVE.class)  CisternSettingEntity cisternSettingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					cisternSettingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				cisternSettingEntity.setCisternSettingAssembles(getCisternSettingAssembles(request));
				baseResponse=cisternService.modCisternSetting(cisternSettingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cisternSetting.Controler.modCisternSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cisternSetting.Controler.modCisternSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除水箱装配配置信息
	 */
	@RequestMapping(value="/setting/delCisternSetting", method= RequestMethod.POST)
    public @ResponseBody String delCisternSetting(@RequestParam("csids") String csids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aocsid=csids.split(",");
			List<Integer> tempCsids=new ArrayList<Integer>();
			for(String csid:aocsid){
				tempCsids.add(Integer.parseInt(csid));
			}
			baseResponse=cisternService.delCisternSetting(tempCsids);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cisternSetting.Controler.delCisternSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cisternSetting.Controler.delCisternSetting.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	@RequestMapping(value="/setting/cisternAssembleDetail", method= RequestMethod.POST)
    public @ResponseBody String cisternAssembleDetail(Model model,CisternSettingFormQueryEntity  cisternSettingFormQueryEntity, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			if(StringUtils.isEmpty(cisternSettingFormQueryEntity.getCsid()) && !StringUtils.isEmpty(cisternSettingFormQueryEntity.getCisternPn())){
				cisternSettingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
				baseResponse=cisternService.queryCisternSettingList(cisternSettingFormQueryEntity);
				if(baseResponse.getDatatablesView().getRecordsTotal()>0){
					CisternSettingEntity cisternSettingEntity=(CisternSettingEntity)baseResponse.getDatatablesView().getData().get(0);
					cisternSettingFormQueryEntity.setCsid(String.valueOf(cisternSettingEntity.getCsid()));
					baseResponse=cisternService.queryCisternSettingAssembleList(cisternSettingFormQueryEntity.getCsid());
					if(baseResponse!=null){
						baseResponse.setMainRecord(cisternSettingEntity);
					}
				}else{
					DatatablesView datatablesViews=new DatatablesView();
					baseResponse.setDatatablesView(datatablesViews);
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}	
			}else{
				baseResponse=cisternService.queryCisternSettingAssembleList(cisternSettingFormQueryEntity.getCsid());
			}
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cisternSetting.Controler.cisternAssembleDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cisternSetting.Controler.cisternAssembleDetail.exception"));
			
		}
		 return jsonData;
    }
}

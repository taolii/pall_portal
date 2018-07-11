package com.pall.portal.module.dataconfig;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
import com.pall.portal.init.DataConfigInitiator;
import com.pall.portal.init.TableDataConfigInitiator;
import com.pall.portal.init.UmsConfigInitiator;
import com.pall.portal.interceptor.support.AuthToken;
import com.pall.portal.repository.entity.dataconfig.DataConfigEntity;
import com.pall.portal.repository.entity.dataconfig.DataConfigQueryFormEntity;
import com.pall.portal.repository.entity.dataconfig.DataConfigTypeEntity;
import com.pall.portal.service.dataconfig.DataConfigManageService;
/*
 * 数据配置管理控制器
 */
@Controller
public class DataConfigManageController{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	/*
	 * 数据配置管理服务
	 */
	@Autowired
	private DataConfigManageService dataConfigManageService;
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private TableDataConfigInitiator tableDataConfigInitiator;
	@Autowired
	private DataConfigInitiator initSysDataConfig;
	
	/*
	 * 缺损管理
	 */
	@RequestMapping(value="defect/defectManage", method= RequestMethod.GET)
    public  String defectManage(Model model, HttpServletRequest request) {
		List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_WORKFLOW));
		List<DataConfigTypeEntity> dataConfigTypes=new ArrayList<DataConfigTypeEntity>();
		if(dataConfigEntitys!=null && dataConfigEntitys.size()>0){
			for(DataConfigEntity dataConfigEntity:dataConfigEntitys){
				DataConfigTypeEntity dataConfigTypeEntity=new DataConfigTypeEntity();
				dataConfigTypeEntity.setDataType(String.valueOf(dataConfigEntity.getDataid()));
				dataConfigTypeEntity.setDataTypeName(dataConfigEntity.getConfigName());
				dataConfigTypes.add(dataConfigTypeEntity);
			}
		}
		model.addAttribute("dataConfigTypes", dataConfigTypes);
		model.addAttribute("sinfoDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_SCRAP_INFO)));
	   return "sysmanage/defect/defectManage";
    }
	@RequestMapping(value="dataconfig/dataConfigManage", method= RequestMethod.GET)
    public  String dataConfigManage(Model model, HttpServletRequest request) {
		List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_LIST));
		List<DataConfigTypeEntity> dataConfigTypes=new ArrayList<DataConfigTypeEntity>();
		if(dataConfigEntitys!=null && dataConfigEntitys.size()>0){
			for(DataConfigEntity dataConfigEntity:dataConfigEntitys){
				DataConfigTypeEntity dataConfigTypeEntity=new DataConfigTypeEntity();
				dataConfigTypeEntity.setDataType(String.valueOf(dataConfigEntity.getDataid()));
				dataConfigTypeEntity.setDataTypeName(dataConfigEntity.getConfigName());
				dataConfigTypes.add(dataConfigTypeEntity);
			}
		}
		model.addAttribute("dataConfigTypes", dataConfigTypes);
	   return "sysmanage/dataconfig/dataConfigManage";
    }
	@RequestMapping(value="dataconfig/dataConfigManage", method= RequestMethod.POST)
    public @ResponseBody String dataConfigManage(Model model,DataConfigQueryFormEntity  dataConfigQueryFormEntity, HttpServletRequest request) {
        if(dataConfigQueryFormEntity.getPageSize()==0){
        	dataConfigQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
		try {
			baseResponse=dataConfigManageService.queryDataConfigList(dataConfigQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dataconfigmanage.userManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dataconfigmanage.userManage.exception"));
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
	/*
	 * 删除数据字典信息
	 */
	@RequestMapping(value="dataconfig/delDataconfig", method= RequestMethod.POST)
    public @ResponseBody String delDataconfig(@RequestParam("dataids") String dataids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] adataid=dataids.split(",");
			baseResponse=dataConfigManageService.delDataConfig(Arrays.asList(adataid));
			dataConfigReload();
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dataconfigmanage.delDataconfig.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dataconfigmanage.delDataconfig.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 添加数据字典
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="dataconfig/addDataconfig", method= RequestMethod.POST)
    public  @ResponseBody String addDataconfig(@Valid DataConfigEntity dataConfigEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					dataConfigEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				baseResponse=dataConfigManageService.addDataConfig(dataConfigEntity);
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
					dataConfigReload();
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dataconfigmanage.addDataconfig.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dataconfigmanage.addDataconfig.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 修改用户信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="dataconfig/modDataconfig", method= RequestMethod.POST)
    public  @ResponseBody String modDataconfig(@Valid DataConfigEntity dataConfigEntity,BindingResult result,Model model,HttpServletRequest request)throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					dataConfigEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				baseResponse=dataConfigManageService.modDataConfig(dataConfigEntity);
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
					dataConfigReload();
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dataconfigmanage.modDataconfig.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dataconfigmanage.modDataconfig.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 数据配置信息重新加载
	 */
	private void dataConfigReload(){
		tableDataConfigInitiator.initialize();
		initSysDataConfig.initialize();
	}
}

package com.pall.portal.module.reagentmixture;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

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

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.pall.portal.annotation.Token;
import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.constants.KeyConstants;
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.common.support.excel.ExcelHeaderNode;
import com.pall.portal.context.HolderContext;
import com.pall.portal.init.DataConfigInitiator;
import com.pall.portal.init.TableDataConfigInitiator;
import com.pall.portal.init.UmsConfigInitiator;
import com.pall.portal.interceptor.support.AuthToken;
import com.pall.portal.repository.entity.dataconfig.DataConfigEntity;
import com.pall.portal.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.portal.repository.entity.reagentmixture.ReagentMixtureEntity;
import com.pall.portal.repository.entity.reagentmixture.ReagentMixtureEntitySns;
import com.pall.portal.repository.entity.reagentmixture.ReagentMixtureQueryFormEntity;
import com.pall.portal.repository.entity.reagentmixture.ReagentMixtureSnsQueryFormEntity;
import com.pall.portal.service.reagentmixture.ReagentMixtureManageService;
/*
 * 试剂混合管理控制器
 */
@Controller
public class ReagentMixtureManageController{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());  
	/*
	 * 试剂混合管理服务
	 */
	@Autowired
	private ReagentMixtureManageService reagentMixtureManageService;
	@Autowired
	private ResourceUtils resourceUtils;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		model.addAttribute("tableName", UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_TABLENAME));
		model.addAttribute("mrDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_DATACONFIG_TYPE_MAINREAGENT)));
		model.addAttribute("subDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_DATACONFIG_TYPE_SUBREAGENT)));
		model.addAttribute("reagentMixtureTable", UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_TABLENAME));
		return model;
	}
	
	/*
	 * 试剂混合管理
	 */
	@RequestMapping(value="reagent/reagentMixtureManage", method= RequestMethod.GET)
    public  String reagentMixtureManage(Model model, HttpServletRequest request) {
		model=initConfigData(model);
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_TABLENAME));
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
	    return "sysmanage/reagent/reagentMixtureManage";
    }
	@RequestMapping(value="reagent/reagentMixtureManage", method= RequestMethod.POST)
    public @ResponseBody String reagentMixtureManage(Model model,ReagentMixtureQueryFormEntity  reagentMixtureQueryFormEntity, HttpServletRequest request) {
        if(reagentMixtureQueryFormEntity.getPageSize()==0){
        	reagentMixtureQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
		try {
			baseResponse=reagentMixtureManageService.queryReagentMixtureList(reagentMixtureQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("reagentMixtureManage.controler.reagentMixtureManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.controler.reagentMixtureManage.exception"));
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
    }
	@RequestMapping(value="reagent/reagentMixtureSnsManage", method= RequestMethod.POST)
    public @ResponseBody String reagentMixtureSnsManage(Model model,ReagentMixtureSnsQueryFormEntity  reagentMixtureSnsQueryFormEntity, HttpServletRequest request) {
        if(reagentMixtureSnsQueryFormEntity.getPageSize()==0){
        	reagentMixtureSnsQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
		try {
			baseResponse=reagentMixtureManageService.queryReagentSnsMixtureList(reagentMixtureSnsQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("reagentMixtureManage.controler.reagentMixtureManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.controler.reagentMixtureManage.exception"));
			
		}
	   return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
    }
	private ReagentMixtureEntity  getFieldEntitys(HttpServletRequest request,ReagentMixtureEntity reagentMixtureEntity,List<DataConfigEntity> dataConfigEntitys){
		String reagentMixtureTableName=UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_TABLENAME);
		List<ReagentMixtureEntitySns> lReagentMixtureEntitySns=new ArrayList<ReagentMixtureEntitySns>();
		String requestValue="";
		for(DataConfigEntity dataConfigEntity:dataConfigEntitys){
				requestValue=request.getParameter(reagentMixtureTableName+dataConfigEntity.getDataid());
				if(!StringUtils.isEmpty(requestValue)){
					ReagentMixtureEntitySns reagentMixtureEntitySns=new ReagentMixtureEntitySns();
					reagentMixtureEntitySns.setReagentsFieldName(reagentMixtureTableName+dataConfigEntity.getDataid());
					reagentMixtureEntitySns.setReagentsName(dataConfigEntity.getConfigName());
					reagentMixtureEntitySns.setReagentsSn(requestValue);
					reagentMixtureEntitySns.setMainReagent(reagentMixtureEntity.getMainReagent());
					reagentMixtureEntitySns.setRmid(reagentMixtureEntity.getRmid());
					lReagentMixtureEntitySns.add(reagentMixtureEntitySns);
				}
		}
		if(reagentMixtureEntity.getReagentMixtureEntitySns()==null){
			reagentMixtureEntity.setReagentMixtureEntitySns(new ArrayList<ReagentMixtureEntitySns>());
		}
		reagentMixtureEntity.getReagentMixtureEntitySns().addAll(lReagentMixtureEntitySns);
		return reagentMixtureEntity;
	}
	/*
	 * 添加试剂混合
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="reagent/addReagentMixture", method= RequestMethod.GET)
    public  String addReagentMixture(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		return "sysmanage/reagent/addReagentMixture";
    }
	/*
	 * 添加试剂混合
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="reagent/addReagentMixture", method= RequestMethod.POST)
    public  @ResponseBody String addReagentMixture(@Valid ReagentMixtureEntity reagentMixtureEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					reagentMixtureEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				if(StringUtils.isEmpty(reagentMixtureEntity.getTemperatureUpEndtime())){
					reagentMixtureEntity.setTemperatureUpStarttime(null);
				}
				if(StringUtils.isEmpty(reagentMixtureEntity.getTemperatureUpEndtime())){
					reagentMixtureEntity.setTemperatureUpEndtime(null);
				}
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_DATACONFIG_TYPE_SUBREAGENT));
				reagentMixtureEntity=getFieldEntitys(request,reagentMixtureEntity,dataConfigEntitys);
				baseResponse=reagentMixtureManageService.addReagentMixture(reagentMixtureEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("reagentMixtureManage.controler.addReagentMixture.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.controler.addReagentMixture.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 修改试剂混合信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="reagent/modReagentMixture", method= RequestMethod.GET)
    public String modReagentMixture(@RequestParam("rmid") String rmid,@RequestParam("operator") String operator,Model model,HttpServletRequest request)throws Exception {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		try {
			ReagentMixtureQueryFormEntity reagentMixtureQueryFormEntity=new ReagentMixtureQueryFormEntity();
			reagentMixtureQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			reagentMixtureQueryFormEntity.setRmid(rmid);
			baseResponse=reagentMixtureManageService.queryReagentMixture(reagentMixtureQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cleanmanage.controler.queryClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.queryClean.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		ReagentMixtureEntity reagentMixtureEntity=null;
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        List<ReagentMixtureEntity> reagentMixtureEntitys=(List<ReagentMixtureEntity>)baseResponse.getReturnObjects();
	        if (reagentMixtureEntitys!=null &&  reagentMixtureEntitys.size()>0){
	        	reagentMixtureEntity=reagentMixtureEntitys.get(0);
	        }
		}
		if(reagentMixtureEntity==null){
			reagentMixtureEntity=new ReagentMixtureEntity();
		}
		model.addAttribute("operator", operator);
		model.addAttribute("reagentMixtureEntity", reagentMixtureEntity);
		return "sysmanage/reagent/modReagentMixture";
    }
	/*
	 * 修改试剂混合信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="reagent/modReagentMixture", method= RequestMethod.POST)
    public  @ResponseBody String modReagentMixture(@Valid ReagentMixtureEntity reagentMixtureEntity,BindingResult result,Model model,HttpServletRequest request)throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					reagentMixtureEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				if(StringUtils.isEmpty(reagentMixtureEntity.getTemperatureUpEndtime())){
					reagentMixtureEntity.setTemperatureUpStarttime(null);
				}
				if(StringUtils.isEmpty(reagentMixtureEntity.getTemperatureUpEndtime())){
					reagentMixtureEntity.setTemperatureUpEndtime(null);
				}
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_DATACONFIG_TYPE_SUBREAGENT));
				reagentMixtureEntity=getFieldEntitys(request,reagentMixtureEntity,dataConfigEntitys);
				baseResponse=reagentMixtureManageService.modReagentMixture(reagentMixtureEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("reagentMixtureManage.controler.modReagentMixture.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.controler.modReagentMixture.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除试剂混合信息
	 */
	@RequestMapping(value="reagent/delReagentMixture", method= RequestMethod.POST)
    public @ResponseBody String delReagentMixture(@RequestParam("rmids") String rmids,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] adataid=rmids.split(",");
			baseResponse=reagentMixtureManageService.delReagentMixture(Arrays.asList(adataid));
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("reagentMixtureManage.controler.delReagentMixture.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.controler.delReagentMixture.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

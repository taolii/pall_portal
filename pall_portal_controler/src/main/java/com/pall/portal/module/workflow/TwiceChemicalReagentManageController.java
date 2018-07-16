package com.pall.portal.module.workflow;

import java.io.File;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thymeleaf.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.util.IOUtils;
import com.google.common.io.Files;
import com.pall.portal.annotation.Token;
import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.constants.KeyConstants;
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.common.support.excel.ExcelDataNode;
import com.pall.portal.common.support.excel.ExcelHeaderNode;
import com.pall.portal.common.tools.ExcelTools;
import com.pall.portal.context.HolderContext;
import com.pall.portal.init.DataConfigInitiator;
import com.pall.portal.init.TableDataConfigInitiator;
import com.pall.portal.init.UmsConfigInitiator;
import com.pall.portal.interceptor.support.AuthToken;
import com.pall.portal.repository.entity.dataconfig.DataConfigEntity;
import com.pall.portal.repository.entity.dataconfig.DataConfigTypeEntity;
import com.pall.portal.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.portal.repository.entity.menu.ButtonEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentEntity;
import com.pall.portal.repository.entity.workflow.ExcelSaveEntity;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity.ADD;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity.SAVE;
import com.pall.portal.repository.entity.workflow.TwiceChemicalCompoundReagentsEntity;
import com.pall.portal.repository.entity.workflow.TwiceChemicalReagentEntity;
import com.pall.portal.repository.entity.workflow.TwiceChemicalReagentMixtureQueryFormEntity;
import com.pall.portal.repository.entity.workflow.TwiceChemicalReagentQueryFormEntity;
import com.pall.portal.repository.entity.workflow.TwiceChemicalReagentRelationEntity;
import com.pall.portal.service.excel.IExcelHandler;
import com.pall.portal.service.menu.ButtonManageService;
import com.pall.portal.service.workflow.TwiceChemicalReagentService;
/*
 * 2次生化镀膜管理控制器
 */
@Controller
public class TwiceChemicalReagentManageController{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	/*
	 * 工作流服务管理接口
	 */
	@Autowired
	private TwiceChemicalReagentService twiceChemicalReagentService;
	@Autowired
	private ButtonManageService buttonManageService;
	/*
	 * excel处理对象
	 */
	@Autowired
	@Qualifier("xlsxExcelHandler")
	private IExcelHandler iExcelHandler;
	/*
	 * 下载文件路径
	 */
	@Value("${system.default.file.download.path}")
	private String downloadFilePath;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		model.addAttribute("pnDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_PARTNUM)));
		model.addAttribute("mrDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_DATACONFIG_TYPE_MAINREAGENT)));
		model.addAttribute("chemicalReagentConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_CHEMICAL_REAGENT)));
		model.addAttribute("bioPatNumConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_BIOPATNUM)));
		model.addAttribute("cp1Configs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_COP1)));
		model.addAttribute("cp2Configs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_COP1)));
		model.addAttribute("rawMaterialConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_RAWMATERIAL)));
		model.addAttribute("coatingStationConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_COATINGSTATION)));
		return model;
	}
	/*
	 * 查询试剂混合信息管理
	 */
	@RequestMapping(value="workflow/twiceReagentMixtureDetail", method= RequestMethod.POST)
    public  @ResponseBody String twiceReagentMixtureDetail(Model model,TwiceChemicalReagentMixtureQueryFormEntity  chemicalReagentMixtureQueryFormEntity, HttpServletRequest request) {
    	 if(chemicalReagentMixtureQueryFormEntity.getPageSize()==0){
    		 chemicalReagentMixtureQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
         }
         BaseTablesResponse baseResponse=new BaseTablesResponse();
 		try {
 			baseResponse=twiceChemicalReagentService.queryTwiceChemicalReagentMixtureList(chemicalReagentMixtureQueryFormEntity);
 		} catch (Exception e) {
 			logger.error(resourceUtils.getMessage("twiceChemicalReagentManage.controler.reagentMixtureDetail.exception"),e);
 			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
 			baseResponse.setResultMsg(resourceUtils.getMessage("twiceChemicalReagentManage.controler.reagentMixtureDetail.exception"));
 			
 		}
 		 return JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
    }
	/*
	 * 生化镀膜管理
	 */
	@RequestMapping(value="workflow/twiceChemicalReagentManage", method= RequestMethod.GET)
    public  String twiceChemicalReagentManage(Model model, HttpServletRequest request) {
		model=initConfigData(model);
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			try {
				BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					List<ButtonEntity> buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
					model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		Map<Integer,List<TableHeaderConfigEntity>> assemblyTableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_TABLENAME));
		model.addAttribute("assemblyTableHeaderConfigs", assemblyTableHeaderConfigs);
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_TABLENAME));
		model.addAttribute("crDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_CHEMICAL_REAGENT)));
		model.addAttribute("crDataConfigType", UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_CHEMICAL_REAGENT));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		model.addAttribute("pnDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_PARTNUM)));
		model.addAttribute("remarkDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_REMARK)));
		List<DataConfigTypeEntity> workingfaceTypes=new ArrayList<DataConfigTypeEntity>();
		DataConfigTypeEntity dataConfigTypeEntity=new DataConfigTypeEntity();
		dataConfigTypeEntity.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_CHEMICAL_REAGENT));
		//dataConfigTypeEntity.setDataTypeName(resourceUtils.getMessage("dataconfigmanage.form.workflow.select.chemical.reagent"));
		dataConfigTypeEntity.setDataTypeName("");
		workingfaceTypes.add(dataConfigTypeEntity);
		model.addAttribute("workingfaceTypes", workingfaceTypes);
		model.addAttribute("tableName", UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_TABLENAME));
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_TABLENAME));
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
		List<ExcelHeaderNode> assemblyTableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> assemblyTableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_TABLENAME));
		if(assemblyTableFieldBindMap!=null){
			assemblyTableFieldBinds.addAll(assemblyTableFieldBindMap.values());
		}
		Collections.sort(assemblyTableFieldBinds,new Comparator<ExcelHeaderNode>() {
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
		model.addAttribute("assemblyTableFieldBinds", JSON.toJSONString(assemblyTableFieldBinds,SerializerFeature.WriteMapNullValue));
	   return "workflow/twiceChemicalReagent/twiceChemicalReagentManage";
    }
	@RequestMapping(value="workflow/twiceChemicalReagentManage", method= RequestMethod.POST)
    public @ResponseBody String chemicalReagentManage(Model model,TwiceChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity, HttpServletRequest request) {
        if(chemicalReagentQueryFormEntity.getPageSize()==0){
        	chemicalReagentQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=twiceChemicalReagentService.queryTwiceChemicalReagentList(chemicalReagentQueryFormEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("twiceChemicalReagentManage.controler.twiceChemicalReagentManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("twiceChemicalReagentManage.controler.twiceChemicalReagentManage.exception"));
			
		}
		 return jsonData;
    }
	public  String chemicalReagentOverturnFiled(String jsonData,List<String> chemicalReagentTypes){
		JSONObject jsonObject=JSON.parseObject(jsonData);
		JSONArray jsonArray=jsonObject.getJSONObject("datatablesView").getJSONArray("data");
		for(int i=0;i<jsonArray.size();i++){
			JSONObject tempjsonObject=jsonArray.getJSONObject(i);
			JSONArray chemicalReagentJSONArray=tempjsonObject.getJSONArray("compoundReagents");
			if(chemicalReagentJSONArray==null)continue;
			for(int j=0;j<chemicalReagentJSONArray.size();j++){
				tempjsonObject.put(chemicalReagentJSONArray.getJSONObject(j).getString("compoundReagentsName"),chemicalReagentJSONArray.getJSONObject(j).getString("compoundReagentsSN"));
			}
			tempjsonObject.remove("compoundReagents");
		}
		Map<String,ExcelHeaderNode> tableFieldBindMap=null;
		if(chemicalReagentTypes!=null){
			for(String chemicalReagentType:chemicalReagentTypes){
				tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(chemicalReagentType);
				if(tableFieldBindMap!=null){
					for(String fieldName:tableFieldBindMap.keySet()){
						for(int i=0;i<jsonArray.size();i++){
							JSONObject tempjsonObject=jsonArray.getJSONObject(i);
							if(tempjsonObject.get(fieldName)==null){
								tempjsonObject.put(fieldName,"");
							}
						}
					}
				}
			}
		}
		
		return JSON.toJSONString(jsonObject,SerializerFeature.WriteMapNullValue);
	}
	/*
	 * 添加生化镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addTwiceChemicalReagent", method= RequestMethod.GET)
    public  String addTwiceChemicalReagent(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		model.addAttribute("bioBomConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_BIOBOM)));
		return "workflow/twiceChemicalReagent/addTwiceChemicalReagent";
    }
	/*
	 * 添加生化镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addTwiceChemicalReagent", method= RequestMethod.POST)
    public  @ResponseBody String addTwiceChemicalReagent(@Validated(ADD.class) TwiceChemicalReagentEntity chemicalReagentEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_CHEMICAL_REAGENT));
				chemicalReagentEntity=getFieldEntitys(request,chemicalReagentEntity,dataConfigEntitys);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					chemicalReagentEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				String reagentMixturetableName=UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_TABLENAME);
				Map<String,String[]>paras=request.getParameterMap();
				if(paras!=null){
					List<TwiceChemicalCompoundReagentsEntity> chemicalCompoundReagents=new ArrayList<TwiceChemicalCompoundReagentsEntity>();
					chemicalReagentEntity.setCompoundReagents(chemicalCompoundReagents);
					for(String paramName:paras.keySet()){
						if(paramName.startsWith(reagentMixturetableName)){
							TwiceChemicalCompoundReagentsEntity chemicalCompoundReagentsEntity=new TwiceChemicalCompoundReagentsEntity();
							String[] temps=paramName.split("_");
							if(temps.length>=2){
								chemicalCompoundReagentsEntity.setSrmid(Integer.parseInt(temps[1]));
							}else{
								continue;
							}
							chemicalCompoundReagentsEntity.setReagentsFieldName(paramName);
							chemicalCompoundReagentsEntity.setReagentsSn(paras.get(paramName)[0]);
							chemicalCompoundReagents.add(chemicalCompoundReagentsEntity);
							
						}
					}
				}
				List<TwiceChemicalReagentRelationEntity> chemicalReagentRelations=new ArrayList<TwiceChemicalReagentRelationEntity>();
				String trayNumLen=request.getParameter("trayNumLen");
				if(!StringUtils.isEmpty(trayNumLen)){
					for(int i=0;i<Integer.parseInt(trayNumLen);i++){
						TwiceChemicalReagentRelationEntity chemicalReagentRelationEntity=new TwiceChemicalReagentRelationEntity();
						chemicalReagentRelationEntity.setTrayNum(request.getParameter("trayNum"+i));
						chemicalReagentRelationEntity.setOldLotNum(request.getParameter("oldLotNum"+i));
						chemicalReagentRelationEntity.setOldBioPatNum(request.getParameter("oldBioPatNum"+i));
						chemicalReagentRelationEntity.setOldTrayNum(request.getParameter("oldTrayNum"+i));
						chemicalReagentRelations.add(chemicalReagentRelationEntity);
					}
				}
				chemicalReagentEntity.setChemicalReagentRelations(chemicalReagentRelations);
				
				if(StringUtils.isEmpty(chemicalReagentEntity.getInPutDate())){
					chemicalReagentEntity.setInPutDate(null);
				}
				baseResponse=twiceChemicalReagentService.addTwiceChemicalReagent(chemicalReagentEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("twiceChemicalReagentManage.controler.addTwiceChemicalReagent.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("twiceChemicalReagentManage.controler.addTwiceChemicalReagent.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 封装缺损请求参数对象
	 */
	private TwiceChemicalReagentEntity  getFieldEntitys(HttpServletRequest request,TwiceChemicalReagentEntity chemicalReagentEntity,List<DataConfigEntity> dataConfigEntitys){
		//不良率计算
		if(chemicalReagentEntity.getInputQty()!=null && chemicalReagentEntity.getGoodsQty()!=null && chemicalReagentEntity.getInputQty()>0){
			double yield=new BigDecimal(((float)chemicalReagentEntity.getGoodsQty()/chemicalReagentEntity.getInputQty())*100).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			chemicalReagentEntity.setActualYield(String.valueOf(yield));
		}
		if(!StringUtils.isEmpty(chemicalReagentEntity.getTheoryYield()) && !"0".equals(chemicalReagentEntity.getTheoryYield())){
			double yield=new BigDecimal((Float.parseFloat(chemicalReagentEntity.getActualYield())/Float.parseFloat(chemicalReagentEntity.getTheoryYield()))*100).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			chemicalReagentEntity.setTheoryActualYield(String.valueOf(yield));
		}
		if(chemicalReagentEntity.getCompoundReagents()==null){
			chemicalReagentEntity.setCompoundReagents(new ArrayList<TwiceChemicalCompoundReagentsEntity>());
		}
		return chemicalReagentEntity;
	}
	/*
	 * 修改生化镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modTwiceChemicalReagent", method= RequestMethod.GET)
    public   String modTwiceChemicalReagent(@RequestParam("crID") String crID,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		TwiceChemicalReagentEntity chemicalReagentEntity=null;
		try {
			TwiceChemicalReagentQueryFormEntity chemicalReagentQueryFormEntity=new TwiceChemicalReagentQueryFormEntity();
			chemicalReagentQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			chemicalReagentQueryFormEntity.setCrID(crID);
			chemicalReagentEntity=twiceChemicalReagentService.getTwiceChemicalReagent(chemicalReagentQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("twiceChemicalReagentManage.controler.exportTwiceChemicalReagent.exception"),e);
		}
		if(chemicalReagentEntity==null){
			chemicalReagentEntity=new TwiceChemicalReagentEntity();
		}
		//数据查询成功，将文件写入下载目录以便下载
		List<DataConfigEntity> bioBomConfigs=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_BIOBOM));
    	
		model.addAttribute("chemicalReagentEntity", chemicalReagentEntity);
		if(bioBomConfigs==null){
			bioBomConfigs=new ArrayList<DataConfigEntity>();
		}
    	model.addAttribute("bioBomConfigs",bioBomConfigs);
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "workflow/twiceChemicalReagent/copyTwiceChemicalReagent";
		}else{
			return "workflow/twiceChemicalReagent/modTwiceChemicalReagent";
		}
    }
	/*
	 * 修改生化镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modTwiceChemicalReagent", method= RequestMethod.POST)
    public  @ResponseBody String modTwiceChemicalReagent(@Validated(SAVE.class) TwiceChemicalReagentEntity chemicalReagentEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DATACONFIG_TYPE_CHEMICAL_REAGENT));
				chemicalReagentEntity=getFieldEntitys(request,chemicalReagentEntity,dataConfigEntitys);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					chemicalReagentEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				String reagentMixturetableName=UmsConfigInitiator.getDataConfig(KeyConstants.REAGENTMIXTURE_TABLENAME);
				Map<String,String[]>paras=request.getParameterMap();
				if(paras!=null){
					List<TwiceChemicalCompoundReagentsEntity> chemicalCompoundReagents=new ArrayList<TwiceChemicalCompoundReagentsEntity>();
					chemicalReagentEntity.setCompoundReagents(chemicalCompoundReagents);
					for(String paramName:paras.keySet()){
						if(paramName.startsWith(reagentMixturetableName)){
							TwiceChemicalCompoundReagentsEntity chemicalCompoundReagentsEntity=new TwiceChemicalCompoundReagentsEntity();
							String[] temps=paramName.split("_");
							if(temps.length>=2){
								chemicalCompoundReagentsEntity.setSrmid(Integer.parseInt(temps[1]));
							}else{
								continue;
							}
							chemicalCompoundReagentsEntity.setReagentsFieldName(paramName);
							chemicalCompoundReagentsEntity.setReagentsSn(paras.get(paramName)[0]);
							chemicalCompoundReagents.add(chemicalCompoundReagentsEntity);
							
						}
					}
				}
				List<TwiceChemicalReagentRelationEntity> chemicalReagentRelations=new ArrayList<TwiceChemicalReagentRelationEntity>();
				String trayNumLen=request.getParameter("trayNumLen");
				if(!StringUtils.isEmpty(trayNumLen)){
					for(int i=0;i<Integer.parseInt(trayNumLen);i++){
						TwiceChemicalReagentRelationEntity chemicalReagentRelationEntity=new TwiceChemicalReagentRelationEntity();
						chemicalReagentRelationEntity.setTrayNum(request.getParameter("trayNum"+i));
						chemicalReagentRelationEntity.setOldLotNum(request.getParameter("oldLotNum"+i));
						chemicalReagentRelationEntity.setOldBioPatNum(request.getParameter("oldBioPatNum"+i));
						chemicalReagentRelationEntity.setOldTrayNum(request.getParameter("oldTrayNum"+i));
						chemicalReagentRelations.add(chemicalReagentRelationEntity);
					}
				}
				chemicalReagentEntity.setChemicalReagentRelations(chemicalReagentRelations);
				
				if(StringUtils.isEmpty(chemicalReagentEntity.getInPutDate())){
					chemicalReagentEntity.setInPutDate(null);
				}
				baseResponse=twiceChemicalReagentService.modifyTwiceChemicalReagent(chemicalReagentEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("twiceChemicalReagentManage.controler.modifyTwiceChemicalReagentexception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("twiceChemicalReagentManage.controler.modifyTwiceChemicalReagentexception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除生化镀膜信息
	 */
	@RequestMapping(value="workflow/delTwiceChemicalReagent", method= RequestMethod.POST)
    public @ResponseBody String delTwiceChemicalReagent(@RequestParam("crIDs") String crIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aocrID=crIDs.split(",");
			List<Integer> tempChemicalReagent=new ArrayList<Integer>();
			for(String crid:aocrID){
				tempChemicalReagent.add(Integer.parseInt(crid));
			}
			baseResponse=twiceChemicalReagentService.delTwiceChemicalReagent(tempChemicalReagent);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("twiceChemicalReagentManage.controler.delTwiceChemicalReagent.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("twiceChemicalReagentManage.controler.delTwiceChemicalReagent.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出生化镀膜信息
	 */
	@RequestMapping(value="workflow/exportTwiceChemicalReagent", method= RequestMethod.POST)
    public @ResponseBody String exportTwiceChemicalReagent(Model model,TwiceChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=twiceChemicalReagentService.exportTwiceChemicalReagent(chemicalReagentQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("twiceChemicalReagentManage.controler.exportTwiceChemicalReagent.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("twiceChemicalReagentManage.controler.exportTwiceChemicalReagent.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_TABLENAME));
	        List<ChemicalReagentEntity> chemicalReagentEntitys=(List<ChemicalReagentEntity>)baseResponse.getReturnObjects();
	        
	        int currentRowNum=excelheadlinesMap.size();
	        Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
	        if(null!=chemicalReagentEntitys && chemicalReagentEntitys.size()>0){
	        	if(!StringUtils.isEmpty(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        		if(chemicalReagentEntitys.size()>Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
	        			baseResponse.setResultMsg(resourceUtils.getMessage("twiceChemicalReagentManage.controler.exportTwiceChemicalReagent.records.limits")+":"+UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS));
	        			baseResponse.setReturnObjects(null);
	        			return JSON.toJSONString(baseResponse);
		        	}
	        	}
	        	rowdatas=ExcelTools.getExcelDatas(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_TABLENAME), chemicalReagentEntitys,currentRowNum);
	        }
	        //设置下载保存文件路径
        	StringBuilder downloadFileFullPath=new StringBuilder();
        	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(downloadFilePath);
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DOWNLOAD_SUBDIRECTORY));
        	downloadFileFullPath.append(File.separator);
        	
        	//设置下载保存文件路径名称
        	StringBuilder fileName=new StringBuilder();
        	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
        	fileName.append("_");
        	fileName.append(resourceUtils.getMessage("twiceChemicalReagentManage.controler.exportTwiceChemicalReagent.filename"));
        	fileName.append("_");
        	SimpleDateFormat sf=new SimpleDateFormat("yyyymmddhh24mmss");
        	fileName.append(sf.format(new Date()));
        	fileName.append(KeyConstants.EXCEL_SUFFIX_XLSX);
        	OutputStream out =null;
	        try {
	        	Files.createParentDirs(new File(downloadFileFullPath.toString()+fileName.toString()));
	        	out=new FileSystemResource(downloadFileFullPath.toString()+fileName.toString()).getOutputStream();
				Workbook workbook=iExcelHandler.getExcelWorkbook(resourceUtils.getMessage("twiceChemicalReagentManage.controler.exportTwiceChemicalReagent.filename"), excelheadlinesMap, rowdatas);
				workbook.write(out);
				List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
				ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
				excelSaveEntity.setFileName(fileName.toString());
				excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.TWICE_CHEMICALREAGENT_DOWNLOAD_SUBDIRECTORY));
				excelSaveEntitys.add(excelSaveEntity);
				baseResponse.setReturnObjects(excelSaveEntitys);
				return JSON.toJSONString(baseResponse);
			} catch (Exception e) {
				logger.error(resourceUtils.getMessage("twiceChemicalReagentManage.controler.exportTwiceChemicalReagent.records.limits"),e);
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("twiceChemicalReagentManage.controler.exportTwiceChemicalReagent.records.limits")+":"+e.toString());
			}finally{
				IOUtils.close(out);
			}
	    }
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

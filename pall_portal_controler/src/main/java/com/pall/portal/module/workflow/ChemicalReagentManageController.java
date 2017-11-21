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

import com.alibaba.druid.util.StringUtils;
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
import com.pall.portal.repository.entity.workflow.ChemicalCompoundReagentsEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentQueryFormEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentRelationEntity;
import com.pall.portal.repository.entity.workflow.ExcelSaveEntity;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity.ADD;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity.SAVE;
import com.pall.portal.service.excel.IExcelHandler;
import com.pall.portal.service.workflow.ChemicalReagentService;
/*
 * 生化镀膜管理控制器
 */
@Controller
public class ChemicalReagentManageController{
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
	private ChemicalReagentService chemicalReagentService;
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
	 * 光学镀膜管理
	 */
	@RequestMapping(value="workflow/chemicalReagentManage", method= RequestMethod.GET)
    public  String chemicalReagentManage(Model model, HttpServletRequest request) {
		Map<Integer,List<TableHeaderConfigEntity>> assemblyTableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_ASSEMBLY_TABLENAME));
		model.addAttribute("assemblyTableHeaderConfigs", assemblyTableHeaderConfigs);
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_CHEMICALREAGENT_TABLENAME));
		model.addAttribute("crDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_CHEMICAL_REAGENT)));
		model.addAttribute("crDataConfigType", UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_CHEMICAL_REAGENT));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		model.addAttribute("pnDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_PARTNUM)));
		model.addAttribute("remarkDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_REMARK)));
		List<DataConfigTypeEntity> workingfaceTypes=new ArrayList<DataConfigTypeEntity>();
		DataConfigTypeEntity dataConfigTypeEntity=new DataConfigTypeEntity();
		dataConfigTypeEntity.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_CHEMICAL_REAGENT));
		dataConfigTypeEntity.setDataTypeName(resourceUtils.getMessage("dataconfigmanage.form.workflow.select.chemical.reagent"));
		workingfaceTypes.add(dataConfigTypeEntity);
		model.addAttribute("workingfaceTypes", workingfaceTypes);
		model.addAttribute("tableName", UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_CHEMICALREAGENT_TABLENAME));
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_CHEMICALREAGENT_TABLENAME));
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
		Map<String,ExcelHeaderNode> assemblyTableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_ASSEMBLY_TABLENAME));
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
	   return "workflow/chemicalReagent/chemicalReagentManage";
    }
	@RequestMapping(value="workflow/chemicalReagentManage", method= RequestMethod.POST)
    public @ResponseBody String chemicalReagentManage(Model model,ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity, HttpServletRequest request) {
        if(chemicalReagentQueryFormEntity.getPageSize()==0){
        	chemicalReagentQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=chemicalReagentService.queryChemicalReagentList(chemicalReagentQueryFormEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> chemicalReagentTypes=new ArrayList<String>();
				chemicalReagentTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_CHEMICALREAGENT_TABLENAME));
				jsonData= chemicalReagentOverturnFiled(jsonData,chemicalReagentTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("chemicalReagentManage.controler.chemicalReagentManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.controler.chemicalReagentManage.exception"));
			
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
	@RequestMapping(value="workflow/addChemicalReagent", method= RequestMethod.POST)
    public  @ResponseBody String addChemicalReagent(@Validated(ADD.class) ChemicalReagentEntity chemicalReagentEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_CHEMICAL_REAGENT));
				chemicalReagentEntity=getFieldEntitys(request,chemicalReagentEntity,dataConfigEntitys);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					chemicalReagentEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				baseResponse=chemicalReagentService.addChemicalReagent(chemicalReagentEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("chemicalReagentManage.controler.addChemicalReagent.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.controler.addChemicalReagent.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 封装缺损请求参数对象
	 */
	private ChemicalReagentEntity  getFieldEntitys(HttpServletRequest request,ChemicalReagentEntity chemicalReagentEntity,List<DataConfigEntity> dataConfigEntitys){
		String[] assemblyOutputLotNums=request.getParameterValues("assemblyOutputLotNum");
		if(assemblyOutputLotNums!=null && assemblyOutputLotNums.length>0){
			if(chemicalReagentEntity.getChemicalReagentRelations()==null){
				chemicalReagentEntity.setChemicalReagentRelations(new ArrayList<ChemicalReagentRelationEntity>());
			}
			for(String assemblyOutputLotNum:assemblyOutputLotNums){
				ChemicalReagentRelationEntity chemicalReagentRelationEntity=new ChemicalReagentRelationEntity();
				chemicalReagentRelationEntity.setAssemblyOutputLotNum(assemblyOutputLotNum);
				chemicalReagentEntity.getChemicalReagentRelations().add(chemicalReagentRelationEntity);
			}
		}
		List<ChemicalCompoundReagentsEntity> compoundReagents=new ArrayList<ChemicalCompoundReagentsEntity>();
		if(dataConfigEntitys!=null){
			String requestValue="";
			String chemicalReagentTableName=UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_CHEMICALREAGENT_TABLENAME);
			for(DataConfigEntity dataConfigEntity:dataConfigEntitys){
					requestValue=request.getParameter(chemicalReagentTableName+dataConfigEntity.getDataid());
					if(!StringUtils.isEmpty(requestValue)){
						ChemicalCompoundReagentsEntity chemicalCompoundReagentsEntity=new ChemicalCompoundReagentsEntity();
						chemicalCompoundReagentsEntity.setCompoundReagentsName(chemicalReagentTableName+dataConfigEntity.getDataid());
						chemicalCompoundReagentsEntity.setCompoundReagentsSN(requestValue);
						compoundReagents.add(chemicalCompoundReagentsEntity);
					}
			}
		}
		//不良率计算
		if(chemicalReagentEntity.getInputQty()!=null && chemicalReagentEntity.getGoodsQty()!=null && chemicalReagentEntity.getInputQty()>0){
			double yield=new BigDecimal((float)chemicalReagentEntity.getGoodsQty()/chemicalReagentEntity.getInputQty()).setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
			chemicalReagentEntity.setActualYield(yield*100);
		}
		if(chemicalReagentEntity.getTheoryYield()!=0){
			double yield=new BigDecimal((float)chemicalReagentEntity.getActualYield()/chemicalReagentEntity.getTheoryYield()).setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
			chemicalReagentEntity.setTheoryActualYield(yield*100);
		}
		if(chemicalReagentEntity.getCompoundReagents()==null){
			chemicalReagentEntity.setCompoundReagents(new ArrayList<ChemicalCompoundReagentsEntity>());
		}
		chemicalReagentEntity.getCompoundReagents().addAll(compoundReagents);
		return chemicalReagentEntity;
	}
	/*
	 * 修改生化镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modChemicalReagent", method= RequestMethod.POST)
    public  @ResponseBody String modChemicalReagent(@Validated(SAVE.class) ChemicalReagentEntity chemicalReagentEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_CHEMICAL_REAGENT));
				chemicalReagentEntity=getFieldEntitys(request,chemicalReagentEntity,dataConfigEntitys);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					chemicalReagentEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				baseResponse=chemicalReagentService.modifyChemicalReagent(chemicalReagentEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("chemicalReagentManage.controler.modifyChemicalReagent.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.controler.modifyChemicalReagent.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除生化镀膜信息
	 */
	@RequestMapping(value="workflow/delChemicalReagent", method= RequestMethod.POST)
    public @ResponseBody String delChemicalReagent(@RequestParam("crIDs") String crIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aocrID=crIDs.split(",");
			List<Integer> tempChemicalReagent=new ArrayList<Integer>();
			for(String crid:aocrID){
				tempChemicalReagent.add(Integer.parseInt(crid));
			}
			baseResponse=chemicalReagentService.delChemicalReagent(tempChemicalReagent);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("chemicalReagentManage.controler.delChemicalReagent.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.controler.delChemicalReagent.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出生化镀膜信息
	 */
	@RequestMapping(value="workflow/exportChemicalReagent", method= RequestMethod.POST)
    public @ResponseBody String exportChemicalReagent(Model model,ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=chemicalReagentService.exportChemicalReagent(chemicalReagentQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("chemicalReagentManage.controler.exportChemicalReagent.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.controler.exportChemicalReagent.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_CHEMICALREAGENT_TABLENAME));
	        List<ChemicalReagentEntity> chemicalReagentEntitys=(List<ChemicalReagentEntity>)baseResponse.getReturnObjects();
	        
	        int currentRowNum=excelheadlinesMap.size();
	        Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
	        if(null!=chemicalReagentEntitys && chemicalReagentEntitys.size()>0){
	        	if(!StringUtils.isEmpty(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        		if(chemicalReagentEntitys.size()>Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
	        			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.controler.exportChemicalReagent.records.limits")+":"+UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS));
	        			baseResponse.setReturnObjects(null);
	        			return JSON.toJSONString(baseResponse);
		        	}
	        	}
	        	rowdatas=ExcelTools.getExcelDatas(UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_CHEMICALREAGENT_TABLENAME), chemicalReagentEntitys,currentRowNum);
	        }
	        //设置下载保存文件路径
        	StringBuilder downloadFileFullPath=new StringBuilder();
        	downloadFileFullPath.append(Class.class.getResource("/").getPath());
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(downloadFilePath);
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.CHEMICALREAGENT_DOWNLOAD_SUBDIRECTORY));
        	downloadFileFullPath.append(File.separator);
        	
        	//设置下载保存文件路径名称
        	StringBuilder fileName=new StringBuilder();
        	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
        	fileName.append("_");
        	fileName.append(resourceUtils.getMessage("chemicalReagentManage.controler.exportChemicalReagent.filename"));
        	fileName.append("_");
        	SimpleDateFormat sf=new SimpleDateFormat("yyyymmddhh24mmss");
        	fileName.append(sf.format(new Date()));
        	fileName.append(KeyConstants.EXCEL_SUFFIX_XLSX);
        	OutputStream out =null;
	        try {
	        	Files.createParentDirs(new File(downloadFileFullPath.toString()+fileName.toString()));
	        	out=new FileSystemResource(downloadFileFullPath.toString()+fileName.toString()).getOutputStream();
				Workbook workbook=iExcelHandler.getExcelWorkbook(resourceUtils.getMessage("chemicalReagentManage.controler.exportChemicalReagent.filename"), excelheadlinesMap, rowdatas);
				workbook.write(out);
				List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
				ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
				excelSaveEntity.setFileName(fileName.toString());
				excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.CHEMICALREAGENT_DOWNLOAD_SUBDIRECTORY));
				excelSaveEntitys.add(excelSaveEntity);
				baseResponse.setReturnObjects(excelSaveEntitys);
				return JSON.toJSONString(baseResponse);
			} catch (Exception e) {
				logger.error(resourceUtils.getMessage("chemicalReagentManage.controler.exportChemicalReagent.records.limits"),e);
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.controler.exportChemicalReagent.records.limits")+":"+e.toString());
			}finally{
				IOUtils.close(out);
			}
	    }
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

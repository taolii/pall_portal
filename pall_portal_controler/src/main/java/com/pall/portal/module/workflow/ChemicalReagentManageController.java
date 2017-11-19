package com.pall.portal.module.workflow;

import java.io.File;
import java.io.OutputStream;
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
import com.pall.portal.common.tools.JSONTools;
import com.pall.portal.context.HolderContext;
import com.pall.portal.init.DataConfigInitiator;
import com.pall.portal.init.TableDataConfigInitiator;
import com.pall.portal.init.UmsConfigInitiator;
import com.pall.portal.interceptor.support.AuthToken;
import com.pall.portal.repository.entity.dataconfig.DataConfigEntity;
import com.pall.portal.repository.entity.dataconfig.DataConfigTypeEntity;
import com.pall.portal.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentQueryFormEntity;
import com.pall.portal.repository.entity.workflow.DefectEntity;
import com.pall.portal.repository.entity.workflow.ExcelSaveEntity;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity.ADD;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity.SAVE;
import com.pall.portal.repository.entity.workflow.OpticalFilmingQueryFormEntity;
import com.pall.portal.service.excel.IExcelHandler;
import com.pall.portal.service.workflow.ChemicalReagentService;
import com.pall.portal.service.workflow.OpticalFilmingService;
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
	private OpticalFilmingService opticalFilmingService;
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
				jsonData= JSONTools.defectsOverturnFiled(jsonData,chemicalReagentTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("chemicalReagentManage.controler.chemicalReagentManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.controler.chemicalReagentManage.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加生化镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addChemicalReagent", method= RequestMethod.POST)
    public  @ResponseBody String addChemicalReagent(@Validated(ADD.class) OpticalCoatingEntity opticalCoatingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_OPTICALFILMING_DEFECT_WF));
				List<DataConfigEntity> ndataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_OPTICALFILMING_DEFECT_NWF));
				int sumDefectValue=getDefectEntitys(request,opticalCoatingEntity,dataConfigEntitys);
				sumDefectValue=sumDefectValue+getDefectEntitys(request,opticalCoatingEntity,ndataConfigEntitys);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					opticalCoatingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				baseResponse=opticalFilmingService.addOpticalFilming(opticalCoatingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("opticalfilmingManage.controler.addOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.controler.addOpticalFilming.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 封装缺损请求参数对象
	 */
	private int getDefectEntitys(HttpServletRequest request,OpticalCoatingEntity opticalCoatingEntity,List<DataConfigEntity> dataConfigEntitys){
		int sumDefectValue=0;
		List<DefectEntity> defects=new ArrayList<DefectEntity>();
		if(dataConfigEntitys!=null){
			String requestValue="";
			String opticalFilmingTableName=UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_OPTICALFILMING_TABLENAME);
			for(DataConfigEntity dataConfigEntity:dataConfigEntitys){
					requestValue=request.getParameter(opticalFilmingTableName+dataConfigEntity.getDataid());
					if(!StringUtils.isEmpty(requestValue)){
						DefectEntity defectEntity=new DefectEntity();
						defectEntity.setDataid(dataConfigEntity.getDataid());
						defectEntity.setDefectName(dataConfigEntity.getConfigName());
						defectEntity.setDefectType(dataConfigEntity.getDataType());
						defectEntity.setDefectValue(Integer.parseInt(requestValue));
						//defectEntity.setDefectID(opticalCoatingEntity.getOpfID());
						sumDefectValue=sumDefectValue+Integer.parseInt(requestValue);
						defects.add(defectEntity);
					}
			}
		}
		if(opticalCoatingEntity.getDefects()==null){
			opticalCoatingEntity.setDefects(new ArrayList<DefectEntity>());
		}
		opticalCoatingEntity.getDefects().addAll(defects);
		return sumDefectValue;
	}
	/*
	 * 修改生化镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modChemicalReagent", method= RequestMethod.POST)
    public  @ResponseBody String modChemicalReagent(@Validated(SAVE.class) OpticalCoatingEntity opticalCoatingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_OPTICALFILMING_DEFECT_WF));
				List<DataConfigEntity> ndataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_OPTICALFILMING_DEFECT_NWF));
				int sumDefectValue=getDefectEntitys(request,opticalCoatingEntity,dataConfigEntitys);
				sumDefectValue=sumDefectValue+getDefectEntitys(request,opticalCoatingEntity,ndataConfigEntitys);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					opticalCoatingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				baseResponse=opticalFilmingService.modifyOpticalFilming(opticalCoatingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("opticalfilmingManage.controler.modifyOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.controler.modifyOpticalFilming.exception"));
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
    public @ResponseBody String exportChemicalReagent(Model model,OpticalFilmingQueryFormEntity  opticalFilmingQueryFormEntity, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=opticalFilmingService.exportOpticalFilming(opticalFilmingQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("opticalfilmingManage.controler.exportOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.controler.exportOpticalFilming.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_OPTICALFILMING_TABLENAME));
	        List<OpticalCoatingEntity> opticalCoatingEntitys=(List<OpticalCoatingEntity>)baseResponse.getReturnObjects();
	        
	        int currentRowNum=excelheadlinesMap.size();
	        Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
	        if(null!=opticalCoatingEntitys && opticalCoatingEntitys.size()>0){
	        	if(!StringUtils.isEmpty(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        		if(opticalCoatingEntitys.size()>Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
	        			baseResponse.setResultMsg(resourceUtils.getMessage("copticalfilmingManage.controler.exportOpticalFilming.records.limits")+":"+UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS));
	        			baseResponse.setReturnObjects(null);
	        			return JSON.toJSONString(baseResponse);
		        	}
	        	}
	        	rowdatas=ExcelTools.getExcelDatas(UmsConfigInitiator.getDataConfig(KeyConstants.WORKFLOW_OPTICALFILMING_TABLENAME), opticalCoatingEntitys,currentRowNum);
	        }
	        //设置下载保存文件路径
        	StringBuilder downloadFileFullPath=new StringBuilder();
        	downloadFileFullPath.append(Class.class.getResource("/").getPath());
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(downloadFilePath);
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DOWNLOAD_SUBDIRECTORY));
        	downloadFileFullPath.append(File.separator);
        	
        	//设置下载保存文件路径名称
        	StringBuilder fileName=new StringBuilder();
        	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
        	fileName.append("_");
        	fileName.append(resourceUtils.getMessage("opticalfilmingManage.controler.exportOpticalFilming.filename"));
        	fileName.append("_");
        	SimpleDateFormat sf=new SimpleDateFormat("yyyymmddhh24mmss");
        	fileName.append(sf.format(new Date()));
        	fileName.append(KeyConstants.EXCEL_SUFFIX_XLSX);
        	OutputStream out =null;
	        try {
	        	Files.createParentDirs(new File(downloadFileFullPath.toString()+fileName.toString()));
	        	out=new FileSystemResource(downloadFileFullPath.toString()+fileName.toString()).getOutputStream();
				Workbook workbook=iExcelHandler.getExcelWorkbook(resourceUtils.getMessage("opticalfilmingManage.controler.exportOpticalFilming.filename"), excelheadlinesMap, rowdatas);
				workbook.write(out);
				List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
				ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
				excelSaveEntity.setFileName(fileName.toString());
				excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DOWNLOAD_SUBDIRECTORY));
				excelSaveEntitys.add(excelSaveEntity);
				baseResponse.setReturnObjects(excelSaveEntitys);
				return JSON.toJSONString(baseResponse);
			} catch (Exception e) {
				logger.error(resourceUtils.getMessage("opticalfilmingManage.controler.exportOpticalFilming.exception"),e);
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.controler.exportOpticalFilming.exception")+":"+e.toString());
			}finally{
				IOUtils.close(out);
			}
	    }
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

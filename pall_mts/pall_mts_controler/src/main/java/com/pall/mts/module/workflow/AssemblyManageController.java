package com.pall.mts.module.workflow;

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
import org.thymeleaf.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.util.IOUtils;
import com.google.common.io.Files;
import com.pall.mts.annotation.Token;
import com.pall.mts.common.constants.IResponseConstants;
import com.pall.mts.common.constants.KeyConstants;
import com.pall.mts.common.i18n.ResourceUtils;
import com.pall.mts.common.response.BaseResponse;
import com.pall.mts.common.response.BaseTablesResponse;
import com.pall.mts.common.support.excel.ExcelDataNode;
import com.pall.mts.common.support.excel.ExcelHeaderNode;
import com.pall.mts.common.tools.ExcelTools;
import com.pall.mts.common.tools.JSONTools;
import com.pall.mts.context.HolderContext;
import com.pall.mts.init.DataConfigInitiator;
import com.pall.mts.init.TableDataConfigInitiator;
import com.pall.mts.init.UmsConfigInitiator;
import com.pall.mts.interceptor.support.AuthToken;
import com.pall.mts.repository.entity.dataconfig.DataConfigEntity;
import com.pall.mts.repository.entity.dataconfig.DataConfigTypeEntity;
import com.pall.mts.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.mts.repository.entity.menu.ButtonEntity;
import com.pall.mts.repository.entity.workflow.AssemblyEntity;
import com.pall.mts.repository.entity.workflow.AssemblyQueryFormEntity;
import com.pall.mts.repository.entity.workflow.DefectEntity;
import com.pall.mts.repository.entity.workflow.ExcelSaveEntity;
import com.pall.mts.repository.entity.workflow.AssemblyEntity.ADD;
import com.pall.mts.repository.entity.workflow.AssemblyEntity.SAVE;
import com.pall.mts.service.excel.IExcelHandler;
import com.pall.mts.service.menu.ButtonManageService;
import com.pall.mts.service.workflow.AssemblyService;
/*
 * 组装管理控制器
 */
@Controller
public class AssemblyManageController{
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
	private AssemblyService assemblyService;
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
		model.addAttribute("clampDownTheCPDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_CLAMP_DOWN_THE_CP)));
		model.addAttribute("clampingCPDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_CLAMPING_CP)));
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		//工作面类型
		List<DataConfigTypeEntity> workingfaceTypes=new ArrayList<DataConfigTypeEntity>();
		DataConfigTypeEntity dataConfigTypeEntity1=new DataConfigTypeEntity();
		dataConfigTypeEntity1.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_WF));
		dataConfigTypeEntity1.setDataTypeName(resourceUtils.getMessage("assemblyManage.form.defecttype.select.work"));
		workingfaceTypes.add(dataConfigTypeEntity1);
		DataConfigTypeEntity dataConfigTypeEntity2=new DataConfigTypeEntity();
		dataConfigTypeEntity2.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_NWF));
		dataConfigTypeEntity2.setDataTypeName(resourceUtils.getMessage("assemblyManage.form.defecttype.select.nowork"));
		workingfaceTypes.add(dataConfigTypeEntity2);
		DataConfigTypeEntity dataConfigTypeEntity3=new DataConfigTypeEntity();
		dataConfigTypeEntity3.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_CLAMPING));
		dataConfigTypeEntity3.setDataTypeName(resourceUtils.getMessage("assemblyManage.form.defecttype.select.clamping"));
		workingfaceTypes.add(dataConfigTypeEntity3);
		DataConfigTypeEntity dataConfigTypeEntity4=new DataConfigTypeEntity();
		dataConfigTypeEntity4.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_INSTALLHUB));
		dataConfigTypeEntity4.setDataTypeName(resourceUtils.getMessage("assemblyManage.form.defecttype.select.install.hub"));
		workingfaceTypes.add(dataConfigTypeEntity4);
		DataConfigTypeEntity dataConfigTypeEntity5=new DataConfigTypeEntity();
		dataConfigTypeEntity5.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_OTHER));
		dataConfigTypeEntity5.setDataTypeName(resourceUtils.getMessage("assemblyManage.form.defecttype.select.other"));
		workingfaceTypes.add(dataConfigTypeEntity5);
		model.addAttribute("workingfaceTypes", workingfaceTypes);
		List<DataConfigEntity> wdataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_WF));
		model.addAttribute("workingfaceDefectConfigs", wdataConfigEntitys);
		List<DataConfigEntity> dataConfigEntitys=new ArrayList<DataConfigEntity>();
		List<DataConfigEntity> nwdataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_NWF));
		List<DataConfigEntity> clampingDataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_CLAMPING));
		List<DataConfigEntity> installHubdataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_INSTALLHUB));
		List<DataConfigEntity> otherdataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_OTHER));
		if(nwdataConfigEntitys==null){
			nwdataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		if(wdataConfigEntitys==null){
			wdataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		if(clampingDataConfigEntitys==null){
			clampingDataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		if(installHubdataConfigEntitys==null){
			installHubdataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		if(otherdataConfigEntitys==null){
			otherdataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		dataConfigEntitys.addAll(nwdataConfigEntitys);
		dataConfigEntitys.addAll(wdataConfigEntitys);
		dataConfigEntitys.addAll(clampingDataConfigEntitys);
		dataConfigEntitys.addAll(installHubdataConfigEntitys);
		dataConfigEntitys.addAll(otherdataConfigEntitys);
		model.addAttribute("defectConfigs",dataConfigEntitys);
		model.addAttribute("tableName", UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_TABLENAME));
		return model;
	}
	/*
	 * 组装管理
	 */
	@RequestMapping(value="workflow/assemblyManage", method= RequestMethod.GET)
    public  String assemblyManage(Model model, HttpServletRequest request) {
		model=initConfigData(model);
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			try {
				BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					List<ButtonEntity> buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
					model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_TABLENAME));
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
	   return "workflow/assembly/assemblyManage";
    }
	@RequestMapping(value="workflow/assemblyManage", method= RequestMethod.POST)
    public @ResponseBody String assemblyManage(Model model,AssemblyQueryFormEntity  assemblyQueryFormEntity, HttpServletRequest request) {
        if(assemblyQueryFormEntity.getPageSize()==0){
        	assemblyQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=assemblyService.queryAssemblyList(assemblyQueryFormEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> defectTypes=new ArrayList<String>();
				defectTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_TABLENAME));
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
	 * 添加组装信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addAssembly", method= RequestMethod.GET)
    public  String addAssembly(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		model.addAttribute("assemblyBomsDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_ASSEMBLY_BOMS)));
		return "workflow/assembly/addAssembly";
    }
	/*
	 * 添加组装信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addAssembly", method= RequestMethod.POST)
    public  @ResponseBody String addAssembly(@Validated(ADD.class) AssemblyEntity assemblyEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_WF));
				List<DataConfigEntity> ndataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_NWF));
				int sumDefectValue=getDefectEntitys(request,assemblyEntity,dataConfigEntitys);
				sumDefectValue=sumDefectValue+getDefectEntitys(request,assemblyEntity,ndataConfigEntitys);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					assemblyEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				if(assemblyEntity.getAssemblyBom()!=null){
					assemblyEntity.setAssemblyBoms(StringUtils.join(assemblyEntity.getAssemblyBom(), ","));
				};
				baseResponse=assemblyService.addAssembly(assemblyEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("assemblyManage.controler.addAssembly.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.controler.addAssembly.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 封装缺损请求参数对象
	 */
	private int getDefectEntitys(HttpServletRequest request,AssemblyEntity assemblyEntity,List<DataConfigEntity> dataConfigEntitys){
		int sumDefectValue=0;
		List<DefectEntity> defects=new ArrayList<DefectEntity>();
		if(dataConfigEntitys!=null){
			String requestValue="";
			String opticalFilmingTableName=UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_TABLENAME);
			for(DataConfigEntity dataConfigEntity:dataConfigEntitys){
					requestValue=request.getParameter(opticalFilmingTableName+dataConfigEntity.getDataid());
					if(!StringUtils.isEmpty(requestValue)){
						DefectEntity defectEntity=new DefectEntity();
						defectEntity.setDataid(dataConfigEntity.getDataid());
						defectEntity.setDefectName(dataConfigEntity.getConfigName());
						defectEntity.setDefectType(dataConfigEntity.getDataType());
						defectEntity.setDefectValue(Integer.parseInt(requestValue));
						sumDefectValue=sumDefectValue+Integer.parseInt(requestValue);
						defects.add(defectEntity);
					}
			}
		}
		if(assemblyEntity.getDefects()==null){
			assemblyEntity.setDefects(new ArrayList<DefectEntity>());
		}
		assemblyEntity.getDefects().addAll(defects);
		return sumDefectValue;
	}
	/*
	 * 修改组装信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modAssembly", method= RequestMethod.GET)
    public   String modAssembly(@RequestParam("assemblyID") String assemblyID,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		try {
			AssemblyQueryFormEntity assemblyQueryFormEntity=new AssemblyQueryFormEntity();
			assemblyQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			assemblyQueryFormEntity.setAssemblyID(assemblyID);
			baseResponse=assemblyService.exportAssembly(assemblyQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cleanmanage.controler.queryClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.queryClean.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		AssemblyEntity assemblyEntity=null;
		List<DataConfigEntity> assemblyBomsDataConfigs=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_ASSEMBLY_BOMS));
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        List<AssemblyEntity> assemblyEntitys=(List<AssemblyEntity>)baseResponse.getReturnObjects();
	        if (assemblyEntitys!=null &&  assemblyEntitys.size()>0){
	        	assemblyEntity=assemblyEntitys.get(0);
	        	if(assemblyBomsDataConfigs!=null && assemblyBomsDataConfigs.size()>0){
	        		if(assemblyEntity!=null && !StringUtils.isEmpty(assemblyEntity.getAssemblyBoms())){
	        			String[] assemblyBoms=assemblyEntity.getAssemblyBoms().split(",");
	        			for(DataConfigEntity dataConfigEntity:assemblyBomsDataConfigs){
	        				dataConfigEntity.setChecked(false);
	        				for(String assemblyBom:assemblyBoms){
	        					if(dataConfigEntity.getConfigName().equals(assemblyBom)){
									dataConfigEntity.setChecked(true);
									break;
								}
							}
	        			}
	        		}
				}
	        }
		}
		if(assemblyEntity==null){
			assemblyEntity=new AssemblyEntity();
		}
		if(assemblyBomsDataConfigs==null){
			assemblyBomsDataConfigs=new ArrayList<DataConfigEntity>();
		}
    	model.addAttribute("assemblyBomsDataConfigs",assemblyBomsDataConfigs);
		model.addAttribute("assemblyEntity", assemblyEntity);
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "workflow/assembly/copyAssembly";
		}else{
			return "workflow/assembly/modAssembly";
		}
    }
	/*
	 * 修改组装信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modAssembly", method= RequestMethod.POST)
    public  @ResponseBody String modAssembly(@Validated(SAVE.class) AssemblyEntity assemblyEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_WF));
				List<DataConfigEntity> ndataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_NWF));
				int sumDefectValue=getDefectEntitys(request,assemblyEntity,dataConfigEntitys);
				sumDefectValue=sumDefectValue+getDefectEntitys(request,assemblyEntity,ndataConfigEntitys);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					assemblyEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				baseResponse=assemblyService.modifyAssembly(assemblyEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("assemblyManage.controler.modifyAssembly.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.controler.modifyAssembly.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除组装信息
	 */
	@RequestMapping(value="workflow/delAssembly", method= RequestMethod.POST)
    public @ResponseBody String delAssembly(@RequestParam("assemblyIDS") String assemblyIDS,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aoassemblyIDS=assemblyIDS.split(",");
			List<Integer> tempAssemblys=new ArrayList<Integer>();
			for(String asemblyID:aoassemblyIDS){
				tempAssemblys.add(Integer.parseInt(asemblyID));
			}
			baseResponse=assemblyService.delAssembly(tempAssemblys);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("assemblyManage.controler.delAssembly.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.controler.delAssembly.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出组装信息
	 */
	@RequestMapping(value="workflow/exportAssembly", method= RequestMethod.POST)
    public @ResponseBody String exportAssembly(Model model,AssemblyQueryFormEntity assemblyQueryFormEntity, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=assemblyService.exportAssembly(assemblyQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("assemblyManage.controler.exportAssembly.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.controler.exportAssembly.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_TABLENAME));
	        List<AssemblyEntity> assemblyEntitys=(List<AssemblyEntity>)baseResponse.getReturnObjects();
	        
	        int currentRowNum=excelheadlinesMap.size();
	        Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
	        if(null!=assemblyEntitys && assemblyEntitys.size()>0){
	        	if(!StringUtils.isEmpty(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        		if(assemblyEntitys.size()>Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
	        			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.controler.exportAssembly.records.limits")+":"+UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS));
	        			baseResponse.setReturnObjects(null);
	        			return JSON.toJSONString(baseResponse);
		        	}
	        	}
	        	rowdatas=ExcelTools.getExcelDatas(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_TABLENAME), assemblyEntitys,currentRowNum);
	        }
	        //设置下载保存文件路径
        	StringBuilder downloadFileFullPath=new StringBuilder();
        	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(downloadFilePath);
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DOWNLOAD_SUBDIRECTORY));
        	downloadFileFullPath.append(File.separator);
        	
        	//设置下载保存文件路径名称
        	StringBuilder fileName=new StringBuilder();
        	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
        	fileName.append("_");
        	fileName.append(resourceUtils.getMessage("assemblyManage.controler.exportAssembly.filename"));
        	fileName.append("_");
        	SimpleDateFormat sf=new SimpleDateFormat("yyyymmddhh24mmss");
        	fileName.append(sf.format(new Date()));
        	fileName.append(KeyConstants.EXCEL_SUFFIX_XLSX);
        	OutputStream out =null;
	        try {
	        	Files.createParentDirs(new File(downloadFileFullPath.toString()+fileName.toString()));
	        	out=new FileSystemResource(downloadFileFullPath.toString()+fileName.toString()).getOutputStream();
				Workbook workbook=iExcelHandler.getExcelWorkbook(resourceUtils.getMessage("assemblyManage.controler.exportAssembly.filename"), excelheadlinesMap, rowdatas);
				workbook.write(out);
				List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
				ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
				excelSaveEntity.setFileName(fileName.toString());
				excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DOWNLOAD_SUBDIRECTORY));
				excelSaveEntitys.add(excelSaveEntity);
				baseResponse.setReturnObjects(excelSaveEntitys);
				return JSON.toJSONString(baseResponse);
			} catch (Exception e) {
				logger.error(resourceUtils.getMessage("assemblyManage.controler.exportAssembly.exception"),e);
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.controler.exportAssembly.exception")+":"+e.toString());
			}finally{
				IOUtils.close(out);
			}
	    }
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

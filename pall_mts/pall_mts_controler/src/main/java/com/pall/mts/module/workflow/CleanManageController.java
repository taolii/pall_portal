package com.pall.mts.module.workflow;

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
import com.pall.mts.repository.entity.workflow.CleanEntity;
import com.pall.mts.repository.entity.workflow.CleanQueryFormEntity;
import com.pall.mts.repository.entity.workflow.DefectEntity;
import com.pall.mts.repository.entity.workflow.ExcelSaveEntity;
import com.pall.mts.repository.entity.workflow.CleanEntity.ADD;
import com.pall.mts.repository.entity.workflow.CleanEntity.SAVE;
import com.pall.mts.service.excel.IExcelHandler;
import com.pall.mts.service.menu.ButtonManageService;
import com.pall.mts.service.workflow.CleanService;
/*
 * 清洁管理控制器
 */
@Controller
public class CleanManageController{
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
	private CleanService cleanService;
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
		
		//工作面类型
		List<DataConfigTypeEntity> workingfaceTypes=new ArrayList<DataConfigTypeEntity>();
		DataConfigTypeEntity dataConfigTypeEntity1=new DataConfigTypeEntity();
		dataConfigTypeEntity1.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_WF));
		dataConfigTypeEntity1.setDataTypeName(resourceUtils.getMessage("cleanmanage.form.defecttype.select.work"));
		workingfaceTypes.add(dataConfigTypeEntity1);
		DataConfigTypeEntity dataConfigTypeEntity2=new DataConfigTypeEntity();
		dataConfigTypeEntity2.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_NWF));
		dataConfigTypeEntity2.setDataTypeName(resourceUtils.getMessage("cleanmanage.form.defecttype.select.nowork"));
		workingfaceTypes.add(dataConfigTypeEntity2);
		model.addAttribute("workingfaceTypes", workingfaceTypes);
		List<DataConfigEntity> wdataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_WF));
		model.addAttribute("workingfaceDefectConfigs", wdataConfigEntitys);
		List<DataConfigEntity> dataConfigEntitys=new ArrayList<DataConfigEntity>();
		List<DataConfigEntity> nwdataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_NWF));
		if(nwdataConfigEntitys==null){
			nwdataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		if(wdataConfigEntitys==null){
			wdataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		dataConfigEntitys.addAll(nwdataConfigEntitys);
		dataConfigEntitys.addAll(wdataConfigEntitys);
		model.addAttribute("defectConfigs",dataConfigEntitys);
		model.addAttribute("cleanTableName", UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_TABLENAME));
		return model;
	}
	/*
	 * 清洁管理
	 */
	@RequestMapping(value="workflow/cleanManage", method= RequestMethod.GET)
    public  String cleanManage(Model model, HttpServletRequest request) {	
		model=initConfigData(model);
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			try {
				BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					List<ButtonEntity> buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
					model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_TABLENAME));
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
	   return "workflow/clean/cleanManage";
    }
	@RequestMapping(value="workflow/cleanManage", method= RequestMethod.POST)
    public @ResponseBody String cleanManage(Model model,CleanQueryFormEntity  cleanQueryFormEntity, HttpServletRequest request) {
        if(cleanQueryFormEntity.getPageSize()==0){
        	cleanQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=cleanService.queryCleanList(cleanQueryFormEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> defectTypes=new ArrayList<String>();
				defectTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_TABLENAME));
				jsonData= JSONTools.defectsOverturnFiled(jsonData,defectTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cleanmanage.controler.cleanManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.cleanManage.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 封装缺损请求参数对象
	 */
	private int getDefectEntitys(HttpServletRequest request,CleanEntity cleanEntity,List<DataConfigEntity> dataConfigEntitys){
		int sumDefectValue=0;
		List<DefectEntity> defects=new ArrayList<DefectEntity>();
		if(dataConfigEntitys!=null){
			String requestValue="";
			String opticalFilmingTableName=UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_TABLENAME);
			for(DataConfigEntity dataConfigEntity:dataConfigEntitys){
					requestValue=request.getParameter(opticalFilmingTableName+dataConfigEntity.getDataid());
					if(!StringUtils.isEmpty(requestValue)){
						DefectEntity defectEntity=new DefectEntity();
						defectEntity.setDataid(dataConfigEntity.getDataid());
						defectEntity.setDefectName(dataConfigEntity.getConfigName());
						defectEntity.setDefectType(dataConfigEntity.getDataType());
						defectEntity.setDefectValue(Integer.parseInt(requestValue));
						//defectEntity.setDefectID(cleanEntity.getCleanID());
						sumDefectValue=sumDefectValue+Integer.parseInt(requestValue);
						defects.add(defectEntity);
					}
			}
		}
		if(cleanEntity.getDefects()==null){
			cleanEntity.setDefects(new ArrayList<DefectEntity>());
		}
		cleanEntity.getDefects().addAll(defects);
		return sumDefectValue;
	}
	/*
	 * 添加清洁信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addClean", method= RequestMethod.GET)
    public  String addClean(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		model.addAttribute("cleanBomConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_CLEANBOM)));
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISHSEL_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISHSEL_TABLENAME));
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
		return "workflow/clean/addClean";
    }
	/*
	 * 添加清洁信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addClean", method= RequestMethod.POST)
    public  @ResponseBody String addClean(@Validated(ADD.class) CleanEntity cleanEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_WF));
				List<DataConfigEntity> ndataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_NWF));
				int sumDefectValue=getDefectEntitys(request,cleanEntity,dataConfigEntitys);
				sumDefectValue=sumDefectValue+getDefectEntitys(request,cleanEntity,ndataConfigEntitys);
				if(sumDefectValue>cleanEntity.getOutputQty()){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.modClean.defect.sumvalue.gratherthan.OutputQty"));
				}else{
					AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
					if(at!=null && at.getUserEntity()!=null){
						cleanEntity.setOperatorid(at.getUserEntity().getOperatorid());
					}
					double yield=0;
					if(sumDefectValue!=0){
						yield=new BigDecimal(1-(float)sumDefectValue/cleanEntity.getOutputQty()).setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
					}else{
						yield=1;
					}
					cleanEntity.setYield(yield*100);
					if(cleanEntity.getCleanBoms()!=null){
						cleanEntity.setCleanBom(StringUtils.join(cleanEntity.getCleanBoms(), ","));
					};
					baseResponse=cleanService.addClean(cleanEntity);
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cleanmanage.controler.addClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.addClean.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 修改抛光信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modClean", method= RequestMethod.GET)
    public   String modPolish(@RequestParam("cleanid") String cleanid,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		try {
			CleanQueryFormEntity cleanQueryFormEntity=new CleanQueryFormEntity();
			cleanQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			cleanQueryFormEntity.setCleanID(cleanid);
			baseResponse=cleanService.exportClean(cleanQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cleanmanage.controler.queryClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.queryClean.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		CleanEntity cleanEntity=null;
		List<DataConfigEntity> cleanBomConfigs=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_CLEANBOM));
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        List<CleanEntity> cleanEntitys=(List<CleanEntity>)baseResponse.getReturnObjects();
	        if (cleanEntitys!=null &&  cleanEntitys.size()>0){
	        	cleanEntity=cleanEntitys.get(0);
	        	if(cleanBomConfigs!=null && cleanBomConfigs.size()>0){
	        		if(cleanEntity!=null && !StringUtils.isEmpty(cleanEntity.getCleanBom())){
	        			String[] cleanBoms=cleanEntity.getCleanBom().split(",");
	        			for(DataConfigEntity dataConfigEntity:cleanBomConfigs){
	        				dataConfigEntity.setChecked(false);
	        				for(String cleanBom:cleanBoms){
	        					if(dataConfigEntity.getConfigName().equals(cleanBom)){
									dataConfigEntity.setChecked(true);
									break;
								}
							}
	        			}
		        		
	        		}
				}
	        }
		}
		if(cleanEntity==null){
			cleanEntity=new CleanEntity();
		}
		model.addAttribute("cleanEntity", cleanEntity);
		if(cleanBomConfigs==null){
			cleanBomConfigs=new ArrayList<DataConfigEntity>();
		}
    	model.addAttribute("cleanBomConfigs",cleanBomConfigs);
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISHSEL_TABLENAME));
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
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "workflow/clean/copyClean";
		}else{
			return "workflow/clean/modClean";
		}
    }
	/*
	 * 修改清洁信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modClean", method= RequestMethod.POST)
    public  @ResponseBody String modClean(@Validated(SAVE.class) CleanEntity cleanEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_WF));
				List<DataConfigEntity> ndataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_NWF));
				int sumDefectValue=getDefectEntitys(request,cleanEntity,dataConfigEntitys);
				sumDefectValue=sumDefectValue+getDefectEntitys(request,cleanEntity,ndataConfigEntitys);
				if(sumDefectValue>cleanEntity.getOutputQty()){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.modClean.defect.sumvalue.gratherthan.OutputQty"));
				}else{
					AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
					if(at!=null && at.getUserEntity()!=null){
						cleanEntity.setOperatorid(at.getUserEntity().getOperatorid());
					}
					double yield=0;
					if(sumDefectValue!=0){
						yield=new BigDecimal(1-(float)sumDefectValue/cleanEntity.getOutputQty()).setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
					}else{
						yield=1;
					}
					cleanEntity.setYield(yield*100);
					if(cleanEntity.getCleanBoms()!=null){
						cleanEntity.setCleanBom(StringUtils.join(cleanEntity.getCleanBoms(), ","));
					};
					baseResponse=cleanService.modifyClean(cleanEntity);
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cleanmanage.controler.modifyClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.modifyClean.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除清洁信息
	 */
	@RequestMapping(value="workflow/delClean", method= RequestMethod.POST)
    public @ResponseBody String delClean(@RequestParam("cleanIDs") String cleanIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aocleanID=cleanIDs.split(",");
			List<Integer> tempClean=new ArrayList<Integer>();
			for(String cleanid:aocleanID){
				tempClean.add(Integer.parseInt(cleanid));
			}
			baseResponse=cleanService.delClean(tempClean);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cleanmanage.controler.delClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.delClean.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出清洁信息
	 */
	@RequestMapping(value="workflow/exportClean", method= RequestMethod.POST)
    public @ResponseBody String exportClean(Model model,CleanQueryFormEntity  cleanQueryFormEntity, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=cleanService.exportClean(cleanQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cleanmanage.controler.exportClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.exportClean.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_TABLENAME));
	        List<CleanEntity> cleanEntitys=(List<CleanEntity>)baseResponse.getReturnObjects();
	        
	        int currentRowNum=excelheadlinesMap.size();
	        Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
	        if(null!=cleanEntitys && cleanEntitys.size()>0){
	        	if(!StringUtils.isEmpty(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        		if(cleanEntitys.size()>Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
	        			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.exportClean.records.limits")+":"+UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS));
	        			baseResponse.setReturnObjects(null);
	        			return JSON.toJSONString(baseResponse);
		        	}
	        	}
	        	rowdatas=ExcelTools.getExcelDatas(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_TABLENAME), cleanEntitys,currentRowNum);
	        }
	        //设置下载保存文件路径
        	StringBuilder downloadFileFullPath=new StringBuilder();
        	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(downloadFilePath);
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DOWNLOAD_SUBDIRECTORY));
        	downloadFileFullPath.append(File.separator);
        	
        	//设置下载保存文件路径名称
        	StringBuilder fileName=new StringBuilder();
        	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
        	fileName.append("_");
        	fileName.append(resourceUtils.getMessage("cleanmanage.controler.exportClean.filename"));
        	fileName.append("_");
        	SimpleDateFormat sf=new SimpleDateFormat("yyyymmddhh24mmss");
        	fileName.append(sf.format(new Date()));
        	fileName.append(KeyConstants.EXCEL_SUFFIX_XLSX);
        	OutputStream out =null;
	        try {
	        	Files.createParentDirs(new File(downloadFileFullPath.toString()+fileName.toString()));
	        	out=new FileSystemResource(downloadFileFullPath.toString()+fileName.toString()).getOutputStream();
				Workbook workbook=iExcelHandler.getExcelWorkbook(resourceUtils.getMessage("cleanmanage.controler.exportClean.filename"), excelheadlinesMap, rowdatas);
				workbook.write(out);
				List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
				ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
				excelSaveEntity.setFileName(fileName.toString());
				excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DOWNLOAD_SUBDIRECTORY));
				excelSaveEntitys.add(excelSaveEntity);
				baseResponse.setReturnObjects(excelSaveEntitys);
				return JSON.toJSONString(baseResponse);
			} catch (Exception e) {
				logger.error(resourceUtils.getMessage("cleanmanage.controler.exportClean.exception"),e);
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.controler.exportClean.exception")+":"+e.toString());
			}finally{
				IOUtils.close(out);
			}
	    }
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

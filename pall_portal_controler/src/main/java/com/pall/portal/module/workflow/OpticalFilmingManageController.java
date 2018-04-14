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
import com.pall.portal.repository.entity.workflow.DefectEntity;
import com.pall.portal.repository.entity.workflow.ExcelSaveEntity;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity.ADD;
import com.pall.portal.repository.entity.workflow.OpticalCoatingEntity.SAVE;
import com.pall.portal.repository.entity.workflow.OpticalFilmingQueryFormEntity;
import com.pall.portal.service.excel.IExcelHandler;
import com.pall.portal.service.workflow.OpticalFilmingService;
/*
 * 光学镀膜管理控制器
 */
@Controller
public class OpticalFilmingManageController{
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
		model.addAttribute("supplierDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_SUPPLIER)));
		model.addAttribute("ocBomDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_OCBOM)));
		//工作面类型
		List<DataConfigTypeEntity> workingfaceTypes=new ArrayList<DataConfigTypeEntity>();
		DataConfigTypeEntity dataConfigTypeEntity1=new DataConfigTypeEntity();
		dataConfigTypeEntity1.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_WF));
		dataConfigTypeEntity1.setDataTypeName(resourceUtils.getMessage("opticalfilmingManage.form.defecttype.select.work"));
		workingfaceTypes.add(dataConfigTypeEntity1);
		DataConfigTypeEntity dataConfigTypeEntity2=new DataConfigTypeEntity();
		dataConfigTypeEntity2.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_NWF));
		dataConfigTypeEntity2.setDataTypeName(resourceUtils.getMessage("opticalfilmingManage.form.defecttype.select.nowork"));
		workingfaceTypes.add(dataConfigTypeEntity2);
		model.addAttribute("workingfaceTypes", workingfaceTypes);
		List<DataConfigEntity> wdataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_WF));
		model.addAttribute("workingfaceDefectConfigs", wdataConfigEntitys);
		List<DataConfigEntity> dataConfigEntitys=new ArrayList<DataConfigEntity>();
		List<DataConfigEntity> nwdataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_NWF));
		if(nwdataConfigEntitys==null){
			nwdataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		if(wdataConfigEntitys==null){
			wdataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		dataConfigEntitys.addAll(nwdataConfigEntitys);
		dataConfigEntitys.addAll(wdataConfigEntitys);
		model.addAttribute("defectConfigs",dataConfigEntitys);
		model.addAttribute("opticalFilmingTableName", UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_TABLENAME));
		return model;
	}
	/*
	 * 光学镀膜管理
	 */
	@RequestMapping(value="workflow/opticalFilmingManage", method= RequestMethod.GET)
    public  String opticalFilmingManage(Model model, HttpServletRequest request) {	
		model=initConfigData(model);
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_TABLENAME));
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
	   return "workflow/opticalfilming/opticalFilmingManage";
    }
	@RequestMapping(value="workflow/opticalFilmingManage", method= RequestMethod.POST)
    public @ResponseBody String opticalFilmingManage(Model model,OpticalFilmingQueryFormEntity  opticalFilmingQueryFormEntity, HttpServletRequest request) {
        if(opticalFilmingQueryFormEntity.getPageSize()==0){
        	opticalFilmingQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=opticalFilmingService.queryOpticalFilmingList(opticalFilmingQueryFormEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> defectTypes=new ArrayList<String>();
				defectTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_TABLENAME));
				jsonData= JSONTools.defectsOverturnFiled(jsonData,defectTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("opticalfilmingManage.controler.opticalFilmingManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.controler.opticalFilmingManage.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加光学镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addOpticalFilming", method= RequestMethod.GET)
    public   String addOpticalFilming(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEANSEL_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEANSEL_TABLENAME));
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
		return "workflow/opticalfilming/addOpticalFilming";
    }
	/*
	 * 添加光学镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addOpticalFilming", method= RequestMethod.POST)
    public  @ResponseBody String addOpticalFilming(@Validated(ADD.class) OpticalCoatingEntity opticalCoatingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_WF));
				List<DataConfigEntity> ndataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_NWF));
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
			String opticalFilmingTableName=UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_TABLENAME);
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
	 * 修改抛光信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modOpticalFilming", method= RequestMethod.GET)
    public   String modOpticalFilming(@RequestParam("opfID") String opfID,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		try {
			OpticalFilmingQueryFormEntity opticalFilmingQueryFormEntity=new OpticalFilmingQueryFormEntity();
			opticalFilmingQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			opticalFilmingQueryFormEntity.setOpfID(opfID);
			baseResponse=opticalFilmingService.exportOpticalFilming(opticalFilmingQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("opticalfilmingManage.controler.opticalFilmingManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.controler.opticalFilmingManage.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		OpticalCoatingEntity opticalCoatingEntity=null;
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        List<OpticalCoatingEntity> opticalCoatingEntitys=(List<OpticalCoatingEntity>)baseResponse.getReturnObjects();
	        if (opticalCoatingEntitys!=null &&  opticalCoatingEntitys.size()>0){
	        	opticalCoatingEntity=opticalCoatingEntitys.get(0);
	        }
		}
		if(opticalCoatingEntity==null){
			opticalCoatingEntity=new OpticalCoatingEntity();
		}
		model.addAttribute("opticalCoatingEntity", opticalCoatingEntity);
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEANSEL_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.CLEANSEL_TABLENAME));
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
			return "workflow/opticalfilming/copyOpticalFilming";
		}else{
			return "workflow/opticalfilming/modOpticalFilming";
		}
    }
	/*
	 * 修改光学镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modOpticalFilming", method= RequestMethod.POST)
    public  @ResponseBody String modOpticalFilming(@Validated(SAVE.class) OpticalCoatingEntity opticalCoatingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_WF));
				List<DataConfigEntity> ndataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_NWF));
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
	 * 删除光学镀膜信息
	 */
	@RequestMapping(value="workflow/delOpticalFilming", method= RequestMethod.POST)
    public @ResponseBody String delOpticalFilming(@RequestParam("opfIDs") String opfIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aoopfID=opfIDs.split(",");
			List<Integer> tempOpticalFilming=new ArrayList<Integer>();
			for(String opfid:aoopfID){
				tempOpticalFilming.add(Integer.parseInt(opfid));
			}
			baseResponse=opticalFilmingService.delOpticalFilming(tempOpticalFilming);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("opticalfilmingManage.controler.delOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.controler.delOpticalFilming.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出光学镀膜信息
	 */
	@RequestMapping(value="workflow/exportOpticalFilming", method= RequestMethod.POST)
    public @ResponseBody String exportOpticalFilming(Model model,OpticalFilmingQueryFormEntity  opticalFilmingQueryFormEntity, HttpServletRequest request) {
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
	        Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_TABLENAME));
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
	        	rowdatas=ExcelTools.getExcelDatas(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_TABLENAME), opticalCoatingEntitys,currentRowNum);
	        }
	        //设置下载保存文件路径
        	StringBuilder downloadFileFullPath=new StringBuilder();
        	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
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

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
import com.pall.mts.repository.entity.workflow.DefectEntity;
import com.pall.mts.repository.entity.workflow.ExcelSaveEntity;
import com.pall.mts.repository.entity.workflow.PolishEntity;
import com.pall.mts.repository.entity.workflow.PolishQueryFormEntity;
import com.pall.mts.repository.entity.workflow.PolishEntity.ADD;
import com.pall.mts.repository.entity.workflow.PolishEntity.SAVE;
import com.pall.mts.service.excel.IExcelHandler;
import com.pall.mts.service.menu.ButtonManageService;
import com.pall.mts.service.workflow.PolishService;
/*
 * 抛光管理控制器
 */
@Controller
public class PolishManageController{
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
	private PolishService polishService;
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
		model.addAttribute("polishTableName", UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_TABLENAME));
		
		model.addAttribute("tmpDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_THROWMILLSTONEPOS)));
		//工作面类型
		List<DataConfigTypeEntity> workingfaceTypes=new ArrayList<DataConfigTypeEntity>();
		DataConfigTypeEntity dataConfigTypeEntity1=new DataConfigTypeEntity();
		dataConfigTypeEntity1.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_DEFECT_WF));
		dataConfigTypeEntity1.setDataTypeName(resourceUtils.getMessage("cleanmanage.form.defecttype.select.work"));
		workingfaceTypes.add(dataConfigTypeEntity1);
		DataConfigTypeEntity dataConfigTypeEntity2=new DataConfigTypeEntity();
		dataConfigTypeEntity2.setDataType(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_DEFECT_NWF));
		dataConfigTypeEntity2.setDataTypeName(resourceUtils.getMessage("cleanmanage.form.defecttype.select.nowork"));
		workingfaceTypes.add(dataConfigTypeEntity2);
		model.addAttribute("workingfaceTypes", workingfaceTypes);
		List<DataConfigEntity> wdataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_DEFECT_WF));
		model.addAttribute("workingfaceDefectConfigs", wdataConfigEntitys);
		List<DataConfigEntity> dataConfigEntitys=new ArrayList<DataConfigEntity>();
		List<DataConfigEntity> nwdataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_DEFECT_NWF));
		if(nwdataConfigEntitys==null){
			nwdataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		if(wdataConfigEntitys==null){
			wdataConfigEntitys=new ArrayList<DataConfigEntity>();
		}
		dataConfigEntitys.addAll(nwdataConfigEntitys);
		dataConfigEntitys.addAll(wdataConfigEntitys);
		model.addAttribute("defectConfigs",dataConfigEntitys);
		return model;
	}
	/*
	 * 抛光管理
	 */
	@RequestMapping(value="workflow/polishManage", method= RequestMethod.GET)
    public  String polishManage(Model model, HttpServletRequest request) {	
		model=initConfigData(model);
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			try {
				BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					List<ButtonEntity> buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
					model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		model.addAttribute("polishDefectConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_DEFECT)));
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_TABLENAME));
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
	   return "workflow/polish/polishManage";
    }
	@RequestMapping(value="workflow/polishManage", method= RequestMethod.POST)
    public @ResponseBody String polishManage(Model model,PolishQueryFormEntity  polishQueryFormEntity, HttpServletRequest request) {
        if(polishQueryFormEntity.getPageSize()==0){
        	polishQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=polishService.queryPolishList(polishQueryFormEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> defectTypes=new ArrayList<String>();
				defectTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_TABLENAME));
				jsonData= JSONTools.defectsOverturnFiled(jsonData,defectTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("polishmanage.controler.polishManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.polishManage.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 封装缺损请求参数对象
	 */
	private int getDefectEntitys(HttpServletRequest request,PolishEntity polishEntity,List<DataConfigEntity> dataConfigEntitys){
		int sumDefectValue=0;
		List<DefectEntity> defects=new ArrayList<DefectEntity>();
		if(dataConfigEntitys!=null){
			String requestValue="";
			String polishTableName=UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_TABLENAME);
			for(DataConfigEntity dataConfigEntity:dataConfigEntitys){
					requestValue=request.getParameter(polishTableName+dataConfigEntity.getDataid());
					if(!StringUtils.isEmpty(requestValue)){
						DefectEntity defectEntity=new DefectEntity();
						defectEntity.setDataid(dataConfigEntity.getDataid());
						defectEntity.setDefectName(dataConfigEntity.getConfigName());
						defectEntity.setDefectType(dataConfigEntity.getDataType());
						defectEntity.setDefectValue(Integer.parseInt(requestValue));
						//defectEntity.setDefectID(polishEntity.getPolishID());
						sumDefectValue=sumDefectValue+Integer.parseInt(requestValue);
						defects.add(defectEntity);
					}
			}
		}
		if(polishEntity.getDefects()==null){
			polishEntity.setDefects(new ArrayList<DefectEntity>());
		}
		polishEntity.getDefects().addAll(defects);
		return sumDefectValue;
	}
	/*
	 * 添加抛光信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addPolish", method= RequestMethod.GET)
    public   String addPolish(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		model.addAttribute("polishBomConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_POLISHBOM)));
		return "workflow/polish/addPolish";
    }
	/*
	 * 添加抛光信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addPolish", method= RequestMethod.POST)
    public  @ResponseBody String addPolish(@Validated(ADD.class) PolishEntity polishEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_DEFECT_WF));
				List<DataConfigEntity> ndataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_DEFECT_NWF));
				int sumDefectValue=getDefectEntitys(request,polishEntity,dataConfigEntitys);
				sumDefectValue=sumDefectValue+getDefectEntitys(request,polishEntity,ndataConfigEntitys);if(sumDefectValue>polishEntity.getCasualInspectionNum()){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.addPolish.defect.sumvalue.gratherthan.CasualInspectionNum"));
				}else{
					AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
					if(at!=null && at.getUserEntity()!=null){
						polishEntity.setOperatorid(at.getUserEntity().getOperatorid());
					}
					double yield=0;
					if(sumDefectValue!=0){
						yield=new BigDecimal(1-(float)sumDefectValue/polishEntity.getCasualInspectionNum()).setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
					}else{
						yield=1;
					}
					polishEntity.setYield(yield*100);
					if(polishEntity.getPolishBoms()!=null){
						polishEntity.setPolishBom(StringUtils.join(polishEntity.getPolishBoms(), ","));
					};
					baseResponse=polishService.addPolish(polishEntity);
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("polishmanage.controler.addPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.addPolish.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 修改抛光信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modPolish", method= RequestMethod.GET)
    public   String modPolish(@RequestParam("polishid") String polishid,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		try {
			PolishQueryFormEntity polishQueryFormEntity=new PolishQueryFormEntity();
			polishQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			polishQueryFormEntity.setPolishID(polishid);
			baseResponse=polishService.exportPolish(polishQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("polishmanage.controler.queryPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.queryPolish.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		PolishEntity polishEntity=null;
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        List<PolishEntity> polishEntitys=(List<PolishEntity>)baseResponse.getReturnObjects();
	        if (polishEntitys!=null &&  polishEntitys.size()>0){
	        	polishEntity=polishEntitys.get(0);
	        }
		}
		if(polishEntity==null){
			polishEntity=new PolishEntity();
		}
		List<DataConfigEntity> polishBomConfigs=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_POLISHBOM));
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
			List<PolishEntity> polishEntitys=(List<PolishEntity>)baseResponse.getReturnObjects();
	        if (polishEntitys!=null &&  polishEntitys.size()>0){
	        	polishEntity=polishEntitys.get(0);
	        	if(polishBomConfigs!=null && polishBomConfigs.size()>0){
	        		if(polishEntity!=null && !StringUtils.isEmpty(polishEntity.getPolishBom())){
	        			String[] polishBoms=polishEntity.getPolishBom().split(",");
	        			for(DataConfigEntity dataConfigEntity:polishBomConfigs){
	        				dataConfigEntity.setChecked(false);
	        				for(String polishBom:polishBoms){
	        					if(dataConfigEntity.getConfigName().equals(polishBom)){
									dataConfigEntity.setChecked(true);
									break;
								}
							}
	        			}
		        		
	        		}
				}
	        }
		}
		if(polishEntity==null){
			polishEntity=new PolishEntity();
		}
		if(polishBomConfigs==null){
			polishBomConfigs=new ArrayList<DataConfigEntity>();
		}
		model.addAttribute("polishEntity", polishEntity);
    	model.addAttribute("polishBomConfigs",polishBomConfigs);
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "workflow/polish/copyPolish";
		}else{
			return "workflow/polish/modPolish";
		}
    }
	/*
	 * 修改抛光信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modPolish", method= RequestMethod.POST)
    public  @ResponseBody String modPolish(@Validated(SAVE.class) PolishEntity polishEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<DataConfigEntity> dataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_DEFECT_WF));
				List<DataConfigEntity> ndataConfigEntitys=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_DEFECT_NWF));
				int sumDefectValue=getDefectEntitys(request,polishEntity,dataConfigEntitys);
				sumDefectValue=sumDefectValue+getDefectEntitys(request,polishEntity,ndataConfigEntitys);
				if(sumDefectValue>polishEntity.getCasualInspectionNum()){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.modPolish.defect.sumvalue.gratherthan.CasualInspectionNum"));
				}else{
					AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
					if(at!=null && at.getUserEntity()!=null){
						polishEntity.setOperatorid(at.getUserEntity().getOperatorid());
					}
					double yield=0;
					if(sumDefectValue!=0){
						yield=new BigDecimal(1-(float)sumDefectValue/polishEntity.getCasualInspectionNum()).setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
					}else{
						yield=1;
					}
					polishEntity.setYield(yield*100);
					if(polishEntity.getPolishBoms()!=null){
						polishEntity.setPolishBom(StringUtils.join(polishEntity.getPolishBoms(), ","));
					};
					baseResponse=polishService.modifyPolish(polishEntity);
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("polishmanage.controler.addPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.addPolish.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除抛光信息
	 */
	@RequestMapping(value="workflow/delPolish", method= RequestMethod.POST)
    public @ResponseBody String delPolish(@RequestParam("polishIDs") String polishIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aopolishID=polishIDs.split(",");
			List<Integer> tempPolish=new ArrayList<Integer>();
			for(String polishid:aopolishID){
				tempPolish.add(Integer.parseInt(polishid));
			}
			baseResponse=polishService.delPolish(tempPolish);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("polishmanage.controler.delPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.delPolish.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出抛光信息
	 */
	@RequestMapping(value="workflow/exportPolish", method= RequestMethod.POST)
    public @ResponseBody String exportPolish(Model model,PolishQueryFormEntity  polishQueryFormEntity, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			polishQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			baseResponse=polishService.exportPolish(polishQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("polishmanage.controler.exportPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.exportPolish.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_TABLENAME));
	        List<PolishEntity> polishEntitys=(List<PolishEntity>)baseResponse.getReturnObjects();
	        
	        int currentRowNum=excelheadlinesMap.size();
	        Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
	        if(null!=polishEntitys && polishEntitys.size()>0){
	        	if(!StringUtils.isEmpty(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        		if(polishEntitys.size()>Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
	        			baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.exportPolish.records.limits")+":"+UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS));
	        			baseResponse.setReturnObjects(null);
	        			return JSON.toJSONString(baseResponse);
		        	}
	        	}
	        	rowdatas=ExcelTools.getExcelDatas(TableDataConfigInitiator.getExcelFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_TABLENAME)), polishEntitys,currentRowNum);
	        }
	        //设置下载保存文件路径
        	StringBuilder downloadFileFullPath=new StringBuilder();
        	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(downloadFilePath);
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DOWNLOAD_SUBDIRECTORY));
        	downloadFileFullPath.append(File.separator);
        	
        	//设置下载保存文件路径名称
        	StringBuilder fileName=new StringBuilder();
        	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
        	fileName.append("_");
        	fileName.append(resourceUtils.getMessage("polishmanage.controler.exportPolish.filename"));
        	fileName.append("_");
        	SimpleDateFormat sf=new SimpleDateFormat("yyyymmddhh24mmss");
        	fileName.append(sf.format(new Date()));
        	fileName.append(KeyConstants.EXCEL_SUFFIX_XLSX);
        	OutputStream out =null;
	        try {
	        	Files.createParentDirs(new File(downloadFileFullPath.toString()+fileName.toString()));
	        	out=new FileSystemResource(downloadFileFullPath.toString()+fileName.toString()).getOutputStream();
				Workbook workbook=iExcelHandler.getExcelWorkbook(resourceUtils.getMessage("polishmanage.controler.exportPolish.filename"), excelheadlinesMap, rowdatas);
				workbook.write(out);
				List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
				ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
				excelSaveEntity.setFileName(fileName.toString());
				excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DOWNLOAD_SUBDIRECTORY));
				excelSaveEntitys.add(excelSaveEntity);
				baseResponse.setReturnObjects(excelSaveEntitys);
				return JSON.toJSONString(baseResponse);
			} catch (Exception e) {
				logger.error(resourceUtils.getMessage("polishmanage.controler.exportPolish.exception"),e);
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("polishmanage.controler.exportPolish.exception")+":"+e.toString());
			}finally{
				IOUtils.close(out);
			}
	    }
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

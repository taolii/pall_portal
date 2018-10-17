package com.pall.wdpts.module.trackinglist;

import java.io.File;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
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
import org.thymeleaf.util.ArrayUtils;
import org.thymeleaf.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.util.IOUtils;
import com.google.common.io.Files;
import com.pall.wdpts.annotation.Token;
import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.constants.KeyConstants;
import com.pall.wdpts.common.i18n.ResourceUtils;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.common.support.excel.ExcelHeaderNode;
import com.pall.wdpts.common.tools.ExcelTools;
import com.pall.wdpts.common.tools.JSONTools;
import com.pall.wdpts.context.HolderContext;
import com.pall.wdpts.init.DataConfigInitiator;
import com.pall.wdpts.init.TableDataConfigInitiator;
import com.pall.wdpts.init.UmsConfigInitiator;
import com.pall.wdpts.interceptor.support.AuthToken;
import com.pall.wdpts.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.wdpts.repository.entity.menu.ButtonEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingInspectEntity;
import com.pall.wdpts.repository.entity.user.UserEntity.ADD;
import com.pall.wdpts.repository.entity.user.UserEntity.SAVE;
import com.pall.wdpts.repository.entity.workflow.ExcelSaveEntity;
import com.pall.wdpts.service.excel.IExcelTemplateHandler;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.trackinglist.PreprocessingService;

/*
 * 预处理装配流程跟踪单
 */
@Controller
public class PreprocessingManageControler{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private ButtonManageService buttonManageService;
	@Autowired
	private PreprocessingService preprocessingService;
	@Autowired
	@Qualifier("xlsxTemplateHandler")
	private IExcelTemplateHandler iExcelTemplateHandler;
	/*
	 * 下载文件路径
	 */
	@Value("${system.default.file.download.path}")
	private String downloadFilePath;
	/*
	 * 下载文件路径
	 */
	@Value("${trackling.preprocessing.template}")
	private String templateFilePath;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_PREPROCESSING_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		model.addAttribute("preprocessingModelDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_PREPROCESSING_DATACONFIG_TYPE_PREPROCESSINGMODEL)));
		return model;
	}
	/*
	 * 初始化默认值
	 */
	private void initDefaultEntity(PreprocessingEntity preprocessingEntity){
		if(StringUtils.isEmpty(preprocessingEntity.getProductionTime())){
			preprocessingEntity.setProductionTime(null);
		}
		if(StringUtils.isEmpty(preprocessingEntity.getAssembleTime())){
			preprocessingEntity.setAssembleTime(null);
		}
		if(StringUtils.isEmpty(preprocessingEntity.getInspectTime()))preprocessingEntity.setInspectTime(null);
	}
	/*
	 * 预处理装配管理
	 */
	@RequestMapping(value="/trackinglist/preprocessingManage", method= RequestMethod.GET)
    public  String preprocessingManage(Model model, HttpServletRequest request) {
		model=initConfigData(model);
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			try {
				BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_PREPROCESSING_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					List<ButtonEntity> buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
					model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_PREPROCESSING_TABLENAME));
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
	   return "trackinglist/preprocessing/preprocessingManage";
    }
	@RequestMapping(value="/trackinglist/preprocessingManage", method= RequestMethod.POST)
    public @ResponseBody String preprocessingManage(Model model,PreprocessingFormQueryEntity  preprocessingFormQueryEntity, HttpServletRequest request) {
        if(preprocessingFormQueryEntity.getPageSize()==0){
        	preprocessingFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=preprocessingService.queryPreprocessingList(preprocessingFormQueryEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> defectTypes=new ArrayList<String>();
				defectTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_PREPROCESSING_TABLENAME));
				jsonData= JSONTools.defectsOverturnFiled(jsonData,defectTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessing.Controler.preprocessingManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.Controler.preprocessingManage.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加预处理装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/addPreprocessing", method= RequestMethod.GET)
    public   String addPreprocessing(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		return "trackinglist/preprocessing/addPreprocessing";
    }
	/*
	 * 添加预处理装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/addPreprocessing", method= RequestMethod.POST)
    public  @ResponseBody String addPreprocessing(@Validated(ADD.class) PreprocessingEntity preprocessingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				initDefaultEntity(preprocessingEntity);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					preprocessingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				preprocessingEntity.setAssembleRecords(getPreprocessingAssembles(request));
				preprocessingEntity.setInspectRecords(getPreprocessingInspects(request));
				if(StringUtils.isEmpty(preprocessingEntity.getInspectTime()))preprocessingEntity.setInspectTime(null);
				baseResponse=preprocessingService.addPreprocessing(preprocessingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessing.Controler.addPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.Controler.addPreprocessing.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 根据请求参数封装预处理送检对象
	 * @param request 请求对象
	 * @return
	 */
	private List<PreprocessingInspectEntity> getPreprocessingInspects(HttpServletRequest request){
		String[] inspectids=request.getParameterValues("inspectid");
		List<PreprocessingInspectEntity> preprocessingInspects=new ArrayList<PreprocessingInspectEntity>();
		if(!ArrayUtils.isEmpty(inspectids)){
			for(String inspectid:inspectids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+inspectid)) && StringUtils.isEmpty(request.getParameter("selfcheckContent_"+inspectid))
						&& StringUtils.isEmpty(request.getParameter("selfcheckName_"+inspectid)) && StringUtils.isEmpty(request.getParameter("selfcheckResult_"+inspectid))){
					continue;
				}
				PreprocessingInspectEntity preprocessingInspectEntity=new PreprocessingInspectEntity();
				preprocessingInspectEntity.setRemarks(request.getParameter("remarks_"+inspectid));
				preprocessingInspectEntity.setSelfcheckContent(request.getParameter("selfcheckContent_"+inspectid));
				preprocessingInspectEntity.setSelfcheckName(request.getParameter("selfcheckName_"+inspectid));
				preprocessingInspectEntity.setSelfcheckResult(request.getParameter("selfcheckResult_"+inspectid));
				preprocessingInspects.add(preprocessingInspectEntity);
				
			}
		}
		return preprocessingInspects;
	}
	/*
	 * 根据请求参数封装预处理装配对象
	 * @param request 请求对象
	 * @return
	 */
	private List<PreprocessingAssembleEntity> getPreprocessingAssembles(HttpServletRequest request){
		String[] assembleids=request.getParameterValues("assembleid");
		List<PreprocessingAssembleEntity> preprocessingAssembles=new ArrayList<PreprocessingAssembleEntity>();
		if(!ArrayUtils.isEmpty(assembleids)){
			for(String assembleid:assembleids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+assembleid)) && StringUtils.isEmpty(request.getParameter("componentName_"+assembleid))
						&& StringUtils.isEmpty(request.getParameter("componentNo_"+assembleid)) && StringUtils.isEmpty(request.getParameter("serialNoRecord_"+assembleid))){
					continue;
				}
				PreprocessingAssembleEntity preprocessingAssembleEntity=new PreprocessingAssembleEntity();
				preprocessingAssembleEntity.setRemarks(request.getParameter("remarks_"+assembleid));
				preprocessingAssembleEntity.setComponentName(request.getParameter("componentName_"+assembleid));
				preprocessingAssembleEntity.setComponentNo(request.getParameter("componentNo_"+assembleid));
				preprocessingAssembleEntity.setSerialNoRecord(request.getParameter("serialNoRecord_"+assembleid));
				preprocessingAssembles.add(preprocessingAssembleEntity);
			}
		}
		return preprocessingAssembles;
	}
	/*
	 * 修改预处理装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/modPreprocessing", method= RequestMethod.GET)
    public   String modPreprocessing(@RequestParam("preprocessingID") String preprocessingID,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		PreprocessingEntity preprocessingEntity=null;
		try {
			preprocessingEntity=preprocessingService.queryPreprocessing(preprocessingID);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessing.service.queryPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.queryPreprocessing.exception"));
		}
		if(preprocessingEntity==null){
			preprocessingEntity=new PreprocessingEntity();
		}
		model.addAttribute("preprocessingAssembles", JSON.toJSONString(preprocessingEntity.getAssembleRecords()));
		model.addAttribute("preprocessingInspects", JSON.toJSONString(preprocessingEntity.getInspectRecords()));
		model.addAttribute("preprocessingEntity", preprocessingEntity);
			
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "trackinglist/preprocessing/copyPreprocessing";
		}else{
			return "trackinglist/preprocessing/modPreprocessing";
		}
    }
	/*
	 * 修改预处理装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/modPreprocessing", method= RequestMethod.POST)
    public  @ResponseBody String modPreprocessing(@Validated(SAVE.class) PreprocessingEntity preprocessingEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				initDefaultEntity(preprocessingEntity);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					preprocessingEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				preprocessingEntity.setAssembleRecords(getPreprocessingAssembles(request));
				preprocessingEntity.setInspectRecords(getPreprocessingInspects(request));
				baseResponse=preprocessingService.modifyPreprocessing(preprocessingEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessing.Controler.modPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.Controler.modPreprocessing.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除预处理装配信息
	 */
	@RequestMapping(value="trackinglist/delPreprocessing", method= RequestMethod.POST)
    public @ResponseBody String delPreprocessing(@RequestParam("preprocessingIDs") String preprocessingIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aoPreprocessingID=preprocessingIDs.split(",");
			List<Integer> tempPreprocessing=new ArrayList<Integer>();
			for(String preprocessingId:aoPreprocessingID){
				tempPreprocessing.add(Integer.parseInt(preprocessingId));
			}
			baseResponse=preprocessingService.delPreprocessing(tempPreprocessing);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessing.Controler.delPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.Controler.delPreprocessing.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出预处理装配信息
	 */
	@RequestMapping(value="trackinglist/exportPreprocessing", method= RequestMethod.POST)
    public @ResponseBody String exportPreprocessing(Model model,@RequestParam("preprocessingID") String preprocessingID, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		PreprocessingEntity preprocessingEntity=null;
		try {
			preprocessingEntity=preprocessingService.queryPreprocessing(preprocessingID);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessing.service.queryPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.queryPreprocessing.exception"));
		}
		if(preprocessingEntity==null){
			preprocessingEntity=new PreprocessingEntity();
		}
		//设置下载保存文件路径
    	StringBuilder downloadFileFullPath=new StringBuilder();
    	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(downloadFilePath);
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_PREPROCESSING_DOWNLOAD_SUBDIRECTORY));
    	downloadFileFullPath.append(File.separator);
    	//设置下载保存文件路径名称
    	StringBuilder fileName=new StringBuilder();
    	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
    	fileName.append("_");
    	fileName.append(resourceUtils.getMessage("preprocessing.Controler.exportPreprocessing.filename"));
    	fileName.append("_");
    	SimpleDateFormat sf=new SimpleDateFormat("yyyymmddhh24mmss");
    	fileName.append(sf.format(new Date()));
    	fileName.append(".");
    	fileName.append(KeyConstants.EXCEL_SUFFIX_XLSX);
    	OutputStream out =null;
        try {
        	Files.createParentDirs(new File(downloadFileFullPath.toString()+fileName.toString()));
        	out=new FileSystemResource(downloadFileFullPath.toString()+fileName.toString()).getOutputStream();
        	//File targeFile=iExcelTemplateHandler.copyExcelTemplate(templateFilePath, downloadFileFullPath.toString(), fileName.toString());
        	int i=1;
        	if(!CollectionUtils.isEmpty(preprocessingEntity.getAssembleRecords())){
        		for(PreprocessingAssembleEntity preprocessingAssembleEntity:preprocessingEntity.getAssembleRecords()){
        			preprocessingAssembleEntity.setPreprocessingID(i++);
        			if(!StringUtils.isEmpty(preprocessingAssembleEntity.getComponentName())){
        				preprocessingAssembleEntity.setComponentName(preprocessingAssembleEntity.getComponentName().replace("|", "\n"));
        			}
        			if(!StringUtils.isEmpty(preprocessingAssembleEntity.getComponentNo())){
        				preprocessingAssembleEntity.setComponentNo(preprocessingAssembleEntity.getComponentNo().replace("|", "\n"));
        			}
        		}
        	}
        	i=1;
        	if(!CollectionUtils.isEmpty(preprocessingEntity.getInspectRecords())){
        		for(PreprocessingInspectEntity preprocessingInspectEntity:preprocessingEntity.getInspectRecords()){
        			preprocessingInspectEntity.setPreprocessingID(i++);
        			if(!StringUtils.isEmpty(preprocessingInspectEntity.getSelfcheckName())){
        				preprocessingInspectEntity.setSelfcheckName(preprocessingInspectEntity.getSelfcheckName().replace("|", "\n"));
        			}
        			if(!StringUtils.isEmpty(preprocessingInspectEntity.getSelfcheckContent())){
        				preprocessingInspectEntity.setSelfcheckContent(preprocessingInspectEntity.getSelfcheckContent().replace("|", "\n"));
        			}
        		}
        	}
        	Map<Integer,List<ExcelHeaderNode>> excelTemplateMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_PREPROCESSING_TEMPLATENAME));
        	if(excelTemplateMap!=null){
        		excelTemplateMap=ExcelTools.getExcelTempateDatas(excelTemplateMap,preprocessingEntity,0);
        	}
        	
        	Workbook workbook=iExcelTemplateHandler.getExcelWorkbook(preprocessingEntity.getPreprocessingPn(), excelTemplateMap);
			workbook.write(out);
			List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
			ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
			excelSaveEntity.setFileName(fileName.toString());
			excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_PREPROCESSING_DOWNLOAD_SUBDIRECTORY));
			excelSaveEntitys.add(excelSaveEntity);
			baseResponse.setReturnObjects(excelSaveEntitys);
			return JSON.toJSONString(baseResponse);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessing.Controler.exportPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.Controler.exportPreprocessing.exception")+":"+e.toString());
		}finally{
			IOUtils.close(out);
		}
		return JSON.toJSONString(baseResponse);
    }
	@RequestMapping(value="/trackinglist/preprocessingInspectDetail", method= RequestMethod.POST)
    public @ResponseBody String preprocessingInspectDetail(Model model,@RequestParam("preprocessingID") String  preprocessingID, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=preprocessingService.queryPreprocessingInspectList(preprocessingID);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessing.Controler.preprocessingInspectDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.Controler.preprocessingInspectDetail.exception"));
			
		}
		 return jsonData;
    }
	@RequestMapping(value="/trackinglist/preprocessingAssembleDetail", method= RequestMethod.POST)
    public @ResponseBody String preprocessingAssembleDetail(Model model,@RequestParam("preprocessingID") String  preprocessingID, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=preprocessingService.queryPreprocessingAssembleList(preprocessingID);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("preprocessing.Controler.preprocessingAssembleDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.Controler.preprocessingAssembleDetail.exception"));
			
		}
		 return jsonData;
    }
}

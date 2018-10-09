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
import com.pall.wdpts.repository.entity.trackinglist.MainframeAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeInspectEntity;
import com.pall.wdpts.repository.entity.user.UserEntity.ADD;
import com.pall.wdpts.repository.entity.user.UserEntity.SAVE;
import com.pall.wdpts.repository.entity.workflow.ExcelSaveEntity;
import com.pall.wdpts.service.excel.IExcelTemplateHandler;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.trackinglist.MainframeService;

/*
 * 主机装配流程跟踪单
 */
@Controller
public class MainframeManageControler {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private ButtonManageService buttonManageService;
	@Autowired
	private MainframeService mainframeService;
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
	@Value("${trackling.mainframe.template}")
	private String templateFilePath;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_MAINFRAME_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		model.addAttribute("mainframeModelDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_MAINFRAME_DATACONFIG_TYPE_MAINFRAMEMODEL)));
		return model;
	}
	/*
	 * 初始化默认值
	 */
	private void initDefaultEntity(MainframeEntity mainframeEntity){
		if(StringUtils.isEmpty(mainframeEntity.getProductionTime())){
			mainframeEntity.setProductionTime(null);
		}
		if(StringUtils.isEmpty(mainframeEntity.getAssembleTime())){
			mainframeEntity.setAssembleTime(null);
		}
		if(StringUtils.isEmpty(mainframeEntity.getInspectTime()))mainframeEntity.setInspectTime(null);
	}
	/*
	 * 主机装配管理
	 */
	@RequestMapping(value="/trackinglist/mainframeManage", method= RequestMethod.GET)
    public  String mainframeManage(Model model, HttpServletRequest request) {
		model=initConfigData(model);
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			try {
				BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_MAINFRAME_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					List<ButtonEntity> buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
					model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_MAINFRAME_TABLENAME));
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
	   return "trackingList/mainframe/mainframeManage";
    }
	@RequestMapping(value="/trackinglist/mainframeManage", method= RequestMethod.POST)
    public @ResponseBody String mainframeManage(Model model,MainframeFormQueryEntity  mainframeFormQueryEntity, HttpServletRequest request) {
        if(mainframeFormQueryEntity.getPageSize()==0){
        	mainframeFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=mainframeService.queryMainframeList(mainframeFormQueryEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> defectTypes=new ArrayList<String>();
				defectTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_MAINFRAME_TABLENAME));
				jsonData= JSONTools.defectsOverturnFiled(jsonData,defectTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframe.Controler.mainframeManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.Controler.mainframeManage.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加主机装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/addMainframe", method= RequestMethod.GET)
    public   String addMainframe(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		return "trackinglist/mainframe/addMainframe";
    }
	/*
	 * 添加主机装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/addMainframe", method= RequestMethod.POST)
    public  @ResponseBody String addMainframe(@Validated(ADD.class) MainframeEntity mainframeEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				initDefaultEntity(mainframeEntity);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					mainframeEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				if(StringUtils.isEmpty(mainframeEntity.getInspectTime()))mainframeEntity.setInspectTime(null);
				mainframeEntity.setAssembleRecords(getMainframeAssembles(request));
				mainframeEntity.setInspectRecords(getMainframeInspects(request));
				baseResponse=mainframeService.addMainframe(mainframeEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframe.Controler.addMainframe.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.Controler.addMainframe.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 根据请求参数封装主机送检对象
	 * @param request 请求对象
	 * @return
	 */
	private List<MainframeInspectEntity> getMainframeInspects(HttpServletRequest request){
		String[] inspectids=request.getParameterValues("inspectid");
		List<MainframeInspectEntity> mainframeInspects=new ArrayList<MainframeInspectEntity>();
		if(!ArrayUtils.isEmpty(inspectids)){
			for(String inspectid:inspectids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+inspectid)) && StringUtils.isEmpty(request.getParameter("selfcheckContent_"+inspectid))
						&& StringUtils.isEmpty(request.getParameter("selfcheckName_"+inspectid)) && StringUtils.isEmpty(request.getParameter("selfcheckResult_"+inspectid))){
					continue;
				}
				MainframeInspectEntity mainframeInspectEntity=new MainframeInspectEntity();
				mainframeInspectEntity.setRemarks(request.getParameter("remarks_"+inspectid));
				mainframeInspectEntity.setSelfcheckContent(request.getParameter("selfcheckContent_"+inspectid));
				mainframeInspectEntity.setSelfcheckName(request.getParameter("selfcheckName_"+inspectid));
				mainframeInspectEntity.setSelfcheckResult(request.getParameter("selfcheckResult_"+inspectid));
				mainframeInspects.add(mainframeInspectEntity);
				
			}
		}
		return mainframeInspects;
	}
	/*
	 * 根据请求参数封装主机装配对象
	 * @param request 请求对象
	 * @return
	 */
	private List<MainframeAssembleEntity> getMainframeAssembles(HttpServletRequest request){
		String[] assembleids=request.getParameterValues("assembleid");
		List<MainframeAssembleEntity> mainframeAssembles=new ArrayList<MainframeAssembleEntity>();
		if(!ArrayUtils.isEmpty(assembleids)){
			for(String assembleid:assembleids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+assembleid)) && StringUtils.isEmpty(request.getParameter("componentName_"+assembleid))
						&& StringUtils.isEmpty(request.getParameter("componentNo_"+assembleid)) && StringUtils.isEmpty(request.getParameter("serialNoRecord_"+assembleid))){
					continue;
				}
				MainframeAssembleEntity mainframeAssembleEntity=new MainframeAssembleEntity();
				mainframeAssembleEntity.setRemarks(request.getParameter("remarks_"+assembleid));
				mainframeAssembleEntity.setComponentName(request.getParameter("componentName_"+assembleid));
				mainframeAssembleEntity.setComponentNo(request.getParameter("componentNo_"+assembleid));
				mainframeAssembleEntity.setSerialNoRecord(request.getParameter("serialNoRecord_"+assembleid));
				mainframeAssembles.add(mainframeAssembleEntity);
			}
		}
		return mainframeAssembles;
	}
	/*
	 * 修改主机装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/modMainframe", method= RequestMethod.GET)
    public   String modMainframe(@RequestParam("mainframeID") String mainframeID,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		MainframeEntity mainframeEntity=null;
		try {
			mainframeEntity=mainframeService.queryMainframe(mainframeID);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframe.service.queryMainframe.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.queryMainframe.exception"));
		}
		if(mainframeEntity==null){
			mainframeEntity=new MainframeEntity();
		}
		model.addAttribute("mainframeAssembles", JSON.toJSONString(mainframeEntity.getAssembleRecords()));
		model.addAttribute("mainframeInspects", JSON.toJSONString(mainframeEntity.getInspectRecords()));
		model.addAttribute("mainframeEntity", mainframeEntity);
			
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "trackinglist/mainframe/copyMainframe";
		}else{
			return "trackinglist/mainframe/modMainframe";
		}
    }
	/*
	 * 修改主机装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/modMainframe", method= RequestMethod.POST)
    public  @ResponseBody String modMainframe(@Validated(SAVE.class) MainframeEntity mainframeEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				initDefaultEntity(mainframeEntity);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					mainframeEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				
				mainframeEntity.setAssembleRecords(getMainframeAssembles(request));
				mainframeEntity.setInspectRecords(getMainframeInspects(request));
				baseResponse=mainframeService.modifyMainframe(mainframeEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframe.Controler.modMainframe.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.Controler.modMainframe.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除主机装配信息
	 */
	@RequestMapping(value="trackinglist/delMainframe", method= RequestMethod.POST)
    public @ResponseBody String delMainframe(@RequestParam("mainframeIDs") String mainframeIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aoMainframeID=mainframeIDs.split(",");
			List<Integer> tempMainframe=new ArrayList<Integer>();
			for(String mainframeId:aoMainframeID){
				tempMainframe.add(Integer.parseInt(mainframeId));
			}
			baseResponse=mainframeService.delMainframe(tempMainframe);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframe.Controler.delMainframe.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.Controler.delMainframe.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出主机装配信息
	 */
	@RequestMapping(value="trackinglist/exportMainframe", method= RequestMethod.POST)
    public @ResponseBody String exportMainframe(Model model,@RequestParam("mainframeID") String mainframeID, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		MainframeEntity mainframeEntity=null;
		try {
			mainframeEntity=mainframeService.queryMainframe(mainframeID);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframe.service.queryMainframe.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.service.queryMainframe.exception"));
		}
		if(mainframeEntity==null){
			mainframeEntity=new MainframeEntity();
		}
		//设置下载保存文件路径
    	StringBuilder downloadFileFullPath=new StringBuilder();
    	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(downloadFilePath);
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_MAINFRAME_DOWNLOAD_SUBDIRECTORY));
    	downloadFileFullPath.append(File.separator);
    	//设置下载保存文件路径名称
    	StringBuilder fileName=new StringBuilder();
    	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
    	fileName.append("_");
    	fileName.append(resourceUtils.getMessage("mainframe.Controler.exportMainframe.filename"));
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
        	if(!CollectionUtils.isEmpty(mainframeEntity.getAssembleRecords())){
        		for(MainframeAssembleEntity mainframeAssembleEntity:mainframeEntity.getAssembleRecords()){
        			mainframeAssembleEntity.setMainframeID(i++);
        			if(!StringUtils.isEmpty(mainframeAssembleEntity.getComponentName())){
        				mainframeAssembleEntity.setComponentName(mainframeAssembleEntity.getComponentName().replace("|", "\n"));
        			}
        			if(!StringUtils.isEmpty(mainframeAssembleEntity.getComponentNo())){
        				mainframeAssembleEntity.setComponentNo(mainframeAssembleEntity.getComponentNo().replace("|", "\n"));
        			}
        		}
        	}
        	i=1;
        	if(!CollectionUtils.isEmpty(mainframeEntity.getInspectRecords())){
        		for(MainframeInspectEntity mainframeInspectEntity:mainframeEntity.getInspectRecords()){
        			mainframeInspectEntity.setMainframeID(i++);
        			if(!StringUtils.isEmpty(mainframeInspectEntity.getSelfcheckName())){
        				mainframeInspectEntity.setSelfcheckName(mainframeInspectEntity.getSelfcheckName().replace("|", "\n"));
        			}
        			if(!StringUtils.isEmpty(mainframeInspectEntity.getSelfcheckContent())){
        				mainframeInspectEntity.setSelfcheckContent(mainframeInspectEntity.getSelfcheckContent().replace("|", "\n"));
        			}
        		}
        	}
        	Map<Integer,List<ExcelHeaderNode>> excelTemplateMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_MAINFRAME_TEMPLATENAME));
        	if(excelTemplateMap!=null){
        		excelTemplateMap=ExcelTools.getExcelTempateDatas(excelTemplateMap,mainframeEntity,0);
        	}
        	
        	Workbook workbook=iExcelTemplateHandler.getExcelWorkbook(mainframeEntity.getMainframePn(), excelTemplateMap);
			workbook.write(out);
			List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
			ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
			excelSaveEntity.setFileName(fileName.toString());
			excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_MAINFRAME_DOWNLOAD_SUBDIRECTORY));
			excelSaveEntitys.add(excelSaveEntity);
			baseResponse.setReturnObjects(excelSaveEntitys);
			return JSON.toJSONString(baseResponse);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframe.Controler.exportMainframe.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.Controler.exportMainframe.exception")+":"+e.toString());
		}finally{
			IOUtils.close(out);
		}
		return JSON.toJSONString(baseResponse);
    }
	@RequestMapping(value="/trackinglist/mainframeInspectDetail", method= RequestMethod.POST)
    public @ResponseBody String mainframeInspectDetail(Model model,@RequestParam("mainframeID") String  mainframeID, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=mainframeService.queryMainframeInspectList(mainframeID);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframe.Controler.mainframeInspectDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.Controler.mainframeInspectDetail.exception"));
			
		}
		 return jsonData;
    }
	@RequestMapping(value="/trackinglist/mainframeAssembleDetail", method= RequestMethod.POST)
    public @ResponseBody String mainframeAssembleDetail(Model model,@RequestParam("mainframeID") String  mainframeID, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=mainframeService.queryMainframeAssembleList(mainframeID);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframe.Controler.mainframeAssembleDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframe.Controler.mainframeAssembleDetail.exception"));
			
		}
		 return jsonData;
    }
}

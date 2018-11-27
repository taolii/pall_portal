package com.pall.wdpts.module.trackinglist;

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
import com.pall.wdpts.common.support.excel.ExcelDataNode;
import com.pall.wdpts.common.support.excel.ExcelHeaderNode;
import com.pall.wdpts.common.tools.ExcelTools;
import com.pall.wdpts.context.HolderContext;
import com.pall.wdpts.init.TableDataConfigInitiator;
import com.pall.wdpts.init.UmsConfigInitiator;
import com.pall.wdpts.interceptor.support.AuthToken;
import com.pall.wdpts.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.wdpts.repository.entity.menu.ButtonEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspFormQueryEntity;
import com.pall.wdpts.repository.entity.user.UserEntity.ADD;
import com.pall.wdpts.repository.entity.user.UserEntity.SAVE;
import com.pall.wdpts.repository.entity.workflow.ExcelSaveEntity;
import com.pall.wdpts.service.excel.IExcelHandler;
import com.pall.wdpts.service.excel.IExcelTemplateHandler;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.trackinglist.DspService;

/*
 * Dsp装配流程跟踪单
 */
@Controller
public class DspManageControler {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private ButtonManageService buttonManageService;
	@Autowired
	private DspService dspService;
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
	@Value("${trackling.dsp.template}")
	private String templateFilePath;
	@Autowired
	@Qualifier("xlsxExcelHandler")
	private IExcelHandler iExcelHandler;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		
		return model;
	}
	/*
	 * 初始化默认值
	 */
	private void initDefaultEntity(DspEntity dspEntity){
		if(StringUtils.isEmpty(dspEntity.getProductionTime())){
			dspEntity.setProductionTime(null);
		}
		if(StringUtils.isEmpty(dspEntity.getAssembleTime())){
			dspEntity.setAssembleTime(null);
		}
	}
	/*
	 * Dsp装配管理
	 */
	@RequestMapping(value="/trackinglist/dspManage", method= RequestMethod.GET)
    public  String dspManage(Model model, HttpServletRequest request) {
		model=initConfigData(model);
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			try {
				BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					List<ButtonEntity> buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
					model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_TABLENAME));
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
	   return "trackinglist/dsp/dspManage";
    }
	@RequestMapping(value="/trackinglist/dspManage", method= RequestMethod.POST)
    public @ResponseBody String dspManage(Model model,DspFormQueryEntity  dspFormQueryEntity, HttpServletRequest request) {
        if(dspFormQueryEntity.getPageSize()==0){
        	dspFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=dspService.queryDspList(dspFormQueryEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dsp.Controler.dspManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.Controler.dspManage.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加Dsp装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/addDsp", method= RequestMethod.GET)
    public   String addDsp(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		return "trackinglist/dsp/addDsp";
    }
	/*
	 * 添加Dsp装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/addDsp", method= RequestMethod.POST)
    public  @ResponseBody String addDsp(@Validated(ADD.class) DspEntity dspEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				initDefaultEntity(dspEntity);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					dspEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				baseResponse=getDspAssembles(request);
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
					dspEntity.setAssembleRecords((List<DspAssembleEntity>)baseResponse.getReturnObjects());
					baseResponse=dspService.addDsp(dspEntity);
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dsp.Controler.addDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.Controler.addDsp.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 根据请求参数封装Dsp装配对象
	 * @param request 请求对象
	 * @return
	 */
	private BaseResponse getDspAssembles(HttpServletRequest request){
		BaseResponse baseResponse=new BaseResponse();
		String[] assembleids=request.getParameterValues("assembleid");
		List<DspAssembleEntity> dspAssembles=new ArrayList<DspAssembleEntity>();
		if(!ArrayUtils.isEmpty(assembleids)){
			for(String assembleid:assembleids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+assembleid)) && StringUtils.isEmpty(request.getParameter("componentName_"+assembleid))
						&& StringUtils.isEmpty(request.getParameter("componentNo_"+assembleid)) && StringUtils.isEmpty(request.getParameter("serialNoRecord_"+assembleid))){
					continue;
				}
				DspAssembleEntity dspAssembleEntity=new DspAssembleEntity();
				dspAssembleEntity.setRemarks(request.getParameter("remarks_"+assembleid));
				dspAssembleEntity.setComponentName(request.getParameter("componentName_"+assembleid));
				dspAssembleEntity.setComponentNo(request.getParameter("componentNo_"+assembleid));
				dspAssembleEntity.setSerialNoRecord(request.getParameter("serialNoRecord_"+assembleid));
				if(StringUtils.isEmpty(dspAssembleEntity.getSerialNoRecord())){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("dsp.Controler.serialNoRecord.Assemble.isNotEmpty"));
					return baseResponse;
				}
				dspAssembles.add(dspAssembleEntity);
			}
		}
		baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		baseResponse.setReturnObjects(dspAssembles);
		return baseResponse;
	}
	/*
	 * 修改Dsp装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/modDsp", method= RequestMethod.GET)
    public   String modDsp(@RequestParam("dspID") String dspID,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		DspEntity dspEntity=null;
		try {
			dspEntity=dspService.queryDsp(dspID);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dsp.service.queryDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.queryDsp.exception"));
		}
		if(dspEntity==null){
			dspEntity=new DspEntity();
		}
		model.addAttribute("dspAssembles", JSON.toJSONString(dspEntity.getAssembleRecords()));
		model.addAttribute("dspEntity", dspEntity);
			
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "trackinglist/dsp/copyDsp";
		}else{
			return "trackinglist/dsp/modDsp";
		}
    }
	/*
	 * 修改Dsp装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/modDsp", method= RequestMethod.POST)
    public  @ResponseBody String modDsp(@Validated(SAVE.class) DspEntity dspEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				initDefaultEntity(dspEntity);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					dspEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				
				baseResponse=getDspAssembles(request);
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
					dspEntity.setAssembleRecords((List<DspAssembleEntity>)baseResponse.getReturnObjects());
					baseResponse=dspService.modifyDsp(dspEntity);
				}
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dsp.Controler.modDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.Controler.modDsp.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除Dsp装配信息
	 */
	@RequestMapping(value="trackinglist/delDsp", method= RequestMethod.POST)
    public @ResponseBody String delDsp(@RequestParam("dspIDs") String dspIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aoDspID=dspIDs.split(",");
			List<Integer> tempDsp=new ArrayList<Integer>();
			for(String dspId:aoDspID){
				tempDsp.add(Integer.parseInt(dspId));
			}
			baseResponse=dspService.delDsp(tempDsp);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dsp.Controler.delDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.Controler.delDsp.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出Dsp装配信息
	 */
	@RequestMapping(value="trackinglist/exportDsp", method= RequestMethod.POST)
    public @ResponseBody String exportDsp(Model model,@RequestParam("dspID") String dspID, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		DspEntity dspEntity=null;
		try {
			dspEntity=dspService.queryDsp(dspID);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dsp.service.queryDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.queryDsp.exception"));
		}
		if(dspEntity==null){
			dspEntity=new DspEntity();
		}
		//设置下载保存文件路径
    	StringBuilder downloadFileFullPath=new StringBuilder();
    	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(downloadFilePath);
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_DOWNLOAD_SUBDIRECTORY));
    	downloadFileFullPath.append(File.separator);
    	//设置下载保存文件路径名称
    	StringBuilder fileName=new StringBuilder();
    	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
    	fileName.append("_");
    	fileName.append(resourceUtils.getMessage("dsp.Controler.exportDsp.filename"));
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
        	if(!CollectionUtils.isEmpty(dspEntity.getAssembleRecords())){
        		for(DspAssembleEntity dspAssembleEntity:dspEntity.getAssembleRecords()){
        			dspAssembleEntity.setDspID(i++);
        			if(!StringUtils.isEmpty(dspAssembleEntity.getComponentName())){
        				dspAssembleEntity.setComponentName(dspAssembleEntity.getComponentName().replace("|", "\n"));
        			}
        			if(!StringUtils.isEmpty(dspAssembleEntity.getComponentNo())){
        				dspAssembleEntity.setComponentNo(dspAssembleEntity.getComponentNo().replace("|", "\n"));
        			}
        		}
        	}
        	Map<Integer,List<ExcelHeaderNode>> excelTemplateMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_TEMPLATENAME));
        	if(excelTemplateMap!=null){
        		excelTemplateMap=ExcelTools.getExcelTempateDatas(excelTemplateMap,dspEntity,0);
        	}
        	
        	Workbook workbook=iExcelTemplateHandler.getExcelWorkbook(dspEntity.getDspPn(), excelTemplateMap);
			workbook.write(out);
			List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
			ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
			excelSaveEntity.setFileName(fileName.toString());
			excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_DOWNLOAD_SUBDIRECTORY));
			excelSaveEntitys.add(excelSaveEntity);
			baseResponse.setReturnObjects(excelSaveEntitys);
			return JSON.toJSONString(baseResponse);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dsp.Controler.exportDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.Controler.exportDsp.exception")+":"+e.toString());
		}finally{
			IOUtils.close(out);
		}
		return JSON.toJSONString(baseResponse);
    }
	@RequestMapping(value="/trackinglist/dspAssembleDetail", method= RequestMethod.POST)
    public @ResponseBody String dspAssembleDetail(Model model,@RequestParam("dspID") String  dspID, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=dspService.queryDspAssembleList(dspID);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dsp.Controler.dspAssembleDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.Controler.dspAssembleDetail.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 导出水箱装配信息
	 */
	@RequestMapping(value="trackinglist/exportDsps", method= RequestMethod.POST)
    public @ResponseBody String exportDsps(Model model,DspFormQueryEntity  dspFormQueryEntity, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		List<DspEntity> dspEntitys=null;
		try {
			dspEntitys=dspService.exportDspList(dspFormQueryEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dsp.service.queryDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.queryDsp.exception"));
			return JSON.toJSONString(baseResponse);
		}
		if(dspEntitys==null){
			dspEntitys=new ArrayList<DspEntity>();
		}
		 Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_TABLENAME));
		int currentRowNum=excelheadlinesMap.size();
        Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
        if(null!=dspEntitys && dspEntitys.size()>0){
        	if(!StringUtils.isEmpty(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
        		if(dspEntitys.size()>Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
        			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
        			baseResponse.setResultMsg(resourceUtils.getMessage("export.records.over.the.limit")+":"+UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS));
        			baseResponse.setReturnObjects(null);
        			return JSON.toJSONString(baseResponse);
	        	}
        	}
        	rowdatas=ExcelTools.getExcelDatas(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_TABLENAME), dspEntitys,currentRowNum);
        }
		//设置下载保存文件路径
    	StringBuilder downloadFileFullPath=new StringBuilder();
    	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(downloadFilePath);
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_DOWNLOAD_SUBDIRECTORY));
    	downloadFileFullPath.append(File.separator);
    	//设置下载保存文件路径名称
    	StringBuilder fileName=new StringBuilder();
    	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
    	fileName.append("_");
    	fileName.append(resourceUtils.getMessage("dsp.Controler.exportDsp.filename"));
    	fileName.append("_");
    	SimpleDateFormat sf=new SimpleDateFormat("yyyymmddhh24mmss");
    	fileName.append(sf.format(new Date()));
    	fileName.append(".");
    	fileName.append(KeyConstants.EXCEL_SUFFIX_XLSX);
    	OutputStream out =null;
        try {
        	Files.createParentDirs(new File(downloadFileFullPath.toString()+fileName.toString()));
        	out=new FileSystemResource(downloadFileFullPath.toString()+fileName.toString()).getOutputStream();
			Workbook workbook=iExcelHandler.getExcelWorkbook(resourceUtils.getMessage("dsp.Controler.exportDsp.filename"), excelheadlinesMap, rowdatas);
			workbook.write(out);
			List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
			ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
			excelSaveEntity.setFileName(fileName.toString());
			excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_DSP_DOWNLOAD_SUBDIRECTORY));
			excelSaveEntitys.add(excelSaveEntity);
			baseResponse.setReturnObjects(excelSaveEntitys);
			return JSON.toJSONString(baseResponse);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("dsp.Controler.exportDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.Controler.exportDsp.exception")+":"+e.toString());
		}finally{
			IOUtils.close(out);
		}
		return JSON.toJSONString(baseResponse);
    }
}

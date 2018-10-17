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
import com.pall.wdpts.repository.entity.trackinglist.CisternAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternFormQueryEntity;
import com.pall.wdpts.repository.entity.user.UserEntity.ADD;
import com.pall.wdpts.repository.entity.user.UserEntity.SAVE;
import com.pall.wdpts.repository.entity.workflow.ExcelSaveEntity;
import com.pall.wdpts.service.excel.IExcelTemplateHandler;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.trackinglist.CisternService;

/*
 * 水箱装配流程跟踪单
 */
@Controller
public class CisternManageControler {
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private ButtonManageService buttonManageService;
	@Autowired
	private CisternService cisternService;
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
	@Value("${trackling.cistern.template}")
	private String templateFilePath;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_CISTERN_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		model.addAttribute("cisternModelDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_CISTERN_DATACONFIG_TYPE_CISTERNMODEL)));
		return model;
	}
	/*
	 * 初始化默认值
	 */
	private void initDefaultEntity(CisternEntity cisternEntity){
		if(StringUtils.isEmpty(cisternEntity.getProductionTime())){
			cisternEntity.setProductionTime(null);
		}
		if(StringUtils.isEmpty(cisternEntity.getAssembleTime())){
			cisternEntity.setAssembleTime(null);
		}
	}
	/*
	 * 水箱装配管理
	 */
	@RequestMapping(value="/trackinglist/cisternManage", method= RequestMethod.GET)
    public  String cisternManage(Model model, HttpServletRequest request) {
		model=initConfigData(model);
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			try {
				BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_CISTERN_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					List<ButtonEntity> buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
					model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_CISTERN_TABLENAME));
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
	   return "trackinglist/cistern/cisternManage";
    }
	@RequestMapping(value="/trackinglist/cisternManage", method= RequestMethod.POST)
    public @ResponseBody String cisternManage(Model model,CisternFormQueryEntity  cisternFormQueryEntity, HttpServletRequest request) {
        if(cisternFormQueryEntity.getPageSize()==0){
        	cisternFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=cisternService.queryCisternList(cisternFormQueryEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> defectTypes=new ArrayList<String>();
				defectTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_CISTERN_TABLENAME));
				jsonData= JSONTools.defectsOverturnFiled(jsonData,defectTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cistern.Controler.cisternManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.Controler.cisternManage.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 添加水箱装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/addCistern", method= RequestMethod.GET)
    public   String addCistern(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		return "trackinglist/cistern/addCistern";
    }
	/*
	 * 添加水箱装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/addCistern", method= RequestMethod.POST)
    public  @ResponseBody String addCistern(@Validated(ADD.class) CisternEntity cisternEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				initDefaultEntity(cisternEntity);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					cisternEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				cisternEntity.setAssembleRecords(getCisternAssembles(request));
				baseResponse=cisternService.addCistern(cisternEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cistern.Controler.addCistern.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.Controler.addCistern.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 根据请求参数封装水箱装配对象
	 * @param request 请求对象
	 * @return
	 */
	private List<CisternAssembleEntity> getCisternAssembles(HttpServletRequest request){
		String[] assembleids=request.getParameterValues("assembleid");
		List<CisternAssembleEntity> cisternAssembles=new ArrayList<CisternAssembleEntity>();
		if(!ArrayUtils.isEmpty(assembleids)){
			for(String assembleid:assembleids){
				if(StringUtils.isEmpty(request.getParameter("remarks_"+assembleid)) && StringUtils.isEmpty(request.getParameter("componentName_"+assembleid))
						&& StringUtils.isEmpty(request.getParameter("componentNo_"+assembleid)) && StringUtils.isEmpty(request.getParameter("serialNoRecord_"+assembleid))){
					continue;
				}
				CisternAssembleEntity cisternAssembleEntity=new CisternAssembleEntity();
				cisternAssembleEntity.setRemarks(request.getParameter("remarks_"+assembleid));
				cisternAssembleEntity.setComponentName(request.getParameter("componentName_"+assembleid));
				cisternAssembleEntity.setComponentNo(request.getParameter("componentNo_"+assembleid));
				cisternAssembleEntity.setSerialNoRecord(request.getParameter("serialNoRecord_"+assembleid));
				cisternAssembles.add(cisternAssembleEntity);
			}
		}
		return cisternAssembles;
	}
	/*
	 * 修改水箱装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/modCistern", method= RequestMethod.GET)
    public   String modCistern(@RequestParam("cisternID") String cisternID,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		model=initConfigData(model);
		BaseResponse baseResponse=new BaseResponse();
		CisternEntity cisternEntity=null;
		try {
			cisternEntity=cisternService.queryCistern(cisternID);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cistern.service.queryCistern.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.queryCistern.exception"));
		}
		if(cisternEntity==null){
			cisternEntity=new CisternEntity();
		}
		model.addAttribute("cisternAssembles", JSON.toJSONString(cisternEntity.getAssembleRecords()));
		model.addAttribute("cisternEntity", cisternEntity);
			
		if("copy".equals(operator)){
			model.addAttribute("operator", "copy");
			return "trackinglist/cistern/copyCistern";
		}else{
			return "trackinglist/cistern/modCistern";
		}
    }
	/*
	 * 修改水箱装配信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="trackinglist/modCistern", method= RequestMethod.POST)
    public  @ResponseBody String modCistern(@Validated(SAVE.class) CisternEntity cisternEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				initDefaultEntity(cisternEntity);
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					cisternEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				cisternEntity.setAssembleRecords(getCisternAssembles(request));
				baseResponse=cisternService.modifyCistern(cisternEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cistern.Controler.modCistern.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.Controler.modCistern.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除水箱装配信息
	 */
	@RequestMapping(value="trackinglist/delCistern", method= RequestMethod.POST)
    public @ResponseBody String delCistern(@RequestParam("cisternIDs") String cisternIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aoCisternID=cisternIDs.split(",");
			List<Integer> tempCistern=new ArrayList<Integer>();
			for(String cisternId:aoCisternID){
				tempCistern.add(Integer.parseInt(cisternId));
			}
			baseResponse=cisternService.delCistern(tempCistern);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cistern.Controler.delCistern.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.Controler.delCistern.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出水箱装配信息
	 */
	@RequestMapping(value="trackinglist/exportCistern", method= RequestMethod.POST)
    public @ResponseBody String exportCistern(Model model,@RequestParam("cisternID") String cisternID, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		CisternEntity cisternEntity=null;
		try {
			cisternEntity=cisternService.queryCistern(cisternID);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cistern.service.queryCistern.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.queryCistern.exception"));
		}
		if(cisternEntity==null){
			cisternEntity=new CisternEntity();
		}
		//设置下载保存文件路径
    	StringBuilder downloadFileFullPath=new StringBuilder();
    	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(downloadFilePath);
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_CISTERN_DOWNLOAD_SUBDIRECTORY));
    	downloadFileFullPath.append(File.separator);
    	//设置下载保存文件路径名称
    	StringBuilder fileName=new StringBuilder();
    	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
    	fileName.append("_");
    	fileName.append(resourceUtils.getMessage("cistern.Controler.exportCistern.filename"));
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
        	if(!CollectionUtils.isEmpty(cisternEntity.getAssembleRecords())){
        		for(CisternAssembleEntity cisternAssembleEntity:cisternEntity.getAssembleRecords()){
        			cisternAssembleEntity.setCisternID(i++);
        			if(!StringUtils.isEmpty(cisternAssembleEntity.getComponentName())){
        				cisternAssembleEntity.setComponentName(cisternAssembleEntity.getComponentName().replace("|", "\n"));
        			}
        			if(!StringUtils.isEmpty(cisternAssembleEntity.getComponentNo())){
        				cisternAssembleEntity.setComponentNo(cisternAssembleEntity.getComponentNo().replace("|", "\n"));
        			}
        		}
        	}
        	Map<Integer,List<ExcelHeaderNode>> excelTemplateMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_CISTERN_TEMPLATENAME));
        	if(excelTemplateMap!=null){
        		excelTemplateMap=ExcelTools.getExcelTempateDatas(excelTemplateMap,cisternEntity,0);
        	}
        	
        	Workbook workbook=iExcelTemplateHandler.getExcelWorkbook(cisternEntity.getCisternPn(), excelTemplateMap);
			workbook.write(out);
			List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
			ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
			excelSaveEntity.setFileName(fileName.toString());
			excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_CISTERN_DOWNLOAD_SUBDIRECTORY));
			excelSaveEntitys.add(excelSaveEntity);
			baseResponse.setReturnObjects(excelSaveEntitys);
			return JSON.toJSONString(baseResponse);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cistern.Controler.exportCistern.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.Controler.exportCistern.exception")+":"+e.toString());
		}finally{
			IOUtils.close(out);
		}
		return JSON.toJSONString(baseResponse);
    }
	@RequestMapping(value="/trackinglist/cisternAssembleDetail", method= RequestMethod.POST)
    public @ResponseBody String cisternAssembleDetail(Model model,@RequestParam("cisternID") String  cisternID, HttpServletRequest request) {
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=cisternService.queryCisternAssembleList(cisternID);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("cistern.Controler.cisternAssembleDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.Controler.cisternAssembleDetail.exception"));
			
		}
		 return jsonData;
    }
}

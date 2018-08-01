package com.pall.wdpts.module.workflow;

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
import com.pall.wdpts.annotation.Token;
import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.constants.KeyConstants;
import com.pall.wdpts.common.i18n.ResourceUtils;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.common.support.excel.ExcelDataNode;
import com.pall.wdpts.common.support.excel.ExcelHeaderNode;
import com.pall.wdpts.common.tools.ExcelTools;
import com.pall.wdpts.common.tools.JSONTools;
import com.pall.wdpts.context.HolderContext;
import com.pall.wdpts.init.DataConfigInitiator;
import com.pall.wdpts.init.TableDataConfigInitiator;
import com.pall.wdpts.init.UmsConfigInitiator;
import com.pall.wdpts.interceptor.support.AuthToken;
import com.pall.wdpts.repository.entity.dataconfig.DataConfigEntity;
import com.pall.wdpts.repository.entity.dataconfig.DataConfigTypeEntity;
import com.pall.wdpts.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.wdpts.repository.entity.menu.ButtonEntity;
import com.pall.wdpts.repository.entity.user.UserEntity.ADD;
import com.pall.wdpts.repository.entity.user.UserEntity.SAVE;
import com.pall.wdpts.repository.entity.workflow.ExcelSaveEntity;
import com.pall.wdpts.repository.entity.workflow.PlatedFilmEntity;
import com.pall.wdpts.repository.entity.workflow.PlatedFilmQueryFormEntity;
import com.pall.wdpts.service.excel.IExcelHandler;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.workflow.PlatedFilmService;
/*
 * 化学镀膜管理控制器
 */
@Controller
public class PlatedFilmManageController{
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
	private PlatedFilmService platedFilmService;
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
		
		model.addAttribute("apsDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_DATACONFIG_TYPE_APSCONDITION)));
		model.addAttribute("fixtureAttrDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_DATACONFIG_TYPE_FIXTUREATTRIBUTE)));
		model.addAttribute("platedFilmTableName", UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_TABLENAME));
		model.addAttribute("supplierDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_SUPPLIER)));
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
	 * 化学镀膜管理
	 */
	@RequestMapping(value="workflow/platedFilmManage", method= RequestMethod.GET)
    public  String platedFilmManage(Model model, HttpServletRequest request) {
		//获取按钮权限
		AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
		if(at!=null && at.getUserEntity()!=null){
			try {
				BaseResponse buttonResonse=buttonManageService.getRightButton(String.valueOf(at.getUserEntity().getOperatorid()),UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_MENUID));
				if(IResponseConstants.RESPONSE_CODE_SUCCESS==buttonResonse.getResultCode()){
					List<ButtonEntity> buttonEntitys=(List<ButtonEntity>)buttonResonse.getReturnObjects();
					model.addAttribute("buttonEntitys", JSON.toJSONString(buttonEntitys,SerializerFeature.WriteMapNullValue));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		
		model.addAttribute("pnDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_PARTNUM)));
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_TABLENAME));
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
	   return "workflow/platedfilm/platedFilmManage";
    }
	@RequestMapping(value="workflow/platedFilmManage", method= RequestMethod.POST)
    public @ResponseBody String platedFilmManage(Model model,PlatedFilmQueryFormEntity  platedFilmQueryFormEntity, HttpServletRequest request) {
        if(platedFilmQueryFormEntity.getPageSize()==0){
        	platedFilmQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=platedFilmService.queryPlatedFilmList(platedFilmQueryFormEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("platedfilmManage.controler.platedfilmManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.controler.platedfilmManage.exception"));
		}
		jsonData=JSONTools.handleJSONNullField(jsonData, UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_TABLENAME));
		 return jsonData;
    }
	/*
	 * 添加化学镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addPlatedFilm", method= RequestMethod.GET)
    public String addPolish(Model model,HttpServletRequest request) {
		model=initConfigData(model);
		model.addAttribute("sfDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_DATACONFIG_TYPE_SFBOMNUM)));
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMINGSEL_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMINGSEL_TABLENAME));
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
		return "workflow/platedfilm/addPlatedFilm";
    }
	
	/*
	 * 添加化学镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/addPlatedFilm", method= RequestMethod.POST)
    public  @ResponseBody String addPlatedFilm(@Validated(ADD.class) PlatedFilmEntity platedFilmEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					platedFilmEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				if(platedFilmEntity.getSfBoms()!=null){
					platedFilmEntity.setSfBomNum(StringUtils.join(platedFilmEntity.getSfBoms(), ","));
				};
				if(StringUtils.isEmpty(platedFilmEntity.getPfTime())){
					platedFilmEntity.setPfTime(null);
				}
				baseResponse=platedFilmService.addPlatedFilm(platedFilmEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("platedfilmManage.controler.addPlatedFilm.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.controler.addPlatedFilm.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 修改化学镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modPlatedFilm", method= RequestMethod.GET)
    public  String modPlatedFilm(@RequestParam("pfid") String pfId,@RequestParam("operator") String operator,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		model=initConfigData(model);
		try {
			PlatedFilmQueryFormEntity  platedFilmQueryFormEntity=new PlatedFilmQueryFormEntity();
			platedFilmQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			platedFilmQueryFormEntity.setPfId(pfId);;
			baseResponse=platedFilmService.exportPlatedFilm(platedFilmQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("opticalfilmingManage.controler.opticalFilmingManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.controler.opticalFilmingManage.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		PlatedFilmEntity platedFilmEntity=null;
		List<DataConfigEntity> sfDataConfigs=DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_DATACONFIG_TYPE_SFBOMNUM));
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        List<PlatedFilmEntity> platedFilmEntitys=(List<PlatedFilmEntity>)baseResponse.getReturnObjects();
	        if (platedFilmEntitys!=null &&  platedFilmEntitys.size()>0){
	        	platedFilmEntity=platedFilmEntitys.get(0);
	        	if(sfDataConfigs!=null && sfDataConfigs.size()>0){
	        		if(platedFilmEntity!=null && !StringUtils.isEmpty(platedFilmEntity.getSfBomNum())){
	        			String[] sfBoms=platedFilmEntity.getSfBomNum().split(",");
	        			for(DataConfigEntity dataConfigEntity:sfDataConfigs){
	        				dataConfigEntity.setChecked(false);
	        				for(String sfBom:sfBoms){
	        					if(dataConfigEntity.getConfigName().equals(sfBom)){
									dataConfigEntity.setChecked(true);
									break;
								}
							}
	        			}
		        		
	        		}
				}
	        }
		}
		if(platedFilmEntity==null){
			platedFilmEntity=new PlatedFilmEntity();
		}
		model.addAttribute("platedFilmEntity", platedFilmEntity);
		if(sfDataConfigs==null){
			sfDataConfigs=new ArrayList<DataConfigEntity>();
		}
    	model.addAttribute("sfDataConfigs",sfDataConfigs);
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMINGSEL_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMINGSEL_TABLENAME));
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
			return "workflow/platedfilm/copyPlatedFilm";
		}else{
			return "workflow/platedfilm/modPlatedFilm";
		}
    }
	/*
	 * 修改化学镀膜信息
	 */
	@Token(flag=Token.CHECK)
	@RequestMapping(value="workflow/modPlatedFilm", method= RequestMethod.POST)
    public  @ResponseBody String modPlatedFilm(@Validated(SAVE.class) PlatedFilmEntity platedFilmEntity,BindingResult result,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=HolderContext.getBindingResult(result);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				AuthToken at=(AuthToken)request.getSession().getAttribute(AuthToken.SESSION_NAME);
				if(at!=null && at.getUserEntity()!=null){
					platedFilmEntity.setOperatorid(at.getUserEntity().getOperatorid());
				}
				if(platedFilmEntity.getSfBoms()!=null){
					platedFilmEntity.setSfBomNum(StringUtils.join(platedFilmEntity.getSfBoms(), ","));
				};
				if(StringUtils.isEmpty(platedFilmEntity.getPfTime())){
					platedFilmEntity.setPfTime(null);
				}
				baseResponse=platedFilmService.modifyPlatedFilm(platedFilmEntity);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("platedfilmManage.controler.modifyPlatedFilm.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.controler.modifyPlatedFilm.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 删除化学镀膜信息
	 */
	@RequestMapping(value="workflow/delPlatedFilm", method= RequestMethod.POST)
    public @ResponseBody String delPlatedFilm(@RequestParam("pfIDs") String pfIDs,Model model,HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			String[] aopfID=pfIDs.split(",");
			List<Integer> tempPlatedFilm=new ArrayList<Integer>();
			for(String pfID:aopfID){
				tempPlatedFilm.add(Integer.parseInt(pfID));
			}
			baseResponse=platedFilmService.delPlatedFilm(tempPlatedFilm);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("platedfilmManage.controler.delPlatedFilm.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.controler.delPlatedFilm.exception"));
		}
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
	/*
	 * 导出化学镀膜信息
	 */
	@RequestMapping(value="workflow/exportPlatedFilm", method= RequestMethod.POST)
    public @ResponseBody String exportPlatedFilm(Model model,PlatedFilmQueryFormEntity  platedFilmQueryFormEntity, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		try {
			baseResponse=platedFilmService.exportPlatedFilm(platedFilmQueryFormEntity);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("platedfilmManage.controler.exportPlatedFilm.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.controler.exportPlatedFilm.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_TABLENAME));
	        List<PlatedFilmEntity> platedFilmEntitys=(List<PlatedFilmEntity>)baseResponse.getReturnObjects();
	        
	        int currentRowNum=excelheadlinesMap.size();
	        Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
	        if(null!=platedFilmEntitys && platedFilmEntitys.size()>0){
	        	if(!StringUtils.isEmpty(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        		if(platedFilmEntitys.size()>Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
	        			baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.controler.exportPlatedFilm.records.limits")+":"+UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS));
	        			baseResponse.setReturnObjects(null);
	        			return JSON.toJSONString(baseResponse);
		        	}
	        	}
	        	rowdatas=ExcelTools.getExcelDatas(UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_TABLENAME), platedFilmEntitys,currentRowNum);
	        }
	        //设置下载保存文件路径
        	StringBuilder downloadFileFullPath=new StringBuilder();
        	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(downloadFilePath);
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_DOWNLOAD_SUBDIRECTORY));
        	downloadFileFullPath.append(File.separator);
        	
        	//设置下载保存文件路径名称
        	StringBuilder fileName=new StringBuilder();
        	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
        	fileName.append("_");
        	fileName.append(resourceUtils.getMessage("platedfilmManage.controler.exportPlatedFilm.filename"));
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
				excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.PLATEDFILM_DOWNLOAD_SUBDIRECTORY));
				excelSaveEntitys.add(excelSaveEntity);
				baseResponse.setReturnObjects(excelSaveEntitys);
				return JSON.toJSONString(baseResponse);
			} catch (Exception e) {
				logger.error(resourceUtils.getMessage("platedfilmManage.controler.exportPlatedFilm.exception"),e);
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("platedfilmManage.controler.exportPlatedFilm.exception")+":"+e.toString());
			}finally{
				IOUtils.close(out);
			}
	    }
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

package com.pall.mts.module.report;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.thymeleaf.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alibaba.fastjson.util.IOUtils;
import com.google.common.io.Files;
import com.pall.mts.common.constants.IResponseConstants;
import com.pall.mts.common.constants.KeyConstants;
import com.pall.mts.common.i18n.ResourceUtils;
import com.pall.mts.common.response.BaseResponse;
import com.pall.mts.common.response.BaseTablesResponse;
import com.pall.mts.common.support.excel.ExcelDataNode;
import com.pall.mts.common.support.excel.ExcelHeaderNode;
import com.pall.mts.common.tools.ExcelTools;
import com.pall.mts.common.tools.JSONTools;
import com.pall.mts.init.DataConfigInitiator;
import com.pall.mts.init.TableDataConfigInitiator;
import com.pall.mts.init.UmsConfigInitiator;
import com.pall.mts.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.mts.repository.entity.report.AssemblyScrapSummaryEntity;
import com.pall.mts.repository.entity.report.AssemblyScrapSummaryQueryFormEntity;
import com.pall.mts.repository.entity.workflow.ExcelSaveEntity;
import com.pall.mts.service.excel.IExcelHandler;
import com.pall.mts.service.report.ReportSummaryService;
/*
 * 组装报废汇总控制器
 */
@Controller
public class AssemblyScrapSummaryController{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	/*
	 * 下载文件路径
	 */
	@Value("${system.default.file.download.path}")
	private String downloadFilePath;
	/*
	 * 工作流服务管理接口
	 */
	@Autowired
	private ReportSummaryService reportSummaryService;
	/*
	 * excel处理对象
	 */
	@Autowired
	@Qualifier("xlsxExcelHandler")
	private IExcelHandler iExcelHandler;
	
	@RequestMapping(value="report/assemblyScrapSummary", method= RequestMethod.GET)
    public  String assemblyScrapSummary(Model model, HttpServletRequest request) {
		model.addAttribute("pnDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_PARTNUM)));
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REPORT_ASSEMBLY_SCRAP_SUMMARY_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REPORT_ASSEMBLY_SCRAP_SUMMARY_TABLENAME));
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
	   return "report/assemblyScrapSummary";
    }
	/*
	 * 组装报废汇总管理
	 */
	@RequestMapping(value="report/assemblyScrapSummary", method= RequestMethod.POST)
	public @ResponseBody String assemblyScrapSummary(Model model,AssemblyScrapSummaryQueryFormEntity assemblyScrapSummaryQueryFormEntity, HttpServletRequest request) {
        if(assemblyScrapSummaryQueryFormEntity.getPageSize()==0){
        	assemblyScrapSummaryQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=reportSummaryService.queryAssemblyScrapSummary(assemblyScrapSummaryQueryFormEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> defectTypes=new ArrayList<String>();
				defectTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.REPORT_ASSEMBLY_SCRAP_SUMMARY_TABLENAME));
				jsonData= JSONTools.defectsOverturnFiled(jsonData,defectTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("report.assemblyScrapSummary.controler.assemblyScrapSummary.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("report.assemblyScrapSummary.controler.assemblyScrapSummary.exception"));
			
		}
		 return jsonData;
    }
	/*
	 * 导出组装信息
	 */
	@RequestMapping(value="workflow/exportAssemblyScrapSummary", method= RequestMethod.POST)
    public @ResponseBody String exportAssemblyScrapSummary(Model model,AssemblyScrapSummaryQueryFormEntity assemblyScrapSummaryQueryFormEntity, HttpServletRequest request) {
		BaseResponse baseResponse=new BaseResponse();
		List<AssemblyScrapSummaryEntity> assemblyScrapSummaryEntitys=null;
		try {
			assemblyScrapSummaryQueryFormEntity.setStartPageNum(0);
			assemblyScrapSummaryQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			assemblyScrapSummaryEntitys=reportSummaryService.queryAssemblyScrapSummaryList(assemblyScrapSummaryQueryFormEntity);
			if(!CollectionUtils.isEmpty(assemblyScrapSummaryEntitys))baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("report.assemblyScrapSummary.controler.assemblyScrapSummary.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("report.assemblyScrapSummary.controler.assemblyScrapSummary.exception"));
		}
		//数据查询成功，将文件写入下载目录以便下载
		if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
	        Map<Integer,List<ExcelHeaderNode>> excelheadlinesMap=TableDataConfigInitiator.getExcelHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REPORT_ASSEMBLY_SCRAP_SUMMARY_TABLENAME));
	        int currentRowNum=excelheadlinesMap.size();
	        Map<Integer,List<ExcelDataNode>> rowdatas=new HashMap<Integer,List<ExcelDataNode>>();
	        if(null!=assemblyScrapSummaryEntitys && assemblyScrapSummaryEntitys.size()>0){
	        	if(!StringUtils.isEmpty(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        		if(assemblyScrapSummaryEntitys.size()>Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS))){
	        			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
	        			baseResponse.setResultMsg(resourceUtils.getMessage("report.assemblyScrapSummary.controler.exportAssemblyScrapSummary.records.limits")+":"+UmsConfigInitiator.getDataConfig(KeyConstants.EXCEL_EXPORT_RECORDS_LIMITS));
	        			baseResponse.setReturnObjects(null);
	        			return JSON.toJSONString(baseResponse);
		        	}
	        	}
	        	rowdatas=ExcelTools.getExcelDatas(TableDataConfigInitiator.getExcelFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REPORT_ASSEMBLY_SCRAP_SUMMARY_TABLENAME)), assemblyScrapSummaryEntitys,currentRowNum);
	        }
	        //设置下载保存文件路径
        	StringBuilder downloadFileFullPath=new StringBuilder();
        	downloadFileFullPath.append(this.getClass().getResource("/").getPath());
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(downloadFilePath);
        	downloadFileFullPath.append(File.separator);
        	downloadFileFullPath.append(UmsConfigInitiator.getDataConfig(KeyConstants.REPORT_ASSEMBLY_SCRAP_SUMMARY_DOWNLOAD_SUBDIRECTORY));
        	downloadFileFullPath.append(File.separator);
        	
        	//设置下载保存文件路径名称
        	StringBuilder fileName=new StringBuilder();
        	fileName.append(resourceUtils.getMessage("bootstrap.system.name"));
        	fileName.append("_");
        	fileName.append(resourceUtils.getMessage("report.assemblyScrapSummary.controler.exportAssemblyScrapSummary.filename"));
        	fileName.append("_");
        	SimpleDateFormat sf=new SimpleDateFormat("yyyymmddhh24mmss");
        	fileName.append(sf.format(new Date()));
        	fileName.append(KeyConstants.EXCEL_SUFFIX_XLSX);
        	OutputStream out =null;
	        try {
	        	Files.createParentDirs(new File(downloadFileFullPath.toString()+fileName.toString()));
	        	out=new FileSystemResource(downloadFileFullPath.toString()+fileName.toString()).getOutputStream();
				Workbook workbook=iExcelHandler.getExcelWorkbook(resourceUtils.getMessage("report.assemblyScrapSummary.controler.exportAssemblyScrapSummary.filename"), excelheadlinesMap, rowdatas);
				workbook.write(out);
				List<ExcelSaveEntity> excelSaveEntitys=new ArrayList<ExcelSaveEntity>();
				ExcelSaveEntity excelSaveEntity=new ExcelSaveEntity();
				excelSaveEntity.setFileName(fileName.toString());
				excelSaveEntity.setSubDirectory(UmsConfigInitiator.getDataConfig(KeyConstants.REPORT_ASSEMBLY_SCRAP_SUMMARY_DOWNLOAD_SUBDIRECTORY));
				excelSaveEntitys.add(excelSaveEntity);
				baseResponse.setReturnObjects(excelSaveEntitys);
				return JSON.toJSONString(baseResponse);
			} catch (Exception e) {
				logger.error(resourceUtils.getMessage("report.assemblyScrapSummary.controler.exportAssemblyScrapSummary.exception"),e);
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("report.assemblyScrapSummary.controler.exportAssemblyScrapSummary.exception")+":"+e.toString());
			}finally{
				IOUtils.close(out);
			}
	    }
		baseResponse.setReturnObjects(null);
		return JSON.toJSONString(baseResponse);
    }
}

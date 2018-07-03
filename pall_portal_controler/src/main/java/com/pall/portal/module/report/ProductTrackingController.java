package com.pall.portal.module.report;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.constants.KeyConstants;
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.common.support.excel.ExcelHeaderNode;
import com.pall.portal.common.tools.JSONTools;
import com.pall.portal.init.DataConfigInitiator;
import com.pall.portal.init.TableDataConfigInitiator;
import com.pall.portal.init.UmsConfigInitiator;
import com.pall.portal.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.portal.repository.entity.report.ProductTrackingQueryFormEntity;
import com.pall.portal.service.report.ReportSummaryService;
/*
 * 产出数量追踪控制器
 */
@Controller
public class ProductTrackingController{
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
	private ReportSummaryService reportSummaryService;
	
	@RequestMapping(value="/report/productTracking", method= RequestMethod.GET)
    public  String productTracking(Model model, HttpServletRequest request) {
		model.addAttribute("pnDataConfigs", DataConfigInitiator.getDataConfig(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_PARTNUM)));
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REPORT_PRODUCTTRACKING_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		List<ExcelHeaderNode> tableFieldBinds=new ArrayList<ExcelHeaderNode>();
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(UmsConfigInitiator.getDataConfig(KeyConstants.REPORT_PRODUCTTRACKING_TABLENAME));
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
	   return "report/productTracking";
    }
	/*
	 * 产出数量追踪管理
	 */
	@RequestMapping(value="report/productTracking", method= RequestMethod.POST)
	public @ResponseBody String productTracking(Model model,ProductTrackingQueryFormEntity productTrackingQueryFormEntity, HttpServletRequest request) {
        if(productTrackingQueryFormEntity.getPageSize()==0){
        	productTrackingQueryFormEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=reportSummaryService.queryProductTracking(productTrackingQueryFormEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("report.productTracking.controler.productTracking.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("report.productTracking.controler.productTracking.exception"));
			
		}
		 return jsonData;
    }
}

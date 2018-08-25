package com.pall.wdpts.module.trackinglist;

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
import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.constants.KeyConstants;
import com.pall.wdpts.common.i18n.ResourceUtils;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.common.support.excel.ExcelHeaderNode;
import com.pall.wdpts.common.tools.JSONTools;
import com.pall.wdpts.init.TableDataConfigInitiator;
import com.pall.wdpts.init.UmsConfigInitiator;
import com.pall.wdpts.interceptor.support.AuthToken;
import com.pall.wdpts.repository.entity.dataconfig.TableHeaderConfigEntity;
import com.pall.wdpts.repository.entity.menu.ButtonEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeFormQueryEntity;
import com.pall.wdpts.service.menu.ButtonManageService;
import com.pall.wdpts.service.trackinglist.MainframeAssembleService;

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
	private MainframeAssembleService mainframeAssembleService;
	/*
	 * 初始化配置数据
	 */
	private Model initConfigData(Model model){
		Map<Integer,List<TableHeaderConfigEntity>> tableHeaderConfigs=TableDataConfigInitiator.getTableHeaderConfig(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_MAINFRAME_TABLENAME));
		model.addAttribute("tableHeaderConfigs", tableHeaderConfigs);
		
		return model;
	}
	/*
	 * 主机装配管理
	 */
	@RequestMapping(value="trackinglist/mainframeManage", method= RequestMethod.GET)
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
	@RequestMapping(value="trackinglist/mainframeManage", method= RequestMethod.POST)
    public @ResponseBody String mainframeManage(Model model,MainframeFormQueryEntity  mainframeFormQueryEntity, HttpServletRequest request) {
        if(mainframeFormQueryEntity.getPageSize()==0){
        	mainframeFormQueryEntity.setPageSize(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.PAGE_DEFAULT_PAGE_SIZE)));
        }
        BaseTablesResponse baseResponse=new BaseTablesResponse();
        String jsonData="";
		try {
			baseResponse=mainframeAssembleService.queryMainframeAssembleList(mainframeFormQueryEntity);
			jsonData=JSON.toJSONString(baseResponse,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty,SerializerFeature.WriteNullNumberAsZero);
			if(IResponseConstants.RESPONSE_CODE_SUCCESS==baseResponse.getResultCode()){
				List<String> defectTypes=new ArrayList<String>();
				defectTypes.add(UmsConfigInitiator.getDataConfig(KeyConstants.TRACKINGLIST_MAINFRAME_TABLENAME));
				jsonData= JSONTools.defectsOverturnFiled(jsonData,defectTypes);
			}
		} catch (Exception e) {
			logger.error(resourceUtils.getMessage("mainframeAssemble.Controler.mainframeAssembleManage.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("mainframeAssemble.Controler.mainframeAssembleManage.exception"));
			
		}
		 return jsonData;
    }
}

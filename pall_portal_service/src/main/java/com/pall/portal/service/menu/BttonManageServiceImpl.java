package com.pall.portal.service.menu;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.datatables.Entity.DatatablesView;
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.repository.entity.menu.ButtonEntity;
import com.pall.portal.repository.entity.menu.ButtonQueryFormEntity;
import com.pall.portal.repository.mapper.menu.ButtonManageDao;
@Repository
public class BttonManageServiceImpl implements ButtonManageService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ButtonManageDao buttonManageDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseResponse delButton(List<String> menuids,List<String>  btnids) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			//删除菜单下的所有按钮信息
			buttonManageDao.delButton(menuids,btnids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("buttonManage.service.delButton.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("buttonManage.service.delButton.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseTablesResponse queryButtonList(ButtonQueryFormEntity buttonQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=buttonManageDao.queryButtonTotalRecords(buttonQueryFormEntity);
			//分页查询结果集
			List<ButtonEntity> buttonEntitys=buttonManageDao.queryButtonList(buttonQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(buttonQueryFormEntity.getDraw());
			if(buttonEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(buttonEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("buttonManage.service.queryButtonList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("buttonManage.service.queryButtonList.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse addButton(ButtonEntity buttonEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=buttonManageDao.addButton(buttonEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("buttonManage.dao.addButton.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("buttonManage.service.addButton.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("buttonManage.service.addButton.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse modButton(ButtonEntity buttonEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=buttonManageDao.modButton(buttonEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("buttonManage.dao.modButton.dao.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("buttonManage.service.modButton.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("buttonManage.service.modButton.service.exception")+e.toString());
		}
		return baseResponse;
	}
	
}

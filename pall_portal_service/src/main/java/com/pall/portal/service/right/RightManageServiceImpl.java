package com.pall.portal.service.right;

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
import com.pall.portal.repository.entity.right.RightEntity;
import com.pall.portal.repository.entity.right.RightQueryFormEntity;
import com.pall.portal.repository.mapper.right.RightManageDao;

/*
 * 权限管理服务
 */
@Repository
public class RightManageServiceImpl implements RightManageService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private RightManageDao rightManageDao;
	
	@Override
	public BaseTablesResponse queryRightList(RightQueryFormEntity  rightQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=rightManageDao.queryRightTotalRecords(rightQueryFormEntity);
			//分页查询结果集
			List<RightEntity> rightEntitys=rightManageDao.queryRightList(rightQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(rightQueryFormEntity.getDraw());
			if(rightEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(rightEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("rightmanage.service.queryRightList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("rightmanage.service.queryRightList.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delRight(List<String> rightids)  throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			rightManageDao.delRight(rightids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("rightManage.service.delRight.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("rightManage.service.delRight.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse addRight(RightEntity rightEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=rightManageDao.addRight(rightEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("rightManage.dao.addRight.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("rightManage.service.addRight.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("rightManage.service.addRight.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse modRight(RightEntity rightEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=rightManageDao.modRight(rightEntity);
			if(resultNum>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("rightManage.dao.modRight.dao.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("rightManage.service.modRight.service.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("rightManage.service.modRight.service.exception")+e.toString());
		}
		return baseResponse;
	}
}

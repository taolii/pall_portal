package com.pall.portal.service.reagentmixture;

import java.util.ArrayList;
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
import com.pall.portal.repository.entity.reagentmixture.ReagentMixtureEntity;
import com.pall.portal.repository.entity.reagentmixture.ReagentMixtureEntitySns;
import com.pall.portal.repository.entity.reagentmixture.ReagentMixtureQueryFormEntity;
import com.pall.portal.repository.entity.reagentmixture.ReagentMixtureSnsQueryFormEntity;
import com.pall.portal.repository.mapper.reagentmixture.ReagentMixtureManageDao;

/*
 * 试剂混合管理服务
 */
@Repository
public class ReagentMixtureManageServiceImpl implements ReagentMixtureManageService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	@Autowired
	private ReagentMixtureManageDao reagentMixtureManageDao;
	
	@Override
	public BaseTablesResponse queryReagentMixtureList(ReagentMixtureQueryFormEntity  reagentMixtureQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=reagentMixtureManageDao.queryReagentMixtureTotalRecords(reagentMixtureQueryFormEntity);
			//分页查询结果集
			List<ReagentMixtureEntity> reagentMixtureEntitys=reagentMixtureManageDao.queryReagentMixtureList(reagentMixtureQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(reagentMixtureQueryFormEntity.getDraw());
			if(reagentMixtureEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(reagentMixtureEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("reagentMixtureManage.service.queryReagentMixtureList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.service.queryReagentMixtureList.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseTablesResponse queryReagentSnsMixtureList(ReagentMixtureSnsQueryFormEntity  reagentMixtureSnsQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=reagentMixtureManageDao.queryReagentMixtureSnsTotalRecords(reagentMixtureSnsQueryFormEntity);
			//分页查询结果集
			List<ReagentMixtureEntitySns> reagentMixtureSnsEntitys=reagentMixtureManageDao.queryReagentSnsMixtureList(reagentMixtureSnsQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(reagentMixtureSnsQueryFormEntity.getDraw());
			if(reagentMixtureSnsEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(reagentMixtureSnsEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("reagentMixtureManage.service.queryReagentMixtureList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.service.queryReagentMixtureList.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delReagentMixture(List<String> rmids)  throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			reagentMixtureManageDao.delReagentMixtureSns(rmids);
			reagentMixtureManageDao.delReagentMixture(rmids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("reagentMixtureManage.service.delReagentMixture.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.service.delReagentMixture.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse addReagentMixture(ReagentMixtureEntity reagentMixtureEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=reagentMixtureManageDao.addReagentMixture(reagentMixtureEntity);
			if(resultNum>0){
				if(resultNum>0){
					//插入混合试剂信息
					if(reagentMixtureEntity.getReagentMixtureEntitySns()!=null && reagentMixtureEntity.getReagentMixtureEntitySns().size()>0){
						for(ReagentMixtureEntitySns reagentMixtureEntitySns:reagentMixtureEntity.getReagentMixtureEntitySns()){
							reagentMixtureEntitySns.setRmid(reagentMixtureEntity.getRmid());
						}
						resultNum=reagentMixtureManageDao.addReagentMixtureSns(reagentMixtureEntity.getReagentMixtureEntitySns());
					}
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.dao.addReagentMixture.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.dao.addReagentMixture.failed"));
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.dao.addReagentMixture.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("reagentMixtureManage.service.addReagentMixture.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.service.addReagentMixture.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse modReagentMixture(ReagentMixtureEntity reagentMixtureEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=reagentMixtureManageDao.modReagentMixture(reagentMixtureEntity);
			if(resultNum>0){
				List<String> lists=new ArrayList<String>();
				lists.add(String.valueOf(reagentMixtureEntity.getRmid()));
				reagentMixtureManageDao.delReagentMixtureSns(lists);
				if(reagentMixtureEntity.getReagentMixtureEntitySns()!=null && reagentMixtureEntity.getReagentMixtureEntitySns().size()>0){
					resultNum=reagentMixtureManageDao.addReagentMixtureSns(reagentMixtureEntity.getReagentMixtureEntitySns());
				}
				if(resultNum>0){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.dao.modReagentMixture.failed"));
					return baseResponse;
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.dao.modReagentMixture.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("reagentMixtureManage.service.modReagentMixture.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.service.modReagentMixture.exception")+e.toString());
		}
		return baseResponse;
	}
	@Override
	public BaseResponse queryReagentMixture(ReagentMixtureQueryFormEntity reagentMixtureQueryFormEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		List<ReagentMixtureEntity> reagentMixtureEntitys=new ArrayList<ReagentMixtureEntity>();
		try{
			//分页查询结果集
			reagentMixtureEntitys=reagentMixtureManageDao.queryReagentMixtureList(reagentMixtureQueryFormEntity);
			if(reagentMixtureEntitys==null){
				reagentMixtureEntitys=new ArrayList<ReagentMixtureEntity>();
			}else{
				for(ReagentMixtureEntity reagentMixtureEntity:reagentMixtureEntitys){
					List<String> rmids=new ArrayList<String>();
					rmids.add(String.valueOf(reagentMixtureEntity.getRmid()));
					reagentMixtureEntity.setReagentMixtureEntitySns(reagentMixtureManageDao.queryReagentMixtureSns(rmids));;
				}
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("reagentMixtureManage.service.queryReagentMixtureList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("reagentMixtureManage.service.queryReagentMixtureList.exception")+e.toString());
		}
		baseResponse.setReturnObjects(reagentMixtureEntitys);
		return baseResponse;
	}
}

package com.pall.wdpts.service.trackinglist;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.datatables.Entity.DatatablesView;
import com.pall.wdpts.common.i18n.ResourceUtils;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.trackinglist.CisternAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingFormQueryEntity;
import com.pall.wdpts.repository.mapper.trackinglist.CisternDao;

/*
 * 工作流服务接口
 */
@Repository
public class CisternServiceImpl implements CisternService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private CisternDao cisternDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseTablesResponse queryCisternList(CisternFormQueryEntity cisternFormQueryEntity)
			throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=cisternDao.queryCisternTotalRecords(cisternFormQueryEntity);
			//分页查询结果集
			List<CisternEntity> cisternAssembleEntitys=cisternDao.queryCisternList(cisternFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(cisternFormQueryEntity.getDraw());
			if(cisternAssembleEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(cisternAssembleEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cistern.service.queryCisternAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.queryCisternAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addCistern(CisternEntity cisternEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			CisternFormQueryEntity cisternFormQueryEntity=new CisternFormQueryEntity();
			cisternFormQueryEntity.setSerialNo(cisternEntity.getSerialNo());
			int records=cisternDao.queryCisternTotalRecords(cisternFormQueryEntity);
			if(records>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("cistern.form.serialNo.exists"));
				return baseResponse;
			}
			int resultNum=cisternDao.addCistern(cisternEntity);
			if(resultNum>0){
				//添加水箱装配配置信息
				List<CisternAssembleEntity> cisternAssembles=cisternEntity.getAssembleRecords();
				if(cisternAssembles!=null && cisternAssembles.size()>0){
					for(CisternAssembleEntity cisternAssembleEntity:cisternAssembles){
						cisternAssembleEntity.setCisternID(cisternEntity.getCisternID());
					}
					resultNum=cisternDao.addCisternAssembles(cisternAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("cistern.dao.addcistern.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("cistern.dao.addCistern.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cistern.service.addCistern.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.addCistern.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modifyCistern(CisternEntity cisternEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			CisternFormQueryEntity cisternFormQueryEntity=new CisternFormQueryEntity();;
			cisternFormQueryEntity.setStartPageNum(0);
			cisternFormQueryEntity.setPageSize(Integer.MAX_VALUE);
			cisternFormQueryEntity.setSerialNo(cisternEntity.getSerialNo());
			List<CisternEntity> cisternEntitys=cisternDao.queryCisternList(cisternFormQueryEntity);
			if(null!=cisternEntitys && cisternEntitys.size()>=1){
				if(cisternEntitys.size()==1 && cisternEntitys.get(0).getSerialNo().equals(cisternEntity.getSerialNo())){
					//更新本身不做处理
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("cistern.form.serialNo.exists"));
					return baseResponse;
				}
			}
			int resultNum=cisternDao.modCistern(cisternEntity);
			if(resultNum>0){
				List<Integer> cisternids=new ArrayList<Integer>();
				cisternids.add(cisternEntity.getCisternID());
				cisternDao.delCisternAssembles(cisternids);
				//添加水箱装配配置信息
				List<CisternAssembleEntity> cisternAssembles=cisternEntity.getAssembleRecords();
				if(cisternAssembles!=null && cisternAssembles.size()>0){
					for(CisternAssembleEntity cisternAssembleEntity:cisternAssembles){
						cisternAssembleEntity.setCisternID(cisternEntity.getCisternID());
					}
					resultNum=cisternDao.addCisternAssembles(cisternAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("cistern.dao.addcistern.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("cistern.dao.modCistern.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cistern.service.modCistern.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.modCistern.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse delCistern(List<Integer> cisternIDS) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			cisternDao.delCisternAssembles(cisternIDS);
			cisternDao.delCistern(cisternIDS);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cistern.service.delCistern.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.delCistern.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryCisternSettingList(
			CisternSettingFormQueryEntity cisternSettingFormQueryEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=cisternDao.queryCisternSettingTotalRecords(cisternSettingFormQueryEntity);
			//分页查询结果集
			List<CisternSettingEntity> cisternSettingEntitys=cisternDao.queryCisternSettingList(cisternSettingFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(cisternSettingFormQueryEntity.getDraw());
			if(cisternSettingEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(cisternSettingEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cistern.service.queryCisternSettingList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.queryCisternSettingList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addCisternSetting(CisternSettingEntity cisternSettingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			//判断cisternPn是否存在
			CisternSettingFormQueryEntity cisternSettingFormQueryEntity=new CisternSettingFormQueryEntity();
			cisternSettingFormQueryEntity.setCisternPn(cisternSettingEntity.getCisternPn());
			int records=cisternDao.queryCisternSettingTotalRecords(cisternSettingFormQueryEntity);
			if(records>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("cisternSetting.form.cisternPn.exists"));
				return baseResponse;
			}
			int resultNum=cisternDao.addCisternSetting(cisternSettingEntity);
			if(resultNum>0){
				//添加水箱装配配置信息
				List<CisternSettingAssembleEntity> cisternSettingAssembles=cisternSettingEntity.getCisternSettingAssembles();
				if(cisternSettingAssembles!=null && cisternSettingAssembles.size()>0){
					for(CisternSettingAssembleEntity cisternSettingAssembleEntity:cisternSettingAssembles){
						cisternSettingAssembleEntity.setCsid(cisternSettingEntity.getCsid());;
					}
					resultNum=cisternDao.addCisternSettingAssembles(cisternSettingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("cistern.dao.addCisternSettingAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("cistern.dao.addCisternSetting.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cistern.service.addCisternSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.addCisternSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modCisternSetting(CisternSettingEntity cisternSettingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			CisternSettingFormQueryEntity cisternSettingFormQueryEntity=new CisternSettingFormQueryEntity();
			cisternSettingFormQueryEntity.setCisternPn(cisternSettingEntity.getCisternPn());
			cisternSettingFormQueryEntity.setStartPageNum(0);
			cisternSettingFormQueryEntity.setPageSize(Integer.MAX_VALUE);
			List<CisternSettingEntity> cisternSettingEntitys=cisternDao.queryCisternSettingList(cisternSettingFormQueryEntity);
			if(null!=cisternSettingEntitys && cisternSettingEntitys.size()>=1){
				if(cisternSettingEntitys.size()==1 && cisternSettingEntitys.get(0).getCisternPn().equals(cisternSettingEntity.getCisternPn())){
					//更新本身不做处理
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("cisternSetting.form.cisternPn.exists"));
					return baseResponse;
				}
			}
			int resultNum=cisternDao.modCisternSetting(cisternSettingEntity);
			if(resultNum>0){
				List<Integer> csids=new ArrayList<Integer>();
				csids.add(cisternSettingEntity.getCsid());
				cisternDao.delCisternSettingAssembles(csids);
				//添加水箱装配配置信息
				List<CisternSettingAssembleEntity> cisternSettingAssembles=cisternSettingEntity.getCisternSettingAssembles();
				if(cisternSettingAssembles!=null && cisternSettingAssembles.size()>0){
					for(CisternSettingAssembleEntity cisternSettingAssembleEntity:cisternSettingAssembles){
						cisternSettingAssembleEntity.setCsid(cisternSettingEntity.getCsid());;
					}
					resultNum=cisternDao.addCisternSettingAssembles(cisternSettingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("cistern.dao.addCisternSettingAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("cistern.dao.modCisternSetting.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cistern.service.modCisternSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.modCisternSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse delCisternSetting(List<Integer> csids) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			cisternDao.delCisternSettingAssembles(csids);
			cisternDao.delCisternSetting(csids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cistern.service.delCisternSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.delCisternSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryCisternSettingAssembleList(String  csid) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<CisternSettingAssembleEntity> cisternSettingAssembles=cisternDao.queryCisternSettingAssembleList(csid);
			DatatablesView datatablesViews=new DatatablesView();
			if(cisternSettingAssembles!=null){
				datatablesViews.setiTotalDisplayRecords(cisternSettingAssembles.size());
				datatablesViews.setRecordsTotal(cisternSettingAssembles.size());
				datatablesViews.setData(cisternSettingAssembles);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cistern.service.queryCisternAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.queryCisternAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public CisternSettingEntity queryCisternSetting(String csid) throws Exception {
		CisternSettingEntity cisternSettingEntity=null;
		try{
			CisternSettingFormQueryEntity cisternSettingFormQuery=new CisternSettingFormQueryEntity();
			cisternSettingFormQuery.setPageSize(1);
			cisternSettingFormQuery.setStartPageNum(0);
			cisternSettingFormQuery.setCsid(csid);
			List<CisternSettingEntity> cisternSettingEntitys=cisternDao.queryCisternSettingList(cisternSettingFormQuery);
			if(cisternSettingEntitys!=null && cisternSettingEntitys.size()>0){
				cisternSettingEntity=cisternSettingEntitys.get(0);
				cisternSettingEntity.setCisternSettingAssembles(cisternDao.queryCisternSettingAssembleList(csid));
			}
		}catch(Exception e){
			throw e;
		}
		return cisternSettingEntity;
	}

	@Override
	public CisternEntity queryCistern(String cisternID) throws Exception {
		CisternEntity cisternEntity=null;
		try{
			CisternFormQueryEntity cisternFormQuery=new CisternFormQueryEntity();
			cisternFormQuery.setPageSize(1);
			cisternFormQuery.setStartPageNum(0);
			cisternFormQuery.setCisternID(cisternID);
			List<CisternEntity> cisternEntitys=cisternDao.queryCisternList(cisternFormQuery);
			if(cisternEntitys!=null && cisternEntitys.size()>0){
				cisternEntity=cisternEntitys.get(0);
				cisternEntity.setAssembleRecords(cisternDao.queryCisternAssembleList(cisternID));
			}
		}catch(Exception e){
			throw e;
		}
		return cisternEntity;
	}

	@Override
	public BaseTablesResponse queryCisternAssembleList(String cisternID) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<CisternAssembleEntity> cisternAssembles=cisternDao.queryCisternAssembleList(cisternID);
			DatatablesView datatablesViews=new DatatablesView();
			if(cisternAssembles!=null){
				datatablesViews.setiTotalDisplayRecords(cisternAssembles.size());
				datatablesViews.setRecordsTotal(cisternAssembles.size());
				datatablesViews.setData(cisternAssembles);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cistern.service.queryCisternAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cistern.service.queryCisternAssembleList.exception"));
		}
		return baseResponse;
	}
}

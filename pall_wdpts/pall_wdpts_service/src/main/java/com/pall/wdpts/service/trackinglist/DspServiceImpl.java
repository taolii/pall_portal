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
import com.pall.wdpts.repository.entity.trackinglist.DspAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingFormQueryEntity;
import com.pall.wdpts.repository.mapper.trackinglist.DspDao;

/*
 * 工作流服务接口
 */
@Repository
public class DspServiceImpl implements  DspService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private DspDao dspDao;
	@Autowired
	private ResourceUtils resourceUtils;

	@Override
	public BaseTablesResponse queryDspList(DspFormQueryEntity dspFormQueryEntity)
			throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=dspDao.queryDspTotalRecords(dspFormQueryEntity);
			//分页查询结果集
			List<DspEntity> dspAssembleEntitys=dspDao.queryDspList(dspFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(dspFormQueryEntity.getDraw());
			if(dspAssembleEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(dspAssembleEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dsp.service.queryDspAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.queryDspAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addDsp(DspEntity dspEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=dspDao.addDsp(dspEntity);
			if(resultNum>0){
				//添加Dsp装配配置信息
				List<DspAssembleEntity> dspAssembles=dspEntity.getAssembleRecords();
				if(dspAssembles!=null && dspAssembles.size()>0){
					for(DspAssembleEntity dspAssembleEntity:dspAssembles){
						dspAssembleEntity.setDspID(dspEntity.getDspID());
					}
					resultNum=dspDao.addDspAssembles(dspAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("dsp.dao.adddsp.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("dsp.dao.addDsp.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dsp.service.addDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.addDsp.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modifyDsp(DspEntity dspEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=dspDao.modDsp(dspEntity);
			if(resultNum>0){
				List<Integer> dspids=new ArrayList<Integer>();
				dspids.add(dspEntity.getDspID());
				dspDao.delDspAssembles(dspids);
				//添加Dsp装配配置信息
				List<DspAssembleEntity> dspAssembles=dspEntity.getAssembleRecords();
				if(dspAssembles!=null && dspAssembles.size()>0){
					for(DspAssembleEntity dspAssembleEntity:dspAssembles){
						dspAssembleEntity.setDspID(dspEntity.getDspID());
					}
					resultNum=dspDao.addDspAssembles(dspAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("dsp.dao.adddsp.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
				
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("dsp.dao.modDsp.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dsp.service.modDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.modDsp.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse delDsp(List<Integer> dspIDS) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			dspDao.delDspAssembles(dspIDS);
			dspDao.delDsp(dspIDS);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dsp.service.delDsp.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.delDsp.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryDspSettingList(
			DspSettingFormQueryEntity dspSettingFormQueryEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=dspDao.queryDspSettingTotalRecords(dspSettingFormQueryEntity);
			//分页查询结果集
			List<DspSettingEntity> dspSettingEntitys=dspDao.queryDspSettingList(dspSettingFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(dspSettingFormQueryEntity.getDraw());
			if(dspSettingEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(dspSettingEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dsp.service.queryDspSettingList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.queryDspSettingList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addDspSetting(DspSettingEntity dspSettingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			//判断dspPn是否存在
			DspSettingFormQueryEntity dspSettingFormQueryEntity=new DspSettingFormQueryEntity();
			dspSettingFormQueryEntity.setDspPn(dspSettingEntity.getDspPn());
			int records=dspDao.queryDspSettingTotalRecords(dspSettingFormQueryEntity);
			if(records>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("dspSetting.form.dspPn.exists"));
				return baseResponse;
			}
			int resultNum=dspDao.addDspSetting(dspSettingEntity);
			if(resultNum>0){
				//添加Dsp装配配置信息
				List<DspSettingAssembleEntity> dspSettingAssembles=dspSettingEntity.getDspSettingAssembles();
				if(dspSettingAssembles!=null && dspSettingAssembles.size()>0){
					for(DspSettingAssembleEntity dspSettingAssembleEntity:dspSettingAssembles){
						dspSettingAssembleEntity.setDsid(dspSettingEntity.getDsid());;
					}
					resultNum=dspDao.addDspSettingAssembles(dspSettingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("dsp.dao.addDspSettingAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("dsp.dao.addDspSetting.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dsp.service.addDspSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.addDspSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modDspSetting(DspSettingEntity dspSettingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=dspDao.modDspSetting(dspSettingEntity);
			if(resultNum>0){
				List<Integer> dspids=new ArrayList<Integer>();
				dspids.add(dspSettingEntity.getDsid());
				dspDao.delDspSettingAssembles(dspids);
				//添加Dsp装配配置信息
				List<DspSettingAssembleEntity> dspSettingAssembles=dspSettingEntity.getDspSettingAssembles();
				if(dspSettingAssembles!=null && dspSettingAssembles.size()>0){
					for(DspSettingAssembleEntity dspSettingAssembleEntity:dspSettingAssembles){
						dspSettingAssembleEntity.setDsid(dspSettingEntity.getDsid());;
					}
					resultNum=dspDao.addDspSettingAssembles(dspSettingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("dsp.dao.addDspSettingAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("dsp.dao.modDspSetting.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dsp.service.modDspSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.modDspSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse delDspSetting(List<Integer> dspids) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			dspDao.delDspSettingAssembles(dspids);
			dspDao.delDspSetting(dspids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dsp.service.delDspSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.delDspSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryDspSettingAssembleList(String dspid) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<DspSettingAssembleEntity> dspSettingAssembles=dspDao.queryDspSettingAssembleList(dspid);
			DatatablesView datatablesViews=new DatatablesView();
			if(dspSettingAssembles!=null){
				datatablesViews.setiTotalDisplayRecords(dspSettingAssembles.size());
				datatablesViews.setRecordsTotal(dspSettingAssembles.size());
				datatablesViews.setData(dspSettingAssembles);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dsp.service.queryDspAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.queryDspAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public DspSettingEntity queryDspSetting(String dsid) throws Exception {
		DspSettingEntity dspSettingEntity=null;
		try{
			DspSettingFormQueryEntity dspSettingFormQuery=new DspSettingFormQueryEntity();
			dspSettingFormQuery.setPageSize(1);
			dspSettingFormQuery.setStartPageNum(0);
			dspSettingFormQuery.setDsid(dsid);
			List<DspSettingEntity> dspSettingEntitys=dspDao.queryDspSettingList(dspSettingFormQuery);
			if(dspSettingEntitys!=null && dspSettingEntitys.size()>0){
				dspSettingEntity=dspSettingEntitys.get(0);
				dspSettingEntity.setDspSettingAssembles(dspDao.queryDspSettingAssembleList(dsid));
			}
		}catch(Exception e){
			throw e;
		}
		return dspSettingEntity;
	}

	@Override
	public DspEntity queryDsp(String dspID) throws Exception {
		DspEntity dspEntity=null;
		try{
			DspFormQueryEntity dspFormQuery=new DspFormQueryEntity();
			dspFormQuery.setPageSize(1);
			dspFormQuery.setStartPageNum(0);
			dspFormQuery.setDspID(dspID);
			List<DspEntity> dspEntitys=dspDao.queryDspList(dspFormQuery);
			if(dspEntitys!=null && dspEntitys.size()>0){
				dspEntity=dspEntitys.get(0);
				dspEntity.setAssembleRecords(dspDao.queryDspAssembleList(dspID));
			}
		}catch(Exception e){
			throw e;
		}
		return dspEntity;
	}

	@Override
	public BaseTablesResponse queryDspAssembleList(String dspID) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<DspAssembleEntity> dspAssembles=dspDao.queryDspAssembleList(dspID);
			DatatablesView datatablesViews=new DatatablesView();
			if(dspAssembles!=null){
				datatablesViews.setiTotalDisplayRecords(dspAssembles.size());
				datatablesViews.setRecordsTotal(dspAssembles.size());
				datatablesViews.setData(dspAssembles);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("dsp.service.queryDspAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("dsp.service.queryDspAssembleList.exception"));
		}
		return baseResponse;
	}
}

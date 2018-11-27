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
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingInspectEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingInspectEntity;
import com.pall.wdpts.repository.mapper.trackinglist.PreprocessingDao;

/*
 * 工作流服务接口
 */
@Repository
public class PreprocessingServiceImpl implements  PreprocessingService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private PreprocessingDao preprocessingDao;
	@Autowired
	private ResourceUtils resourceUtils;
	
	@Override
	public BaseTablesResponse queryPreprocessingList(
			PreprocessingFormQueryEntity preprocessingAssembleFormQueryEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=preprocessingDao.queryPreprocessingTotalRecords(preprocessingAssembleFormQueryEntity);
			//分页查询结果集
			List<PreprocessingEntity> preprocessingAssembleEntitys=preprocessingDao.queryPreprocessingList(preprocessingAssembleFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(preprocessingAssembleFormQueryEntity.getDraw());
			if(preprocessingAssembleEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(preprocessingAssembleEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.queryPreprocessingList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.queryPreprocessingList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addPreprocessing(PreprocessingEntity preprocessingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			PreprocessingFormQueryEntity preprocessingFormQueryEntity=new PreprocessingFormQueryEntity();
			preprocessingFormQueryEntity.setSerialNo(preprocessingEntity.getSerialNo());
			int records=preprocessingDao.queryPreprocessingTotalRecords(preprocessingFormQueryEntity);
			if(records>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.form.serialNo.exists"));
				return baseResponse;
			}
			int resultNum=preprocessingDao.addPreprocessing(preprocessingEntity);
			if(resultNum>0){
				//添加预处理装配配置信息
				List<PreprocessingAssembleEntity> preprocessingAssembles=preprocessingEntity.getAssembleRecords();
				if(preprocessingAssembles!=null && preprocessingAssembles.size()>0){
					for(PreprocessingAssembleEntity preprocessingAssembleEntity:preprocessingAssembles){
						preprocessingAssembleEntity.setPreprocessingID(preprocessingEntity.getPreprocessingID());
					}
					resultNum=preprocessingDao.addPreprocessingAssembles(preprocessingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.addPreprocessingAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
				//添加预处理送检配置信息
				List<PreprocessingInspectEntity> preprocessingInspects=preprocessingEntity.getInspectRecords();
				if(preprocessingInspects!=null && preprocessingInspects.size()>0){
					for(PreprocessingInspectEntity preprocessingInspectEntity:preprocessingInspects){
						preprocessingInspectEntity.setPreprocessingID(preprocessingEntity.getPreprocessingID());
					}
					resultNum=preprocessingDao.addPreprocessingInspects(preprocessingInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.addPreprocessingInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.addPreprocessing.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.addPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.addPreprocessing.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modifyPreprocessing(PreprocessingEntity preprocessingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			PreprocessingFormQueryEntity preprocessingFormQueryEntity=new PreprocessingFormQueryEntity();;
			preprocessingFormQueryEntity.setStartPageNum(0);
			preprocessingFormQueryEntity.setPageSize(Integer.MAX_VALUE);
			preprocessingFormQueryEntity.setSerialNo(preprocessingEntity.getSerialNo());
			List<PreprocessingEntity> preprocessingEntitys=preprocessingDao.queryPreprocessingList(preprocessingFormQueryEntity);
			if(null!=preprocessingEntitys && preprocessingEntitys.size()>=1){
				if(preprocessingEntitys.size()==1 && preprocessingEntitys.get(0).getSerialNo().equals(preprocessingEntity.getSerialNo())){
					//更新本身不做处理
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.form.serialNo.exists"));
					return baseResponse;
				}
			}
			int resultNum=preprocessingDao.modPreprocessing(preprocessingEntity);
			if(resultNum>0){
				List<Integer> preprocessingids=new ArrayList<Integer>();
				preprocessingids.add(preprocessingEntity.getPreprocessingID());
				preprocessingDao.delPreprocessingAssembles(preprocessingids);
				preprocessingDao.delPreprocessingInspects(preprocessingids);
				//添加预处理装配配置信息
				List<PreprocessingAssembleEntity> preprocessingAssembles=preprocessingEntity.getAssembleRecords();
				if(preprocessingAssembles!=null && preprocessingAssembles.size()>0){
					for(PreprocessingAssembleEntity preprocessingAssembleEntity:preprocessingAssembles){
						preprocessingAssembleEntity.setPreprocessingID(preprocessingEntity.getPreprocessingID());
					}
					resultNum=preprocessingDao.addPreprocessingAssembles(preprocessingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.addPreprocessingAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
				//添加预处理送检配置信息
				List<PreprocessingInspectEntity> preprocessingInspects=preprocessingEntity.getInspectRecords();
				if(preprocessingInspects!=null && preprocessingInspects.size()>0){
					for(PreprocessingInspectEntity preprocessingInspectEntity:preprocessingInspects){
						preprocessingInspectEntity.setPreprocessingID(preprocessingEntity.getPreprocessingID());
					}
					resultNum=preprocessingDao.addPreprocessingInspects(preprocessingInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.addPreprocessingInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.modPreprocessing.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.modPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.modPreprocessing.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse delPreprocessing(List<Integer> preprocessingIDS) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			preprocessingDao.delPreprocessingInspects(preprocessingIDS);
			preprocessingDao.delPreprocessingAssembles(preprocessingIDS);
			preprocessingDao.delPreprocessing(preprocessingIDS);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.delPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.delPreprocessing.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryPreprocessingSettingList(
			PreprocessingSettingFormQueryEntity preprocessingSettingFormQueryEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=preprocessingDao.queryPreprocessingSettingTotalRecords(preprocessingSettingFormQueryEntity);
			//分页查询结果集
			List<PreprocessingSettingEntity> preprocessingSettingEntitys=preprocessingDao.queryPreprocessingSettingList(preprocessingSettingFormQueryEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(preprocessingSettingFormQueryEntity.getDraw());
			if(preprocessingSettingEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(preprocessingSettingEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.queryPreprocessingSettingList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.queryPreprocessingSettingList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addPreprocessingSetting(PreprocessingSettingEntity preprocessingSettingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			//判断preprocessingPn是否存在
			PreprocessingSettingFormQueryEntity preprocessingSettingFormQueryEntity=new PreprocessingSettingFormQueryEntity();
			preprocessingSettingFormQueryEntity.setPreprocessingPn(preprocessingSettingEntity.getPreprocessingPn());
			int records=preprocessingDao.queryPreprocessingSettingTotalRecords(preprocessingSettingFormQueryEntity);
			if(records>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingSetting.form.preprocessingPn.exists"));
				return baseResponse;
			}
			int resultNum=preprocessingDao.addPreprocessingSetting(preprocessingSettingEntity);
			if(resultNum>0){
				//添加预处理装配配置信息
				List<PreprocessingSettingAssembleEntity> preprocessingSettingAssembles=preprocessingSettingEntity.getPreprocessingSettingAssembles();
				if(preprocessingSettingAssembles!=null && preprocessingSettingAssembles.size()>0){
					for(PreprocessingSettingAssembleEntity preprocessingSettingAssembleEntity:preprocessingSettingAssembles){
						preprocessingSettingAssembleEntity.setPsid(preprocessingSettingEntity.getPsid());;
					}
					resultNum=preprocessingDao.addPreprocessingSettingAssembles(preprocessingSettingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.addPreprocessingSettingAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
				//添加预处理送检配置信息
				List<PreprocessingSettingInspectEntity> preprocessingSettingInspects=preprocessingSettingEntity.getPreprocessingSettingInspects();
				if(preprocessingSettingInspects!=null && preprocessingSettingInspects.size()>0){
					for(PreprocessingSettingInspectEntity preprocessingSettingInspectEntity:preprocessingSettingInspects){
						preprocessingSettingInspectEntity.setPsid(preprocessingSettingEntity.getPsid());;
					}
					resultNum=preprocessingDao.addPreprocessingSettingInspects(preprocessingSettingInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.addPreprocessingSettingInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.addPreprocessingSetting.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.addPreprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.addPreprocessingSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modPreprocessingSetting(PreprocessingSettingEntity preprocessingSettingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			PreprocessingSettingFormQueryEntity preprocessingSettingFormQueryEntity=new PreprocessingSettingFormQueryEntity();
			preprocessingSettingFormQueryEntity.setPreprocessingPn(preprocessingSettingEntity.getPreprocessingPn());
			preprocessingSettingFormQueryEntity.setStartPageNum(0);
			preprocessingSettingFormQueryEntity.setPageSize(Integer.MAX_VALUE);
			List<PreprocessingSettingEntity> preprocessingSettingEntitys=preprocessingDao.queryPreprocessingSettingList(preprocessingSettingFormQueryEntity);
			if(null!=preprocessingSettingEntitys && preprocessingSettingEntitys.size()>=1){
				if(preprocessingSettingEntitys.size()==1 && preprocessingSettingEntitys.get(0).getPreprocessingPn().equals(preprocessingSettingEntity.getPreprocessingPn())){
					//更新本身不做处理
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingSetting.form.preprocessingPn.exists"));
					return baseResponse;
				}
			}
			int resultNum=preprocessingDao.modPreprocessingSetting(preprocessingSettingEntity);
			if(resultNum>0){
				List<Integer> psids=new ArrayList<Integer>();
				psids.add(preprocessingSettingEntity.getPsid());
				preprocessingDao.delPreprocessingSettingAssembles(psids);
				preprocessingDao.delPreprocessingSettingInspects(psids);
				//添加预处理装配配置信息
				List<PreprocessingSettingAssembleEntity> preprocessingSettingAssembles=preprocessingSettingEntity.getPreprocessingSettingAssembles();
				if(preprocessingSettingAssembles!=null && preprocessingSettingAssembles.size()>0){
					for(PreprocessingSettingAssembleEntity preprocessingSettingAssembleEntity:preprocessingSettingAssembles){
						preprocessingSettingAssembleEntity.setPsid(preprocessingSettingEntity.getPsid());;
					}
					resultNum=preprocessingDao.addPreprocessingSettingAssembles(preprocessingSettingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.addPreprocessingSettingAssemble.failed"));
						return baseResponse;
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
				//添加预处理送检配置信息
				List<PreprocessingSettingInspectEntity> preprocessingSettingInspects=preprocessingSettingEntity.getPreprocessingSettingInspects();
				if(preprocessingSettingInspects!=null && preprocessingSettingInspects.size()>0){
					for(PreprocessingSettingInspectEntity preprocessingSettingInspectEntity:preprocessingSettingInspects){
						preprocessingSettingInspectEntity.setPsid(preprocessingSettingEntity.getPsid());;
					}
					resultNum=preprocessingDao.addPreprocessingSettingInspects(preprocessingSettingInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.addPreprocessingSettingInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.dao.modPreprocessingSetting.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.modPreprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.modPreprocessingSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse delPreprocessingSetting(List<Integer> psids) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			preprocessingDao.delPreprocessingSettingInspects(psids);
			preprocessingDao.delPreprocessingSettingAssembles(psids);
			preprocessingDao.delPreprocessingSetting(psids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.delPreprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.delPreprocessingSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryPreprocessingSettingAssembleList(String psid) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<PreprocessingSettingAssembleEntity> preprocessingSettingAssembles=preprocessingDao.queryPreprocessingSettingAssembleList(psid);
			DatatablesView datatablesViews=new DatatablesView();
			if(preprocessingSettingAssembles!=null){
				datatablesViews.setiTotalDisplayRecords(preprocessingSettingAssembles.size());
				datatablesViews.setRecordsTotal(preprocessingSettingAssembles.size());
				datatablesViews.setData(preprocessingSettingAssembles);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.queryPreprocessingSettingAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.queryPreprocessingSettingAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryPreprocessingSettingInspectList(String  psid) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<PreprocessingSettingInspectEntity> preprocessingSettingInspects=preprocessingDao.queryPreprocessingSettingInspectList(psid);
			DatatablesView datatablesViews=new DatatablesView();
			if(preprocessingSettingInspects!=null){
				datatablesViews.setiTotalDisplayRecords(preprocessingSettingInspects.size());
				datatablesViews.setRecordsTotal(preprocessingSettingInspects.size());
				datatablesViews.setData(preprocessingSettingInspects);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.queryPreprocessingSettingInspectList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.queryPreprocessingSettingInspectList.exception"));
		}
		return baseResponse;
	}

	@Override
	public PreprocessingSettingEntity queryPreprocessingSetting(String psid) throws Exception {
		PreprocessingSettingEntity preprocessingSettingEntity=null;
		try{
			PreprocessingSettingFormQueryEntity preprocessingSettingFormQuery=new PreprocessingSettingFormQueryEntity();
			preprocessingSettingFormQuery.setPageSize(1);
			preprocessingSettingFormQuery.setStartPageNum(0);
			preprocessingSettingFormQuery.setPsid(psid);
			List<PreprocessingSettingEntity> preprocessingSettingEntitys=preprocessingDao.queryPreprocessingSettingList(preprocessingSettingFormQuery);
			if(preprocessingSettingEntitys!=null && preprocessingSettingEntitys.size()>0){
				preprocessingSettingEntity=preprocessingSettingEntitys.get(0);
				preprocessingSettingEntity.setPreprocessingSettingAssembles(preprocessingDao.queryPreprocessingSettingAssembleList(psid));
				preprocessingSettingEntity.setPreprocessingSettingInspects(preprocessingDao.queryPreprocessingSettingInspectList(psid));
			}
		}catch(Exception e){
			throw e;
		}
		return preprocessingSettingEntity;
	}

	@Override
	public PreprocessingEntity queryPreprocessing(String preprocessingID) throws Exception {
		PreprocessingEntity preprocessingEntity=null;
		try{
			PreprocessingFormQueryEntity preprocessingFormQuery=new PreprocessingFormQueryEntity();
			preprocessingFormQuery.setPageSize(1);
			preprocessingFormQuery.setStartPageNum(0);
			preprocessingFormQuery.setPreprocessingID(preprocessingID);
			List<PreprocessingEntity> preprocessingEntitys=preprocessingDao.queryPreprocessingList(preprocessingFormQuery);
			if(preprocessingEntitys!=null && preprocessingEntitys.size()>0){
				preprocessingEntity=preprocessingEntitys.get(0);
				preprocessingEntity.setAssembleRecords(preprocessingDao.queryPreprocessingAssembleList(preprocessingID));
				preprocessingEntity.setInspectRecords(preprocessingDao.queryPreprocessingInspectList(preprocessingID));
			}
		}catch(Exception e){
			throw e;
		}
		return preprocessingEntity;
	}

	@Override
	public BaseTablesResponse queryPreprocessingAssembleList(String preprocessingID) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<PreprocessingAssembleEntity> preprocessingAssembles=preprocessingDao.queryPreprocessingAssembleList(preprocessingID);
			DatatablesView datatablesViews=new DatatablesView();
			if(preprocessingAssembles!=null){
				datatablesViews.setiTotalDisplayRecords(preprocessingAssembles.size());
				datatablesViews.setRecordsTotal(preprocessingAssembles.size());
				datatablesViews.setData(preprocessingAssembles);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.queryPreprocessingAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.queryPreprocessingAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryPreprocessingInspectList(String preprocessingID) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<PreprocessingInspectEntity> preprocessingInspects=preprocessingDao.queryPreprocessingInspectList(preprocessingID);
			DatatablesView datatablesViews=new DatatablesView();
			if(preprocessingInspects!=null){
				datatablesViews.setiTotalDisplayRecords(preprocessingInspects.size());
				datatablesViews.setRecordsTotal(preprocessingInspects.size());
				datatablesViews.setData(preprocessingInspects);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessing.service.queryPreprocessingInspectList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessing.service.queryPreprocessingInspectList.exception"));
		}
		return baseResponse;
	}
	@Override
	public List<PreprocessingEntity> exportPreprocessingList(PreprocessingFormQueryEntity preprocessingFormQueryEntity) throws Exception {
		List<PreprocessingEntity> preprocessingEntitys=null;
		try{
			preprocessingFormQueryEntity.setStartPageNum(0);
			//查询总记录数
			int totalRecords=preprocessingDao.queryPreprocessingTotalRecords(preprocessingFormQueryEntity);
			if(totalRecords==0){
				return new ArrayList<PreprocessingEntity>();
			}
			//分页查询结果集
			preprocessingFormQueryEntity.setPageSize(totalRecords);
			preprocessingEntitys=preprocessingDao.queryPreprocessingList(preprocessingFormQueryEntity);
		}catch(Exception e){
			throw e;
		}
		return preprocessingEntitys;
	}
}

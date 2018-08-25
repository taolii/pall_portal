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
import com.pall.wdpts.repository.mapper.trackinglist.PreprocessingAssembleDao;

/*
 * 工作流服务接口
 */
@Repository
public class PreprocessingAssembleServiceImpl implements  PreprocessingAssembleService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private PreprocessingAssembleDao preprocessingAssembleDao;
	@Autowired
	private ResourceUtils resourceUtils;
	
	@Override
	public BaseTablesResponse queryPreprocessingList(
			PreprocessingFormQueryEntity preprocessingAssembleFormQueryEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=preprocessingAssembleDao.queryPreprocessingTotalRecords(preprocessingAssembleFormQueryEntity);
			//分页查询结果集
			List<PreprocessingEntity> preprocessingAssembleEntitys=preprocessingAssembleDao.queryPreprocessingList(preprocessingAssembleFormQueryEntity);
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
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse addPreprocessing(PreprocessingEntity preprocessingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=preprocessingAssembleDao.addPreprocessing(preprocessingEntity);
			if(resultNum>0){
				//添加预处理装配配置信息
				List<PreprocessingAssembleEntity> preprocessingAssembles=preprocessingEntity.getAssembleRecords();
				if(preprocessingAssembles!=null && preprocessingAssembles.size()>0){
					for(PreprocessingAssembleEntity preprocessingAssembleEntity:preprocessingAssembles){
						preprocessingAssembleEntity.setPreprocessingID(preprocessingEntity.getPreprocessingID());
					}
					resultNum=preprocessingAssembleDao.addPreprocessingAssembles(preprocessingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.addPreprocessingAssemble.failed"));
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
					resultNum=preprocessingAssembleDao.addPreprocessingInspects(preprocessingInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.addPreprocessingInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.addPreprocessing.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.addPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.addPreprocessing.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modifyPreprocessing(PreprocessingEntity preprocessingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=preprocessingAssembleDao.modPreprocessing(preprocessingEntity);
			if(resultNum>0){
				List<Integer> preprocessingids=new ArrayList<Integer>();
				preprocessingids.add(preprocessingEntity.getPreprocessingID());
				preprocessingAssembleDao.delPreprocessingAssembles(preprocessingids);
				preprocessingAssembleDao.delPreprocessingInspects(preprocessingids);
				//添加预处理装配配置信息
				List<PreprocessingAssembleEntity> preprocessingAssembles=preprocessingEntity.getAssembleRecords();
				if(preprocessingAssembles!=null && preprocessingAssembles.size()>0){
					for(PreprocessingAssembleEntity preprocessingAssembleEntity:preprocessingAssembles){
						preprocessingAssembleEntity.setPreprocessingID(preprocessingEntity.getPreprocessingID());
					}
					resultNum=preprocessingAssembleDao.addPreprocessingAssembles(preprocessingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.addPreprocessingAssemble.failed"));
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
					resultNum=preprocessingAssembleDao.addPreprocessingInspects(preprocessingInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.addPreprocessingInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.modPreprocessing.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.modPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.modPreprocessing.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse delPreprocessing(List<Integer> preprocessingIDS) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			preprocessingAssembleDao.delPreprocessingInspects(preprocessingIDS);
			preprocessingAssembleDao.delPreprocessingAssembles(preprocessingIDS);
			preprocessingAssembleDao.delPreprocessing(preprocessingIDS);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.delPreprocessing.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.delPreprocessing.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse exportPreprocessing(
			PreprocessingFormQueryEntity preprocessingAssembleFormQueryEntity) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BaseTablesResponse queryPreprocessingSettingList(
			PreprocessingSettingFormQueryEntity preprocessingSettingFormQueryEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=preprocessingAssembleDao.queryPreprocessingSettingTotalRecords(preprocessingSettingFormQueryEntity);
			//分页查询结果集
			List<PreprocessingSettingEntity> preprocessingSettingEntitys=preprocessingAssembleDao.queryPreprocessingSettingList(preprocessingSettingFormQueryEntity);
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
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingSettingList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingSettingList.exception"));
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
			int records=preprocessingAssembleDao.queryPreprocessingSettingTotalRecords(preprocessingSettingFormQueryEntity);
			if(records>0){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingSetting.form.preprocessingPn.exists"));
				return baseResponse;
			}
			int resultNum=preprocessingAssembleDao.addPreprocessingSetting(preprocessingSettingEntity);
			if(resultNum>0){
				//添加预处理装配配置信息
				List<PreprocessingSettingAssembleEntity> preprocessingSettingAssembles=preprocessingSettingEntity.getPreprocessingSettingAssembles();
				if(preprocessingSettingAssembles!=null && preprocessingSettingAssembles.size()>0){
					for(PreprocessingSettingAssembleEntity preprocessingSettingAssembleEntity:preprocessingSettingAssembles){
						preprocessingSettingAssembleEntity.setPsid(preprocessingSettingEntity.getPsid());;
					}
					resultNum=preprocessingAssembleDao.addPreprocessingSettingAssembles(preprocessingSettingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.addPreprocessingSettingAssemble.failed"));
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
					resultNum=preprocessingAssembleDao.addPreprocessingSettingInspects(preprocessingSettingInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.addPreprocessingSettingInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.addPreprocessingSetting.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.addPreprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.addPreprocessingSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse modPreprocessingSetting(PreprocessingSettingEntity preprocessingSettingEntity)
			throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=preprocessingAssembleDao.modPreprocessingSetting(preprocessingSettingEntity);
			if(resultNum>0){
				List<Integer> psids=new ArrayList<Integer>();
				psids.add(preprocessingSettingEntity.getPsid());
				preprocessingAssembleDao.delPreprocessingSettingAssembles(psids);
				preprocessingAssembleDao.delPreprocessingSettingInspects(psids);
				//添加预处理装配配置信息
				List<PreprocessingSettingAssembleEntity> preprocessingSettingAssembles=preprocessingSettingEntity.getPreprocessingSettingAssembles();
				if(preprocessingSettingAssembles!=null && preprocessingSettingAssembles.size()>0){
					for(PreprocessingSettingAssembleEntity preprocessingSettingAssembleEntity:preprocessingSettingAssembles){
						preprocessingSettingAssembleEntity.setPsid(preprocessingSettingEntity.getPsid());;
					}
					resultNum=preprocessingAssembleDao.addPreprocessingSettingAssembles(preprocessingSettingAssembles);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.addPreprocessingSettingAssemble.failed"));
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
					resultNum=preprocessingAssembleDao.addPreprocessingSettingInspects(preprocessingSettingInspects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.addPreprocessingSettingInspect.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.dao.modPreprocessingSetting.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.modPreprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.modPreprocessingSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseResponse delPreprocessingSetting(List<Integer> psids) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			preprocessingAssembleDao.delPreprocessingSettingInspects(psids);
			preprocessingAssembleDao.delPreprocessingSettingAssembles(psids);
			preprocessingAssembleDao.delPreprocessingSetting(psids);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.delPreprocessingSetting.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.delPreprocessingSetting.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryPreprocessingSettingAssembleList(String psid) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<PreprocessingSettingAssembleEntity> preprocessingSettingAssembles=preprocessingAssembleDao.queryPreprocessingSettingAssembleList(psid);
			DatatablesView datatablesViews=new DatatablesView();
			if(preprocessingSettingAssembles!=null){
				datatablesViews.setiTotalDisplayRecords(preprocessingSettingAssembles.size());
				datatablesViews.setRecordsTotal(preprocessingSettingAssembles.size());
				datatablesViews.setData(preprocessingSettingAssembles);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryPreprocessingSettingInspectList(String psid) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<PreprocessingSettingInspectEntity> preprocessingSettingInspects=preprocessingAssembleDao.queryPreprocessingSettingInspectList(psid);
			DatatablesView datatablesViews=new DatatablesView();
			if(preprocessingSettingInspects!=null){
				datatablesViews.setiTotalDisplayRecords(preprocessingSettingInspects.size());
				datatablesViews.setRecordsTotal(preprocessingSettingInspects.size());
				datatablesViews.setData(preprocessingSettingInspects);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingAssembleList.exception"));
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
			List<PreprocessingSettingEntity> preprocessingSettingEntitys=preprocessingAssembleDao.queryPreprocessingSettingList(preprocessingSettingFormQuery);
			if(preprocessingSettingEntitys!=null && preprocessingSettingEntitys.size()>0){
				preprocessingSettingEntity=preprocessingSettingEntitys.get(0);
				preprocessingSettingEntity.setPreprocessingSettingAssembles(preprocessingAssembleDao.queryPreprocessingSettingAssembleList(psid));
				preprocessingSettingEntity.setPreprocessingSettingInspects(preprocessingAssembleDao.queryPreprocessingSettingInspectList(psid));
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
			List<PreprocessingEntity> preprocessingEntitys=preprocessingAssembleDao.queryPreprocessingList(preprocessingFormQuery);
			if(preprocessingEntitys!=null && preprocessingEntitys.size()>0){
				preprocessingEntity=preprocessingEntitys.get(0);
				preprocessingEntity.setAssembleRecords(preprocessingAssembleDao.queryPreprocessingAssembleList(preprocessingID));
				preprocessingEntity.setInspectRecords(preprocessingAssembleDao.queryPreprocessingInspectList(preprocessingID));
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
			List<PreprocessingAssembleEntity> preprocessingAssembles=preprocessingAssembleDao.queryPreprocessingAssembleList(preprocessingID);
			DatatablesView datatablesViews=new DatatablesView();
			if(preprocessingAssembles!=null){
				datatablesViews.setiTotalDisplayRecords(preprocessingAssembles.size());
				datatablesViews.setRecordsTotal(preprocessingAssembles.size());
				datatablesViews.setData(preprocessingAssembles);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingAssembleList.exception"));
		}
		return baseResponse;
	}

	@Override
	public BaseTablesResponse queryPreprocessingInspectList(String preprocessingID) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			List<PreprocessingInspectEntity> preprocessingInspects=preprocessingAssembleDao.queryPreprocessingInspectList(preprocessingID);
			DatatablesView datatablesViews=new DatatablesView();
			if(preprocessingInspects!=null){
				datatablesViews.setiTotalDisplayRecords(preprocessingInspects.size());
				datatablesViews.setRecordsTotal(preprocessingInspects.size());
				datatablesViews.setData(preprocessingInspects);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingAssembleList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("preprocessingAssemble.service.queryPreprocessingAssembleList.exception"));
		}
		return baseResponse;
	}
	
}

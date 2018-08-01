package com.pall.wdpts.service.workflow;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pall.wdpts.common.constants.IResponseConstants;
import com.pall.wdpts.common.constants.KeyConstants;
import com.pall.wdpts.common.datatables.Entity.DatatablesView;
import com.pall.wdpts.common.i18n.ResourceUtils;
import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.init.UmsConfigInitiator;
import com.pall.wdpts.repository.entity.workflow.CleanEntity;
import com.pall.wdpts.repository.entity.workflow.DefectEntity;
import com.pall.wdpts.repository.entity.workflow.OpticalCoatingEntity;
import com.pall.wdpts.repository.entity.workflow.OpticalFilmingQueryFormEntity;
import com.pall.wdpts.repository.mapper.workflow.DefectDao;
import com.pall.wdpts.repository.mapper.workflow.OpticalFilmingDao;
import com.pall.wdpts.service.workflow.OpticalFilmingService;

/*
 * 工作流服务实现类
 */
@Repository
public class OpticalFilmingServiceImpl implements OpticalFilmingService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private OpticalFilmingDao opticalFilmingDao;
	@Autowired
	private DefectDao defectDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseTablesResponse queryOpticalFilmingList(OpticalFilmingQueryFormEntity  opticalFilmingQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=opticalFilmingDao.queryOpticalFilmingTotalRecords(opticalFilmingQueryFormEntity);
			//分页查询结果集
			List<OpticalCoatingEntity> opticalCoatingEntitys=opticalFilmingDao.queryOpticalFilmingList(opticalFilmingQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(opticalFilmingQueryFormEntity.getDraw());
			if(opticalCoatingEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(getDefectRecords(opticalCoatingEntitys));
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("opticalfilmingManage.workflow.service.queryOpticalFilmingList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.service.queryOpticalFilmingList.exception"));
		}
		return baseResponse;
	}
	/*
	 * 获取缺损信息
	 */
	private List<OpticalCoatingEntity> getDefectRecords(List<OpticalCoatingEntity> opticalCoatingEntitys) throws Exception{
		List<Integer> defectids=new ArrayList<Integer>();
		Map<Integer,OpticalCoatingEntity> map=new HashMap<Integer,OpticalCoatingEntity>();
		for(OpticalCoatingEntity opticalCoatingEntity:opticalCoatingEntitys){
			defectids.add(opticalCoatingEntity.getOpfID());
			map.put(opticalCoatingEntity.getOpfID(),opticalCoatingEntity);
		}
		if(defectids.size()>0){
			List<DefectEntity> defectEntitys=defectDao.queryDefectsByDefectID(defectids);
			if(null!=defectEntitys){
				for(DefectEntity defectEntity:defectEntitys){
					defectEntity.setFieldName(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_TABLENAME)+defectEntity.getDataid());
					if(null!=map.get(defectEntity.getDefectID())){
						if(null==map.get(defectEntity.getDefectID()).getDefects()){
							map.get(defectEntity.getDefectID()).setDefects(new ArrayList<DefectEntity>());
						}
						map.get(defectEntity.getDefectID()).getDefects().add(defectEntity);
					}
				}
			}
		}
		return opticalCoatingEntitys;
	}
	@Override
	public BaseResponse addOpticalFilming(OpticalCoatingEntity opticalCoatingEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=opticalFilmingDao.addOpticalFilming(opticalCoatingEntity);
			if(resultNum>0){
				List<DefectEntity> defects=opticalCoatingEntity.getDefects();
				if(defects!=null && defects.size()>0){
					for(DefectEntity defectEntity:defects){
						defectEntity.setDefectID(opticalCoatingEntity.getOpfID());
					}
					resultNum=defectDao.addDefectResult(defects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.dao.addDefectResult.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.dao.addOpticalFilming.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("opticalfilmingManage.workflow.service.addOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.service.addOpticalFilming.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse  modifyOpticalFilming(OpticalCoatingEntity opticalCoatingEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=opticalFilmingDao.modifyOpticalFilming(opticalCoatingEntity);
			if(resultNum>0){
				List<DefectEntity> defects=opticalCoatingEntity.getDefects();
				if(defects!=null && defects.size()>0){
					List<Integer> defectIDs=new ArrayList<Integer>();
					defectIDs.add(opticalCoatingEntity.getOpfID());
					List<Integer> defectTypes=new ArrayList<Integer>();
					defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_WF)));
					defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_NWF)));
					defectDao.delDefectResult(defectIDs,defectTypes);
					for(DefectEntity defectEntity:defects){
						defectEntity.setDefectID(opticalCoatingEntity.getOpfID());
					}
					resultNum=defectDao.addDefectResult(defects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.dao.addDefectResult.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.dao.modifyOpticalFilming.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("opticalfilmingManage.workflow.service.modifyOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.service.modifyOpticalFilming.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delOpticalFilming(List<Integer> opfIDs) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			opticalFilmingDao.delOpticalFilming(opfIDs);
			List<Integer> defectTypes=new ArrayList<Integer>();
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_WF)));
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_NWF)));
			defectDao.delDefectResult(opfIDs,defectTypes);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("opticalfilmingManage.workflow.service.delOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.service.delOpticalFilming.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse exportOpticalFilming(OpticalFilmingQueryFormEntity  opticalFilmingQueryFormEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			opticalFilmingQueryFormEntity.setStartPageNum(0);
			//查询总记录数
			int totalRecords=opticalFilmingDao.queryOpticalFilmingTotalRecords(opticalFilmingQueryFormEntity);
			if(totalRecords==0){
				baseResponse.setReturnObjects(new ArrayList<OpticalCoatingEntity>());
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				return baseResponse;
			}
			//分页查询结果集
			opticalFilmingQueryFormEntity.setPageSize(totalRecords);
			List<OpticalCoatingEntity> opticalCoatingEntitys=opticalFilmingDao.queryOpticalFilmingList(opticalFilmingQueryFormEntity);
			opticalCoatingEntitys=getDefectRecords(opticalCoatingEntitys);
			baseResponse.setReturnObjects(opticalCoatingEntitys);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("opticalfilmingManage.workflow.service.exportOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.service.exportOpticalFilming.exception"));
		}
		return baseResponse;
	}
	
}

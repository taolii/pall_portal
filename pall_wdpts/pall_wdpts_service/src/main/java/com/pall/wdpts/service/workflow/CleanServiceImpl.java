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
import com.pall.wdpts.repository.entity.workflow.AssemblyEntity;
import com.pall.wdpts.repository.entity.workflow.CleanEntity;
import com.pall.wdpts.repository.entity.workflow.CleanQueryFormEntity;
import com.pall.wdpts.repository.entity.workflow.DefectEntity;
import com.pall.wdpts.repository.mapper.workflow.CleanDao;
import com.pall.wdpts.repository.mapper.workflow.DefectDao;
import com.pall.wdpts.service.workflow.CleanService;

/*
 * 工作流服务实现类
 */
@Repository
public class CleanServiceImpl implements CleanService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private CleanDao cleanDao;
	@Autowired
	private DefectDao defectDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseTablesResponse queryCleanList(CleanQueryFormEntity cleanQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=cleanDao.queryCleanTotalRecords(cleanQueryFormEntity);
			//分页查询结果集
			List<CleanEntity> cleanEntitys=cleanDao.queryCleanList(cleanQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(cleanQueryFormEntity.getDraw());
			if(cleanEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(getDefectRecords(cleanEntitys));
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cleanmanage.workflow.service.queryCleanList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.workflow.service.queryCleanList.exception"));
		}
		return baseResponse;
	}
	/*
	 * 获取缺损信息
	 */
	private List<CleanEntity> getDefectRecords(List<CleanEntity> cleanEntitys) throws Exception{
		List<Integer> defectids=new ArrayList<Integer>();
		Map<Integer,CleanEntity> map=new HashMap<Integer,CleanEntity>();
		for(CleanEntity cleanEntity:cleanEntitys){
			defectids.add(cleanEntity.getCleanID());
			map.put(cleanEntity.getCleanID(),cleanEntity);
		}
		if(defectids.size()>0){
			List<DefectEntity> defectEntitys=defectDao.queryDefectsByDefectID(defectids);
			if(null!=defectEntitys){
				for(DefectEntity defectEntity:defectEntitys){
					defectEntity.setFieldName(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_TABLENAME)+defectEntity.getDataid());
					if(null!=map.get(defectEntity.getDefectID())){
						if(null==map.get(defectEntity.getDefectID()).getDefects()){
							map.get(defectEntity.getDefectID()).setDefects(new ArrayList<DefectEntity>());
						}
						map.get(defectEntity.getDefectID()).getDefects().add(defectEntity);
					}
				}
			}
		}
		return cleanEntitys;
	}
	@Override
	public BaseResponse addClean(CleanEntity cleanEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=cleanDao.addClean(cleanEntity);
			if(resultNum>0){
				List<DefectEntity> defects=cleanEntity.getDefects();
				if(defects!=null && defects.size()>0){
					for(DefectEntity defectEntity:defects){
						defectEntity.setDefectID(cleanEntity.getCleanID());
					}
					resultNum=defectDao.addDefectResult(defects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.workflow.dao.addDefectResult.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.workflow.dao.addClean.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cleanmanage.workflow.service.addClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.workflow.service.addClean.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse modifyClean(CleanEntity cleanEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=cleanDao.modifyClean(cleanEntity);
			if(resultNum>0){
				List<DefectEntity> defects=cleanEntity.getDefects();
				if(defects!=null && defects.size()>0){
					List<Integer> defectIDs=new ArrayList<Integer>();
					defectIDs.add(cleanEntity.getCleanID());
					List<Integer> defectTypes=new ArrayList<Integer>();
					defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_WF)));
					defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_NWF)));
					defectDao.delDefectResult(defectIDs,defectTypes);
					for(DefectEntity defectEntity:defects){
						defectEntity.setDefectID(cleanEntity.getCleanID());
					}
					resultNum=defectDao.addDefectResult(defects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.workflow.dao.addDefectResult.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.workflow.dao.modifyClean.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cleanmanage.workflow.service.modifyClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.workflow.service.modifyClean.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delClean(List<Integer> cleanIDs) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			cleanDao.delClean(cleanIDs);
			List<Integer> defectTypes=new ArrayList<Integer>();
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_WF)));
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.CLEAN_DATACONFIG_TYPE_DEFECT_NWF)));
			defectDao.delDefectResult(cleanIDs,defectTypes);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cleanmanage.workflow.service.delClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.workflow.service.delClean.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse exportClean(CleanQueryFormEntity cleanQueryFormEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			cleanQueryFormEntity.setStartPageNum(0);
			//查询总记录数
			int totalRecords=cleanDao.queryCleanTotalRecords(cleanQueryFormEntity);
			if(totalRecords==0){
				baseResponse.setReturnObjects(new ArrayList<CleanEntity>());
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				return baseResponse;
			}
			//分页查询结果集
			cleanQueryFormEntity.setPageSize(totalRecords);
			List<CleanEntity> cleanEntitys=cleanDao.queryCleanList(cleanQueryFormEntity);
			cleanEntitys=getDefectRecords(cleanEntitys);
			baseResponse.setReturnObjects(cleanEntitys);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("cleanmanage.workflow.service.exportClean.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("cleanmanage.workflow.service.exportClean.exception"));
		}
		return baseResponse;
	}
	
}

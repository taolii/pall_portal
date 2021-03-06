package com.pall.mts.service.workflow;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pall.mts.common.constants.IResponseConstants;
import com.pall.mts.common.constants.KeyConstants;
import com.pall.mts.common.datatables.Entity.DatatablesView;
import com.pall.mts.common.i18n.ResourceUtils;
import com.pall.mts.common.response.BaseResponse;
import com.pall.mts.common.response.BaseTablesResponse;
import com.pall.mts.init.UmsConfigInitiator;
import com.pall.mts.repository.entity.workflow.DefectEntity;
import com.pall.mts.repository.entity.workflow.PlatedFilmEntity;
import com.pall.mts.repository.entity.workflow.PolishEntity;
import com.pall.mts.repository.entity.workflow.PolishQueryFormEntity;
import com.pall.mts.repository.mapper.workflow.DefectDao;
import com.pall.mts.repository.mapper.workflow.PolishDao;
import com.pall.mts.service.workflow.PolishService;

/*
 * 工作流服务实现类
 */
@Repository
public class PolishServiceImpl implements PolishService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private PolishDao polishDao;
	@Autowired
	private DefectDao defectDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseTablesResponse queryPolishList(PolishQueryFormEntity polishQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=polishDao.queryPolishTotalRecords(polishQueryFormEntity);
			//分页查询结果集
			List<PolishEntity> polishEntitys=polishDao.queryPolishList(polishQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(polishQueryFormEntity.getDraw());
			if(polishEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(getDefectRecords(polishEntitys));
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("polshmanage.workflow.service.queryPolishList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.service.queryPolishList.exception"));
		}
		return baseResponse;
	}
	/*
	 * 获取缺损信息
	 */
	private List<PolishEntity> getDefectRecords(List<PolishEntity> polishEntitys) throws Exception{
		List<Integer> defectids=new ArrayList<Integer>();
		Map<Integer,PolishEntity> map=new HashMap<Integer,PolishEntity>();
		for(PolishEntity polishEntity:polishEntitys){
			defectids.add(polishEntity.getPolishID());
			map.put(polishEntity.getPolishID(),polishEntity);
		}
		if(defectids.size()>0){
			List<DefectEntity> defectEntitys=defectDao.queryDefectsByDefectID(defectids);
			if(null!=defectEntitys){
				for(DefectEntity defectEntity:defectEntitys){
					defectEntity.setFieldName(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_TABLENAME)+defectEntity.getDataid());
					if(null!=map.get(defectEntity.getDefectID())){
						if(null==map.get(defectEntity.getDefectID()).getDefects()){
							map.get(defectEntity.getDefectID()).setDefects(new ArrayList<DefectEntity>());
						}
						map.get(defectEntity.getDefectID()).getDefects().add(defectEntity);
					}
				}
			}
		}
		return polishEntitys;
	}
	@Override
	public BaseResponse addPolish(PolishEntity polishEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			PolishQueryFormEntity polishQueryFormEntity=new PolishQueryFormEntity();
			polishQueryFormEntity.setFixtureNumber(polishEntity.getFixtureNumber());
			polishQueryFormEntity.setInputLotNum(polishEntity.getInputLotNum());
			int totalCount=polishDao.queryPolishTotalRecords(polishQueryFormEntity);
			if(totalCount>=1){
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.service.addPolish.fixtureandinputlotnum.exists"));
				return baseResponse;
			}
			int resultNum=polishDao.addPolish(polishEntity);
			if(resultNum>0){
				List<DefectEntity> defects=polishEntity.getDefects();
				if(defects!=null && defects.size()>0){
					for(DefectEntity defectEntity:defects){
						defectEntity.setDefectID(polishEntity.getPolishID());
					}
					resultNum=defectDao.addDefectResult(defects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.dao.addDefectResult.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.dao.addPolish.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("polshmanage.workflow.service.addPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.service.addPolish.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse modifyPolish(PolishEntity polishEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			PolishQueryFormEntity polishQueryFormEntity=new PolishQueryFormEntity();
			polishQueryFormEntity.setStartPageNum(0);
			polishQueryFormEntity.setPageSize(Integer.MAX_VALUE);
			polishQueryFormEntity.setFixtureNumber(polishEntity.getFixtureNumber());
			polishQueryFormEntity.setInputLotNum(polishEntity.getInputLotNum());
			List<PolishEntity> polishEntitys=polishDao.queryPolishList(polishQueryFormEntity);
			if(null!=polishEntitys && polishEntitys.size()>=1){
				if(polishEntitys.size()==1 && polishEntitys.get(0).getPolishID().intValue()==polishEntity.getPolishID().intValue()){
					//更新本身不做处理
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.service.modifyPolish.fixtureandinputlotnum.exists"));
					return baseResponse;
				}
			}
			int resultNum=polishDao.modifyPolish(polishEntity);
			if(resultNum>0){
				List<DefectEntity> defects=polishEntity.getDefects();
				if(defects!=null && defects.size()>0){
					List<Integer> defectIDs=new ArrayList<Integer>();
					defectIDs.add(polishEntity.getPolishID());
					List<Integer> defectTypes=new ArrayList<Integer>();
					defectDao.delDefectResult(defectIDs,defectTypes);
					for(DefectEntity defectEntity:defects){
						defectEntity.setDefectID(polishEntity.getPolishID());
					}
					resultNum=defectDao.addDefectResult(defects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.dao.addDefectResult.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.dao.modifyPolish.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("polshmanage.workflow.service.modifyPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.service.modifyPolish.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delPolish(List<Integer> polishIDs) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			polishDao.delPolish(polishIDs);
			List<Integer> defectTypes=new ArrayList<Integer>();
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.POLISH_DATACONFIG_TYPE_DEFECT)));
			defectDao.delDefectResult(polishIDs,defectTypes);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("polshmanage.workflow.service.delPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.service.delPolish.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse exportPolish(PolishQueryFormEntity polishQueryFormEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			polishQueryFormEntity.setStartPageNum(0);
			//查询总记录数
			int totalRecords=polishDao.queryPolishTotalRecords(polishQueryFormEntity);
			if(totalRecords==0){
				baseResponse.setReturnObjects(new ArrayList<PolishEntity>());
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				return baseResponse;
			}
			//分页查询结果集
			polishQueryFormEntity.setPageSize(totalRecords);
			List<PolishEntity> polishEntitys=polishDao.queryPolishList(polishQueryFormEntity);
			polishEntitys=getDefectRecords(polishEntitys);
			baseResponse.setReturnObjects(polishEntitys);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("polshmanage.workflow.service.exportPolish.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("polshmanage.workflow.service.exportPolish.exception"));
		}
		return baseResponse;
	}
	
}

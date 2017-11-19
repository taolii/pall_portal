package com.pall.portal.service.workflow;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.constants.KeyConstants;
import com.pall.portal.common.datatables.Entity.DatatablesView;
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.init.UmsConfigInitiator;
import com.pall.portal.repository.entity.workflow.ChemicalCompoundReagentsEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentQueryFormEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentRelationEntity;
import com.pall.portal.repository.entity.workflow.CleanEntity;
import com.pall.portal.repository.entity.workflow.DefectEntity;
import com.pall.portal.repository.mapper.workflow.ChemicalReagentDao;

/*
 * 工作流服务实现类
 */
@Repository
public class ChemicalReagentServiceImpl implements ChemicalReagentService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ChemicalReagentDao chemicalReagentDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseTablesResponse queryChemicalReagentList(ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=chemicalReagentDao.queryChemicalReagentTotalRecords(chemicalReagentQueryFormEntity);
			//分页查询结果集
			List<ChemicalReagentEntity> chemicalReagentEntitys=chemicalReagentDao.queryChemicalReagentList(chemicalReagentQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(chemicalReagentQueryFormEntity.getDraw());
			if(chemicalReagentEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(chemicalReagentEntitys);
				Map<Integer,ChemicalReagentEntity> chemicalReagentMap=new HashMap<Integer,ChemicalReagentEntity>();
				for(ChemicalReagentEntity chemicalReagentEntity:chemicalReagentEntitys){
					chemicalReagentMap.put(chemicalReagentEntity.getCrID(), chemicalReagentEntity);
				}
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("chemicalReagentManage.workflow.service.queryChemicalReagentList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.service.queryChemicalReagentList.exception"));
		}
		return baseResponse;
	}
	/*
	 * 封装化学混合试剂信息
	 */
	private List<ChemicalReagentEntity> getChemicalCompoundReagents(Map<Integer,ChemicalReagentEntity> chemicalReagentMap) throws Exception{
		/*List<Integer> crIDs=new ArrayList<Integer>();
		crIDs.addAll(chemicalReagentMap.keySet());
		List<ChemicalCompoundReagentsEntity> chemicalCompoundReagents=chemicalReagentDao.queryChemicalCompoundReagents(crIDs);
		if(chemicalCompoundReagents!=null && chemicalCompoundReagents.size()>0){
			for(ChemicalCompoundReagentsEntity ChemicalCompoundReagentsEntity:chemicalCompoundReagents){
				if(ChemicalCompoundReagentsEntity.)
			}
		}*/
		return null;
	}
	/*
	 * 封装化学试剂关系对象信息
	 */
	private List<ChemicalReagentEntity> getChemicalReagentRelations(Map<Integer,ChemicalReagentEntity> chemicalReagentMap) throws Exception{
		/*List<Integer> defectids=new ArrayList<Integer>();
		Map<Integer,CleanEntity> map=new HashMap<Integer,CleanEntity>();
		for(CleanEntity cleanEntity:cleanEntitys){
			defectids.add(cleanEntity.getCleanID());
			map.put(cleanEntity.getCleanID(),cleanEntity);
		}
		if(defectids.size()>0){
			List<Integer> defectTypes=new ArrayList<Integer>();
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_CLEAN_DEFECT_WF)));
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.DATACONFIG_TYPE_CLEAN_DEFECT_NWF)));
			List<DefectEntity> defectEntitys=defectDao.queryDefectList(defectids,defectTypes);
			if(null!=defectEntitys){
				for(DefectEntity defectEntity:defectEntitys){
					if(null!=map.get(defectEntity.getDefectID())){
						if(null==map.get(defectEntity.getDefectID()).getDefects()){
							map.get(defectEntity.getDefectID()).setDefects(new ArrayList<DefectEntity>());
						}
						map.get(defectEntity.getDefectID()).getDefects().add(defectEntity);
					}
				}
			}
		}*/
		return null;
	}
	@Override
	public BaseResponse addChemicalReagent(ChemicalReagentEntity chemicalReagentEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=chemicalReagentDao.addChemicalReagent(chemicalReagentEntity);
			if(resultNum>0){
				//插入混合试剂信息
				if(chemicalReagentEntity.getCompoundReagents()!=null && chemicalReagentEntity.getCompoundReagents().size()>0){
					for(ChemicalCompoundReagentsEntity chemicalCompoundReagentsEntity:chemicalReagentEntity.getCompoundReagents()){
						chemicalCompoundReagentsEntity.setCrID(chemicalReagentEntity.getCrID());
					}
					resultNum=chemicalReagentDao.addChemicalCompoundReagents(chemicalReagentEntity.getCompoundReagents());
				}
				//插入关联关系对象信息
				if(resultNum>0){
					if(chemicalReagentEntity.getChemicalReagentRelations()!=null && chemicalReagentEntity.getChemicalReagentRelations().size()>0){
						for(ChemicalReagentRelationEntity chemicalReagentRelationEntity:chemicalReagentEntity.getChemicalReagentRelations()){
							chemicalReagentRelationEntity.setCrID(chemicalReagentEntity.getCrID());
						}
						resultNum=chemicalReagentDao.addChemicalReagentRelations(chemicalReagentEntity.getChemicalReagentRelations());
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.dao.addChemicalReagent.failed"));
					return baseResponse;
				}
				if(resultNum>0){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.dao.addChemicalReagent.failed"));
					return baseResponse;
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.dao.addChemicalReagent.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("chemicalReagentManage.workflow.service.addChemicalReagent.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.service.addChemicalReagent.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse  modifyChemicalReagent(ChemicalReagentEntity chemicalReagentEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			List<Integer> crIDs=new ArrayList<Integer>();
			crIDs.add(chemicalReagentEntity.getCrID());
			//删除化学试剂信息
			chemicalReagentDao.delChemicalCompoundReagents(crIDs);
			//删除关系关系对象信息
			chemicalReagentDao.delChemicalReagentRelations(crIDs);
			int resultNum=chemicalReagentDao.modifyChemicalReagent(chemicalReagentEntity);
			if(resultNum>0){
				//插入混合试剂信息
				if(chemicalReagentEntity.getCompoundReagents()!=null && chemicalReagentEntity.getCompoundReagents().size()>0){
					for(ChemicalCompoundReagentsEntity chemicalCompoundReagentsEntity:chemicalReagentEntity.getCompoundReagents()){
						chemicalCompoundReagentsEntity.setCrID(chemicalReagentEntity.getCrID());
					}
					resultNum=chemicalReagentDao.addChemicalCompoundReagents(chemicalReagentEntity.getCompoundReagents());
				}
				//插入关联关系对象信息
				if(resultNum>0){
					if(chemicalReagentEntity.getChemicalReagentRelations()!=null && chemicalReagentEntity.getChemicalReagentRelations().size()>0){
						for(ChemicalReagentRelationEntity chemicalReagentRelationEntity:chemicalReagentEntity.getChemicalReagentRelations()){
							chemicalReagentRelationEntity.setCrID(chemicalReagentEntity.getCrID());
						}
						resultNum=chemicalReagentDao.addChemicalReagentRelations(chemicalReagentEntity.getChemicalReagentRelations());
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.dao.modifyChemicalReagent.failed"));
					return baseResponse;
				}
				if(resultNum>0){
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
					baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.dao.modifyChemicalReagent.failed"));
					return baseResponse;
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.dao.modifyChemicalReagent.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("chemicalReagentManage.workflow.service.modifyChemicalReagent.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.service.modifyChemicalReagent.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delChemicalReagent(List<Integer> crIDs) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			chemicalReagentDao.delChemicalReagent(crIDs);
			
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("opticalfilmingManage.workflow.service.delOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.service.delOpticalFilming.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse exportChemicalReagent(ChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			chemicalReagentQueryFormEntity.setStartPageNum(0);
			//查询总记录数
			int totalRecords=chemicalReagentDao.queryChemicalReagentTotalRecords(chemicalReagentQueryFormEntity);
			//分页查询结果集
			chemicalReagentQueryFormEntity.setPageSize(totalRecords);
			List<ChemicalReagentEntity> chemicalReagentEntitys=chemicalReagentDao.queryChemicalReagentList(chemicalReagentQueryFormEntity);
			baseResponse.setReturnObjects(chemicalReagentEntitys);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("opticalfilmingManage.workflow.service.exportOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.service.exportOpticalFilming.exception"));
		}
		return baseResponse;
	}
	
}

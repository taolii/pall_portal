package com.pall.portal.service.workflow;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.alibaba.druid.util.StringUtils;
import com.pall.portal.common.constants.IResponseConstants;
import com.pall.portal.common.datatables.Entity.DatatablesView;
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.repository.entity.workflow.ChemicalCompoundReagentsEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentQueryFormEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentRelationEntity;
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
					if(chemicalReagentEntity.getChemicalReagentRelations()==null){
						chemicalReagentEntity.setChemicalReagentRelations(new ArrayList<ChemicalReagentRelationEntity>());
					}
					if(chemicalReagentEntity.getCompoundReagents()==null){
						chemicalReagentEntity.setCompoundReagents(new ArrayList<ChemicalCompoundReagentsEntity>());
					}
					chemicalReagentEntity.setAssemblyOutputLotNums("");
					chemicalReagentEntity.setPfOutputLotNums("");
					chemicalReagentEntity.setOcOutputLotNums("");
					chemicalReagentMap.put(chemicalReagentEntity.getCrID(), chemicalReagentEntity);
				}
				getChemicalCompoundReagents(chemicalReagentMap);
				getChemicalReagentRelations(chemicalReagentMap);
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
		List<Integer> crIDs=new ArrayList<Integer>();
		List<ChemicalReagentEntity> chemicalReagents=new ArrayList<ChemicalReagentEntity>();
		crIDs.addAll(chemicalReagentMap.keySet());
		List<ChemicalCompoundReagentsEntity> chemicalCompoundReagents=chemicalReagentDao.queryChemicalCompoundReagents(crIDs);
		if(chemicalCompoundReagents!=null && chemicalCompoundReagents.size()>0){
			for(ChemicalCompoundReagentsEntity ChemicalCompoundReagentsEntity:chemicalCompoundReagents){
				if(chemicalReagentMap.get(ChemicalCompoundReagentsEntity.getCrID())!=null){
					chemicalReagentMap.get(ChemicalCompoundReagentsEntity.getCrID()).getCompoundReagents().add(ChemicalCompoundReagentsEntity);
				}
			}
		}
		chemicalReagents.addAll(chemicalReagentMap.values());
		return chemicalReagents;
	}
	/*
	 * 封装化学试剂关系对象信息
	 */
	private List<ChemicalReagentEntity> getChemicalReagentRelations(Map<Integer,ChemicalReagentEntity> chemicalReagentMap) throws Exception{
		List<Integer> crIDs=new ArrayList<Integer>();
		List<ChemicalReagentEntity> chemicalReagents=new ArrayList<ChemicalReagentEntity>();
		crIDs.addAll(chemicalReagentMap.keySet());
		List<ChemicalReagentRelationEntity> chemicalReagentRelations=chemicalReagentDao.queryChemicalReagentRelations(crIDs);
		if(chemicalReagentRelations!=null && chemicalReagentRelations.size()>0){
			for(ChemicalReagentRelationEntity chemicalReagentRelationEntity:chemicalReagentRelations){
				if(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID())!=null){
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getAssemblyOutputLotNum())){
						chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setAssemblyOutputLotNums(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getAssemblyOutputLotNums()+chemicalReagentRelationEntity.getAssemblyOutputLotNum()+",");
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getPfOutputLotNum())){
						chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setPfOutputLotNums(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getPfOutputLotNums()+chemicalReagentRelationEntity.getPfOutputLotNum()+",");
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getOcOutputLotNum())){
						chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setOcOutputLotNums(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getOcOutputLotNums()+chemicalReagentRelationEntity.getOcOutputLotNum()+",");
					}
					chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getChemicalReagentRelations().add(chemicalReagentRelationEntity);
				}
			}
		}
		chemicalReagents.addAll(chemicalReagentMap.values());
		return chemicalReagents;
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
			if(chemicalReagentEntitys!=null){
				Map<Integer,ChemicalReagentEntity> chemicalReagentMap=new HashMap<Integer,ChemicalReagentEntity>();
				for(ChemicalReagentEntity chemicalReagentEntity:chemicalReagentEntitys){
					if(chemicalReagentEntity.getChemicalReagentRelations()==null){
						chemicalReagentEntity.setChemicalReagentRelations(new ArrayList<ChemicalReagentRelationEntity>());
					}
					if(chemicalReagentEntity.getCompoundReagents()==null){
						chemicalReagentEntity.setCompoundReagents(new ArrayList<ChemicalCompoundReagentsEntity>());
					}
					chemicalReagentEntity.setAssemblyOutputLotNums("");
					chemicalReagentEntity.setPfOutputLotNums("");
					chemicalReagentEntity.setOcOutputLotNums("");
					chemicalReagentMap.put(chemicalReagentEntity.getCrID(), chemicalReagentEntity);
				}
				getChemicalCompoundReagents(chemicalReagentMap);
				getChemicalReagentRelations(chemicalReagentMap);
			}
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("opticalfilmingManage.workflow.service.exportOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.service.exportOpticalFilming.exception"));
		}
		return baseResponse;
	}
	
}

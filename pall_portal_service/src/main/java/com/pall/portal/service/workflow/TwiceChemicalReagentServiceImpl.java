package com.pall.portal.service.workflow;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.pall.portal.repository.entity.workflow.TwiceChemicalCompoundReagentsEntity;
import com.pall.portal.repository.entity.workflow.TwiceChemicalReagentEntity;
import com.pall.portal.repository.entity.workflow.TwiceChemicalReagentMixtureQueryFormEntity;
import com.pall.portal.repository.entity.workflow.TwiceChemicalReagentQueryFormEntity;
import com.pall.portal.repository.entity.workflow.TwiceChemicalReagentRelationEntity;
import com.pall.portal.repository.mapper.workflow.TwiceChemicalReagentDao;

/*
 * 工作流服务实现类
 */
@Repository
public class TwiceChemicalReagentServiceImpl implements TwiceChemicalReagentService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private TwiceChemicalReagentDao chemicalReagentDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseTablesResponse queryTwiceChemicalReagentList(TwiceChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=chemicalReagentDao.queryTwiceChemicalReagentTotalRecords(chemicalReagentQueryFormEntity);
			//分页查询结果集
			List<TwiceChemicalReagentEntity> chemicalReagentEntitys=chemicalReagentDao.queryTwiceChemicalReagentList(chemicalReagentQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(chemicalReagentQueryFormEntity.getDraw());
			if(chemicalReagentEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(chemicalReagentEntitys);
				Map<Integer,TwiceChemicalReagentEntity> chemicalReagentMap=new HashMap<Integer,TwiceChemicalReagentEntity>();
				for(TwiceChemicalReagentEntity chemicalReagentEntity:chemicalReagentEntitys){
					if(chemicalReagentEntity.getChemicalReagentRelations()==null){
						chemicalReagentEntity.setChemicalReagentRelations(new ArrayList<TwiceChemicalReagentRelationEntity>());
					}
					if(chemicalReagentEntity.getCompoundReagents()==null){
						chemicalReagentEntity.setCompoundReagents(new ArrayList<TwiceChemicalCompoundReagentsEntity>());
					}
					chemicalReagentEntity.setApsBoms("");
					chemicalReagentEntity.setApsLotNums("");
					chemicalReagentEntity.setTrayLotNums("");
					chemicalReagentEntity.settLotNums("");
					chemicalReagentEntity.setAssemblyBoms("");
					chemicalReagentEntity.setAssemblyLotNums("");
					chemicalReagentEntity.setPolishBoms("");
					chemicalReagentEntity.setPolishLotNums("");
					chemicalReagentEntity.setCleanBoms("");
					chemicalReagentEntity.setCleanLotNums("");
					chemicalReagentEntity.setOcBoms("");
					chemicalReagentEntity.setOcLotNums("");
					
					chemicalReagentMap.put(chemicalReagentEntity.getCrID(), chemicalReagentEntity);
				}
				if(chemicalReagentMap!=null && chemicalReagentMap.size()>0){
					getTwiceChemicalCompoundReagents(chemicalReagentMap);
					getTwiceChemicalReagentRelations(chemicalReagentMap);
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
	private List<TwiceChemicalReagentEntity> getTwiceChemicalCompoundReagents(Map<Integer,TwiceChemicalReagentEntity> chemicalReagentMap) throws Exception{
		List<Integer> crIDs=new ArrayList<Integer>();
		List<TwiceChemicalReagentEntity> chemicalReagents=new ArrayList<TwiceChemicalReagentEntity>();
		crIDs.addAll(chemicalReagentMap.keySet());
		List<TwiceChemicalCompoundReagentsEntity> chemicalCompoundReagents=chemicalReagentDao.queryTwiceChemicalCompoundReagents(crIDs);
		if(chemicalCompoundReagents!=null && chemicalCompoundReagents.size()>0){
			for(TwiceChemicalCompoundReagentsEntity ChemicalCompoundReagentsEntity:chemicalCompoundReagents){
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
	private List<TwiceChemicalReagentEntity> getTwiceChemicalReagentRelations(Map<Integer,TwiceChemicalReagentEntity> chemicalReagentMap) throws Exception{
		List<Integer> crIDs=new ArrayList<Integer>();
		List<TwiceChemicalReagentEntity> chemicalReagents=new ArrayList<TwiceChemicalReagentEntity>();
		crIDs.addAll(chemicalReagentMap.keySet());
		List<TwiceChemicalReagentRelationEntity> chemicalReagentRelations=chemicalReagentDao.queryTwiceChemicalReagentRelations(crIDs);
		if(chemicalReagentRelations!=null && chemicalReagentRelations.size()>0){
			Set<String> tempSet=new HashSet<String>();
			for(TwiceChemicalReagentRelationEntity chemicalReagentRelationEntity:chemicalReagentRelations){
				if(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID())!=null){
					chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getChemicalReagentRelations().add(chemicalReagentRelationEntity);
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getTrayLotNum())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getTrayLotNums())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setTrayLotNums(chemicalReagentRelationEntity.getTrayLotNum());
							tempSet.add("trayLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getTrayLotNum());
						}else if(tempSet.add("trayLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getTrayLotNum())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setTrayLotNums(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getTrayLotNums()+","+chemicalReagentRelationEntity.getTrayLotNum());
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.gettLotNum())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).gettLotNums())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).settLotNums(chemicalReagentRelationEntity.gettLotNum());
							tempSet.add("tLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.gettLotNum());
						}else if(tempSet.add("tLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.gettLotNum())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).settLotNums(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).gettLotNums()+","+chemicalReagentRelationEntity.gettLotNum());
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getAssemblyLotNum())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getAssemblyLotNums())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setAssemblyLotNums(chemicalReagentRelationEntity.getAssemblyLotNum());
							tempSet.add("assemblyLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getAssemblyLotNum());
						}else if(tempSet.add("assemblyLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getAssemblyLotNum())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setAssemblyLotNums(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getAssemblyLotNums()+","+chemicalReagentRelationEntity.getAssemblyLotNum());
						}
						
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getAssemblyBom())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getAssemblyBoms())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setAssemblyBoms(chemicalReagentRelationEntity.getAssemblyBom());
							tempSet.add("assemblyBom"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getAssemblyBom());
						}else if(tempSet.add("assemblyBom"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getAssemblyBom())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setAssemblyBoms(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getAssemblyBoms()+","+chemicalReagentRelationEntity.getAssemblyBom());
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getApsLotNum())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getApsLotNums())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setApsLotNums(chemicalReagentRelationEntity.getApsLotNum());
							tempSet.add("apsLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getApsLotNum());
						}else if(tempSet.add("apsLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getApsLotNum())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setApsLotNums(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getApsLotNums()+","+chemicalReagentRelationEntity.getApsLotNum());
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getApsBom())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getApsBoms())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setApsBoms(chemicalReagentRelationEntity.getApsBom());
							tempSet.add("apsBom"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getApsBom());
						}else if(tempSet.add("apsBom"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getApsBom())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setApsBoms(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getApsBoms()+","+chemicalReagentRelationEntity.getApsBom());
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getOcLotNum())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getOcLotNums())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setTrayLotNums(chemicalReagentRelationEntity.getOcLotNum());
							tempSet.add("ocLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getOcLotNum());
						}else if(tempSet.add("ocLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getOcLotNum())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setOcLotNums(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getOcLotNums()+","+chemicalReagentRelationEntity.getOcLotNum());
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getOcBom())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getOcBoms())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setOcBoms(chemicalReagentRelationEntity.getOcBom());
							tempSet.add("ocBom"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getOcBom());
						}else if(tempSet.add("ocBom"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getOcBom())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setOcBoms(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getOcBoms()+","+chemicalReagentRelationEntity.getOcBom());
						}
						
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getCleanLotNum())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getCleanLotNums())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setCleanLotNums(chemicalReagentRelationEntity.getCleanLotNum());
							tempSet.add("cleanLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getCleanLotNum());
						}else if(tempSet.add("cleanLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getCleanLotNum())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setCleanLotNums(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getCleanLotNums()+","+chemicalReagentRelationEntity.getCleanLotNum());
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getCleanBom())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getCleanBoms())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setCleanBoms(chemicalReagentRelationEntity.getCleanBom());
							tempSet.add("cleanBom"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getCleanBom());
						}else if(tempSet.add("cleanBom"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getCleanBom())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setCleanBoms(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getCleanBoms()+","+chemicalReagentRelationEntity.getCleanBom());
						}
						
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getPolishLotNum())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getPolishLotNums())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setPolishLotNums(chemicalReagentRelationEntity.getPolishLotNum());
							tempSet.add("polishLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getPolishLotNum());
						}else if(tempSet.add("polishLotNum"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getPolishLotNum())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setPolishLotNums(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getPolishLotNums()+","+chemicalReagentRelationEntity.getPolishLotNum());
						}
						
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getPolishBom())){
						if(StringUtils.isEmpty(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getPolishBoms())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setPolishBoms(chemicalReagentRelationEntity.getPolishBom());
							tempSet.add("polishBom"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getPolishBom());
						}else if(tempSet.add("polishBom"+chemicalReagentRelationEntity.getCrID()+chemicalReagentRelationEntity.getPolishBom())){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setPolishBoms(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getPolishBoms()+","+chemicalReagentRelationEntity.getPolishBom());
						}
						
					}
				}
			}
		}
		chemicalReagents.addAll(chemicalReagentMap.values());
		return chemicalReagents;
	}
	@Override
	public BaseResponse addTwiceChemicalReagent(TwiceChemicalReagentEntity chemicalReagentEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=chemicalReagentDao.addTwiceChemicalReagent(chemicalReagentEntity);
			if(resultNum>0){
				//插入混合试剂信息
				if(chemicalReagentEntity.getCompoundReagents()!=null && chemicalReagentEntity.getCompoundReagents().size()>0){
					for(TwiceChemicalCompoundReagentsEntity chemicalCompoundReagentsEntity:chemicalReagentEntity.getCompoundReagents()){
						chemicalCompoundReagentsEntity.setCrID(chemicalReagentEntity.getCrID());
						resultNum=chemicalReagentDao.addTwiceChemicalCompoundReagents(chemicalCompoundReagentsEntity);
					}
				}
				//插入关联关系对象信息
				if(resultNum>0){
					if(chemicalReagentEntity.getChemicalReagentRelations()!=null && chemicalReagentEntity.getChemicalReagentRelations().size()>0){
						for(TwiceChemicalReagentRelationEntity chemicalReagentRelationEntity:chemicalReagentEntity.getChemicalReagentRelations()){
							chemicalReagentRelationEntity.setCrID(chemicalReagentEntity.getCrID());
						}
						resultNum=chemicalReagentDao.addTwiceChemicalReagentRelations(chemicalReagentEntity.getChemicalReagentRelations());
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
	public BaseResponse  modifyTwiceChemicalReagent(TwiceChemicalReagentEntity chemicalReagentEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			List<Integer> crIDs=new ArrayList<Integer>();
			crIDs.add(chemicalReagentEntity.getCrID());
			//删除化学试剂信息
			chemicalReagentDao.delTwiceChemicalCompoundReagents(crIDs);
			//删除关系关系对象信息
			chemicalReagentDao.delTwiceChemicalReagentRelations(crIDs);
			int resultNum=chemicalReagentDao.modifyTwiceChemicalReagent(chemicalReagentEntity);
			if(resultNum>0){
				//插入混合试剂信息
				if(chemicalReagentEntity.getCompoundReagents()!=null && chemicalReagentEntity.getCompoundReagents().size()>0){
					for(TwiceChemicalCompoundReagentsEntity chemicalCompoundReagentsEntity:chemicalReagentEntity.getCompoundReagents()){
						chemicalCompoundReagentsEntity.setCrID(chemicalReagentEntity.getCrID());
						resultNum=chemicalReagentDao.addTwiceChemicalCompoundReagents(chemicalCompoundReagentsEntity);
					}
				}
				//插入关联关系对象信息
				if(resultNum>0){
					if(chemicalReagentEntity.getChemicalReagentRelations()!=null && chemicalReagentEntity.getChemicalReagentRelations().size()>0){
						for(TwiceChemicalReagentRelationEntity chemicalReagentRelationEntity:chemicalReagentEntity.getChemicalReagentRelations()){
							chemicalReagentRelationEntity.setCrID(chemicalReagentEntity.getCrID());
						}
						resultNum=chemicalReagentDao.addTwiceChemicalReagentRelations(chemicalReagentEntity.getChemicalReagentRelations());
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
	public BaseResponse delTwiceChemicalReagent(List<Integer> crIDs) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			chemicalReagentDao.delTwiceChemicalReagent(crIDs);
			
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("opticalfilmingManage.workflow.service.delOpticalFilming.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("opticalfilmingManage.workflow.service.delOpticalFilming.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse exportTwiceChemicalReagent(TwiceChemicalReagentQueryFormEntity  chemicalReagentQueryFormEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			chemicalReagentQueryFormEntity.setStartPageNum(0);
			//查询总记录数
			int totalRecords=chemicalReagentDao.queryTwiceChemicalReagentTotalRecords(chemicalReagentQueryFormEntity);
			if(totalRecords==0){
				baseResponse.setReturnObjects(new ArrayList<TwiceChemicalReagentEntity>());
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				return baseResponse;
			}
			//分页查询结果集
			chemicalReagentQueryFormEntity.setPageSize(totalRecords);
			List<TwiceChemicalReagentEntity> chemicalReagentEntitys=chemicalReagentDao.queryTwiceChemicalReagentList(chemicalReagentQueryFormEntity);
			baseResponse.setReturnObjects(chemicalReagentEntitys);
			if(chemicalReagentEntitys!=null){
				Map<Integer,TwiceChemicalReagentEntity> chemicalReagentMap=new HashMap<Integer,TwiceChemicalReagentEntity>();
				for(TwiceChemicalReagentEntity chemicalReagentEntity:chemicalReagentEntitys){
					if(chemicalReagentEntity.getChemicalReagentRelations()==null){
						chemicalReagentEntity.setChemicalReagentRelations(new ArrayList<TwiceChemicalReagentRelationEntity>());
					}
					if(chemicalReagentEntity.getCompoundReagents()==null){
						chemicalReagentEntity.setCompoundReagents(new ArrayList<TwiceChemicalCompoundReagentsEntity>());
					}
					
					chemicalReagentMap.put(chemicalReagentEntity.getCrID(), chemicalReagentEntity);
				}
				getTwiceChemicalCompoundReagents(chemicalReagentMap);
				getTwiceChemicalReagentRelations(chemicalReagentMap);
			}
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("chemicalReagentManage.workflow.service.exportChemicalReagent.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.service.exportChemicalReagent.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseTablesResponse queryTwiceChemicalReagentMixtureList(
			TwiceChemicalReagentMixtureQueryFormEntity chemicalReagentMixtureQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=chemicalReagentDao.queryTwiceChemicalReagentMixtureTotalRecords(chemicalReagentMixtureQueryFormEntity);
			//分页查询结果集
			List<TwiceChemicalCompoundReagentsEntity> chemicalCompoundReagentsEntitys=chemicalReagentDao.queryTwiceChemicalReagentMixtureList(chemicalReagentMixtureQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(chemicalReagentMixtureQueryFormEntity.getDraw());
			if(chemicalCompoundReagentsEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(chemicalCompoundReagentsEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("chemicalReagentManage.workflow.service.reagentMixtureDetail.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("chemicalReagentManage.workflow.service.reagentMixtureDetail.exception"));
		}
		return baseResponse;
	}
	@Override
	public TwiceChemicalReagentEntity getTwiceChemicalReagent(TwiceChemicalReagentQueryFormEntity chemicalReagentQueryFormEntity)
			throws Exception {
		TwiceChemicalReagentEntity chemicalReagentEntity=null;
		try{
			chemicalReagentQueryFormEntity.setStartPageNum(0);
			chemicalReagentQueryFormEntity.setPageSize(1);
			List<TwiceChemicalReagentEntity> chemicalReagentEntitys=chemicalReagentDao.queryTwiceChemicalReagentList(chemicalReagentQueryFormEntity);
			if(chemicalReagentEntitys!=null){
				chemicalReagentEntity=chemicalReagentEntitys.get(0);
				if(chemicalReagentEntity!=null){
					if(chemicalReagentEntity.getChemicalReagentRelations()==null){
						chemicalReagentEntity.setChemicalReagentRelations(new ArrayList<TwiceChemicalReagentRelationEntity>());
					}
					if(chemicalReagentEntity.getCompoundReagents()==null){
						chemicalReagentEntity.setCompoundReagents(new ArrayList<TwiceChemicalCompoundReagentsEntity>());
					}
					Map<Integer,TwiceChemicalReagentEntity> chemicalReagentMap=new HashMap<Integer,TwiceChemicalReagentEntity>();
					chemicalReagentMap.put(chemicalReagentEntity.getCrID(), chemicalReagentEntity);
					getTwiceChemicalCompoundReagents(chemicalReagentMap);
					List<TwiceChemicalReagentRelationEntity> chemicalReagentRelations=chemicalReagentDao.getTwiceChemicalReagentRelations(String.valueOf(chemicalReagentEntity.getCrID()));
					if(chemicalReagentRelations!=null){
						chemicalReagentEntity.getChemicalReagentRelations().addAll(chemicalReagentRelations);
					}
				}
				
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("chemicalReagentManage.workflow.service.exportChemicalReagent.exception"),e);
		}
		if(chemicalReagentEntity==null){
			chemicalReagentEntity=new TwiceChemicalReagentEntity();
		}
		return chemicalReagentEntity;
	}
	
}

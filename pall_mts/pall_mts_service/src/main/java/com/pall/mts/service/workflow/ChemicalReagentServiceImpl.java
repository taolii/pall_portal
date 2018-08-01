package com.pall.mts.service.workflow;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;

import com.pall.mts.common.constants.IResponseConstants;
import com.pall.mts.common.datatables.Entity.DatatablesView;
import com.pall.mts.common.i18n.ResourceUtils;
import com.pall.mts.common.response.BaseResponse;
import com.pall.mts.common.response.BaseTablesResponse;
import com.pall.mts.repository.entity.workflow.ChemicalCompoundReagentsEntity;
import com.pall.mts.repository.entity.workflow.ChemicalReagentEntity;
import com.pall.mts.repository.entity.workflow.ChemicalReagentMixtureQueryFormEntity;
import com.pall.mts.repository.entity.workflow.ChemicalReagentQueryFormEntity;
import com.pall.mts.repository.entity.workflow.ChemicalReagentRelationEntity;
import com.pall.mts.repository.mapper.workflow.ChemicalReagentDao;
import com.pall.mts.service.workflow.ChemicalReagentService;

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
					getChemicalCompoundReagents(chemicalReagentMap);
					getChemicalReagentRelations(chemicalReagentMap);
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
			Set<String> tempSet=new TreeSet<String>();
			for(ChemicalReagentRelationEntity chemicalReagentRelationEntity:chemicalReagentRelations){
				if(chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID())!=null){
					chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).getChemicalReagentRelations().add(chemicalReagentRelationEntity);
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getTrayLotNum())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getTrayLotNum());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setTrayLotNums(chemicalReagentRelationEntity.getTrayLotNum());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setTrayLotNums(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.gettLotNum())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.gettLotNum());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).settLotNums(chemicalReagentRelationEntity.gettLotNum());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).settLotNums(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getAssemblyLotNum())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getAssemblyLotNum());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setAssemblyLotNums(chemicalReagentRelationEntity.getAssemblyLotNum());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setAssemblyLotNums(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getAssemblyBom())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getAssemblyBom());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setAssemblyBoms(chemicalReagentRelationEntity.getAssemblyBom());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setAssemblyBoms(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getApsLotNum())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getApsLotNum());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setApsLotNums(chemicalReagentRelationEntity.getApsLotNum());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setApsLotNums(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getApsBom())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getApsBom());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setApsBoms(chemicalReagentRelationEntity.getApsBom());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setApsBoms(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getOcLotNum())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getOcLotNum());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setOcLotNums(chemicalReagentRelationEntity.getOcLotNum());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setOcLotNums(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getOcBom())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getOcBom());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setOcBoms(chemicalReagentRelationEntity.getOcBom());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setOcBoms(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getCleanLotNum())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getCleanLotNum());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setCleanLotNums(chemicalReagentRelationEntity.getCleanLotNum());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setCleanLotNums(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getCleanBom())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getCleanBom());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setCleanBoms(chemicalReagentRelationEntity.getCleanBom());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setCleanBoms(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getPolishLotNum())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getPolishLotNum());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setPolishLotNums(chemicalReagentRelationEntity.getPolishLotNum());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setPolishLotNums(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
					if(!StringUtils.isEmpty(chemicalReagentRelationEntity.getPolishBom())){
						tempSet.clear();
						String[]temps=StringUtils.commaDelimitedListToStringArray(chemicalReagentRelationEntity.getPolishBom());
						if(ObjectUtils.isEmpty(temps)){
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setPolishBoms(chemicalReagentRelationEntity.getPolishBom());
						}else{
							tempSet.addAll(Arrays.asList(temps));
							chemicalReagentMap.get(chemicalReagentRelationEntity.getCrID()).setPolishBoms(StringUtils.collectionToCommaDelimitedString(tempSet));
						}
					}
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
						resultNum=chemicalReagentDao.addChemicalCompoundReagents(chemicalCompoundReagentsEntity);
					}
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
						resultNum=chemicalReagentDao.addChemicalCompoundReagents(chemicalCompoundReagentsEntity);
					}
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
			//删除化学试剂信息
			chemicalReagentDao.delChemicalCompoundReagents(crIDs);
			//删除关系关系对象信息
			chemicalReagentDao.delChemicalReagentRelations(crIDs);
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
			if(totalRecords==0){
				baseResponse.setReturnObjects(new ArrayList<ChemicalReagentEntity>());
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				return baseResponse;
			}
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
					
					chemicalReagentMap.put(chemicalReagentEntity.getCrID(), chemicalReagentEntity);
				}
				getChemicalCompoundReagents(chemicalReagentMap);
				getChemicalReagentRelations(chemicalReagentMap);
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
	public BaseTablesResponse queryChemicalReagentMixtureList(
			ChemicalReagentMixtureQueryFormEntity chemicalReagentMixtureQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=chemicalReagentDao.queryChemicalReagentMixtureTotalRecords(chemicalReagentMixtureQueryFormEntity);
			//分页查询结果集
			List<ChemicalCompoundReagentsEntity> chemicalCompoundReagentsEntitys=chemicalReagentDao.queryChemicalReagentMixtureList(chemicalReagentMixtureQueryFormEntity);
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
	public ChemicalReagentEntity getChemicalReagent(ChemicalReagentQueryFormEntity chemicalReagentQueryFormEntity)
			throws Exception {
		ChemicalReagentEntity chemicalReagentEntity=null;
		try{
			chemicalReagentQueryFormEntity.setStartPageNum(0);
			chemicalReagentQueryFormEntity.setPageSize(1);
			List<ChemicalReagentEntity> chemicalReagentEntitys=chemicalReagentDao.queryChemicalReagentList(chemicalReagentQueryFormEntity);
			if(chemicalReagentEntitys!=null){
				chemicalReagentEntity=chemicalReagentEntitys.get(0);
				if(chemicalReagentEntity!=null){
					if(chemicalReagentEntity.getChemicalReagentRelations()==null){
						chemicalReagentEntity.setChemicalReagentRelations(new ArrayList<ChemicalReagentRelationEntity>());
					}
					if(chemicalReagentEntity.getCompoundReagents()==null){
						chemicalReagentEntity.setCompoundReagents(new ArrayList<ChemicalCompoundReagentsEntity>());
					}
					Map<Integer,ChemicalReagentEntity> chemicalReagentMap=new HashMap<Integer,ChemicalReagentEntity>();
					chemicalReagentMap.put(chemicalReagentEntity.getCrID(), chemicalReagentEntity);
					getChemicalCompoundReagents(chemicalReagentMap);
					List<ChemicalReagentRelationEntity> chemicalReagentRelations=chemicalReagentDao.getChemicalReagentRelations(String.valueOf(chemicalReagentEntity.getCrID()));
					if(chemicalReagentRelations!=null){
						chemicalReagentEntity.getChemicalReagentRelations().addAll(chemicalReagentRelations);
					}
				}
				
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("chemicalReagentManage.workflow.service.exportChemicalReagent.exception"),e);
		}
		if(chemicalReagentEntity==null){
			chemicalReagentEntity=new ChemicalReagentEntity();
		}
		return chemicalReagentEntity;
	}
	
}

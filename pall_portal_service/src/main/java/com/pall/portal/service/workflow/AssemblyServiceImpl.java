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
import com.pall.portal.common.constants.KeyConstants;
import com.pall.portal.common.datatables.Entity.DatatablesView;
import com.pall.portal.common.i18n.ResourceUtils;
import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.init.UmsConfigInitiator;
import com.pall.portal.repository.entity.workflow.AssemblyEntity;
import com.pall.portal.repository.entity.workflow.AssemblyQueryFormEntity;
import com.pall.portal.repository.entity.workflow.ChemicalReagentEntity;
import com.pall.portal.repository.entity.workflow.DefectEntity;
import com.pall.portal.repository.mapper.workflow.AssemblyDao;
import com.pall.portal.repository.mapper.workflow.DefectDao;

/*
 * 工作流服务实现类
 */
@Repository
public class AssemblyServiceImpl implements AssemblyService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private AssemblyDao assemblyDao;
	@Autowired
	private DefectDao defectDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseTablesResponse queryAssemblyList(AssemblyQueryFormEntity  assemblyQueryFormEntity) throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=assemblyDao.queryAssemblyQueryTotalRecords(assemblyQueryFormEntity);
			//分页查询结果集
			List<AssemblyEntity> assemblyEntitys=assemblyDao.queryAssemblyQueryList(assemblyQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(assemblyQueryFormEntity.getDraw());
			if(assemblyEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(getDefectRecords(assemblyEntitys));
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("assemblyManage.workflow.service.queryassemblyList.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.workflow.service.queryassemblyList.exception"));
		}
		return baseResponse;
	}
	/*
	 * 获取缺损信息
	 */
	private List<AssemblyEntity> getDefectRecords(List<AssemblyEntity> assemblyEntitys) throws Exception{
		List<Integer> defectids=new ArrayList<Integer>();
		Map<Integer,AssemblyEntity> map=new HashMap<Integer,AssemblyEntity>();
		for(AssemblyEntity assemblyEntity:assemblyEntitys){
			defectids.add(assemblyEntity.getAssemblyID());
			map.put(assemblyEntity.getAssemblyID(),assemblyEntity);
		}
		if(defectids.size()>0){
			List<Integer> defectTypes=new ArrayList<Integer>();
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_WF)));
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_NWF)));
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_CLAMPING)));
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_INSTALLHUB)));
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_OTHER)));
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
		}
		return assemblyEntitys;
	}
	@Override
	public BaseResponse addAssembly(AssemblyEntity assemblyEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=assemblyDao.addAssembly(assemblyEntity);
			if(resultNum>0){
				List<DefectEntity> defects=assemblyEntity.getDefects();
				if(defects!=null && defects.size()>0){
					for(DefectEntity defectEntity:defects){
						defectEntity.setDefectID(assemblyEntity.getAssemblyID());
					}
					resultNum=defectDao.addDefectResult(defects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.workflow.dao.addDefectResult.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.workflow.dao.addAssembly.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("assemblyManage.workflow.service.addAssembly.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.workflow.service.addAssembly.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse  modifyAssembly(AssemblyEntity assemblyEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			int resultNum=assemblyDao.modifyAssembly(assemblyEntity);
			if(resultNum>0){
				List<DefectEntity> defects=assemblyEntity.getDefects();
				if(defects!=null && defects.size()>0){
					List<Integer> defectIDs=new ArrayList<Integer>();
					defectIDs.add(assemblyEntity.getAssemblyID());
					List<Integer> defectTypes=new ArrayList<Integer>();
					defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_WF)));
					defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.OPTICALFILMING_DATACONFIG_TYPE_DEFECT_NWF)));
					defectDao.delDefectResult(defectIDs,defectTypes);
					for(DefectEntity defectEntity:defects){
						defectEntity.setDefectID(assemblyEntity.getAssemblyID());
					}
					resultNum=defectDao.addDefectResult(defects);
					if(resultNum>0){
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
					}else{
						baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
						baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.workflow.dao.addDefectResult.failed"));
					}
				}else{
					baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				}
			}else{
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
				baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.workflow.dao.modifyAssembly.failed"));
			}
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("assemblyManage.workflow.service.modifyAssembly.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.workflow.service.modifyAssembly.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse delAssembly(List<Integer> assemblyIDS) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			assemblyDao.delAssembly(assemblyIDS);
			List<Integer> defectTypes=new ArrayList<Integer>();
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_WF)));
			defectTypes.add(Integer.parseInt(UmsConfigInitiator.getDataConfig(KeyConstants.ASSEMBLY_DATACONFIG_TYPE_DEFECT_NWF)));
			defectDao.delDefectResult(assemblyIDS,defectTypes);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("assemblyManage.workflow.service.delAssembly.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.workflow.service.delAssembly.exception"));
		}
		return baseResponse;
	}
	@Override
	public BaseResponse exportAssembly(AssemblyQueryFormEntity  assemblyQueryFormEntity) throws Exception {
		BaseResponse baseResponse=new BaseResponse();
		try{
			assemblyQueryFormEntity.setStartPageNum(0);
			//查询总记录数
			int totalRecords=assemblyDao.queryAssemblyQueryTotalRecords(assemblyQueryFormEntity);
			if(totalRecords==0){
				baseResponse.setReturnObjects(new ArrayList<AssemblyEntity>());
				baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
				return baseResponse;
			}
			//分页查询结果集
			assemblyQueryFormEntity.setPageSize(totalRecords);
			List<AssemblyEntity> assemblyEntitys=assemblyDao.queryAssemblyQueryList(assemblyQueryFormEntity);
			assemblyEntitys=getDefectRecords(assemblyEntitys);
			baseResponse.setReturnObjects(assemblyEntitys);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("assemblyManage.workflow.service.exportAssembly.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("assemblyManage.workflow.service.exportAssembly.exception"));
		}
		return baseResponse;
	}
	
}

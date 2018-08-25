package com.pall.mts.service.report;

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
import com.pall.mts.common.response.BaseTablesResponse;
import com.pall.mts.init.UmsConfigInitiator;
import com.pall.mts.repository.entity.report.AssemblyScrapSummaryEntity;
import com.pall.mts.repository.entity.report.AssemblyScrapSummaryQueryFormEntity;
import com.pall.mts.repository.entity.report.ProductTrackingEntity;
import com.pall.mts.repository.entity.report.ProductTrackingQueryFormEntity;
import com.pall.mts.repository.entity.workflow.DefectEntity;
import com.pall.mts.repository.mapper.report.ReportSummaryDao;
import com.pall.mts.service.report.ReportSummaryService;

/*
 * 报表统计服务层
 */
@Repository
public class ReportSummaryServiceImpl implements ReportSummaryService{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ReportSummaryDao reportSummaryDao;
	@Autowired
	private ResourceUtils resourceUtils;
	@Override
	public BaseTablesResponse queryAssemblyScrapSummary(AssemblyScrapSummaryQueryFormEntity assemblyScrapSummaryQueryFormEntity)
			throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=reportSummaryDao.queryAssemblyScrapSummaryTotalRecords(assemblyScrapSummaryQueryFormEntity);
			//分页查询结果集
			List<AssemblyScrapSummaryEntity> assemblyScrapSummaryEntitys=reportSummaryDao.queryAssemblyScrapSummary(assemblyScrapSummaryQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(assemblyScrapSummaryQueryFormEntity.getDraw());
			if(assemblyScrapSummaryEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(getDefectRecords(assemblyScrapSummaryEntitys));
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("report.assemblyScrapSummary.service.queryAssemblyScrapSummary.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("report.assemblyScrapSummary.service.queryAssemblyScrapSummary.exception"));
		}
		return baseResponse;
	}
	/*
	 * 获取缺损信息
	 */
	private List<AssemblyScrapSummaryEntity> getDefectRecords(List<AssemblyScrapSummaryEntity> assemblyScrapSummaryEntitys) throws Exception{
		List<AssemblyScrapSummaryEntity> tempAssemblyScrapSummaryEntitys=new ArrayList<AssemblyScrapSummaryEntity>();
		Map<String,AssemblyScrapSummaryEntity> map=new HashMap<String,AssemblyScrapSummaryEntity>();
		for(AssemblyScrapSummaryEntity assemblyScrapSummaryEntity:assemblyScrapSummaryEntitys){
			if(map.get(assemblyScrapSummaryEntity.getOutputLotNum()+assemblyScrapSummaryEntity.getPartNum()+assemblyScrapSummaryEntity.getWorkOrderNum())==null){
				map.put(assemblyScrapSummaryEntity.getOutputLotNum()+assemblyScrapSummaryEntity.getPartNum()+assemblyScrapSummaryEntity.getWorkOrderNum(),assemblyScrapSummaryEntity);
				assemblyScrapSummaryEntity.setDefects(new ArrayList<DefectEntity>());
				tempAssemblyScrapSummaryEntitys.add(assemblyScrapSummaryEntity);
			}
			DefectEntity defectEntity=new DefectEntity();
			defectEntity.setFieldName(UmsConfigInitiator.getDataConfig(KeyConstants.REPORT_ASSEMBLY_SCRAP_SUMMARY_TABLENAME)+assemblyScrapSummaryEntity.getDataid());
			defectEntity.setDefectValue(assemblyScrapSummaryEntity.getDefectValues());
			map.get(assemblyScrapSummaryEntity.getOutputLotNum()+assemblyScrapSummaryEntity.getPartNum()+assemblyScrapSummaryEntity.getWorkOrderNum()).getDefects().add(defectEntity);
		}
		return tempAssemblyScrapSummaryEntitys;
	}
	@Override
	public BaseTablesResponse queryProductTracking(ProductTrackingQueryFormEntity productTrackingQueryFormEntity)
			throws Exception {
		BaseTablesResponse baseResponse=new BaseTablesResponse();
		try{
			//查询总记录数
			int totalRecords=reportSummaryDao.queryProductTrackingTotalRecords(productTrackingQueryFormEntity);
			//分页查询结果集
			List<ProductTrackingEntity> assemblyScrapSummaryEntitys=reportSummaryDao.queryProductTracking(productTrackingQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(productTrackingQueryFormEntity.getDraw());
			if(assemblyScrapSummaryEntitys!=null){
				datatablesViews.setiTotalDisplayRecords(totalRecords);
				datatablesViews.setRecordsTotal(totalRecords);
				datatablesViews.setData(assemblyScrapSummaryEntitys);
			}
			baseResponse.setDatatablesView(datatablesViews);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_SUCCESS);
		}catch(Exception e){
			logger.error(resourceUtils.getMessage("report.productTracking.service.productTracking.exception"),e);
			baseResponse.setResultCode(IResponseConstants.RESPONSE_CODE_FAILED);
			baseResponse.setResultMsg(resourceUtils.getMessage("report.productTracking.service.productTracking.exception"));
		}
		return baseResponse;
	}
	@Override
	public List<AssemblyScrapSummaryEntity> queryAssemblyScrapSummaryList(
			AssemblyScrapSummaryQueryFormEntity assemblyScrapSummaryQueryFormEntity) throws Exception {
		List<AssemblyScrapSummaryEntity> assemblyScrapSummaryEntitys=null;
		try{
			assemblyScrapSummaryEntitys=reportSummaryDao.queryAssemblyScrapSummary(assemblyScrapSummaryQueryFormEntity);
			DatatablesView datatablesViews=new DatatablesView();
			datatablesViews.setDraw(assemblyScrapSummaryQueryFormEntity.getDraw());
			if(assemblyScrapSummaryEntitys!=null){
				assemblyScrapSummaryEntitys=getDefectRecords(assemblyScrapSummaryEntitys);
			}
		}catch(Exception e){
			throw e;
		}
		return assemblyScrapSummaryEntitys;
	}
}

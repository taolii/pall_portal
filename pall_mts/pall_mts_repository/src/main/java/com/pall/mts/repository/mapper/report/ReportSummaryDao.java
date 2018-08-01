package com.pall.mts.repository.mapper.report;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.pall.mts.repository.entity.report.AssemblyScrapSummaryEntity;
import com.pall.mts.repository.entity.report.AssemblyScrapSummaryQueryFormEntity;
import com.pall.mts.repository.entity.report.ProductTrackingEntity;
import com.pall.mts.repository.entity.report.ProductTrackingQueryFormEntity;

/*
 * 工作流数据访问层
 */
@Repository("reportSummaryDao")
public interface ReportSummaryDao {
	/*
	 * 根据条件查询组装报废汇总信息
	 * @param assemblyScrapSummaryQueryFormEntity 组装报废汇总查询对象
	 * @return 查询结果
	 */
	public List<AssemblyScrapSummaryEntity> queryAssemblyScrapSummary(AssemblyScrapSummaryQueryFormEntity  assemblyScrapSummaryQueryFormEntity);
	/*
	 * 根据条件查询组装报废汇总记录数
	 * @param assemblyScrapSummaryQueryFormEntity 组装报废汇总查询对象
	 * @return 查询结果
	 */
	public int queryAssemblyScrapSummaryTotalRecords(AssemblyScrapSummaryQueryFormEntity  assemblyScrapSummaryQueryFormEntity);
	/*
	 * 根据条件查询产品跟踪信息
	 * @param productTrackingQueryFormEntity 产品跟踪查询对象
	 * @return 查询结果
	 */
	public List<ProductTrackingEntity> queryProductTracking(ProductTrackingQueryFormEntity productTrackingQueryFormEntity);
	/*
	 * 根据条件查询产品跟踪记录数
	 * @param productTrackingQueryFormEntity 产品跟踪查询对象
	 * @return 查询结果
	 */
	public int queryProductTrackingTotalRecords(ProductTrackingQueryFormEntity productTrackingQueryFormEntity);
	
}

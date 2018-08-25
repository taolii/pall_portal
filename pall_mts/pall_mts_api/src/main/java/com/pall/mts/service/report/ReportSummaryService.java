package com.pall.mts.service.report;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.mts.common.response.BaseTablesResponse;
import com.pall.mts.repository.entity.report.AssemblyScrapSummaryEntity;
import com.pall.mts.repository.entity.report.AssemblyScrapSummaryQueryFormEntity;
import com.pall.mts.repository.entity.report.ProductTrackingQueryFormEntity;

/*
 * 组装报废汇总服务层
 */
@Service
public interface ReportSummaryService {
	/*
	 * 根据条件查询组装报废汇总信息
	 * @param assemblyScrapSummaryQueryFormEntity 组装信息查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryAssemblyScrapSummary(AssemblyScrapSummaryQueryFormEntity  assemblyScrapSummaryQueryFormEntity) throws Exception;
	/*
	 * 根据条件查询产品跟踪信息
	 * @param productTrackingQueryFormEntity 产品跟踪查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryProductTracking(ProductTrackingQueryFormEntity productTrackingQueryFormEntity) throws Exception;
	/*
	 * 根据条件查询组装报废汇总信息
	 * @param assemblyScrapSummaryQueryFormEntity 组装信息查询对象
	 * @return 查询结果
	 */
	public List<AssemblyScrapSummaryEntity> queryAssemblyScrapSummaryList(AssemblyScrapSummaryQueryFormEntity  assemblyScrapSummaryQueryFormEntity) throws Exception;
}

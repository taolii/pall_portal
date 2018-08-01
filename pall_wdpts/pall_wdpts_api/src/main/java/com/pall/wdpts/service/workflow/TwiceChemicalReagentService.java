package com.pall.wdpts.service.workflow;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.wdpts.common.response.BaseResponse;
import com.pall.wdpts.common.response.BaseTablesResponse;
import com.pall.wdpts.repository.entity.workflow.TwiceChemicalReagentEntity;
import com.pall.wdpts.repository.entity.workflow.TwiceChemicalReagentMixtureQueryFormEntity;
import com.pall.wdpts.repository.entity.workflow.TwiceChemicalReagentQueryFormEntity;

/*
 * 工作流服务接口
 */
@Service
public interface TwiceChemicalReagentService {
	/*
	 * 根据条件查询化学试剂记录信息
	 * @param twiceChemicalReagentQueryFormEntity 化学试剂信息查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryTwiceChemicalReagentList(TwiceChemicalReagentQueryFormEntity  twiceChemicalReagentQueryFormEntity) throws Exception;
	/*
	 * 根据条件查询化学试剂混合信息
	 * @param twiceChemicalReagentMixtureQueryFormEntity 化学混合试剂查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryTwiceChemicalReagentMixtureList(TwiceChemicalReagentMixtureQueryFormEntity  twiceChemicalReagentMixtureQueryFormEntity) throws Exception;
	/*
	 * 添加化学试剂信息
	 * @param twiceChemicalReagentEntity 化学试剂信息
	 * @return 添加结果
	 */
	public BaseResponse addTwiceChemicalReagent(TwiceChemicalReagentEntity twiceChemicalReagentEntity) throws Exception;
	/*
	 * 修改化学试剂信息
	 * @param twiceChemicalReagentEntity 化学试剂信息
	 * @return 修改结果
	 */
	public BaseResponse modifyTwiceChemicalReagent(TwiceChemicalReagentEntity twiceChemicalReagentEntity) throws Exception;
	/*
	 * 删除化学试剂信息
	 * @param crIDs 需要删除的化学试剂信息列表
	 * @return 删除结果
	 */
	public BaseResponse delTwiceChemicalReagent(List<Integer> crIDs) throws Exception;
	/*
	 * 导出化学试剂信息
	 * @param twiceChemicalReagentQueryFormEntity 化学试剂信息查询对象
	 * @return 导出结果
	 */
	public BaseResponse exportTwiceChemicalReagent(TwiceChemicalReagentQueryFormEntity  twiceChemicalReagentQueryFormEntity) throws Exception;
	/*
	 * 导出化学试剂信息
	 * @param twiceChemicalReagentQueryFormEntity 化学试剂信息查询对象
	 * @return 导出结果
	 */
	public TwiceChemicalReagentEntity getTwiceChemicalReagent(TwiceChemicalReagentQueryFormEntity  twiceChemicalReagentQueryFormEntity) throws Exception;
}

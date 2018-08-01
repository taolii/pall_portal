package com.pall.mts.service.reagentmixture;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.mts.common.response.BaseResponse;
import com.pall.mts.common.response.BaseTablesResponse;
import com.pall.mts.repository.entity.reagentmixture.ReagentMixtureEntity;
import com.pall.mts.repository.entity.reagentmixture.ReagentMixtureQueryFormEntity;
import com.pall.mts.repository.entity.reagentmixture.ReagentMixtureSnsQueryFormEntity;

/*
 * 试剂混合管理服务
 */
@Service
public interface ReagentMixtureManageService {
	/*
	 * 根据条件查询混合试剂信息
	 * @param reagentMixtureQueryFormEntity 混合试剂查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryReagentMixtureList(ReagentMixtureQueryFormEntity  reagentMixtureQueryFormEntity) throws Exception;
	/*
	 * 删除混合试剂信息
	 * @param rmids 需要删除的混合试剂列表
	 * @return 删除结果
	 */
	public BaseResponse delReagentMixture(List<String> rmids) throws Exception;
	/*
	 * 新增混合试剂信息
	 * @param reagentMixtureEntity 混合试剂对象
	 * @return 结果
	 */
	public BaseResponse addReagentMixture(ReagentMixtureEntity reagentMixtureEntity) throws Exception;
	/*
	 * 修改混合试剂信息
	 * @param reagentMixtureEntity 混合试剂对象
	 * @return 结果
	 */
	public BaseResponse modReagentMixture(ReagentMixtureEntity reagentMixtureEntity) throws Exception;
	/*
	 * 根据条件查询混合试剂信息
	 * @param reagentMixtureQueryFormEntity 混合试剂查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryReagentSnsMixtureList(ReagentMixtureSnsQueryFormEntity  reagentMixtureSnsQueryFormEntity) throws Exception; 
	/*
	 * 根据条件查询混合试剂信息
	 * @param reagentMixtureQueryFormEntity 混合试剂查询对象
	 * @return 查询结果
	 */
	public BaseResponse queryReagentMixture(ReagentMixtureQueryFormEntity  reagentMixtureQueryFormEntity) throws Exception;
	
}

package com.pall.wdpts.repository.mapper.reagentmixture;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pall.wdpts.repository.entity.reagentmixture.ReagentMixtureEntity;
import com.pall.wdpts.repository.entity.reagentmixture.ReagentMixtureEntitySns;
import com.pall.wdpts.repository.entity.reagentmixture.ReagentMixtureQueryFormEntity;
import com.pall.wdpts.repository.entity.reagentmixture.ReagentMixtureSnsQueryFormEntity;
/*
 * 混合试剂数据访问层
 */
public interface ReagentMixtureManageDao {
	/*
	 * 根据条件查询混合试剂信息
	 * @param reagentMixtureQueryFormEntity 混合试剂查询对象
	 * @return 查询结果
	 */
	public List<ReagentMixtureEntity> queryReagentMixtureList(ReagentMixtureQueryFormEntity  reagentMixtureQueryFormEntity) throws Exception;
	/*
	 * 根据条件查询混合试剂总记录数
	 * @param reagentMixtureQueryFormEntity 混合试剂查询对象
	 * @return 查询结果
	 */
	public int queryReagentMixtureTotalRecords(ReagentMixtureQueryFormEntity  reagentMixtureQueryFormEntity);
	/*
	 * 删除混合试剂信息
	 * @param rmids 需要删除的混合试剂列表
	 * @return 删除结果
	 */
	public int delReagentMixture(@Param("rmids") List<String> rmids) throws Exception;
	/*
	 * 新增混合试剂信息
	 * @param reagentMixtureEntity 混合试剂对象
	 * @return 结果
	 */
	public int addReagentMixture(ReagentMixtureEntity reagentMixtureEntity) throws Exception;
	/*
	 * 修改混合试剂信息
	 * @param reagentMixtureEntity 混合试剂对象
	 * @return 结果
	 */
	public int modReagentMixture(ReagentMixtureEntity reagentMixtureEntity) throws Exception;
	/*
	 * 新增混合试剂编号信息
	 * @param reagentMixtureEntity 混合试剂对象
	 * @return 结果
	 */
	public int addReagentMixtureSns(List<ReagentMixtureEntitySns> reagentMixtureEntitySns) throws Exception;
	/*
	 * 删除混合试剂编号信息
	 * @param rmids 需要删除的混合试剂列表
	 * @return 删除结果
	 */
	public int delReagentMixtureSns(@Param("rmids") List<String> rmids) throws Exception;
	/*
	 * 查询混合试剂编号信息
	 * @param rmids 需要查询的混合试剂列表
	 * @return 
	 */
	public List<ReagentMixtureEntitySns> queryReagentMixtureSns(@Param("rmids") List<String> rmids) throws Exception;
	/*
	 * 查询混合试剂编号信息
	 * @param reagentMixtureSnsQueryFormEntity 混合试剂查询对象
	 * @return 查询结果
	 */
	public List<ReagentMixtureEntitySns> queryReagentSnsMixtureList(ReagentMixtureSnsQueryFormEntity  reagentMixtureSnsQueryFormEntity) throws Exception;
	/*
	 * 查询混合试剂编号总记录数
	 * @param reagentMixtureSnsQueryFormEntity 混合试剂查询对象
	 * @return 查询结果
	 */
	public int queryReagentMixtureSnsTotalRecords(ReagentMixtureSnsQueryFormEntity  reagentMixtureSnsQueryFormEntity);
}

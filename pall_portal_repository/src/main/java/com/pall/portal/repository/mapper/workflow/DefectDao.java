package com.pall.portal.repository.mapper.workflow;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.portal.repository.entity.workflow.DefectEntity;

/*
 * 工作流数据访问层
 */
@Repository("defectDao")
public interface DefectDao {
	/*
	 * 根据条件查询抛光缺损记录信息
	 * @param defectids 缺损信息（缺损id与缺损类型为唯一标示）
	 * @param defectidTypes 缺损类型
	 * @return 查询结果
	 */
	public List<DefectEntity> queryDefectList(@Param("defectids") List<Integer> defectids,@Param("defectidTypes") List<Integer> defectidTypes);
	/*
	 * 添加缺损结果信息
	 * @param DefectEntity 缺损结果信息
	 * @return 添加结果
	 */
	public int addDefectResult(List<DefectEntity> defects) throws Exception;
	/*
	 * 修改缺损结果信息
	 * @param DefectEntity 缺损结果信息
	 * @return 修改结果
	 */
	public int modifyDefectResult(DefectEntity defectEntity) throws Exception;
	/*
	 * 删除缺损结果信息
	 * @param defectids 需要删除的缺损结果信息列表
	 * @param defectidTypes 缺损类型
	 * @return 删除结果
	 */
	public int delDefectResult(@Param("defectIDs") List<Integer> defectIDs,@Param("defectidTypes") List<Integer> defectidTypes) throws Exception;
}

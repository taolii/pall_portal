package com.pall.mts.repository.mapper.workflow;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.mts.repository.entity.workflow.OpticalCoatingEntity;
import com.pall.mts.repository.entity.workflow.OpticalFilmingQueryFormEntity;

/*
 * 工作流数据访问层
 */
@Repository("opticalFilmingDao")
public interface OpticalFilmingDao {
	/*
	 * 根据条件查询光学镀膜记录信息
	 * @param opticalFilmingQueryFormEntity 光学镀膜信息查询对象
	 * @return 查询结果
	 */
	public List<OpticalCoatingEntity> queryOpticalFilmingList(OpticalFilmingQueryFormEntity  opticalFilmingQueryFormEntity);
	/*
	 * 根据条件查询光学镀膜记录数
	 * @param opticalFilmingQueryFormEntity 光学镀膜信息查询对象
	 * @return 查询结果
	 */
	public int queryOpticalFilmingTotalRecords(OpticalFilmingQueryFormEntity  opticalFilmingQueryFormEntity);
	/*
	 * 添加光学镀膜信息
	 * @param opticalCoatingEntity 光学镀膜信息
	 * @return 添加结果
	 */
	public int addOpticalFilming(OpticalCoatingEntity opticalCoatingEntity) throws Exception;
	/*
	 * 修改光学镀膜信息
	 * @param opticalCoatingEntity 光学镀膜信息
	 * @return 修改结果
	 */
	public int modifyOpticalFilming(OpticalCoatingEntity opticalCoatingEntity) throws Exception;
	/*
	 * 删除光学镀膜信息
	 * @param optIDs 需要删除的光学镀膜信息列表
	 * @return 删除结果
	 */
	public int delOpticalFilming(@Param("opfIDs") List<Integer> opfIDs) throws Exception;
	
}

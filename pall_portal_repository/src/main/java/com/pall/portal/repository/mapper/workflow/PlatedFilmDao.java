package com.pall.portal.repository.mapper.workflow;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.portal.repository.entity.workflow.PlatedFilmEntity;
import com.pall.portal.repository.entity.workflow.PlatedFilmQueryFormEntity;

/*
 * 工作流数据访问层
 */
@Repository("platedFilmDao")
public interface PlatedFilmDao {
	/*
	 * 根据条件查询化学镀膜记录信息
	 * @param platedFilmQueryFormEntity 化学镀膜信息查询对象
	 * @return 查询结果
	 */
	public List<PlatedFilmEntity> queryPlatedFilmList(PlatedFilmQueryFormEntity  platedFilmQueryFormEntity);
	/*
	 * 根据条件查询化学镀膜记录数
	 * @param platedFilmQueryFormEntity 化学镀膜信息查询对象
	 * @return 查询结果
	 */
	public int queryPlatedFilmTotalRecords(PlatedFilmQueryFormEntity  platedFilmQueryFormEntity);
	/*
	 * 添加化学镀膜信息
	 * @param platedFilmEntity 化学镀膜信息
	 * @return 添加结果
	 */
	public int addPlatedFilm(PlatedFilmEntity platedFilmEntity) throws Exception;
	/*
	 * 修改化学镀膜信息
	 * @param platedFilmEntity 化学镀膜信息
	 * @return 修改结果
	 */
	public int modifyPlatedFilm(PlatedFilmEntity platedFilmEntity) throws Exception;
	/*
	 * 删除化学镀膜信息
	 * @param pfIDs 需要删除的化学镀膜信息列表
	 * @return 删除结果
	 */
	public int delPlatedFilm(@Param("pfIDs") List<Integer> pfIDs) throws Exception;
	
}

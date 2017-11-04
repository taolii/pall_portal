package com.pall.portal.service.workflow;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pall.portal.common.response.BaseResponse;
import com.pall.portal.common.response.BaseTablesResponse;
import com.pall.portal.repository.entity.workflow.PlatedFilmEntity;
import com.pall.portal.repository.entity.workflow.PlatedFilmQueryFormEntity;

/*
 * 工作流服务接口
 */
@Service
public interface PlatedFilmService {
	/*
	 * 根据条件查询化学镀膜记录信息
	 * @param platedFilmQueryFormEntity 化学镀膜信息查询对象
	 * @return 查询结果
	 */
	public BaseTablesResponse queryPlatedFilmList(PlatedFilmQueryFormEntity  platedFilmQueryFormEntity) throws Exception;
	/*
	 * 添加化学镀膜信息
	 * @param platedFilmEntity 化学镀膜信息
	 * @return 添加结果
	 */
	public BaseResponse addPlatedFilm(PlatedFilmEntity platedFilmEntity) throws Exception;
	/*
	 * 修改化学镀膜信息
	 * @param platedFilmEntity 化学镀膜信息
	 * @return 修改结果
	 */
	public BaseResponse modifyPlatedFilm(PlatedFilmEntity platedFilmEntity) throws Exception;
	/*
	 * 删除化学镀膜信息
	 * @param pfIDs 需要删除的化学镀膜信息列表
	 * @return 删除结果
	 */
	public BaseResponse delPlatedFilm(List<Integer> pfIDs) throws Exception;
	/*
	 * 导出化学镀膜信息
	 * @platedFilmQueryFormEntity 化学镀膜信息查询对象
	 * @return 导出结果
	 */
	public BaseResponse exportPlatedFilm(PlatedFilmQueryFormEntity  platedFilmQueryFormEntity) throws Exception;
}

package com.pall.wdpts.repository.mapper.trackinglist;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.pall.wdpts.repository.entity.trackinglist.MainframeEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeFormQueryEntity;

/*
 * 工作流服务接口
 */
@Repository("mainframeAssembleDao")
public interface MainframeAssembleDao {
	/*
	 * 根据条件查询主机装配记录信息
	 * @param mainframeAssembleFormQueryEntity 主机装配查询对象
	 * @return 查询结果
	 */
	public List<MainframeEntity> queryMainframeList(MainframeFormQueryEntity  mainframeFormQueryEntity) ;
	/*
	 * 根据条件查询主机装配记录信息
	 * @param mainframeAssembleFormQueryEntity 主机装配查询对象
	 * @return 查询结果
	 */
	public int queryMainframeTotalRecords(MainframeFormQueryEntity  mainframeFormQueryEntity);
	/*
	 * 添加主机装配信息
	 * @param mainframeAssembleEntity 主机装配信息
	 * @return 添加结果
	 */
	public int addMainframeAssemble(MainframeEntity mainframeEntity) ;
	/*
	 * 修改主机装配信息
	 * @param MainframeAssembleEntity 主机装配信息
	 * @return 修改结果
	 */
	public int modifyMainframe(MainframeEntity mainframeEntity) ;
	/*
	 * 删除主机装配信息
	 * @param mainframeAssembleIDS 需要删除的主机装配列表
	 * @return 删除结果
	 */
	public int delMainframe(List<Integer> mainframeIDS) ;

}

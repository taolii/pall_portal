package com.pall.wdpts.repository.mapper.trackinglist;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.pall.wdpts.repository.entity.trackinglist.CisternEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternFormQueryEntity;

/*
 * 工作流服务接口
 */
@Repository("cisternAssembleDao")
public interface CisternAssembleDao {
	/*
	 * 根据条件查询水箱装配记录信息
	 * @param cisternFormQueryEntity 水箱装配查询对象
	 * @return 查询结果
	 */
	public List<CisternEntity> queryCisternList(CisternFormQueryEntity  cisternFormQueryEntity) ;
	/*
	 * 根据条件查询水箱装配记录信息
	 * @param cisternFormQueryEntity 水箱装配查询对象
	 * @return 查询结果
	 */
	public int queryCisternTotalRecords(CisternFormQueryEntity  cisternFormQueryEntity);
	/*
	 * 添加水箱装配信息
	 * @param cisternAssembleEntity 水箱装配信息
	 * @return 添加结果
	 */
	public int addCistern(CisternEntity cisternEntity) ;
	/*
	 * 修改水箱装配信息
	 * @param cisternAssembleEntity 水箱装配信息
	 * @return 修改结果
	 */
	public int modifyCistern(CisternEntity cisternEntity) ;
	/*
	 * 删除水箱装配信息
	 * @param cisternIDS 需要删除的水箱装配列表
	 * @return 删除结果
	 */
	public int delCisternAssemble(List<Integer> cisternIDS) ;
	
}

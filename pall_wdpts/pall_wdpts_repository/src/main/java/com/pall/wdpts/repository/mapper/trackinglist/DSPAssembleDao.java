package com.pall.wdpts.repository.mapper.trackinglist;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.pall.wdpts.repository.entity.trackinglist.DSPAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.DSPEntity;
import com.pall.wdpts.repository.entity.trackinglist.DSPFormQueryEntity;

/*
 * 工作流服务接口
 */
@Repository("dspAssembleDao")
public interface DSPAssembleDao {
	/*
	 * 根据条件查询DSP装配记录信息
	 * @param dspAssembleFormQueryEntity DSP装配查询对象
	 * @return 查询结果
	 */
	public List<DSPEntity> queryDSPList(DSPFormQueryEntity  dspFormQueryEntity) ;
	/*
	 * 根据条件查询DSP装配记录信息
	 * @param dspAssembleFormQueryEntity DSP装配查询对象
	 * @return 查询结果
	 */
	public int queryDSPTotalRecords(DSPFormQueryEntity  dspFormQueryEntity);
	/*
	 * 添加DSP装配信息
	 * @param dspEntity DSP装配信息
	 * @return 添加结果
	 */
	public int addDSP(DSPEntity dspEntity) ;
	/*
	 * 添加DSP装配信息
	 * @param dspAssembleEntity DSP装配信息
	 * @return 添加结果
	 */
	public int addDSPAssemble(DSPAssembleEntity dspAssembleEntity) ;
	/*
	 * 修改DSP装配信息
	 * @param dspAssembleEntity DSP装配信息
	 * @return 修改结果
	 */
	public int modifyDSP(DSPEntity dspEntity) ;
	/*
	 * 删除DSP装配信息
	 * @param dspAssembleIDS 需要删除的DSP装配列表
	 * @return 删除结果
	 */
	public int delDSPAssemble(List<Integer> dspIDS) ;
	/*
	 * 删除DSP装配信息
	 * @param dspAssembleIDS 需要删除的DSP装配列表
	 * @return 删除结果
	 */
	public int delDSP(List<Integer> dspIDS) ;
	/*
	 * 根据条件查询DSP装配记录信息
	 * @param dspID DSP唯一标识
	 * @return 查询结果
	 */
	public List<DSPAssembleEntity> queryDSPAssembleList(String  dspID) ;
}

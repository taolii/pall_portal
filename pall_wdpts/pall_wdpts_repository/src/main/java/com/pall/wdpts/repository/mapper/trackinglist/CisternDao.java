package com.pall.wdpts.repository.mapper.trackinglist;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.wdpts.repository.entity.trackinglist.CisternAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.CisternSettingFormQueryEntity;

/*
 * 工作流服务接口
 */
@Repository("cisternDao")
public interface CisternDao {
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
	 * @param cisternEntity 水箱装配信息
	 * @return 添加结果
	 */
	public int addCistern(CisternEntity cisternEntity);
	/*
	 * 修改水箱装配信息
	 * @param cisternEntity 水箱装配信息
	 * @return 修改结果
	 */
	public int modCistern(CisternEntity cisternEntity);
	/*
	 * 删除水箱装配信息
	 * @param cisternAssembleIDS 需要删除的水箱装配列表
	 * @return 删除结果
	 */
	public int delCistern(@Param("cisternIDS")  List<Integer> cisternIDS);
	/*
	 * 添加水箱装配信息
	 * @param cisternAssembles 水箱装配信息
	 * @return 添加结果
	 */
	public int addCisternAssembles(List<CisternAssembleEntity> cisternAssembles);
	
	/*
	 * 删除水箱装配信息
	 * @param cisternSettingEntity 水箱装配信息
	 * @return 添加结果
	 */
	public int delCisternAssembles(@Param("cisternIDS")  List<Integer> cisternIDS);
	/*
	 * 根据条件查询水箱装配记录信息
	 * @param cisternID 水箱装配查询对象
	 * @return 查询结果
	 */
	public List<CisternAssembleEntity> queryCisternAssembleList(@Param("cisternID")  String cisternID) ;
	/*
	 * 根据条件查询水箱配置信息
	 * @param cisternSettingFormQueryEntity 水箱配置查询对象
	 * @return 查询结果
	 */
	public List<CisternSettingEntity> queryCisternSettingList(CisternSettingFormQueryEntity  cisternSettingFormQueryEntity);
	/*
	 * 根据条件查询水箱配置记录信息
	 * @param cisternSettingFormQueryEntity 水箱配置查询对象
	 * @return 查询结果
	 */
	public int queryCisternSettingTotalRecords(CisternSettingFormQueryEntity  cisternSettingFormQueryEntity) throws Exception;
	/*
	 * 添加水箱装配配置信息
	 * @param cisternSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public int addCisternSetting(CisternSettingEntity cisternSettingEntity);
	/*
	 * 修改水箱装配配置信息
	 * @param cisternSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public int modCisternSetting(CisternSettingEntity cisternSettingEntity);
	/*
	 * 删除水箱装配配置信息
	 * @param csids 删除列表信息
	 * @return 添加结果
	 */
	public int delCisternSetting(@Param("csids")  List<Integer> csids);
	/*
	 * 添加水箱装配配置信息
	 * @param cisternSettingAssembles 水箱装配配置信息
	 * @return 添加结果
	 */
	public int addCisternSettingAssembles(List<CisternSettingAssembleEntity> cisternSettingAssembles);
	
	/*
	 * 删除水箱装配配置信息
	 * @param cisternSettingEntity 水箱装配配置信息
	 * @return 添加结果
	 */
	public int delCisternSettingAssembles(@Param("csids") List<Integer> csids);
	/*
	 * 根据条件查询水箱装配配置信息
	 * @param csid 水箱配置唯一标示
	 * @return 查询结果
	 */
	public List<CisternSettingAssembleEntity> queryCisternSettingAssembleList(@Param("csid") String  csid);
}

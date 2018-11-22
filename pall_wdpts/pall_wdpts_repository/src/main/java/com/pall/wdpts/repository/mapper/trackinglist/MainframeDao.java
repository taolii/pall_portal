package com.pall.wdpts.repository.mapper.trackinglist;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.wdpts.repository.entity.trackinglist.MainframeAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeInspectEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.MainframeSettingInspectEntity;

/*
 * 工作流服务接口
 */
@Repository("mainframeDao")
public interface MainframeDao {
	/*
	 * 根据条件查询主机装配记录信息
	 * @param mainframeFormQueryEntity 主机装配查询对象
	 * @return 查询结果
	 */
	public List<MainframeEntity> queryMainframeList(MainframeFormQueryEntity  mainframeFormQueryEntity) ;
	/*
	 * 根据条件查询主机装配记录信息
	 * @param mainframeFormQueryEntity 主机装配查询对象
	 * @return 查询结果
	 */
	public int queryMainframeTotalRecords(MainframeFormQueryEntity  mainframeFormQueryEntity);
	/*
	 * 添加主机装配信息
	 * @param mainframeEntity 主机装配信息
	 * @return 添加结果
	 */
	public int addMainframe(MainframeEntity mainframeEntity);
	/*
	 * 修改主机装配信息
	 * @param mainframeEntity 主机装配信息
	 * @return 修改结果
	 */
	public int modMainframe(MainframeEntity mainframeEntity);
	/*
	 * 删除主机装配信息
	 * @param mainframeAssembleIDS 需要删除的主机装配列表
	 * @return 删除结果
	 */
	public int delMainframe(@Param("mainframeIDS")  List<Integer> mainframeIDS);
	/*
	 * 添加主机装配信息
	 * @param mainframeAssembles 主机装配信息
	 * @return 添加结果
	 */
	public int addMainframeAssembles(List<MainframeAssembleEntity> mainframeAssembles);
	
	/*
	 * 删除主机装配信息
	 * @param mainframeSettingEntity 主机装配信息
	 * @return 添加结果
	 */
	public int delMainframeAssembles(@Param("mainframeIDS")  List<Integer> mainframeIDS);
	/*
	 * 添加主机送检信息
	 * @param mainframeSettingInspects 主机送检信息
	 * @return 添加结果
	 */
	public int addMainframeInspects(List<MainframeInspectEntity> mainframeInspects);
	/*
	 * 删除主机送检信息
	 * @param mainframeSettingEntity 主机送检信息
	 * @return 添加结果
	 */
	public int delMainframeInspects(@Param("mainframeIDS")  List<Integer> mainframeIDS);
	/*
	 * 根据条件查询主机装配记录信息
	 * @param mainframeID 主机装配查询对象
	 * @return 查询结果
	 */
	public List<MainframeAssembleEntity> queryMainframeAssembleList(@Param("mainframeID")  String mainframeID) ;
	/*
	 * 根据条件查询 主机送检信息
	 * @param mainframeID 主机唯一标示
	 * @return 查询结果
	 */
	public List<MainframeInspectEntity> queryMainframeInspectList(@Param("mainframeID")  String mainframeID);
	/*
	 * 根据条件查询主机配置信息
	 * @param mainframeSettingFormQueryEntity 主机配置查询对象
	 * @return 查询结果
	 */
	public List<MainframeSettingEntity> queryMainframeSettingList(MainframeSettingFormQueryEntity  mainframeSettingFormQueryEntity);
	/*
	 * 根据条件查询主机配置记录信息
	 * @param mainframeSettingFormQueryEntity 主机配置查询对象
	 * @return 查询结果
	 */
	public int queryMainframeSettingTotalRecords(MainframeSettingFormQueryEntity  mainframeSettingFormQueryEntity) throws Exception;
	/*
	 * 添加主机装配配置信息
	 * @param mainframeSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public int addMainframeSetting(MainframeSettingEntity mainframeSettingEntity);
	/*
	 * 修改主机装配配置信息
	 * @param mainframeSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public int modMainframeSetting(MainframeSettingEntity mainframeSettingEntity);
	/*
	 * 删除主机装配配置信息
	 * @param mids 删除列表信息
	 * @return 添加结果
	 */
	public int delMainframeSetting(@Param("msids")  List<Integer> msids);
	/*
	 * 添加主机装配配置信息
	 * @param mainframeSettingAssembles 主机装配配置信息
	 * @return 添加结果
	 */
	public int addMainframeSettingAssembles(List<MainframeSettingAssembleEntity> mainframeSettingAssembles);
	
	/*
	 * 删除主机装配配置信息
	 * @param mainframeSettingEntity 主机装配配置信息
	 * @return 添加结果
	 */
	public int delMainframeSettingAssembles(@Param("msids") List<Integer> msids);
	/*
	 * 添加主机送检配置信息
	 * @param mainframeSettingInspects 主机送检配置信息
	 * @return 添加结果
	 */
	public int addMainframeSettingInspects(List<MainframeSettingInspectEntity> mainframeSettingInspects);
	/*
	 * 删除主机送检配置信息
	 * @param mainframeSettingEntity 主机送检配置信息
	 * @return 添加结果
	 */
	public int delMainframeSettingInspects(@Param("msids")  List<Integer> msids);
	/*
	 * 根据条件查询主机装配配置信息
	 * @param mid 主机配置唯一标示
	 * @return 查询结果
	 */
	public List<MainframeSettingAssembleEntity> queryMainframeSettingAssembleList(@Param("msid") String  msid);
	/*
	 * 根据条件查询 主机送检配置信息
	 * @param msid 主机配置唯一标示
	 * @return 查询结果
	 */
	public List<MainframeSettingInspectEntity> queryMainframeSettingInspectList(@Param("msid") String  msid);

}

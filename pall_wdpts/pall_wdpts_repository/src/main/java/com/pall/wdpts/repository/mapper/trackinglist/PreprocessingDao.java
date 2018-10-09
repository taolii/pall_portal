package com.pall.wdpts.repository.mapper.trackinglist;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.wdpts.repository.entity.trackinglist.PreprocessingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingInspectEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.PreprocessingSettingInspectEntity;

/*
 * 工作流服务接口
 */
@Repository("preprocessingDao")
public interface PreprocessingDao {
	/*
	 * 根据条件查询预处理装配记录信息
	 * @param preprocessingFormQueryEntity 预处理装配查询对象
	 * @return 查询结果
	 */
	public List<PreprocessingEntity> queryPreprocessingList(PreprocessingFormQueryEntity  preprocessingFormQueryEntity) ;
	/*
	 * 根据条件查询预处理装配记录信息
	 * @param preprocessingFormQueryEntity 预处理装配查询对象
	 * @return 查询结果
	 */
	public int queryPreprocessingTotalRecords(PreprocessingFormQueryEntity  preprocessingFormQueryEntity);
	/*
	 * 添加预处理装配信息
	 * @param preprocessingEntity 预处理装配信息
	 * @return 添加结果
	 */
	public int addPreprocessing(PreprocessingEntity preprocessingEntity);
	/*
	 * 修改预处理装配信息
	 * @param preprocessingEntity 预处理装配信息
	 * @return 修改结果
	 */
	public int modPreprocessing(PreprocessingEntity preprocessingEntity);
	/*
	 * 删除预处理装配信息
	 * @param preprocessingAssembleIDS 需要删除的预处理装配列表
	 * @return 删除结果
	 */
	public int delPreprocessing(@Param("preprocessingIDS")  List<Integer> preprocessingIDS);
	/*
	 * 添加预处理装配信息
	 * @param preprocessingAssembles 预处理装配信息
	 * @return 添加结果
	 */
	public int addPreprocessingAssembles(List<PreprocessingAssembleEntity> preprocessingAssembles);
	
	/*
	 * 删除预处理装配信息
	 * @param preprocessingSettingEntity 预处理装配信息
	 * @return 添加结果
	 */
	public int delPreprocessingAssembles(@Param("preprocessingIDS")  List<Integer> preprocessingIDS);
	/*
	 * 添加预处理送检信息
	 * @param preprocessingSettingInspects 预处理送检信息
	 * @return 添加结果
	 */
	public int addPreprocessingInspects(List<PreprocessingInspectEntity> preprocessingInspects);
	/*
	 * 删除预处理送检信息
	 * @param preprocessingSettingEntity 预处理送检信息
	 * @return 添加结果
	 */
	public int delPreprocessingInspects(@Param("preprocessingIDS")  List<Integer> preprocessingIDS);
	/*
	 * 根据条件查询预处理装配记录信息
	 * @param preprocessingID 预处理装配查询对象
	 * @return 查询结果
	 */
	public List<PreprocessingAssembleEntity> queryPreprocessingAssembleList(@Param("preprocessingID")  String preprocessingID) ;
	/*
	 * 根据条件查询 预处理送检信息
	 * @param preprocessingID 预处理唯一标示
	 * @return 查询结果
	 */
	public List<PreprocessingInspectEntity> queryPreprocessingInspectList(@Param("preprocessingID")  String preprocessingID);
	/*
	 * 根据条件查询预处理配置信息
	 * @param preprocessingSettingFormQueryEntity 预处理配置查询对象
	 * @return 查询结果
	 */
	public List<PreprocessingSettingEntity> queryPreprocessingSettingList(PreprocessingSettingFormQueryEntity  preprocessingSettingFormQueryEntity);
	/*
	 * 根据条件查询预处理配置记录信息
	 * @param preprocessingSettingFormQueryEntity 预处理配置查询对象
	 * @return 查询结果
	 */
	public int queryPreprocessingSettingTotalRecords(PreprocessingSettingFormQueryEntity  preprocessingSettingFormQueryEntity) throws Exception;
	/*
	 * 添加预处理装配配置信息
	 * @param preprocessingSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public int addPreprocessingSetting(PreprocessingSettingEntity preprocessingSettingEntity);
	/*
	 * 修改预处理装配配置信息
	 * @param preprocessingSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public int modPreprocessingSetting(PreprocessingSettingEntity preprocessingSettingEntity);
	/*
	 * 删除预处理装配配置信息
	 * @param psids 删除列表信息
	 * @return 添加结果
	 */
	public int delPreprocessingSetting(@Param("psids")  List<Integer> psids);
	/*
	 * 添加预处理装配配置信息
	 * @param preprocessingSettingAssembles 预处理装配配置信息
	 * @return 添加结果
	 */
	public int addPreprocessingSettingAssembles(List<PreprocessingSettingAssembleEntity> preprocessingSettingAssembles);
	
	/*
	 * 删除预处理装配配置信息
	 * @param preprocessingSettingEntity 预处理装配配置信息
	 * @return 添加结果
	 */
	public int delPreprocessingSettingAssembles(@Param("psids") List<Integer> psids);
	/*
	 * 添加预处理送检配置信息
	 * @param preprocessingSettingInspects 预处理送检配置信息
	 * @return 添加结果
	 */
	public int addPreprocessingSettingInspects(List<PreprocessingSettingInspectEntity> preprocessingSettingInspects);
	/*
	 * 删除预处理送检配置信息
	 * @param preprocessingSettingEntity 预处理送检配置信息
	 * @return 添加结果
	 */
	public int delPreprocessingSettingInspects(@Param("psids")  List<Integer> psids);
	/*
	 * 根据条件查询预处理装配配置信息
	 * @param psid 预处理配置唯一标示
	 * @return 查询结果
	 */
	public List<PreprocessingSettingAssembleEntity> queryPreprocessingSettingAssembleList(@Param("psid") String  psid);
	/*
	 * 根据条件查询 预处理送检配置信息
	 * @param psid 预处理配置唯一标示
	 * @return 查询结果
	 */
	public List<PreprocessingSettingInspectEntity> queryPreprocessingSettingInspectList(@Param("psid") String  psid);
}

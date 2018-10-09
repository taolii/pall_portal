package com.pall.wdpts.repository.mapper.trackinglist;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.pall.wdpts.repository.entity.trackinglist.DspAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspFormQueryEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingAssembleEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingEntity;
import com.pall.wdpts.repository.entity.trackinglist.DspSettingFormQueryEntity;

/*
 * 工作流服务接口
 */
@Repository("dspDao")
public interface DspDao {
   /*
	 * 根据条件查询Dsp装配记录信息
	 * @param dspFormQueryEntity Dsp装配查询对象
	 * @return 查询结果
	 */
	public List<DspEntity> queryDspList(DspFormQueryEntity  dspFormQueryEntity) ;
	/*
	 * 根据条件查询Dsp装配记录信息
	 * @param dspFormQueryEntity Dsp装配查询对象
	 * @return 查询结果
	 */
	public int queryDspTotalRecords(DspFormQueryEntity  dspFormQueryEntity);
	/*
	 * 添加Dsp装配信息
	 * @param dspEntity Dsp装配信息
	 * @return 添加结果
	 */
	public int addDsp(DspEntity dspEntity);
	/*
	 * 修改Dsp装配信息
	 * @param dspEntity Dsp装配信息
	 * @return 修改结果
	 */
	public int modDsp(DspEntity dspEntity);
	/*
	 * 删除Dsp装配信息
	 * @param dspAssembleIDS 需要删除的Dsp装配列表
	 * @return 删除结果
	 */
	public int delDsp(@Param("dspIDS")  List<Integer> dspIDS);
	/*
	 * 添加Dsp装配信息
	 * @param dspAssembles Dsp装配信息
	 * @return 添加结果
	 */
	public int addDspAssembles(List<DspAssembleEntity> dspAssembles);
	
	/*
	 * 删除Dsp装配信息
	 * @param dspSettingEntity Dsp装配信息
	 * @return 添加结果
	 */
	public int delDspAssembles(@Param("dspIDS")  List<Integer> dspIDS);
	/*
	 * 根据条件查询Dsp装配记录信息
	 * @param dspID Dsp装配查询对象
	 * @return 查询结果
	 */
	public List<DspAssembleEntity> queryDspAssembleList(@Param("dspID")  String dspID) ;
	/*
	 * 根据条件查询Dsp配置信息
	 * @param dspSettingFormQueryEntity Dsp配置查询对象
	 * @return 查询结果
	 */
	public List<DspSettingEntity> queryDspSettingList(DspSettingFormQueryEntity  dspSettingFormQueryEntity);
	/*
	 * 根据条件查询Dsp配置记录信息
	 * @param dspSettingFormQueryEntity Dsp配置查询对象
	 * @return 查询结果
	 */
	public int queryDspSettingTotalRecords(DspSettingFormQueryEntity  dspSettingFormQueryEntity) throws Exception;
	/*
	 * 添加Dsp装配配置信息
	 * @param dspSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public int addDspSetting(DspSettingEntity dspSettingEntity);
	/*
	 * 修改Dsp装配配置信息
	 * @param dspSettingEntity 处理装配配置信息
	 * @return 添加结果
	 */
	public int modDspSetting(DspSettingEntity dspSettingEntity);
	/*
	 * 删除Dsp装配配置信息
	 * @param dspids 删除列表信息
	 * @return 添加结果
	 */
	public int delDspSetting(@Param("dsids")  List<Integer> dsids);
	/*
	 * 添加Dsp装配配置信息
	 * @param dspSettingAssembles Dsp装配配置信息
	 * @return 添加结果
	 */
	public int addDspSettingAssembles(List<DspSettingAssembleEntity> dspSettingAssembles);
	
	/*
	 * 删除Dsp装配配置信息
	 * @param dspSettingEntity Dsp装配配置信息
	 * @return 添加结果
	 */
	public int delDspSettingAssembles(@Param("dsids") List<Integer> dsids);
	/*
	 * 根据条件查询Dsp装配配置信息
	 * @param dspid Dsp配置唯一标示
	 * @return 查询结果
	 */
	public List<DspSettingAssembleEntity> queryDspSettingAssembleList(@Param("dsid") String  dsid);
}

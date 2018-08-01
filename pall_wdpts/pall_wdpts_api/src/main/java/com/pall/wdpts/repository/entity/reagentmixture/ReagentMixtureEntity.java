package com.pall.wdpts.repository.entity.reagentmixture;

import java.util.List;

/*
 * 试剂混合对象
 */
public class ReagentMixtureEntity {
	/*
	 * 试剂编号
	 */
	private int rmid;
	/*
	 * 配置时间
	 */
	private String configTime;
	/*
	 * 主试剂
	 */
	private String mainReagent;
	/*
	 * Rev
	 */
	private String rev;
	/*
	 * LOT#
	 */
	private String lotNum;
	/*
	 * WO#
	 */
	private String woNum;
	/*
	 * 混合试剂编号信息
	 */
	private List<ReagentMixtureEntitySns> reagentMixtureEntitySns;
	/*
	 * Amount(mg)
	 */
	private double amount;
	/*
	 * PH值
	 */
	private Double phValue;
	/*
	 * 浓度
	 */
	private Double concentration;
	/*
	 * 回温开始时间
	 */
	private String temperatureUpStarttime;
	/*
	 * 回温结束时间
	 */
	private String temperatureUpEndtime;
	/*
	 * 试剂温度
	 */
	private String reagentTemperature;
	/*
	 * 试剂配制操作员
	 */
	private String configOperator;
	/*
	 * 备注1
	 */
	private String reserver1;
	/*
	 * 备注2
	 */
	private String reserver2;
	/*
	 * 备注3
	 */
	private String reserver3;
	/*
	 * 创建时间
	 */
	private String createTime;
	/*
	 * 更新时间
	 */
	private String updateTime;
	/*
	 * 操作员编号
	 */
	private int operatorid;
	public int getRmid() {
		return rmid;
	}
	public void setRmid(int rmid) {
		this.rmid = rmid;
	}
	public String getConfigTime() {
		return configTime;
	}
	public void setConfigTime(String configTime) {
		this.configTime = configTime;
	}
	public String getMainReagent() {
		return mainReagent;
	}
	public void setMainReagent(String mainReagent) {
		this.mainReagent = mainReagent;
	}
	public String getRev() {
		return rev;
	}
	public void setRev(String rev) {
		this.rev = rev;
	}
	public String getLotNum() {
		return lotNum;
	}
	public void setLotNum(String lotNum) {
		this.lotNum = lotNum;
	}
	public String getWoNum() {
		return woNum;
	}
	public void setWoNum(String woNum) {
		this.woNum = woNum;
	}
	public List<ReagentMixtureEntitySns> getReagentMixtureEntitySns() {
		return reagentMixtureEntitySns;
	}
	public void setReagentMixtureEntitySns(List<ReagentMixtureEntitySns> reagentMixtureEntitySns) {
		this.reagentMixtureEntitySns = reagentMixtureEntitySns;
	}
	
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public Double getPhValue() {
		return phValue;
	}
	public void setPhValue(Double phValue) {
		this.phValue = phValue;
	}
	public Double getConcentration() {
		return concentration;
	}
	public void setConcentration(Double concentration) {
		this.concentration = concentration;
	}
	public String getTemperatureUpStarttime() {
		return temperatureUpStarttime;
	}
	public void setTemperatureUpStarttime(String temperatureUpStarttime) {
		this.temperatureUpStarttime = temperatureUpStarttime;
	}
	public String getTemperatureUpEndtime() {
		return temperatureUpEndtime;
	}
	public void setTemperatureUpEndtime(String temperatureUpEndtime) {
		this.temperatureUpEndtime = temperatureUpEndtime;
	}
	public String getReagentTemperature() {
		return reagentTemperature;
	}
	public void setReagentTemperature(String reagentTemperature) {
		this.reagentTemperature = reagentTemperature;
	}
	public String getConfigOperator() {
		return configOperator;
	}
	public void setConfigOperator(String configOperator) {
		this.configOperator = configOperator;
	}
	public String getReserver1() {
		return reserver1;
	}
	public void setReserver1(String reserver1) {
		this.reserver1 = reserver1;
	}
	public String getReserver2() {
		return reserver2;
	}
	public void setReserver2(String reserver2) {
		this.reserver2 = reserver2;
	}
	public String getReserver3() {
		return reserver3;
	}
	public void setReserver3(String reserver3) {
		this.reserver3 = reserver3;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public int getOperatorid() {
		return operatorid;
	}
	public void setOperatorid(int operatorid) {
		this.operatorid = operatorid;
	}
	
}

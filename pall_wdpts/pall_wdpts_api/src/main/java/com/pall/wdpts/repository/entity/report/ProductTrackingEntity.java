package com.pall.wdpts.repository.entity.report;

/*
 * 组装报废汇总信息
 */
public class ProductTrackingEntity {
	private String fixtureNum;
	/*
	 * Output LOT#
	 */
	private String outputLotNum;
	private Integer inputQtys;
	/*
	 * output Qty(pcs)
	 */
	private Integer outputQtys;
	/*
	 * 碎片数量Scrap Qty(pcs)
	 */
	private Integer scrapQtys;
	private Integer toOtherQtys;
	private Integer diffQtys;
	
	/*
	 * 零件号
	 */
	private String partNum;
	/*
	 * 工单号
	 */
	private String workOrderNum;
	public String getFixtureNum() {
		return fixtureNum;
	}
	public void setFixtureNum(String fixtureNum) {
		this.fixtureNum = fixtureNum;
	}
	public String getOutputLotNum() {
		return outputLotNum;
	}
	public void setOutputLotNum(String outputLotNum) {
		this.outputLotNum = outputLotNum;
	}
	public Integer getInputQtys() {
		return inputQtys;
	}
	public void setInputQtys(Integer inputQtys) {
		this.inputQtys = inputQtys;
	}
	public Integer getOutputQtys() {
		return outputQtys;
	}
	public void setOutputQtys(Integer outputQtys) {
		this.outputQtys = outputQtys;
	}
	public Integer getScrapQtys() {
		return scrapQtys;
	}
	public void setScrapQtys(Integer scrapQtys) {
		this.scrapQtys = scrapQtys;
	}
	public Integer getToOtherQtys() {
		return toOtherQtys;
	}
	public void setToOtherQtys(Integer toOtherQtys) {
		this.toOtherQtys = toOtherQtys;
	}
	public Integer getDiffQtys() {
		return diffQtys;
	}
	public void setDiffQtys(Integer diffQtys) {
		this.diffQtys = diffQtys;
	}
	public String getPartNum() {
		return partNum;
	}
	public void setPartNum(String partNum) {
		this.partNum = partNum;
	}
	public String getWorkOrderNum() {
		return workOrderNum;
	}
	public void setWorkOrderNum(String workOrderNum) {
		this.workOrderNum = workOrderNum;
	}
	
}

package com.pall.wdpts.repository.entity.report;

import java.util.List;

import com.pall.wdpts.repository.entity.workflow.DefectEntity;

/*
 * 组装报废汇总信息
 */
public class AssemblyScrapSummaryEntity {
	private int totalRecords;
	/*
	 * Output LOT#
	 */
	private String outputLotNum;
	/*
	 * output Qty(pcs)
	 */
	private Integer outputQtys;
	/*
	 * 碎片数量Scrap Qty(pcs)
	 */
	private Integer scrapQtys;
	/*
	 * 缺损信息
	 */
	private List<DefectEntity> defects;
	
	/*
	 * 零件号
	 */
	private String partNum;
	/*
	 * 工单号
	 */
	private String workOrderNum;
	private String dataid;
	private int defectValues;
	public int getTotalRecords() {
		return totalRecords;
	}
	public void setTotalRecords(int totalRecords) {
		this.totalRecords = totalRecords;
	}
	public String getOutputLotNum() {
		return outputLotNum;
	}
	public void setOutputLotNum(String outputLotNum) {
		this.outputLotNum = outputLotNum;
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
	public List<DefectEntity> getDefects() {
		return defects;
	}
	public void setDefects(List<DefectEntity> defects) {
		this.defects = defects;
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
	public String getDataid() {
		return dataid;
	}
	public void setDataid(String dataid) {
		this.dataid = dataid;
	}
	public int getDefectValues() {
		return defectValues;
	}
	public void setDefectValues(int defectValues) {
		this.defectValues = defectValues;
	}
	
}

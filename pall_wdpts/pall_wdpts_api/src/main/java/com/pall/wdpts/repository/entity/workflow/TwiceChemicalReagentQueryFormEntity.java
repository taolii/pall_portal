package com.pall.wdpts.repository.entity.workflow;

/*
 * 光学镀膜查询对象
 */
public class TwiceChemicalReagentQueryFormEntity {
	/*
	 * 起始页
	 */
	private int startPageNum;
	private int draw;
	/*
	 * 每页记录数
	 */
	private int pageSize;
	/*
	 * 试剂混合物的批次，Lot
	 */
	private String lot;
	private String crID;
	private String startInPutDate;
	private String endInPutDate;
	private String oldLotNum;
	private String oldTrayNum;
	private String oldBioPatNum;
	private String trayNum;
	private String chemicalLotNum;
	private String bioPatNum;
	public int getStartPageNum() {
		return startPageNum;
	}
	public int getDraw() {
		return draw;
	}
	public void setDraw(int draw) {
		this.draw = draw;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getLot() {
		return lot;
	}
	public void setLot(String lot) {
		this.lot = lot;
	}
	public String getCrID() {
		return crID;
	}
	public void setCrID(String crID) {
		this.crID = crID;
	}
	public String getStartInPutDate() {
		return startInPutDate;
	}
	public void setStartInPutDate(String startInPutDate) {
		this.startInPutDate = startInPutDate;
	}
	public String getEndInPutDate() {
		return endInPutDate;
	}
	public void setEndInPutDate(String endInPutDate) {
		this.endInPutDate = endInPutDate;
	}
	public String getOldLotNum() {
		return oldLotNum;
	}
	public void setOldLotNum(String oldLotNum) {
		this.oldLotNum = oldLotNum;
	}
	public String getOldTrayNum() {
		return oldTrayNum;
	}
	public void setOldTrayNum(String oldTrayNum) {
		this.oldTrayNum = oldTrayNum;
	}
	public String getOldBioPatNum() {
		return oldBioPatNum;
	}
	public void setOldBioPatNum(String oldBioPatNum) {
		this.oldBioPatNum = oldBioPatNum;
	}
	public String getTrayNum() {
		return trayNum;
	}
	public void setTrayNum(String trayNum) {
		this.trayNum = trayNum;
	}
	public String getChemicalLotNum() {
		return chemicalLotNum;
	}
	public void setChemicalLotNum(String chemicalLotNum) {
		this.chemicalLotNum = chemicalLotNum;
	}
	public String getBioPatNum() {
		return bioPatNum;
	}
	public void setBioPatNum(String bioPatNum) {
		this.bioPatNum = bioPatNum;
	}
	public void setStartPageNum(int startPageNum) {
		this.startPageNum = startPageNum;
	}
	
}

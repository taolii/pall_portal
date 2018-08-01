package com.pall.mts.repository.entity.workflow;
/*
 * excel下载文件保存信息对象
 */
public class ExcelSaveEntity {
	/*
	 * excel文件保存的子目录
	 */
	public String subDirectory;
	/*
	 * 保存文件的文件名
	 */
	public String fileName;
	public String getSubDirectory() {
		return subDirectory;
	}
	public void setSubDirectory(String subDirectory) {
		this.subDirectory = subDirectory;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
}

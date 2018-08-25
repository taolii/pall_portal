package com.pall.wdpts.service.word;

import java.io.File;
import java.io.IOException;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.stereotype.Service;

import com.pall.wdpts.common.support.word.WordDataNode;
@Service
public interface IWordHandler {
	/*
	 * 根据数据源生成word文档
	 * @param document word对象
	 * @param wordDataNode 文档需要替换信息
	 * @param targetFile目标文件
	 * @return
	 */
	public boolean replaceDocument(XWPFDocument document,WordDataNode wordDataNode,File targetFile);
	/*
	 * 获取word对象
	 * @param targetFile 目标文件
	 * @return
	 */
	public XWPFDocument  getXWPFDocument(File targetFile) throws IOException;
	/*
	 * 获取word对象
	 * @param sourceTemplateFilePath 原模板文件路径
	 * @param targetFilePath 目标文件路径
	 * @param targetFileName 目标文件名
	 * @return
	 */
	public File  getTargeFileByTemplateFile(String sourceTemplateFilePath,String targetFilePath,String targetFileName) throws IOException;
}

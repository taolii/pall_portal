package com.pall.wdpts.service.word;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.xwpf.usermodel.PositionInParagraph;
import org.apache.poi.xwpf.usermodel.TextSegement;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Repository;

import com.alibaba.fastjson.util.IOUtils;
import com.google.common.io.Files;
import com.pall.wdpts.common.support.word.WordDataNode;
/*
 * docx word数据格式处理类
 */
@Repository("docxWordHandler")
public class DocxWordHandler implements IWordHandler{

	@Override
	public XWPFDocument  getXWPFDocument(File targetFile) throws IOException{
		BufferedInputStream inputStream = new BufferedInputStream(new FileInputStream(targetFile));
		return new XWPFDocument(inputStream);
	}
	@Override
	public File  getTargeFileByTemplateFile(String sourceTemplateFilePath,String targetFilePath,String targetFileName) throws IOException{
		Resource configStyleResource=new ClassPathResource(sourceTemplateFilePath);
		File targetFile=new File(targetFilePath+File.separator+targetFileName);
		Files.copy(configStyleResource.getFile(), targetFile);
		return targetFile;
	}
	
	@Override
    public boolean replaceDocument(XWPFDocument document,WordDataNode wordDataNode,File targetFile) {
		//替换段落文本
		replaceParagraphs(wordDataNode.getDocumentDatas(),document.getParagraphs());
		//表格内容替换
		replaceTable(document.getTables(),wordDataNode.getDocumentDatas());
		//添加表数据
		if(wordDataNode.getTableRowsDatas()!=null && wordDataNode.getTableRowsDatas().size()>0){
			for(String rowKey:wordDataNode.getTableRowsDatas().keySet()){
				List<Map<String, String>> rowsDatas=wordDataNode.getTableRowsDatas().get(rowKey);
				//确认添加位置
				addTableRows(rowKey,document.getTables(),rowsDatas);
			}
		}
		FileOutputStream stream=null;
		try {
			stream = new FileOutputStream(targetFile);
			document.write(stream);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			IOUtils.close(stream);
		}
		return true;
    }
	/**
	* 添加表格数据
	* @param tables 表格对象集合
	* @param addrowLable 添加行标示
	* @param replacements 需要替换的信息集合
	* @return
	*/
	private  void addTableRows(String addrowLable,List<XWPFTable> tables, List<Map<String, String>> replacements){
		if(CollectionUtils.isEmpty(tables))return;
		for (int i = 0; i < tables.size(); i++) {
			XWPFTable table = tables.get(i);
			List<XWPFTableRow> rows = table.getRows();
			if(CollectionUtils.isEmpty(rows))continue;
			if(checkText(table.getText())){
				int rowid=0;
				for(XWPFTableRow xwpfTableRow:rows){
					rowid++;
					List<XWPFTableCell> cells = xwpfTableRow.getTableCells();
					if(CollectionUtils.isEmpty(cells))continue;
					for (XWPFTableCell cell : cells) {
						if(cell.getText().indexOf("${"+addrowLable+"}")!=-1){
							for(int j=0;j<replacements.size()-1;j++){
								//table.addRow(xwpfTableRow, rowid+j);
							}
							break;
						}
					}
					
				}
			}
		}
	}
	/**
	* 替换表格对象方法
	* @param tables 表格对象集合
	* @param replacements 需要替换的信息集合
	* @return
	*/
	private  void replaceTable(List<XWPFTable> tables, Map<String, String> replacements){
		if(CollectionUtils.isEmpty(tables))return;
		for (int i = 0; i < tables.size(); i++) {
			//只处理行数大于等于2的表格，且不循环表头
			XWPFTable table = tables.get(i);
			List<XWPFTableRow> rows = table.getRows();
			if(CollectionUtils.isEmpty(rows))continue;
			if(checkText(table.getText())){
				for(XWPFTableRow xwpfTableRow:rows){
					List<XWPFTableCell> cells = xwpfTableRow.getTableCells();
					if(CollectionUtils.isEmpty(cells))continue;
					for (XWPFTableCell cell : cells) {
						if(checkText(cell.getText())){
							replaceParagraphs(replacements,cell.getParagraphs());
						}
					}
				}
			}
		}
	}
	/**
     * 1.替换段落中的文本
     * 
     * @param replacements
     * @param count
     * @param paragraphs
     * @return
     */
    private void replaceParagraphs(Map<String, String> replacements, List<XWPFParagraph> paragraphs) {
       for (XWPFParagraph paragraph : paragraphs) {
            List<XWPFRun> runs = paragraph.getRuns();
            for (Map.Entry<String, String> replPair : replacements.entrySet()) {
                String oldText = "${"+replPair.getKey()+"}";
                String newText = replPair.getValue();
                // 获取文本段
                TextSegement tSegement = paragraph.searchText(oldText, new PositionInParagraph());
                if (tSegement != null) {
                    int beginRun = tSegement.getBeginRun();
                    int endRun = tSegement.getEndRun();
                    if (beginRun == endRun) {
                        XWPFRun run = runs.get(beginRun);
                        String runText = run.getText(0);
                        String replaced = runText.replace(oldText, newText);
                        run.setText(replaced, 0);
                    } else {
                        StringBuilder b = new StringBuilder();
                        for (int runPos = beginRun; runPos <= endRun; runPos++) {
                            XWPFRun run = runs.get(runPos);
                            b.append(run.getText(0));
                        }
                        String connectedRuns = b.toString();
                        String replaced = connectedRuns.replace(oldText, newText);
                        XWPFRun partOne = runs.get(beginRun);
                        partOne.setText(replaced, 0);
                        for (int runPos = beginRun + 1; runPos <= endRun; runPos++) {
                            XWPFRun partNext = runs.get(runPos);
                            partNext.setText("", 0);
                        }
                    }
                }
            }
        }
    }

	/**
	* 为表格插入数据，行数不够添加新行
	 * @param table 需要插入数据的表格
	* @param tableList 插入数据集合
	 */
	public static void insertTable(XWPFTable table, List<String[]> tableList){
		//创建行,根据需要插入的数据添加新行，不处理表头
		for(int i = 1; i < tableList.size(); i++){
			//XWPFTableRow row =table.addRow(row, pos);
		}
		//遍历表格插入数据
		List<XWPFTableRow> rows = table.getRows();
		for(int i = 1; i < rows.size(); i++){
			XWPFTableRow newRow = table.getRow(i);
			List<XWPFTableCell> cells = newRow.getTableCells();
			for(int j = 0; j < cells.size(); j++){
				XWPFTableCell cell = cells.get(j);
				cell.setText(tableList.get(i-1)[j]);
			}
		}
	}
	/**
	* 判断文本中时候包含$
	* @param text 文本
	* @return 包含返回true,不包含返回false
	*/
	private  boolean checkText(String text){
		boolean check  =  false;
		if(text.indexOf("$")!= -1){
			check = true;
		}
		return check;
	}

}

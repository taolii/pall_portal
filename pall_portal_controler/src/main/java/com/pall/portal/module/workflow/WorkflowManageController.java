package com.pall.portal.module.workflow;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.util.IOUtils;
import com.pall.portal.common.i18n.ResourceUtils;
/*
 * 抛光管理控制器
 */
@Controller
public class WorkflowManageController{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private ResourceUtils resourceUtils;
	/*
	 * 下载文件路径
	 */
	@Value("${system.default.file.download.path}")
	private String downloadFilePath;
	/*
	 * 数据下载
	 */
	@RequestMapping(value="workflow/excelfileDownload", method= RequestMethod.GET)
    public void excelfileDownload(Model model,@RequestParam("fileName") String fileName,@RequestParam("subDirectory") String subDirectory, HttpServletRequest request,HttpServletResponse response) {
		StringBuilder downloadFileFullPath=new StringBuilder();
		downloadFileFullPath.append(Class.class.getResource("/").getPath());
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(downloadFilePath);
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(subDirectory);
    	downloadFileFullPath.append(File.separator);
    	downloadFileFullPath.append(fileName);
		response.setContentType("application/octet-stream;charset=UTF-8");
        BufferedInputStream in = null;    
        BufferedOutputStream out = null;
        try {
        	fileName=URLEncoder.encode(fileName, "UTF-8");
        	response.setHeader("Content-disposition", "attachment;filename="+fileName);
        	in = new BufferedInputStream(new FileInputStream(downloadFileFullPath.toString()));    
            out = new BufferedOutputStream(response.getOutputStream());    
            byte[] data = new byte[1024];    
            int len = 0;    
            while (-1 != (len=in.read(data, 0, data.length))) {    
                out.write(data, 0, len);    
            }    
			//Files.copy(new File(downloadFileFullPath.toString()),response.getOutputStream());
			response.flushBuffer();
		} catch (IOException e) {
			logger.error(downloadFileFullPath+resourceUtils.getMessage("workflow.controler.excelfileDownload.exception"),e);
		}finally{
			IOUtils.close(in);
			IOUtils.close(out);
		}
        //Files.delete(new File(downloadFileFullPath.toString()));
    }
}

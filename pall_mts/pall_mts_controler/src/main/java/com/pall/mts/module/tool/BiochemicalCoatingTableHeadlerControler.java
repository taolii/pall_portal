package com.pall.mts.module.tool;

import com.alibaba.excel.support.ExcelTypeEnum;
import com.pall.mts.common.i18n.ResourceUtils;
import com.pall.mts.repository.entity.dataconfig.TableHeaderConfigEntity;
import org.apache.poi.util.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.thymeleaf.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
@PropertySource(value = "classpath:config/template/iochemicalCoating/template-iochemicalCoating.properties",encoding = "utf-8")
@Controller
public class BiochemicalCoatingTableHeadlerControler {
    /*
     * 系统日志
     */
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Value("${iochemicalCoating.tableHead.excel.filepath}")
    private String tableHeadFilePath;
    @Value("${iochemaical.menuid}")
    private int tableMenuid;
    @Value("${iochemaical.sql.delete}")
    private String tableDeleteSql;
    @Value("${iochemaical.sql.insert}")
    private String tableInsertSql;
    @Value("${iochemicalCoating.tableHead.excel.downloadFilePath}")
    private String downloadFilePath;

    @Autowired
    private ResourceUtils resourceUtils;
    @RequestMapping(value="biochemicalCoating/tableHeadParse", method= RequestMethod.GET)
    public  String assemblyManage(Model model, HttpServletRequest request) {
        StringBuilder templateFileFullPath=new StringBuilder();
        templateFileFullPath.append(this.getClass().getResource("/").getPath());
        templateFileFullPath.append(tableHeadFilePath);
        InputStream is=null;
        Map<String,List<List<String>>> maps=null;
        try {
           String wirteFilePath=this.getClass().getResource("/").getPath()+downloadFilePath;
            is=new FileInputStream(new File(templateFileFullPath.toString()));
            maps= PrintTableHeaderSql.readExcelWithStringList(is,ExcelTypeEnum.XLSX);
            List<TableHeaderConfigEntity> tableHeaderConfigEntitys=PrintTableHeaderSql.assemblyTableHeader(maps,tableMenuid);
            PrintTableHeaderSql.printTableHeader(maps.keySet(),tableHeaderConfigEntitys,tableDeleteSql,tableInsertSql,wirteFilePath);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }finally {
            IOUtils.closeQuietly(is);
        }
        return "redirect:/index";
    }
}

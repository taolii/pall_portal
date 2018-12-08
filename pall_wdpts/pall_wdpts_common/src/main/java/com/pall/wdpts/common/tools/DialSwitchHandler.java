package com.pall.wdpts.common.tools;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.util.IOUtils;
/*
 * 生成拨码开关图片
 */
@Component
public class DialSwitchHandler{
	/*
	 * 系统日志
	 */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	/*
	 * 生成拨码开关图片
	 * @param tdWidth 单元格的宽度
	 * @param tdHeight 单元格的高度
	 * @param tableRows表行记录
	 * @return
	 */
	private  byte[] graphicsGeneration(int tdWith,int tdHeight,List<List<String>> tableRows){
        //图片的高度
		int imageHeight=tableRows.size()*tdHeight+10;
		//图片的宽度
        int imageWidth=tableRows.get(0).size()*tdWith+10;
		BufferedImage image = new BufferedImage(imageWidth, imageHeight, BufferedImage.TYPE_INT_RGB);
        Graphics graphics = image.getGraphics();
        graphics.setColor(Color.WHITE);
        graphics.fillRect(0, 0, imageWidth, imageHeight);
        graphics.setColor(Color.black);
        //填充
        int padding=5;
        // 画横线
        for(int i=0;i<tableRows.size()+1;i++){
        	graphics.drawLine(padding, padding+(tdHeight*i), imageWidth - padding,padding+(tdHeight*i));
        	graphics.setColor(Color.black);
        }
        // 画竖线
        graphics.setColor(Color.black);
        for(int i=0;i<tableRows.size();i++){
        	for(int j=0;j<tableRows.get(i).size()+1;j++){
            	graphics.drawLine((5+(tdWith*j)),padding+tdHeight*i,padding+(tdWith*j),tdHeight*(i+1)+padding);
            	graphics.setColor(Color.black);
            }
        }
        // 写入内容
        graphics.setColor(Color.black);
        Font font = new Font("黑体", Font.BOLD, 14);
        graphics.setFont(font);
        for(int i=0;i<tableRows.size();i++){
        	for(int j=0;j<tableRows.get(i).size();j++){
            	graphics.drawString(tableRows.get(i).get(j), 10+(tdWith*j), tdHeight*(i+1)+1);
            }
        }
        byte[] imageBytes=null;
        ByteArrayOutputStream  output=null;
        try {
        	output=new ByteArrayOutputStream();
			ImageIO.write(image, "jpg", output);
			imageBytes=output.toByteArray();
		} catch (IOException e) {
			logger.error("genneration dial switch image exception",e);
		}finally{
			IOUtils.close(output);
		}
       
        return imageBytes;
    }
 
   
    public byte[] dialSwitchHandler(String dialSwitch){
    	List<List<String>> tableRows = new ArrayList<>();
    	char[] dialNos=dialSwitch.toCharArray();
    	List<String> dialSwitchTitle = new ArrayList<>();
    	dialSwitchTitle.add("");
    	List<String> dialSwitchON =new ArrayList<>(); 
    	dialSwitchON.add("ON");
        List<String> dialSwitchOFF = new ArrayList<>();
        dialSwitchOFF.add("OFF");
        int i=1;
    	for(Character dialNo:dialNos){
    		dialSwitchTitle.add(" "+String.valueOf(i++));
    		if("1".equals(String.valueOf(dialNo))){
    			dialSwitchON.add(" X");
    			dialSwitchOFF.add("");
    		}else{
    			dialSwitchON.add("");
    			dialSwitchOFF.add(" X");
    		}
    	}
    	tableRows.add(dialSwitchTitle);
    	tableRows.add(dialSwitchON);
    	tableRows.add(dialSwitchOFF);
    	if(CollectionUtils.isEmpty(tableRows) || CollectionUtils.isEmpty(tableRows.get(0))){
        	return null;
        }
    	return graphicsGeneration(30,20,tableRows);
    }
}

package pall_wdpts_controler;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.thymeleaf.util.StringUtils;

public class GeneralHeaders {
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());  
	public static void main(String[] args){
		new GeneralHeaders().parse();
	}
	public   void parse(){
		String sql="INSERT INTO `t_ums_th_config` VALUES ('MENUID', 'TABLENAME', 'LINENUM', 'COLNUM', null, 'ROWS', 'COLS', null, 'fieldname', '0', 'HEADLINE', null);";
		Path path=Paths.get("h:/1.txt");
		String menuid="207";
		String TABLENAME="18-0027";
		Map<String,List<String[]>> headers=new HashMap<String,List<String[]>>();
		StringBuffer sb=new StringBuffer();
		try {
			List<String> lines=Files.readAllLines(path);
			
			if(!CollectionUtils.isEmpty(lines)){
				for(String line:lines){
					String[] temps=StringUtils.split(line, "|");
					if(temps.length!=2)break;
					if(CollectionUtils.isEmpty(headers.get(temps[0]))){
						headers.put(temps[0], new ArrayList<String[]>());
					}
					String[] temparr=new String[3];
					temparr[0]=temps[0];
					temparr[1]=temps[1];
					temparr[2]=line;
					headers.get(temps[0]).add(temparr);
				}
				Set<String> keys=headers.keySet();
				List<String> tempkeys=new ArrayList<String>();
				tempkeys.addAll(keys);
				Collections.sort(tempkeys,new Comparator<String>() {
					@Override
			        public int compare(String o1, String o2) {
						if(o1.compareToIgnoreCase(o2)>0){
							return 1;
						}else if(o1.compareToIgnoreCase(o2)<0){
							return -1;
						}else{
							return 0;
						}
			        }
				});
				//第一行数据
				String dest="";
				int COLNUM=1;
				for(String key :tempkeys){
					dest=sql;
					dest=dest.replace("MENUID", menuid);
					dest=dest.replace("LINENUM", "1");
					dest=dest.replace("TABLENAME", TABLENAME);
					dest=dest.replace("ROWS", "1");
					dest=dest.replace("fieldname", "");
					dest=dest.replace("HEADLINE", key);
					dest=dest.replace("COLNUM", String.valueOf(COLNUM));
					COLNUM=COLNUM+headers.get(key).size();
					dest=dest.replace("COLS", String.valueOf(headers.get(key).size()));
					sb.append(dest);
					sb.append("\r\n");
				}
				COLNUM=1;
				for(String key :tempkeys){
					List<String[]> temps=headers.get(key);
					for(String[] temp:temps){
						dest=sql;
						dest=dest.replace("MENUID", menuid);
						dest=dest.replace("LINENUM", "2");
						dest=dest.replace("TABLENAME", TABLENAME);
						dest=dest.replace("ROWS", "1");
						dest=dest.replace("fieldname", temp[2]);
						dest=dest.replace("HEADLINE", temp[1]);
						dest=dest.replace("COLNUM", String.valueOf(COLNUM));
						COLNUM++;
						dest=dest.replace("COLS", "1");
						sb.append(dest);
						sb.append("\r\n");
					}
				}
			}
			Files.write(Paths.get("h:/2.txt"), sb.toString().getBytes(), StandardOpenOption.WRITE);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

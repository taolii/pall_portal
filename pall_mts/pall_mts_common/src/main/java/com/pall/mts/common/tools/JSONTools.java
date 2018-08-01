package com.pall.mts.common.tools;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.pall.mts.common.support.excel.ExcelHeaderNode;
import com.pall.mts.init.TableDataConfigInitiator;

/*
 * JSON工具类
 */
public class JSONTools {
	/*
	 * 将BaseTablesResponse中key为defects子集合信息翻转为父对象属性
	 * @param jsonData 需要翻转的JSON字符串
	 * @param overturnKey将指定的key下的集合对象翻转为父对象的属性
	 * @return 返回翻转后的json字符串
	 */
	public static String defectsOverturnFiled(String jsonData,List<String> defectTypes){
		JSONObject jsonObject=JSON.parseObject(jsonData);
		JSONArray jsonArray=jsonObject.getJSONObject("datatablesView").getJSONArray("data");
		for(int i=0;i<jsonArray.size();i++){
			JSONObject tempjsonObject=jsonArray.getJSONObject(i);
			JSONArray defectsJSONArray=tempjsonObject.getJSONArray("defects");
			if(defectsJSONArray==null)continue;
			for(int j=0;j<defectsJSONArray.size();j++){
				tempjsonObject.put(defectsJSONArray.getJSONObject(j).getString("fieldName"),defectsJSONArray.getJSONObject(j).getIntValue("defectValue"));
				tempjsonObject.remove("defects");
			}
		}
		Map<String,ExcelHeaderNode> tableFieldBindMap=null;
		if(defectTypes!=null){
			for(String defectType:defectTypes){
				tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(defectType);
				if(tableFieldBindMap!=null){
					for(String fieldName:tableFieldBindMap.keySet()){
						for(int i=0;i<jsonArray.size();i++){
							JSONObject tempjsonObject=jsonArray.getJSONObject(i);
							if(tempjsonObject.get(fieldName)==null){
								tempjsonObject.put(fieldName,"");
							}
						}
					}
				}
			}
		}
		
		return JSON.toJSONString(jsonObject,SerializerFeature.WriteMapNullValue);
	}
	/*
	 * 将BaseTablesResponse中key为defects子集合信息翻转为父对象属性
	 * @param jsonData 需要翻转的JSON字符串
	 * @param overturnKey将指定的key下的集合对象翻转为父对象的属性
	 * @return 返回翻转后的json字符串
	 */
	public static String handleJSONNullField(String jsonData,String tableName){
		JSONObject jsonObject=JSON.parseObject(jsonData);
		JSONArray jsonArray=jsonObject.getJSONObject("datatablesView").getJSONArray("data");
		Map<String,ExcelHeaderNode> tableFieldBindMap=TableDataConfigInitiator.getTableFieldBindConfig(tableName);
		if(tableFieldBindMap!=null){
			for(String fieldName:tableFieldBindMap.keySet()){
				for(int i=0;i<jsonArray.size();i++){
					JSONObject tempjsonObject=jsonArray.getJSONObject(i);
					if(tempjsonObject.get(fieldName)==null){
						tempjsonObject.put(fieldName,"");
					}
				}
			}
		}
		
		return JSON.toJSONString(jsonObject,SerializerFeature.WriteMapNullValue);
	}
	public static void main(String[] args){
		String gg="{\"datatablesView\":{\"data\":[{\"casualInspectionNum\":0,\"defects\":[{\"dataid\":1,\"defectID\":1,\"defectName\":\"nullnull1\",\"defectType\":1,\"defectValue\":50},{\"dataid\":2,\"defectID\":1,\"defectName\":\"nullnull2\",\"defectType\":1,\"defectValue\":80},{\"dataid\":18,\"defectID\":1,\"defectName\":\"nullnull18\",\"defectType\":1,\"defectValue\":90}],\"fixtureNumber\":\"98\",\"inputLotNum\":\"76\",\"inputQty\":87,\"inputTime\":\"2017-07-30 15:08:49.0\",\"partNum\":\"09\",\"pickingTime\":\"2017-07-13\",\"polishID\":1,\"polishLotNum\":\"09\",\"polishTime\":\"2017-07-30\",\"throwMillstoneNum\":\"98\",\"throwMillstonePosition\":\"98\",\"updateTime\":\"2017-07-30 15:08:45.0\",\"workOrderNum\":\"09\",\"yield\":98}],\"draw\":1,\"iTotalDisplayRecords\":1,\"recordsFiltered\":0,\"recordsTotal\":1},\"resultCode\":0,\"resultMsg\":null}";
		System.out.println(defectsOverturnFiled(gg,null));
	}
}

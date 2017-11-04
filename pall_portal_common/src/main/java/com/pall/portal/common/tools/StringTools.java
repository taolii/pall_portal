package com.pall.portal.common.tools;
/*
 * 字符工具类
 */
public class StringTools {
	/*
	 * 从字符串尾计算某个字符第N此出现的位置
	 */
	public static int lastIndexOf(String indexStr, String delimiter,int times){
		if (times<=0) {
			return -1;
		}
		for(int i=0;i<times;i++){
			int offset = indexStr.lastIndexOf(delimiter);
			if (offset < 0) {
				return offset;
			}else{
				indexStr=indexStr.substring(0, offset);
			}
		}
		return indexStr.length();
	}
	/*
	 * 计算某个字符第N此出现的位置
	 */
	public static int indexOf(String indexStr, String delimiter,int times){
		if (times<=0) {
			return -1;
		}
		for(int i=0;i<times;i++){
			int offset = indexStr.lastIndexOf(delimiter);
			if (offset < 0) {
				return offset;
			}else{
				indexStr=indexStr.substring(0, offset);
			}
		}
		return indexStr.length();
	}
}

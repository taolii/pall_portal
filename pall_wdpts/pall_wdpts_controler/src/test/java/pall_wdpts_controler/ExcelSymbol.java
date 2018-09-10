package pall_wdpts_controler;

public class ExcelSymbol {
	public static void main(String[] args) throws Exception {
	
		int[] code = {0x2610, 0x2611};
		for (int i = 0; i < 2; i++) {
			String s1 = new String(code, i, 1);
			System.out.println(s1);// 验证字符代码是否可行
		}
	}
}

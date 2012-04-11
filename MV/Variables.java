import java.util.ArrayList;

public class Variables {
	public static ArrayList<Integer> cteInt = new ArrayList<Integer>();
	public static ArrayList<Float> cteFloat = new ArrayList<Float>();
	public static ArrayList<String> cteHex = new ArrayList<String>();
	public static ArrayList<String> cteString = new ArrayList<String>();
	
	public static void agregaConstante(int dv, String valor){
		if(dv>=12000&&dv<12500){
			cteInt.add(Integer.parseInt(valor));
		}
		else if(dv>=12500&&dv<13000){
			cteFloat.add(Float.parseFloat(valor));
		}
		else if(dv>=13000&&dv<13500){
			cteHex.add(valor);
		}
		else if(dv>=13500&&dv<14000){
			cteString.add(valor);
		}
	}
	
	public float getValorNumerico(int dv){
		if(dv>=12000&&dv<12500){
			return cteInt.get(dv-12000);
		}
		else if(dv>=12500&&dv<13000){
			return cteFloat.get(dv-125000);
		}
		return -1000;
	}
}

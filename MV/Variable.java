import java.util.ArrayList;

public class Variable {
	public static int [] globalesInt;
	public static float [] globalesFlo;
	public static String [] globalesCol;
	public static String [] globalesStr;
	
	public static int [] tempsInt;
	public static float [] tempsFlo;
	public static String [] tempsCol;
	public static String [] tempsStr;
	
	public int [] varInt;
	public float [] varFlo;
	public String [] varCol;
	public String [] varStr;
	
	public static ArrayList<Integer> cteInt = new ArrayList<Integer>();
	public static ArrayList<Float> cteFlo = new ArrayList<Float>();
	public static ArrayList<String> cteCol = new ArrayList<String>();
	public static ArrayList<String> cteStr = new ArrayList<String>();
	
	public Variable(int i, int f, int c, int s){
		varInt = new int[i];
		varFlo = new float[f];
		varCol = new String[c];
		varStr = new String[s];
	}
	
	public static void inicializaGlobales(int i, int f, int c, int s){
		globalesInt = new int[i];
		globalesFlo = new float[f];
		globalesCol = new String[c];
		globalesStr = new String[s];
	}
	
	public static void inicializaTemporales(int i, int f, int c, int s){
		tempsInt = new int[i];
		tempsFlo = new float[f];
		tempsCol = new String[c];
		tempsStr = new String[s];
	}
	
	public static void agregaConstante(int dv, String valor){
		if(dv>=12000&&dv<12500){
			cteInt.add(Integer.parseInt(valor));
		}
		else if(dv>=12500&&dv<13000){
			cteFlo.add(Float.parseFloat(valor));
		}
		else if(dv>=13000&&dv<13500){
			cteCol.add(valor);
		}
		else if(dv>=13500&&dv<14000){
			cteStr.add(valor);
		}
	}
	
	public float getValorNumerico(int dv){
		if(dv>=0&&dv<500){
			System.out.println("de la direccion"+dv+"Regrese:"+ globalesInt[dv]);
			return globalesInt[dv];
		}
		if(dv>=500&&dv<1000){
			return globalesFlo[dv-500];
		}
		if(dv>=2000&&dv<2500){
			return varInt[dv-2000];
		}
		if(dv>=2500&&dv<3000){
			return varFlo[dv-2500];
		}
		if(dv>=4000&&dv<6000){
			return tempsInt[dv-4000];
		}
		if(dv>=6000&&dv<8000){
			return tempsFlo[dv-6000];
		}
		if(dv>=12000&&dv<12500){
			return cteInt.get(dv-12000);
		}
		if(dv>=12500&&dv<13000){

			System.out.println("de la direccion"+dv+"Regrese:"+ cteFlo.get(dv-12500));
			return cteFlo.get(dv-12500);
		}
		return 0;
	}
	
	public String getValorString(int dv){
		if(dv>=1000&&dv<1500){
			return globalesCol[dv-1000];
		}
		if(dv>=1500&&dv<2000){
			return globalesStr[dv-1500];
		}
		if(dv>=3000&&dv<3500){
			return varCol[dv-3000];
		}
		if(dv>=3500&&dv<4000){
			return varStr[dv-3500];
		}
		if(dv>=8000&&dv<10000){
			return tempsCol[dv-8000];
		}
		if(dv>=10000&&dv<8000){
			return tempsStr[dv-10000];
		}
		if(dv>=13000&&dv<13500){
			return cteCol.get(dv-13000);
		}
		else if(dv>=13500&&dv<14000){
			return cteStr.get(dv-13500);
		}
		return "";
	}
}

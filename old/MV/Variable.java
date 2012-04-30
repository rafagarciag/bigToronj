/*
 * La clase Variable concentra todos los tipos de variables en un solo lugar para facilitar
 * su acceso. Una instancia de la clase variable es usada para representar el scope de
 * un procedimiento. Ademas se cuenta con diversos arreglos de tipo estaticos para poder
 * tener acceso a las variables globales o temporales desde cualquier scope que se este
 * trabajando.
 */

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
	
	/*
	 * Este constructor es llamado con cada cambio de scope en la maquina virtual
	 * Se inicializan los tamaños de las variables temporales de cada instancia segun
	 * los parametros que se obtienen de su procedimiento correspondiente.
	 */
	public Variable(int i, int f, int c, int s){
		varInt = new int[i];
		varFlo = new float[f];
		varCol = new String[c];
		varStr = new String[s];
	}
	
	/*
	 * Con este metodo se inicializan los tamaños de los arreglos que contienen las
	 * variables globales del programa que se va a ejecutar.
	 */
	public static void inicializaGlobales(int i, int f, int c, int s){
		globalesInt = new int[i];
		globalesFlo = new float[f];
		globalesCol = new String[c];
		globalesStr = new String[s];
	}
	
	/*
	 * Este metodo inicializa los tamaños de los arreglos que contienen las variables
	 * temporales. Se opto por esta solucion en lugar de solo declarar un tamaño fijo
	 * para que la maquina virtual sea lo mas eficiente posible y no gaste mucha memoria.
	 */
	public static void inicializaTemporales(int i, int f, int c, int s){
		tempsInt = new int[i];
		tempsFlo = new float[f];
		tempsCol = new String[c];
		tempsStr = new String[s];
	}
	
	/*
	 * Este metodo es invocado con cada linea del archivo .btjo que contiene una constante
	 * para cada linea genera introduce una nueva constante a su respectiva lista.
	 * Se utilizo arraylist para obtener la ventaja de ampliacion dinamica asi como las
	 * facilidades de acceso de un arreglo.
	 */
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
	
	/*
	 * Segun el rango en el que se encuentre el parametro que se manda a este metodo
	 * regresara la posicion correpondiente en el arreglo que corresponda a su 
	 * localizacion en memoria de la maquina virtual.
	 * Se opto por regresar un valor float ya que este puede regresar ambos tipos de 
	 * valores numericos(flotantes y enteros). En caso de requerirse se hace un cast
	 * a entero en su llamada en la maquina virtual.
	 */
	public float getValorNumerico(int dv){
		if(dv>=0&&dv<500){
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
			return cteFlo.get(dv-12500);
		}
		return -1000;
	}
	
	/*
	 * De igual forma que el metodo anterior este metodo busca un valor en el arreglo
	 * correspondiente segun el rango en el que se encuentra la direccion virtual que
	 * se mando como parametro.
	 * Las variables hexadecimales se almacenan en un string y son transformadas a
	 * enteros hexadecimales cuando se necesita por lo que este metodo regresa un valor
	 * de tipo string.
	 */
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

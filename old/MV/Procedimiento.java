/*
 * La clase procedimiento es usada para instanciar cada uno de los procedimientos que
 * son mandados por el compilador a la maquina virtual para que esta tenga la informacion
 * necesaria al momento de hacer cambios de scopes que surgen a partir de cada llamada a
 * un procedimiento.
 */

public class Procedimiento {
	private int tipo;
	private int totalInt;
	private int totalFlo;
	private int totalCol;
	private int totalStr;
	private int cuadInicio;
	
	/*
	 * Se cuenta con un simple constructor que inicializa todas las variables segun
	 * los parametros que sean mandados al momento de generar una nueva instancia
	 */
	public Procedimiento(int tipo, int totalInt, int totalFlo, int totalCol, int totalStr, int cuadInicio){
		this.tipo=tipo;
		this.totalInt=totalInt;
		this.totalFlo=totalFlo;
		this.totalCol=totalCol;
		this.totalStr=totalStr;
		this.cuadInicio=cuadInicio;
	}
	
	/*
	 * Metodos get para tener acceso a la informacion de cada instancia
	 */
	public int getTipo() {
		return tipo;
	}

	public int getTotalInt() {
		return totalInt;
	}

	public int getTotalFlo() {
		return totalFlo;
	}

	public int getTotalCol() {
		return totalCol;
	}

	public int getTotalStr() {
		return totalStr;
	}

	public int getCuadInicio() {
		return cuadInicio;
	}
	
	
}

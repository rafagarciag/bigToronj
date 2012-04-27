public class Procedimiento {
	private int tipo;
	private int totalInt;
	private int totalFlo;
	private int totalCol;
	private int totalStr;
	private int cuadInicio;
	
	public Procedimiento(int tipo, int totalInt, int totalFlo, int totalCol, int totalStr, int cuadInicio){
		this.tipo=tipo;
		this.totalInt=totalInt;
		this.totalFlo=totalFlo;
		this.totalCol=totalCol;
		this.totalStr=totalStr;
		this.cuadInicio=cuadInicio;
	}

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

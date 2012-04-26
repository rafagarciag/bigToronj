import java.util.Arrays;


public class Procedimiento {
	private int tipo;
	private String id;
	private int totalVariables;
	private int totalParams;
	private int totalInt;
	private int totalFlo;
	private int totalCol;
	private int totalStr;
	private int [] params;
	private int cuadruploInicio;
	
	public int getTipo() {
		return tipo;
	}
	public String getId() {
		return id;
	}
	public int[] getParams() {
		return params;
	}
	public int getCuadruploInicio() {
		return cuadruploInicio;
	}
}

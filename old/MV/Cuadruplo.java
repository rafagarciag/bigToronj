/*La clase cuadruplo tiene como proposito facilitar el acceso a la informacion
 *que contiene cada cuadruplo que fue generado por el compulador.*/

public class Cuadruplo{
	private int operacion;
	private int operando1;
	private int operando2;
	private int resultado;
	
	/*Se utiliza un simple constructor que inicializa los valores del cuadruplo
	 *segun lo que se leyo del archivo objeto.*/
	public Cuadruplo(int operacion, int operando1, int operando2, int resultado){
		this.operacion=operacion;
		this.operando1=operando1;
		this.operando2=operando2;
		this.resultado=resultado;	
	}
	
	// Metodos get usados para extraer la informacion de cada cuadruplo.
	public int getOperacion(){
		return operacion;
	}
	
	public int getOperando1(){
		return operando1;
	}
	
	public int getOperando2(){
		return operando2;
	}
	
	public int getResultado(){
		return resultado;
	}
}

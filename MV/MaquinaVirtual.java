import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

public class MaquinaVirtual{

	static Variables variables = new Variables();
	
	public static void main(String args[]) throws IOException, InterruptedException{
		
		
		BufferedReader objIn = new BufferedReader(new InputStreamReader(new DataInputStream(new FileInputStream(args[0]+".btjo"))));
		
		String constante;
		String [] auxConstante = new String [2];
		
		String cuadruplo;
		String [] auxCuadruplo = new String [4];
		Cuadruplo [] cuadruplos = new Cuadruplo [1000];
		
		int index=0;
		
		while(!(constante=objIn.readLine()).equals("##")){
			auxConstante=constante.split(",");
			Variables.agregaConstante(Integer.parseInt(auxConstante[0]), auxConstante[1]);
		}
		
  		while((cuadruplo=objIn.readLine())!=null){
  			auxCuadruplo=cuadruplo.split(",");
  			cuadruplos[index]=new Cuadruplo(Integer.parseInt(auxCuadruplo[0]),Integer.parseInt(auxCuadruplo[1]),
  											Integer.parseInt(auxCuadruplo[2]),Integer.parseInt(auxCuadruplo[3]));
  			index++;
  		}
  		cuadruplos[index]=new Cuadruplo(-9999,-1,-1,-1);
		System.out.println("Fin de lectura");
		
		UnPanel elPanel = new UnPanel(variables.getValorNumerico(12000),variables.getValorNumerico(12001));
		Drawing d = new Drawing(elPanel);
		
		index=0;
		while(cuadruplos[index].getOperacion()!=-9999){
			switch(cuadruplos[index].getOperacion()){
				//OPERACIONES ARITMETICAS
				case 100:
					System.out.println("SUMA");
					break;
				case 101:
					System.out.println("RESTA");
					break;
				case 102:
					System.out.println("MULTIPLICACION");
					break;
				case 103:
					System.out.println("DIVISION");
					break;
				
				//ASIGNACION
				case 150:
					System.out.println("ASIGNACION");
					break;
					
				//OPERACIONES LOGICAS
				case 200:
					System.out.println("AND");
					break;
				case 201:
					System.out.println("OR");
					break;
				case 202:
					System.out.println("MENOR");
					break;
				case 203:
					System.out.println("MENOR/IGUAL");
					break;
				case 204:
					System.out.println("MAYOR");
					break;
				case 205:
					System.out.println("MAYOR/IGUAL");
					break;
				case 206:
					System.out.println("IGUAL");
					break;
				case 207:
					System.out.println("DIFERENTE");
					break;
				
				//GOTOs
				case 300:
					System.out.println("GOTO");
					break;
				case 301:
					System.out.println("GOTO/VERDADERO");
					break;
				case 302:
					System.out.println("GOTO/FALSO");
					break;
					
				//DIBUJO
				case 400:
					System.out.println("LINEA");
					elPanel.dibujaLinea(variables.getValorNumerico(cuadruplos[index].getOperando1()), 
							variables.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 401:
					System.out.println("TRIANGULO");
					break;
				case 402:
					System.out.println("TETRAGON");
					elPanel.dibujaRectangulo(variables.getValorNumerico(cuadruplos[index].getOperando1()), 
							variables.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 403:
					System.out.println("CIRCULO");
					elPanel.dibujaCirculo(variables.getValorNumerico(cuadruplos[index].getOperando1()), 
							variables.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				
				case 450:
					System.out.println("TRANS");
					elPanel.traslada(variables.getValorNumerico(cuadruplos[index].getOperando1()), 
							variables.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 451:
					System.out.println("ROTATE");
					elPanel.rota(variables.getValorNumerico(cuadruplos[index].getOperando1()));
					break;
					
				//PUSHES Y POPES
				case 500:
					System.out.println("PUSH");
					elPanel.push();
					break;
				case 501:
					System.out.println("POP");
					elPanel.pop();
					break;
				case 502:
					System.out.println("POPORIGIN");
					break;
			}
			index++;
			//Thread.sleep(500);
		}
	}
}
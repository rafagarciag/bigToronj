import java.io.*;
import java.util.*;
import javax.swing.*;
import java.awt.*;

public class MaquinaVirtual{

	public static void main(String args[]) throws IOException{
		BufferedReader cuadIn = new BufferedReader(new InputStreamReader(new DataInputStream(new FileInputStream(args[0]+".btjo"))));
		
		int [][] listaConstantes = new int [200][2];
		
		Cuadruplo [] cuadruplos = new Cuadruplo [1000];
		
		String [] auxString = new String [4];
		int index=0;
		String cuadruplo;
  		while((cuadruplo=cuadIn.readLine())!=null){
  			auxString=cuadruplo.split(",");
  			cuadruplos[index]=new Cuadruplo(Integer.parseInt(auxString[0]),Integer.parseInt(auxString[1]),
  											Integer.parseInt(auxString[2]),Integer.parseInt(auxString[3]));
  			index++;
  		}
  		cuadruplos[index]=new Cuadruplo(-9999,-1,-1,-1);
		System.out.println("Fin de lectura");
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
					break;
				case 401:
					System.out.println("TRIANGULO");
					break;
				case 402:
					System.out.println("TETRAGON");
					break;
				case 403:
					System.out.println("CIRCULO");
					break;
			}
			index++;
		}
		
		UnCanvas elCanvas = new UnCanvas();
		Drawing d = new Drawing(elCanvas);
	}



}

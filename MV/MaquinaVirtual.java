import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.LinkedList;
import java.util.Queue;

public class MaquinaVirtual{
 	
	public static void main(String args[]) throws IOException, InterruptedException{
		//BufferedReader usado para la lecutra del archivo .btjo
		BufferedReader objIn = new BufferedReader(new InputStreamReader(new DataInputStream(new FileInputStream(args[0]+".btjo"))));
		
		//...
		Queue <Integer> pilaRetornos = new LinkedList<Integer>();
		Queue <Variable> pilaScopes = new LinkedList<Variable>();
		Variable scope;
		
		String constante;//String auxiliar usado para leer una linea del archivo con la informacion de una constante
		String [] auxConstante = new String [2];//En este arreglo se divide la informacion del string anterior para manipularse mas facilmente
		
		String procedimiento;
		String [] auxProcedimiento = new String [6];
		Procedimiento [] listaProcs;
		
		String cuadruplo;//String auxiliar para lectura de cuadruplos en el archivo
		String [] auxCuadruplo = new String [4];//Arreglo auxiliar para contener la informacion de los cuadruplos para manipularse mas facilmente
		
		/*
		 * Los primeros 4 renglones del archivo contienen el total de variables globales
		 * segun su tipo.
		 * Con esta instruccion se inicializan los arreglos que van a contener los datos
		 * de dichas variables
		 */
		Variable.inicializaGlobales(Integer.parseInt(objIn.readLine()),
				Integer.parseInt(objIn.readLine()),
				Integer.parseInt(objIn.readLine()),
				Integer.parseInt(objIn.readLine()));
		
		/*
		 * Esta instruccion inicializa los arreglos de las variables temporales.
		 * Funciona de la misma manera que el metodo anterior pero leyendo de las lineas
		 * 5 a 8
		 */
		Variable.inicializaTemporales(Integer.parseInt(objIn.readLine()),
				Integer.parseInt(objIn.readLine()),
				Integer.parseInt(objIn.readLine()),
				Integer.parseInt(objIn.readLine()));
		
		
		
		while(!(constante=objIn.readLine()).equals("##")){
			auxConstante=constante.split(",");
			Variable.agregaConstante(Integer.parseInt(auxConstante[0]), auxConstante[1]);
		}
		
		int numProcs=Integer.parseInt(objIn.readLine());
		listaProcs = new Procedimiento[numProcs];
		for(int i=0;i<listaProcs.length;i++){
			procedimiento=objIn.readLine();
			auxProcedimiento=procedimiento.split(",");
			listaProcs[i]=new Procedimiento(Integer.parseInt(auxProcedimiento[0]),Integer.parseInt(auxProcedimiento[1]),Integer.parseInt(auxProcedimiento[2]),
					Integer.parseInt(auxProcedimiento[3]),Integer.parseInt(auxProcedimiento[4]),Integer.parseInt(auxProcedimiento[5]));
		}
		
		scope= new Variable(listaProcs[numProcs-1].getTotalInt(),listaProcs[numProcs-1].getTotalFlo(),
				listaProcs[numProcs-1].getTotalCol(),listaProcs[numProcs-1].getTotalStr());
		
		Cuadruplo [] cuadruplos = new Cuadruplo [Integer.parseInt(objIn.readLine())+1];
		
		int index=0;
  		while((cuadruplo=objIn.readLine())!=null){
  			auxCuadruplo=cuadruplo.split(",");
  			cuadruplos[index]=new Cuadruplo(Integer.parseInt(auxCuadruplo[0]),Integer.parseInt(auxCuadruplo[1]),
  											Integer.parseInt(auxCuadruplo[2]),Integer.parseInt(auxCuadruplo[3]));
  			index++;
  		}
  		cuadruplos[index]=new Cuadruplo(-9999,-1,-1,-1);
		System.out.println("Fin de lectura");
		
		
		
		UnPanel elPanel = new UnPanel(scope.getValorNumerico(12000),scope.getValorNumerico(12001), scope.getValorString(13000));
		Drawing d = new Drawing(elPanel, args[0]);
		
		index=0;
		while(cuadruplos[index].getOperacion()!=-9999){
			System.out.print(index+": ");
			switch(cuadruplos[index].getOperacion()){
				//OPERACIONES ARITMETICAS
				case 100:
					System.out.println("SUMA");
					if(cuadruplos[index].getResultado()>=4000&&cuadruplos[index].getResultado()<6000)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=(int)(scope.getValorNumerico(cuadruplos[index].getOperando1())+scope.getValorNumerico(cuadruplos[index].getOperando2()));
					else if(cuadruplos[index].getResultado()>=6000&&cuadruplos[index].getResultado()<8000)
						Variable.tempsFlo[cuadruplos[index].getResultado()-6000]=(scope.getValorNumerico(cuadruplos[index].getOperando1())+scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 101:
					System.out.println("RESTA");
					if(cuadruplos[index].getResultado()>=4000&&cuadruplos[index].getResultado()<6000)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=(int)(scope.getValorNumerico(cuadruplos[index].getOperando1())-scope.getValorNumerico(cuadruplos[index].getOperando2()));
					else if(cuadruplos[index].getResultado()>=6000&&cuadruplos[index].getResultado()<8000)
						Variable.tempsFlo[cuadruplos[index].getResultado()-6000]=(scope.getValorNumerico(cuadruplos[index].getOperando1())-scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 102:
					System.out.println("MULTIPLICACION");
					if(cuadruplos[index].getResultado()>=4000&&cuadruplos[index].getResultado()<6000)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=(int)(scope.getValorNumerico(cuadruplos[index].getOperando1())*scope.getValorNumerico(cuadruplos[index].getOperando2()));
					else if(cuadruplos[index].getResultado()>=6000&&cuadruplos[index].getResultado()<8000)
						Variable.tempsFlo[cuadruplos[index].getResultado()-6000]=(scope.getValorNumerico(cuadruplos[index].getOperando1())*scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 103:
					System.out.println("DIVISION");
					if(cuadruplos[index].getResultado()>=4000&&cuadruplos[index].getResultado()<6000)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=(int)(scope.getValorNumerico(cuadruplos[index].getOperando1())/scope.getValorNumerico(cuadruplos[index].getOperando2()));
					else if(cuadruplos[index].getResultado()>=6000&&cuadruplos[index].getResultado()<8000)
						Variable.tempsFlo[cuadruplos[index].getResultado()-6000]=(scope.getValorNumerico(cuadruplos[index].getOperando1())/scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				
				//ASIGNACION
				case 150:
					System.out.println("ASIGNACION");
					switch(cuadruplos[index].getResultado()/2000){
						case 0:
							switch((cuadruplos[index].getResultado()%2000)/500){
								case 0:
									Variable.globalesInt[cuadruplos[index].getResultado()]=(int)scope.getValorNumerico(cuadruplos[index].getOperando1());
									break;
								case 1:
									Variable.globalesFlo[cuadruplos[index].getResultado()-500]=scope.getValorNumerico(cuadruplos[index].getOperando1());
									break;
								case 2:
									Variable.globalesCol[cuadruplos[index].getResultado()-1000]=scope.getValorString(cuadruplos[index].getOperando1());
									break;
								case 3:
									Variable.globalesStr[cuadruplos[index].getResultado()-1500]=scope.getValorString(cuadruplos[index].getOperando1());
									break;
							}
							break;
						case 1:
							switch((cuadruplos[index].getResultado()%2000)/500){
								case 0:
									scope.varInt[cuadruplos[index].getResultado()-2000]=(int)scope.getValorNumerico(cuadruplos[index].getOperando1());
									break;
								case 1:
									scope.varFlo[cuadruplos[index].getResultado()-2500]=scope.getValorNumerico(cuadruplos[index].getOperando1());
									break;
								case 2:
									scope.varCol[cuadruplos[index].getResultado()-3000]=scope.getValorString(cuadruplos[index].getOperando1());
									break;
								case 3:
									scope.varStr[cuadruplos[index].getResultado()-3500]=scope.getValorString(cuadruplos[index].getOperando1());
									break;
							}
							break;
						case 2:
							Variable.tempsInt[cuadruplos[index].getResultado()-4000]=(int)scope.getValorNumerico(cuadruplos[index].getOperando1());
							break;
						case 3:
							Variable.tempsFlo[cuadruplos[index].getResultado()-6000]=scope.getValorNumerico(cuadruplos[index].getOperando1());
							break;	
						case 4:
							Variable.tempsCol[cuadruplos[index].getResultado()-8000]=scope.getValorString(cuadruplos[index].getOperando1());
							break;
						case 5:
							Variable.tempsStr[cuadruplos[index].getResultado()-10000]=scope.getValorString(cuadruplos[index].getOperando1());
							break;
					}
					break;
					
				//OPERACIONES LOGICAS
				case 200:
					System.out.println("AND");
					if (scope.getValorNumerico(cuadruplos[index].getOperando1())!=0 && scope.getValorNumerico(cuadruplos[index].getOperando2())!=0)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 201:
					System.out.println("OR");
					if (scope.getValorNumerico(cuadruplos[index].getOperando1())!=0 || scope.getValorNumerico(cuadruplos[index].getOperando2())!=0)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 202:
					System.out.println("MENOR");
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) < scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 203:
					System.out.println("MENOR/IGUAL");
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) <= scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 204:
					System.out.println("MAYOR");
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) > scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 205:
					System.out.println("MAYOR/IGUAL");
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) >= scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 206:
					System.out.println("IGUAL");
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) == scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 207:
					System.out.println("DIFERENTE");
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) != scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				
				//GOTOs
				case 300:
					System.out.println("GOTO");
					index=cuadruplos[index].getResultado()-1;
					break;
				case 301:
					System.out.println("GOTO/VERDADERO");
					if (scope.getValorNumerico(cuadruplos[index].getOperando1())!=0){
						index=cuadruplos[index].getResultado()-1;
					}
					break;
				case 302:
					System.out.println("GOTO/FALSO");
					if (scope.getValorNumerico(cuadruplos[index].getOperando1())==0){
						index=cuadruplos[index].getResultado()-1;
					}
					break;
				//DIBUJO
				case 400:
					System.out.println("LINEA");
					elPanel.dibujaLinea(scope.getValorNumerico(cuadruplos[index].getOperando1()), 
							scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 401:
					System.out.println("TRIANGULO");
					break;
				case 402:
					System.out.println("TETRAGON");
					elPanel.dibujaRectangulo(scope.getValorNumerico(cuadruplos[index].getOperando1()), 
							scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 403:
					System.out.println("CIRCULO");
					elPanel.dibujaCirculo(scope.getValorNumerico(cuadruplos[index].getOperando1()), 
							scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				
				case 450:
					System.out.println("TRANS");
					elPanel.traslada(scope.getValorNumerico(cuadruplos[index].getOperando1()), 
							scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 451:
					System.out.println("ROTATE");
					elPanel.rota(scope.getValorNumerico(cuadruplos[index].getOperando1()));
					break;
				case 452:
					System.out.println("COLOR");
					elPanel.cambiaColor(scope.getValorString(cuadruplos[index].getOperando1()));
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
					elPanel.popOrigin();
					break;
					
				//Llamadas y metodos
				case 600:
					System.out.println("RET");
					scope=pilaScopes.poll();
					index=pilaRetornos.poll();
					break;
				case 601:
					System.out.println("GOSUB");
					int iSUB=cuadruplos[index].getResultado();
					pilaRetornos.add(index);
					index=listaProcs[iSUB].getCuadInicio()-1;
					break;
				case 602:
					System.out.println("PARAM");
					switch(cuadruplos[index].getResultado()/2000){
					case 0:
						
						break;
					case 1:
						switch((cuadruplos[index].getResultado()%2000)/500){
						case 0:
							scope.varInt[cuadruplos[index].getResultado()-2000]=(int)pilaScopes.peek().getValorNumerico(cuadruplos[index].getOperando1());
							break;
						case 1:
							scope.varFlo[cuadruplos[index].getResultado()-2500]=pilaScopes.peek().getValorNumerico(cuadruplos[index].getOperando1());
							break;
						case 2:
							
							break;
						case 3:
							
							break;
						}
						break;
					}
					break;
				case 603:
					System.out.println("RETURN");
					
					break;
					
				//ERA
				case 999:
					System.out.println("ERA");
					int iERA=cuadruplos[index].getResultado();
					pilaScopes.add(scope);
					scope=new Variable(listaProcs[iERA].getTotalInt(),listaProcs[iERA].getTotalFlo(),
							listaProcs[iERA].getTotalCol(),listaProcs[iERA].getTotalStr());
					break;
					
			}
			index++;
			//Thread.sleep(500);
		}
	}
}
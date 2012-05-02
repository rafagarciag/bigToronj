import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Stack;

public class MaquinaVirtual{
 	
	public static void main(String args[]) throws IOException, InterruptedException{
		
		
		/*
		 * AL momento de ejecucion el usuario puede dar el numero de milisegundos que desea que a maquina virtual espere
		 * antes de generar la siguiente figura para poder apreciar la forma en la que se genera la imagen final.
		 */
		int wait=Integer.parseInt(args[1]);
		boolean dibujo=false;
		
		//BufferedReader usado para la lecutra del archivo .btjo
		BufferedReader objIn = new BufferedReader(new InputStreamReader(new DataInputStream(new FileInputStream(args[0]+".btjo"))));
		BufferedReader stdIn = new BufferedReader(new InputStreamReader(System.in));
		
		//...
		Stack <Integer> pilaRetornos = new Stack<Integer>();
		Stack <Variable> pilaScopes = new Stack<Variable>();
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
		
		
		/*
		 * Este ciclo se encarga de ir guardando el valor de las constantes que se van a utilizar a lo largo
		 * del programa. Se utiliza la instruccion agregaConstante por cada linea del archivo objeto
		 * hasta que se llega al delimitado "##"
		 */
		while(!(constante=objIn.readLine()).equals("##")){
			auxConstante=constante.split(",");
			Variable.agregaConstante(Integer.parseInt(auxConstante[0]), auxConstante[1]);
		}
		
		/*
		 * En esta parte del codigo se lee del archivo objeto el numero de metodos que se generaron por el usuario
		 * Dicho numero determina cuantas lineas siguientes contienen informacion sobre dichos procedimientos
		 * Para cada una de estas lineas se inicializa una nueva instancia de un procedimiento y se guarda en el
		 * arreglo correspondiente.
		 */
		int numProcs=Integer.parseInt(objIn.readLine());
		listaProcs = new Procedimiento[numProcs];
		for(int i=0;i<listaProcs.length;i++){
			procedimiento=objIn.readLine();
			auxProcedimiento=procedimiento.split(",");
			listaProcs[i]=new Procedimiento(Integer.parseInt(auxProcedimiento[0]),Integer.parseInt(auxProcedimiento[1]),Integer.parseInt(auxProcedimiento[2]),
					Integer.parseInt(auxProcedimiento[3]),Integer.parseInt(auxProcedimiento[4]),Integer.parseInt(auxProcedimiento[5]));
		}
		
		/*
		 * Se inicializa el primer scope del programa el cual corresponde al metodo drawing y que siempre esta guardado
		 * en la ultima posicion del arreglo de procedimientos.
		 */
		scope= new Variable(listaProcs[numProcs-1].getTotalInt(),listaProcs[numProcs-1].getTotalFlo(),
				listaProcs[numProcs-1].getTotalCol(),listaProcs[numProcs-1].getTotalStr());
		
		/*
		 * Se inicializa el tamaño del arreglo que guarda los cuadruplos segun el numero que se lee del
		 * archivo objeto.
		 */
		Cuadruplo [] cuadruplos = new Cuadruplo [Integer.parseInt(objIn.readLine())+1];
		
		/*
		 * Siendo los cuadruplos la ultima parte que se guarda en el archivo objeto el siguiente ciclo se ejecuta
		 * hasta encontarse con el final del archivo y obtiene la informacion de los cuadruplos por cada linea
		 * que se va consumiendo.
		 */
		int index=0;
  		while((cuadruplo=objIn.readLine())!=null){
  			auxCuadruplo=cuadruplo.split(",");
  			cuadruplos[index]=new Cuadruplo(Integer.parseInt(auxCuadruplo[0]),Integer.parseInt(auxCuadruplo[1]),
  											Integer.parseInt(auxCuadruplo[2]),Integer.parseInt(auxCuadruplo[3]));
  			index++;
  		}
  		//Se le otorga un codigo de escape al ultimo cuadruplo para saber que el programa ha finalziado
  		cuadruplos[index]=new Cuadruplo(-9999,-1,-1,-1);
		
		//Se incializa el canvas que generara las imagenes
		UnPanel elPanel = new UnPanel(scope.getValorNumerico(12000),scope.getValorNumerico(12001), scope.getValorString(13000));
		//Se inicializa la ventana que desplegara el canvas
		new Drawing(elPanel, args[0]);
		
		index=0;
		/*
		 * Este es el ciclo principal de la maquina virtual. Se dedica a interpretar los cuadruplos generados por el compilador
		 * uno tras otro hasta que llega al cuadruplo que marca el fin del programa marcado con el codigo -9999
		 */
		while(cuadruplos[index].getOperacion()!=-9999){
			
			
			switch(cuadruplos[index].getOperacion()){
				//OPERACIONES ARITMETICAS
				case 100: //SUMA
					if(cuadruplos[index].getResultado()>=4000&&cuadruplos[index].getResultado()<6000)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=(int)(scope.getValorNumerico(cuadruplos[index].getOperando1())+scope.getValorNumerico(cuadruplos[index].getOperando2()));
					else if(cuadruplos[index].getResultado()>=6000&&cuadruplos[index].getResultado()<8000)
						Variable.tempsFlo[cuadruplos[index].getResultado()-6000]=(scope.getValorNumerico(cuadruplos[index].getOperando1())+scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 101: //RESTA
					if(cuadruplos[index].getResultado()>=4000&&cuadruplos[index].getResultado()<6000)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=(int)(scope.getValorNumerico(cuadruplos[index].getOperando1())-scope.getValorNumerico(cuadruplos[index].getOperando2()));
					else if(cuadruplos[index].getResultado()>=6000&&cuadruplos[index].getResultado()<8000)
						Variable.tempsFlo[cuadruplos[index].getResultado()-6000]=(scope.getValorNumerico(cuadruplos[index].getOperando1())-scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 102: //MULTIPLICACION
					if(cuadruplos[index].getResultado()>=4000&&cuadruplos[index].getResultado()<6000)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=(int)(scope.getValorNumerico(cuadruplos[index].getOperando1())*scope.getValorNumerico(cuadruplos[index].getOperando2()));
					else if(cuadruplos[index].getResultado()>=6000&&cuadruplos[index].getResultado()<8000)
						Variable.tempsFlo[cuadruplos[index].getResultado()-6000]=(scope.getValorNumerico(cuadruplos[index].getOperando1())*scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				case 103: //DIVISION
					if(cuadruplos[index].getResultado()>=4000&&cuadruplos[index].getResultado()<6000)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=(int)(scope.getValorNumerico(cuadruplos[index].getOperando1())/scope.getValorNumerico(cuadruplos[index].getOperando2()));
					else if(cuadruplos[index].getResultado()>=6000&&cuadruplos[index].getResultado()<8000)
						Variable.tempsFlo[cuadruplos[index].getResultado()-6000]=(scope.getValorNumerico(cuadruplos[index].getOperando1())/scope.getValorNumerico(cuadruplos[index].getOperando2()));
					break;
				
				
				case 150: //ASIGNACION
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
				case 200: //AND
					if (scope.getValorNumerico(cuadruplos[index].getOperando1())!=0 && scope.getValorNumerico(cuadruplos[index].getOperando2())!=0)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 201: //OR
					if (scope.getValorNumerico(cuadruplos[index].getOperando1())!=0 || scope.getValorNumerico(cuadruplos[index].getOperando2())!=0)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 202: //MENOR
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) < scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 203: //MENOR O IGUAL
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) <= scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 204: //MAYOR
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) > scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 205: //MAYOR O IGUAL
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) >= scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 206: //IGUAL
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) == scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 207: //DIFERENTE
					if (scope.getValorNumerico(cuadruplos[index].getOperando1()) != scope.getValorNumerico(cuadruplos[index].getOperando2()))
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				case 208: //NEGACION
					if (scope.getValorNumerico(cuadruplos[index].getResultado())==0)
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=1;
					else
						Variable.tempsInt[cuadruplos[index].getResultado()-4000]=0;
					break;
				
				//GOTOs
				case 300: //GO TO
					index=cuadruplos[index].getResultado()-1;
					break;
				case 301: //GO TO VERDADERO
					if (scope.getValorNumerico(cuadruplos[index].getOperando1())!=0){
						index=cuadruplos[index].getResultado()-1;
					}
					break;
				case 302: //GO TO FALSO
					if (scope.getValorNumerico(cuadruplos[index].getOperando1())==0){
						index=cuadruplos[index].getResultado()-1;
					}
					break;
					
				//DIBUJO
				case 400: //LINEA
					elPanel.dibujaLinea(scope.getValorNumerico(cuadruplos[index].getOperando1()), 
							scope.getValorNumerico(cuadruplos[index].getOperando2()));
					dibujo=true;
					break;
				case 401: //TRIANGULO
					elPanel.dibujaTriangulo(scope.getValorNumerico(cuadruplos[index+1].getOperando1()),
							scope.getValorNumerico(cuadruplos[index+1].getOperando2()), 
							scope.getValorNumerico(cuadruplos[index].getOperando1()),
							scope.getValorNumerico(cuadruplos[index].getOperando2()),
							scope.getValorNumerico(cuadruplos[index].getResultado()));
					index++;
					dibujo=true;
					break;
				case 402: //RECTANGULO
					elPanel.dibujaRectangulo(scope.getValorNumerico(cuadruplos[index].getOperando1()), 
							scope.getValorNumerico(cuadruplos[index].getOperando2()),
							scope.getValorNumerico(cuadruplos[index].getResultado()));
					dibujo=true;
					break;
				case 403: //CIRCULO
					elPanel.dibujaCirculo(scope.getValorNumerico(cuadruplos[index].getOperando1()), 
							scope.getValorNumerico(cuadruplos[index].getOperando2()),
							scope.getValorNumerico(cuadruplos[index].getResultado()));
					dibujo=true;
					break;
				
				case 450: //TRASLACION
					elPanel.traslada(scope.getValorNumerico(cuadruplos[index].getOperando1()), 
							scope.getValorNumerico(cuadruplos[index].getOperando2()));
					Variable.globalesInt[0]=elPanel.getPointerX();
					Variable.globalesInt[1]=elPanel.getPointerY();
					break;
				case 451: //ROTACION
					elPanel.rota(scope.getValorNumerico(cuadruplos[index].getOperando1()));
					break;
				case 452: //CAMBIO DE COLOR
					elPanel.cambiaColor(scope.getValorString(cuadruplos[index].getOperando1()));
					break;
					
				//PUSHES Y POPES
				case 500: //PUSH
					elPanel.push();
					break;
				case 501: //POP
					elPanel.pop();
					Variable.globalesInt[0]=elPanel.getPointerX();
					Variable.globalesInt[1]=elPanel.getPointerY();
					break;
				case 502: //POP ORIGIN
					elPanel.popOrigin();
					Variable.globalesInt[0]=elPanel.getPointerX();
					Variable.globalesInt[1]=elPanel.getPointerY();
					break;
					
				//LLAMADAS Y METODOS
				case 600: //RET
					scope=pilaScopes.pop();
					index=pilaRetornos.pop();
					break;
				case 601: //GOSUB
					int iSUB=cuadruplos[index].getResultado();
					pilaRetornos.push(index);
					index=listaProcs[iSUB].getCuadInicio()-1;
					break;
				case 602: //PARAM
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
							scope.varCol[cuadruplos[index].getResultado()-3000]=pilaScopes.peek().getValorString(cuadruplos[index].getOperando1());
							break;
						case 3:
							scope.varStr[cuadruplos[index].getResultado()-3500]=pilaScopes.peek().getValorString(cuadruplos[index].getOperando1());
							break;
						}
						break;
					}
					break;
					
				case 700: //PRINT
					float print=scope.getValorNumerico(cuadruplos[index].getResultado());
					if(print!=-1000)
						System.out.print(""+print);
					else{
						String printStr=scope.getValorString(cuadruplos[index].getResultado());
						System.out.print(printStr.substring(1, printStr.length()-1));	
						
					}
					break;
				case 701: //PRINTL
					float printl=scope.getValorNumerico(cuadruplos[index].getResultado());
					if(printl!=-1000)
						System.out.println(""+printl);
					else{
						String printStr=scope.getValorString(cuadruplos[index].getResultado());
						System.out.println(printStr.substring(1, printStr.length()-1));	
						
					}
					break;
				case 702: //READ
					switch(cuadruplos[index].getResultado()/2000){
						case 0:
							switch((cuadruplos[index].getResultado()%2000)/500){
								case 0:
									Variable.globalesInt[cuadruplos[index].getResultado()]=Integer.parseInt(stdIn.readLine());
									break;
								case 1:
									Variable.globalesFlo[cuadruplos[index].getResultado()-500]=Float.parseFloat(stdIn.readLine());
									break;
								case 2:
									Variable.globalesCol[cuadruplos[index].getResultado()-1000]=stdIn.readLine();
									break;
								case 3:
									Variable.globalesStr[cuadruplos[index].getResultado()-1500]=stdIn.readLine();
									break;
							}
							break;
						case 1:
							switch((cuadruplos[index].getResultado()%2000)/500){
								case 0:
									scope.varInt[cuadruplos[index].getResultado()-2000]=Integer.parseInt(stdIn.readLine());
									break;
								case 1:
									scope.varFlo[cuadruplos[index].getResultado()-2500]=Float.parseFloat(stdIn.readLine());
									break;
								case 2:
									scope.varCol[cuadruplos[index].getResultado()-3000]=stdIn.readLine();
									break;
								case 3:
									scope.varStr[cuadruplos[index].getResultado()-3500]=stdIn.readLine();
									break;
							}
							break;
					}
					break;
					
				/*
				 * Al llegar a un cuadruplo con el codigo de operacion de ERA se mete el scope actual a la pila de scopes
				 * y se inicializa una nueva instancia de scope segun el id del procedimiento que fue llamado.
				 */
				case 999: //ERA
					int iERA=cuadruplos[index].getResultado();
					pilaScopes.push(scope);
					scope=new Variable(listaProcs[iERA].getTotalInt(),listaProcs[iERA].getTotalFlo(),
							listaProcs[iERA].getTotalCol(),listaProcs[iERA].getTotalStr());
					break;
			}
			
			index++;
			/*
			 * En caso de que se haya generado una figura el thread principal de la maquina virtual se manda a dormir
			 * para darle tiempo al usuario de apreciar la forma en la que se genera la imagen final.
			 */
			if (dibujo){
				Thread.sleep(wait);
				dibujo=false;
			}
		}
		//Al finalizar la ejecucion del programa se genera una imagen .png del canvas generado
		elPanel.guardaImagen(args[0]);
	}
}
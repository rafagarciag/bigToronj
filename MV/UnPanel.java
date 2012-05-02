import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.imageio.ImageIO;
import javax.swing.*;

/*
 * La clase UnPanel es la encargada de generar las imagenes que seran desplegadas
 * al momento de ejecutar un programa escrito en bigToronj.
 * Se puede decir que una instancia de la clase UnPanel es el lienzo que es colocado
 * en el JFrame que aparecera en la ejecucion del programa.
 */
public class UnPanel extends JPanel {
	
	/*Se utiliza una BufferedImage para tener acceso a una instacia de Graphics2D
	 * que no se pierda a medida que se repintando el dibujo.*/
	private BufferedImage image;
	private Graphics2D g2d;
	
	/*pointerX y pointerY representan el lugar donde se encuentra actualmente
	 * el puntero que señala donde se generara un figura*/
	private int pointerX;
	private int pointerY;
	
	/*
	 * Las variables boolTrans y boolRot son variables de control para determinar
	 * que tipo de pop() se va a ejecutar.
	 * Las variables transX,transY y rot almacenan los valores en que se a trasladado
	 * o rotado el origen del panel.
	 * Por ultimo las pilas de cada transformacion son utilizadas para almacenar
	 * las transformaciones que se hayan realizado al momento de hacer un push()
	 */
	public boolean boolTrans=false;
	public int transX;
	public ArrayList<Integer> pilaX = new ArrayList<Integer>();
	public int transY;
	public ArrayList<Integer> pilaY = new ArrayList<Integer>();
	public boolean boolRot=false;
	public double rot;
	public ArrayList<Double> pilaRot = new ArrayList<Double>();
	
	
	/*
	 * El constructor del panel genera la BufferedImage que sera utilizada para pintar
	 * el Jframe durante la ejecucion.
	 * Se obtiene ademas el contexto grafico de la imagen para manipularla con cada
	 * figura que debe ser dibujada
	 * Por ultimo se incorpora el color de fondo de la imagen dibujando un rectangulo
	 * del color correspondiente que cubre todo el panel.
	 */
	public UnPanel(float x, float y, String color) {
		image = new BufferedImage((int)x, (int)y, BufferedImage.TYPE_INT_ARGB);
		g2d = (Graphics2D) image.getGraphics();
		g2d.setColor(Color.decode("0x"+color.substring(1)));
		g2d.fillRect(0, 0, (int)x, (int)y);
		g2d.setColor(Color.BLACK);
	}
	
	/*
	 * Se da override al metodo paintComponent para poder dibujar la BufferedImage
	 * en el canvas con cada llamada que se hace al metodo repaint() del panel.
	 */
	@Override
	protected void paintComponent(Graphics g) {
		super.paintComponent(g);
		if (image != null) {
			g.drawImage(image, 0, 0, null);
		}
	}
	
	/*
	 * El metodo push introduce a sus respectivas pilas los valores actuales de las 
	 * modificaciones que se han hecho al origen del panel.
	 * Ademas reinicia dichos valores a cero para poder comenzar a hacer 
	 * modificaciones otra vez
	 */
	public void push(){
		pilaX.add(transX);
		pilaY.add(transY);
		pilaRot.add(rot);
		transX=0;
		transY=0;
		rot=0;
	}
	
	/*
	 * El metodo pop se encarga de regresar las cordenadas del contexto grafico a una 
	 * posicion previa a las ultimas transformaciones que ha sufrido.
	 * Antes de hacer cualquier cosa se verifica el estado de las banderas boolTrans y
	 * boolRot. En caso se estar prendidas el metodo pop solo resta las modificaciones que
	 * se han realizado para volver a la posicion anterior.
	 * En caso de estar apagadas significa que se estan generando diversos pop seguidos
	 * por lo que en esta situacion se tiene que sacar las posiciones que estan guardadas
	 * en las pilas de modificaciones para poder regresar el puntero a la posicion que
	 * se desea.
	 */
	public void pop(){
		if(!boolRot){
			if(!pilaRot.isEmpty()){
				rot=pilaRot.get(pilaRot.size()-1);
				pilaRot.remove(pilaRot.size()-1);
			}
			g2d.rotate(-rot);
		}
		else{
			g2d.rotate(-rot);
			rot=0;
		}
		if(!boolTrans){
			if(!pilaX.isEmpty()){
				transX=pilaX.get(pilaX.size()-1);
				pilaX.remove(pilaX.size()-1);
			}
			if(!pilaY.isEmpty()){
				transY=pilaY.get(pilaY.size()-1);
				pilaY.remove(pilaY.size()-1);
			}
			pointerX-=(int)transX;
			pointerY-=(int)transY;
			g2d.translate(-transX, -transY);
		}
		else{
			pointerX-=(int)transX;
			pointerY-=(int)transY;
			g2d.translate(-transX, -transY);
			transX=0;
			transY=0;
		}
		boolTrans=false;
		boolRot=false;
	}
	
	/*
	 * Para llegar al origen del panel se generan llamadas al metodo pop()
	 * hasta que las pilas de transformaciones queden vacias.
	 * Una vez que las pilas estan vacias se llama pop() una vez mas para reiniciar
	 * los valores del pointer a cero.
	 */
	public void popOrigin(){
		pilaX.clear();
		pilaY.clear();
		pilaRot.clear();
		Color auxColor=g2d.getColor();
		g2d.dispose();
		g2d = (Graphics2D) image.getGraphics();
		g2d.setColor(auxColor);
	}
	
	/*
	 * A partir de los parametros que recibe este metodo traslada el origen del panel
	 * segun las distancias establecidas. Se almacenan ademas las distancias trasladadas
	 * para ejecutar restarlas al momento de hacer un pop().
	 */
	public void traslada(float x, float y){
		pointerX+=(int)x;
		pointerY+=(int)y;
		g2d.translate((int)x, (int)y);
		transX+=x;
		transY+=y;
		boolTrans=true;
	}
	
	/*
	 * Se recibe como parametro los grados que se desea rotar el origen del panel
	 * Se hace una conversion a radianes y se ejecuta la rotacion. Ademas se almacenan 
	 * los valores necesarios para la correcta ejecucion de el metodo pop()
	 */
	public void rota(float x){
		g2d.rotate(Math.toRadians(x));
		rot+=Math.toRadians(x);
		boolRot=true;
	}
	
	/*
	 * Este metodo modifica el color del panel para que las siguientes figuras que
	 * se dibujen despues de la invocacion de este metodo tengan el color correspondiente.
	 */
	public void cambiaColor(String color){
		g2d.setColor(Color.decode("0x"+color.substring(1)));
	}
	
	/*
	 * El metodo de triangulo genera 3 puntos, uno es el origen actual, mientras
	 * que los otros dos son formados a partir de los parametros que se reciben.
	 * A partir de las cordenadas X y Y de los los puntos generados se dibuja un
	 * poligono de tres lados.
	 * Segun el valor de fill dicho poligono estara lleno o vacio.
	 */
	public void dibujaTriangulo(float a, float b, float c, float d, float fill){
		Point p1 = new Point(0,0);
		Point p2 = new Point((int)a,(int)b);
		Point p3 = new Point((int)c,(int)d);
		
		int[] xs = { p1.x, p2.x, p3.x };
		int[] ys = { p1.y, p2.y, p3.y };
		Polygon triangle = new Polygon(xs, ys, xs.length);
		
		if(fill==0)
			g2d.drawPolygon(triangle);
		else
			g2d.fillPolygon(triangle);
		repaint();
	}
	
	/*
	 * Este metodo dibuja una linea recta en el panel.
	 * La linea parte desde el pointer del dibujo hacia los puntos que son
	 * pasados como parametros.
	 */
	public void dibujaLinea(float x, float y){
		g2d.drawLine(0, 0, (int)x, (int)y);
		repaint();
	}
	
	/*
	 * Como su nombre lo explica este metodo se dedica a dibujar un rectangulo en el panel
	 * Primero se ejecuta una traslacion negativa con la mitad del tamaño del rectangulo
	 * para que este se dibuje en el centro del pointer de dibujo.
	 * Segun el valor de fill el rectangulo esta lleno o es solo el marco
	 */
	public void dibujaRectangulo(float x, float y, float fill){
		g2d.translate(-(int)x/2, -(int)y/2);
		if(fill==0)
			g2d.drawRect(0, 0, (int)x, (int)y);
		else
			g2d.fillRect(0, 0, (int)x, (int)y);
		g2d.translate((int)x/2, (int)y/2);
		repaint();
	}
	/*
	 * Wste metodo se dedica a dibujar un circulo en el panel
	 * Primero se ejecuta una traslacion negativa con la mitad del tamaño del circulo
	 * para que este se dibuje en el centro del pointer de dibujo.
	 * Segun el valor de fill el circulo se llena de color o no.
	 */
	public void dibujaCirculo(float x, float y, float fill){
		g2d.translate(-(int)x/2, -(int)y/2);
		if(fill==0)
			g2d.drawOval(0, 0, (int)x, (int)y);
		else
			g2d.fillOval(0, 0, (int)x, (int)y);
		g2d.translate((int)x/2, (int)y/2);
		repaint();
	}
	
	/*
	 * Este metodo se encarga de generar una imagen con extension ".png"
	 * del programa que se acaba de ejecutar.
	 * De esta forma el usuario tiene una copia permanente de sus creaciones
	 * en bigToronj
	 */
	public void guardaImagen(String nombre){
		try{
			ImageIO.write(image, "png", new File(nombre+".png"));
		}
		catch (IOException e){
			e.printStackTrace();
		}
	}
	/*
	 * Metodos get usados para obtener la informacion del panel que se necesita
	 * en otras clases de la maquina virtual.
	 */
	public int getAncho(){
		return image.getWidth();
	}
	
	public int getAlto(){
		return image.getHeight();
	}
	
	public int getPointerX() {
		return pointerX;
	}

	public int getPointerY() {
		return pointerY;
	}
}
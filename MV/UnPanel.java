import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.ArrayList;

import javax.swing.*;

@SuppressWarnings("serial")
public class UnPanel extends JPanel {
	private BufferedImage image;
	private Graphics2D g2d;
	
	//Pilas para transformaciones
	public boolean boolTrans=false;
	public int transX;
	public ArrayList<Integer> pilaX = new ArrayList<Integer>();
	public int transY;
	public ArrayList<Integer> pilaY = new ArrayList<Integer>();
	public boolean boolRot=false;
	public double rot;
	public ArrayList<Double> pilaRot = new ArrayList<Double>();

	public UnPanel(float x, float y, String color) {
		image = new BufferedImage((int)x, (int)y, BufferedImage.TYPE_INT_ARGB);
		g2d = (Graphics2D) image.getGraphics();
		g2d.setColor(Color.decode("0x"+color.substring(1)));
		g2d.fillRect(0, 0, (int)x, (int)y);
		g2d.setColor(Color.BLACK);
	}
	
	public int getAncho(){
		return image.getWidth();
	}
	
	public int getAlto(){
		return image.getHeight();
	}
	
	@Override
	protected void paintComponent(Graphics g) {
		super.paintComponent(g);
		if (image != null) {
			g.drawImage(image, 0, 0, null);
		}
	}
	
	public void push(){
		pilaX.add(transX);
		pilaY.add(transY);
		pilaRot.add(rot);
		transX=0;
		transY=0;
		rot=0;
	}
	
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
			g2d.translate(-transX, -transY);
		}
		else{
			g2d.translate(-transX, -transY);
			transX=0;
			transY=0;
		}
		boolTrans=false;
		boolRot=false;
	}
	
	public void popOrigin(){
		while(!(pilaX.isEmpty()||pilaY.isEmpty()||pilaRot.isEmpty())){
			pop();
		}
		pop();
	}
	
	public void traslada(float x, float y){
		g2d.translate((int)x, (int)y);
		transX+=x;
		transY+=y;
		boolTrans=true;
	}
	
	public void rota(float x){
		System.out.println("Los grados: "+x);
		System.out.println("To radians:"+Math.toRadians(x));
		g2d.rotate(Math.toRadians(x));
		rot+=Math.toRadians(x);
		boolRot=true;
	}
	
	public void cambiaColor(String color){
		g2d.setColor(Color.decode("0x"+color.substring(1)));
	}
	
	public void dibujaLinea(float x, float y){
		g2d.drawLine(0, 0, (int)x, (int)y);
		repaint();
	}

	public void dibujaRectangulo(float x, float y){
		g2d.translate(-(int)x/2, -(int)y/2);
		g2d.fillRect(0, 0, (int)x, (int)y);
		g2d.translate((int)x/2, (int)y/2);
		repaint();
	}
   
	public void dibujaCirculo(float x, float y){
		g2d.translate(-(int)x/2, -(int)y/2);
		g2d.fillOval(0, 0, (int)x, (int)y);
		g2d.translate((int)x/2, (int)y/2);
		repaint();
	}
}
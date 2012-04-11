import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.ArrayList;

import javax.swing.*;

@SuppressWarnings("serial")
public class UnPanel extends JPanel {
	private BufferedImage image;
	private Graphics2D g2d;
	
	//Pilas para transformaciones
	public boolean auxPop=false;
	public int transX;
	public ArrayList<Integer> pilaX = new ArrayList<Integer>();
	public int transY;
	public ArrayList<Integer> pilaY = new ArrayList<Integer>();
	public double rot;
	public ArrayList<Double> pilaRot = new ArrayList<Double>();

	public UnPanel(float x, float y) {
		image = new BufferedImage((int)x, (int)y, BufferedImage.TYPE_INT_ARGB);
		g2d = (Graphics2D) image.getGraphics();
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
		
	}
	
	public void pop(){
		
	}
	
	public void traslada(float x, float y){
		g2d.translate((int)x, (int)y);
		transX+=x;
		transY+=y;
	}
	
	public void dibujaLinea(float x, float y){
		g2d.setColor(Color.green);
		g2d.drawLine(0, 0, (int)x, (int)y);
		repaint();
	}

	public void dibujaRectangulo(float x, float y){
		g2d.setColor(Color.blue);
		g2d.fillRect(0, 0, (int)x, (int)y);
		repaint();
	}
   
	public void dibujaCirculo(float x, float y){
		g2d.setColor(Color.red);
		g2d.fillOval(0, 0, (int)x, (int)y);
		repaint();
	}
}
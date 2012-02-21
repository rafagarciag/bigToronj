import javax.swing.*;
import java.awt.*;

public class UnCanvas extends Canvas{
	public void paint(Graphics g){
		super.paint(g);
        Graphics2D g2d = (Graphics2D) g;
	
		g2d.setColor(Color.red);
		g2d.translate(100,100);
		g2d.fillRect(0,0,100,50);
		g2d.setColor(Color.blue);
		
		/*
		//ROTATE_IN_PLACE
		g2d.translate(50,25);
		g2d.rotate(.67);
		g2d.translate(-50,-25);
		g2d.fillRect(0,0,100,50);
		//ROTATE_IN_PLACE
		*/
	}
}

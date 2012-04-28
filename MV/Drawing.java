import java.awt.Dimension;
import java.awt.Toolkit;

import javax.swing.*;

public class Drawing{
	Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();
	
	private JFrame frame;
	
	public Drawing(UnPanel elPanel, String nombre){
		frame = new JFrame(nombre);
		frame.setUndecorated(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().add(elPanel);
		frame.setSize(elPanel.getAncho(),elPanel.getAlto());
		frame.setLocation((dim.width-elPanel.getAncho())/2,
				(dim.height-elPanel.getAlto())/2);
		frame.setVisible(true);
	}
}

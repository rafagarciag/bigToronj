/*
 * La clase Drawing es una instancia de un Jframe el cual desplegara el panel que contiene
 * los dibujos que genero el usuario a partir del codigo en bigToronj
 */

import java.awt.Dimension;
import java.awt.Toolkit;

import javax.swing.*;

public class Drawing{
	/*
	 * La variable dim es utilizada para obtener las dimensiones de la pantalla
	 * con el proposito de acomodar el dibujo en el centro de la misma.
	 */
	Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();
	
	private JFrame frame;
	
	/*
	 * EL constructor del Frame recibe como parametros el panel generado para adaptarse
	 * al tamaño de la imagen. Recibe ademas un string que contiene el nombre del programa
	 * ejecutandose para usarse como titulo en el frame.
	 */
	public Drawing(UnPanel elPanel, String nombre){
		frame = new JFrame(nombre);
		frame.setUndecorated(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().add(elPanel);
		frame.setSize(elPanel.getAncho(),elPanel.getAlto());
		frame.setLocation((dim.width-elPanel.getAncho())/2,
				(dim.height-elPanel.getAlto())/2);
		frame.setResizable(false);
		frame.setVisible(true);
	}
}

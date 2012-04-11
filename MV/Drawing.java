import javax.swing.*;

public class Drawing{
	
	private JFrame frame;
	
	public Drawing(UnPanel elPanel){
		frame = new JFrame("Drawing");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().add(elPanel);
		frame.setSize(elPanel.getAncho(),elPanel.getAlto());
		frame.setVisible(true);
	}
}

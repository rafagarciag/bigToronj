import javax.swing.*;
import java.awt.*;

public class Drawing{
	public Drawing(UnCanvas elCanvas){
		JFrame frame = new JFrame("Drawing");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().add(elCanvas);
		frame.setSize(1000,600);
		frame.setVisible(true); 
	}
}

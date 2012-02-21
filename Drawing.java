import javax.swing.*;
import java.awt.*;

public class Drawing{
	public static void main(String [] args){
		Drawing d = new Drawing();
	}


	public Drawing(){
		JFrame frame = new JFrame("Drawing");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().add(new UnCanvas());
		frame.setSize(1000,600);
		frame.setVisible(true); 
	}
}

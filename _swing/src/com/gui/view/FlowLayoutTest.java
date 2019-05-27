package com.gui.view;

import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JFrame;

public class FlowLayoutTest extends JFrame {

	public FlowLayoutTest() {
		setBounds(400, 400, 500, 500);

		//FlowLayout�� �Ű������� ������ġ�� �����ؾ���
		//�·�����, �������, �߾�����
		setLayout(new FlowLayout(FlowLayout.CENTER));
		for(int i =0; i <100; i++)
			add(new JButton(i+1+""));

		setVisible(true);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
}

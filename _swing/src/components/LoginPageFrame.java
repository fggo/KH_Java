package components;

import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.*;

import org.openide.awt.DropDownButtonFactory;

public class LoginPageFrame extends JFrame implements ActionListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static final int WIDTH = 900;
	private static final int HEIGHT = 900;
	
	private JSplitPane splitPane1, splitPane2, splitPane3;
	private JPanel topPanel, bottomPanel, rightPanel, leftPanel, subPanel1, subPanel2;
	
	private JButton logoBtn, menuDropDownBtn, myPageBtn, orderViewBtn;
	private JButton signInBtn1, signInBtn2, signUpBtn1, signUpBtn2, orderBtn;
	
	private JTextField phoneInput;

	public LoginPageFrame(String title) throws HeadlessException {
		super(title);
		setSize(WIDTH, HEIGHT);
		setLocationRelativeTo(null);
		
		this.createMenuBar();
		
		getContentPane().setLayout(new BorderLayout());

		splitPane1 = new JSplitPane(JSplitPane.VERTICAL_SPLIT);
		splitPane1.setDividerLocation(300 + splitPane1.getInsets().top);

		phoneInput = new JTextField("", 11);
		signInBtn1 = new JButton("�α���");
		signUpBtn1 = new JButton("ȸ������");
		orderBtn = new JButton("�ֹ��ϱ�");

		leftPanel = new JPanel();
		rightPanel = new JPanel(new GridLayout(2,1));
		subPanel1 = new JPanel(new FlowLayout(FlowLayout.RIGHT)); 
		subPanel1.add(new JLabel("�ڵ��� ��ȣ"));
		subPanel1.add(phoneInput);
		subPanel2 = new JPanel(new FlowLayout(FlowLayout.RIGHT));
		subPanel2.add(signInBtn1);
		subPanel2.add(signUpBtn1);
		rightPanel.add(subPanel1);
		rightPanel.add(subPanel2);
		
		topPanel = new JPanel(new GridLayout(1,2));
		topPanel.add(leftPanel);
		topPanel.add(rightPanel);
		bottomPanel = new JPanel(new GridLayout(2,1));
		bottomPanel.add(new JPanel());
		bottomPanel.add(orderBtn);
		splitPane1.setTopComponent(topPanel);
		splitPane1.setBottomComponent(bottomPanel);

		
		JToolBar navBar = this.createNavBar();

		splitPane2 = new JSplitPane(JSplitPane.VERTICAL_SPLIT);
		splitPane2.setDividerLocation(70 + splitPane2.getInsets().top);

		topPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
		topPanel.add(navBar);
		bottomPanel = new JPanel(new BorderLayout());
		bottomPanel.add(splitPane1);
		splitPane2.setTopComponent(topPanel);
		splitPane2.setBottomComponent(bottomPanel);


		JPanel topMostPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
		signInBtn2 = new JButton("�α���");
		signUpBtn2 = new JButton("ȸ������");
		topMostPanel.add(signInBtn2);
		topMostPanel.add(signUpBtn2);
		splitPane3 = new JSplitPane(JSplitPane.VERTICAL_SPLIT);
		splitPane3.setDividerLocation(30 + splitPane3.getInsets().top);

		topPanel = topMostPanel;
		bottomPanel = new JPanel(new BorderLayout());
		bottomPanel.add(splitPane2);
		splitPane3.setTopComponent(topPanel);
		splitPane3.setBottomComponent(bottomPanel);

		add(splitPane3);
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

	}
	
	private JToolBar createNavBar() {

		JToolBar toolbar = new JToolBar();
		toolbar.setFloatable(false);
		
		//logo
		Image img = null;
		try {
			img = ImageIO.read(new File("src/components/images/burger.png"));
			img = img.getScaledInstance(100, 50, Image.SCALE_DEFAULT);
		} catch(IOException e) {
			e.printStackTrace();
		}
		logoBtn = new JButton(new ImageIcon(img));
		logoBtn.setPreferredSize(new Dimension(100, 50));

		JPanel panel = new JPanel();
        panel.add(logoBtn); //add button to panel

        toolbar.add(panel);//add panel to toolbar
		toolbar.add(new JSeparator());

		
		//menu dropdown
		menuDropDownBtn = createDropDownButton();
		menuDropDownBtn.setPreferredSize(new Dimension(70, 50));
		
		panel = new JPanel();
		panel.add(menuDropDownBtn);

		toolbar.add(panel);
		toolbar.add(new JSeparator());

        //mypage
		myPageBtn = new JButton(new ImageIcon(
				getClass().getResource("images/save.png")));
		myPageBtn.setPreferredSize(new Dimension(100, 50));

		panel = new JPanel();
        panel.add(myPageBtn); //add button to panel

		toolbar.add(panel);
		toolbar.add(new JSeparator());

		//order view
		orderViewBtn = new JButton(new ImageIcon(
				getClass().getResource("images/run.png")));
		orderViewBtn.setPreferredSize(new Dimension(100, 50));

		panel = new JPanel();
        panel.add(orderViewBtn); //add button to panel

		toolbar.add(panel);
		
//		setLayout(new FlowLayout(FlowLayout.LEFT));
//		add(toolbar);

		return toolbar;
	}

	private JButton createDropDownButton() {
		JPopupMenu popupMenu = createDropDownMenu();
		
		ImageIcon icon = new ImageIcon(getClass().getResource("images/new.gif"));
		
		JButton menuDropDownBtn = DropDownButtonFactory.createDropDownButton(icon, popupMenu);
		menuDropDownBtn.addActionListener(this);
		
		return menuDropDownBtn;
	}

	private JPopupMenu createDropDownMenu() {
		JPopupMenu popupMenu = new JPopupMenu();
		
		JMenuItem menuItemCreateSpringProject = new JMenuItem("�ܹ��� - 2000��");
		popupMenu.add(menuItemCreateSpringProject);
		
		JMenuItem menuItemCreateHibernateProject = new JMenuItem("���� - 1000��");
		popupMenu.add(menuItemCreateHibernateProject);
		
		JMenuItem menuItemCreateStrutsProject = new JMenuItem("�ݶ� - 700��");
		popupMenu.add(menuItemCreateStrutsProject);
		
		menuItemCreateSpringProject.addActionListener(this);
		menuItemCreateHibernateProject.addActionListener(this);
		menuItemCreateStrutsProject.addActionListener(this);
		
		return popupMenu;
	}

	private void createMenuBar() {
		JMenuBar menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		
		JMenu menuFile = new JMenu("File");
		JMenuItem menuItemExit = new JMenuItem("Exit");
		
		menuFile.add(menuItemExit);
		
		menuBar.add(menuFile);
	}
	
	public static void main(String[] args) throws Exception {
		UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		new LoginPageFrame("food").setVisible(true);
//		SwingUtilities.invokeLater(new Runnable() {
//			
//			@Override
//			public void run() {
//			}
//		});
	}

	@Override
	public void actionPerformed(ActionEvent evt) {
		Object source = evt.getSource();
		if (source instanceof JMenuItem) {
			JMenuItem clickedMenuItem = (JMenuItem) source;
			String menuText = clickedMenuItem.getText();
			System.out.println(menuText+ "�� �߰��մϴ�.");
		} else if (source instanceof JButton) {
			System.out.println("�޴��� �����մϴ�.");
		}
	}

}

package com.kh.food.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;

import com.kh.food.model.vo.User;
import com.kh.food.view.MainMenu;

public class UserController {
	//����� ������ �а�(readFromFile),����(storeToFile) ���� ����
	private final File dataFile=new File("Users.dat"); 

	HashSet<User> users = new HashSet<User>();

	private String phone; //���� �α��� ���� ����(User��ü�� 1:1���� ��Ŵ)

	private MainMenu menu; //�޴� ������ ���� ��ü
	
	private final static int SEATS = 10;
	
	private boolean[] reservations = new boolean[SEATS];

	public UserController() {
		phone = null;
		readFromFile();
	}

	public void mainMenu() {
		menu = new MainMenu();
		MainMenu.mainMenu();
	}

	public void readFromFile() {
		if(dataFile.exists()==false)
			return;
		try {
			FileInputStream file=new FileInputStream(dataFile);		
			ObjectInputStream in=new ObjectInputStream(file);
			
			while(true) {
				User user=(User)in.readObject();
				if(user==null)
					break;
				users.add(user);
			}
			
			in.close();
		}
		catch(IOException e) {
			return;
		}
		catch(ClassNotFoundException e) {
			return;
		}
	}

	public void storeToFile() {
		try {
			FileOutputStream file=new FileOutputStream(dataFile);		
			ObjectOutputStream out=new ObjectOutputStream(file);
			
			Iterator<User> itr=users.iterator();
			while(itr.hasNext())
				out.writeObject(itr.next());
			
			out.close();
		}
		catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public void signUp() {
		if(this.phone != null)
			System.out.println("ȸ������ �Ϸ��� ���� �α׾ƿ� ���ּ���.");

		User user = MainMenu.signUpView();
		boolean isAdded = users.add(user);
		if(isAdded)
			System.out.println("ȸ�������� ���������� ó���Ǿ����ϴ�.");
		else {
			System.out.println("�̹� �����ϴ� ȸ�� �Դϴ�.");
		}
	}

	public void signIn() {
		String phoneInput = MainMenu.signInView();
		if(phoneInput.equals(this.phone) || phone != null)
			System.out.println("�̹� �α��� �Ǿ� �ֽ��ϴ�.");

		User user = getUserByPhone(phoneInput);
		if(user==null) {
			System.out.println("�α��ο� ���� �Ͽ����ϴ�.");
		}
		else {
			user.setLogged(true);
			setPhone(phoneInput);
			System.out.println("�α��� �ƽ��ϴ�.");
		}
	}
	
	public void logOff() {
		User user = null;
		Iterator<User>itr = users.iterator();
		while(itr.hasNext()) {	
			user = itr.next();
			if(user.getPhone().equals(this.phone)) {
				user.setLogged(false);
				if(user.getSeatNo() >=1 && user.getSeatNo() <=reservations.length) {
					reservations[user.getSeatNo() -1] = false;
					user.setSeatNo(0);
				}
				this.phone = null;
				System.out.println("�α׾ƿ� �ƽ��ϴ�.");
			}
		}
	}

	private User getUserByPhone(String phoneNum) {
		User user = null;
		Iterator<User> itr = users.iterator();
		while(itr.hasNext()) {
			user = itr.next();
			if(user.getPhone().equals(phoneNum)) {
				return user;
			}
		}
		return null;
	}

	public void order() {
		if (phone==null) {
			System.out.println("�α��� �� �̿��� �� �ֽ��ϴ�.");
			return;
		}
		
		//�ֹ�
		User user = getUserByPhone(this.phone);
		Map<String, Integer> orderList = MainMenu.orderView();
		user.setOrderList(orderList);

		//�¼�
		this.reserveSeat();
		
		//�ֹ��Ѿ� �� �ֹ����� ���
		int[] foodPrices = menu.getFoodPrices();
		int total = 0;
		int index = 0;
		for(Map.Entry<String, Integer> entry : orderList.entrySet()) {
			total += (entry.getValue()*foodPrices[index]);
			System.out.println("\t" + entry.getKey() + " ----- " 
					+ foodPrices[index++] +" * " + entry.getValue() + "��");
		}

		System.out.println("�ֹ��Ͻ� �Ѿ��� : " + total + "�� �Դϴ�.");
	}

	public void viewOrder() {
		
	}

	public void reserveSeat() {
		int seatNo = MainMenu.reserveSeatView();
		User user = getUserByPhone(this.phone);
		if(seatNo >=1 && seatNo <= reservations.length) {
			user.setSeatNo(seatNo);
		}
		user.setOrderCreated(new GregorianCalendar());
	}

	public void showUsers() {
		System.out.println("�̸�\t��ȭ\t�̸���\t�ּ�\t�α��λ���\t�ֹ���¥");

		Iterator<User> itr = users.iterator();
		while(itr.hasNext()) {
			itr.next().showUserInfo();
		}
	}

	//getter setter
	public String getPhone() { return phone; }
	public void setPhone(String phone) { this.phone = phone; }
	public boolean[] getReservations() { return reservations; }
	public void setReservations(boolean[] reservations) { this.reservations = reservations; }
	public static int getSeats() { return SEATS; }
}

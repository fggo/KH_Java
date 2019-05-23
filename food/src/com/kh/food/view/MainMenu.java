package com.kh.food.view;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

import com.kh.food.controller.UserController;
import com.kh.food.main.Main;
import com.kh.food.model.vo.MenuChoiceException;
import com.kh.food.model.vo.User;
import static com.kh.food.view.Constants.*;

public class MainMenu {
	public final static Scanner CONSOLE = new Scanner(System.in);
	static UserController controller = Main.getController();
	
	public static void showMainMenu() {
		System.out.println("=== Ȩ������ ===");
		System.out.println("1. ȸ�� ����");
		System.out.println("2. �α���");
		System.out.println("3. �α׿���");
		System.out.println("4. �ֹ� �ϱ�");
		System.out.println("5. �ֹ� ��ȸ");
		System.out.println("6. �մ���Ȳ ��ȸ");
		System.out.println("0. ���α׷� ����.");
		System.out.print("�޴� �Է�: ");
	}

	public static void mainMenu() {
		int choice = -1;
		do {
			try {
				MainMenu.showMainMenu();
				choice = CONSOLE.nextInt(); CONSOLE.nextLine();
				if(choice <MENU_EXIT || choice > SHOW_USERS)
					throw new MenuChoiceException(choice);

				switch(choice) {
					case SIGNUP: controller.signUp(); break;
					case SIGNIN: controller.signIn(); break;
					case LOGOFF: controller.logOff(); break;
					case ORDER: controller.order(); break;
					case VIEW_ORDER: controller.viewOrder(); break;
					case SHOW_USERS: controller.showUsers(); seatView(); break;
					case MENU_EXIT:
						controller.logOff();
						controller.storeToFile();
						System.out.println("���α׷��� �����մϴ�.");
						return;
				}
			} catch(MenuChoiceException e) {
				e.showWrongChoice();
				System.out.println("�޴������� �ٽ� �մϴ�.\n");
			}
		} while(choice != 0);
	}
	
	public static User signUpView() {
		System.out.println("=== ȸ�� ���� ===");
		System.out.print("ȸ�� �̸� : ");
		String username = CONSOLE.nextLine();
		System.out.print("ȸ�� ��ȭ : ");
		String phone = CONSOLE.nextLine();
		System.out.print("ȸ�� �̸��� : " );
		String email = CONSOLE.nextLine();
		System.out.print("ȸ�� �ּ� : ");
		String address = CONSOLE.nextLine();
		
		User user = new User(username, phone, email, address, OFF,
				new HashMap<String, Integer>(), null, -1);
		return user;
	}

	public static String signInView() {
		System.out.println("=== ȸ�� �α��� ===");
		System.out.print("�ڵ�����ȣ : ");
		String phone = CONSOLE.nextLine();

		return phone;
	}

	public static void showFoodMenu() {
		System.out.println("=== ���� �޴� ===");
		System.out.println("  1. �ܹ��� --- 2,000");
		System.out.println("  2. ġŲ --- 9,000");
		System.out.println("=== ���� �޴� ===");
		System.out.println("  3. �ݶ� --- 1,000");
		System.out.println("  4. ���� --- 500");
		System.out.println("  0. �ֹ� ����");
		System.out.print(" ��ȣ�Է�: ");
	}

	public static Map<String,Integer> orderView(){
		Map<String, Integer> orderList =new HashMap<String,Integer>();
		int total = 0;
		int choice = -1;
		int qty = 0;
		do {
			try {
				MainMenu.showFoodMenu();
				choice = CONSOLE.nextInt(); CONSOLE.nextLine();

				if(choice!=MENU_EXIT) {
					System.out.print("����: ");
					qty = CONSOLE.nextInt(); CONSOLE.nextLine();
					if(qty <0)
						throw new MenuChoiceException(qty);
				}
				switch(choice) {
					case MENU_BURGER:
						orderList.put(BURGER, qty);
						total += PRICE_BURGER * qty;
						break;
					case MENU_CHICKEN:
						orderList.put(CHICKEN, qty);
						total += PRICE_CHICKEN * qty;
						break;
					case MENU_COKE:
						orderList.put(COKE, qty);
						total += PRICE_COKE * qty;
						break;
					case MENU_MILK:
						orderList.put(MILK, qty);
						total += PRICE_MILK * qty;
						break;
					case MENU_EXIT:
						System.out.println("�ֹ��� �Ϸ��Ͽ����ϴ�.");
						return orderList;
					default:
						throw new MenuChoiceException(choice);
				}
			} catch(MenuChoiceException e) {
				e.showWrongChoice();
				System.out.println("�޴������� �ٽ��մϴ�.\n");
			}
		}while(choice!= 0);
		
		return new HashMap<String,Integer>();
	}
	
	public static void seatView() {
		System.out.println("���̺� ��Ȳ(X: ���¼�)");
		boolean[] reservations = controller.getReservations();
		
		for(int i=0;i<reservations.length; i++) {
			if(i==reservations.length/2)
				System.out.println();
			System.out.print((reservations[i]==true ? 'O':'X') + " ");
		}
		System.out.println();
	}

	public static int reserveSeatView() {
		MainMenu.seatView();
		boolean[] reservations = controller.getReservations();
		Set<Integer> seatNos = new HashSet<Integer>();
		
		for(int i=0;i<reservations.length; i++)
			if(reservations[i]==false) seatNos.add(i+1);

		char answer = '\u0000';
		int seatNo = -1;
		do {
			System.out.print("�Ļ��ϰ� ���ðڽ��ϱ�? (Y/N): ");
			answer = Character.toUpperCase(CONSOLE.nextLine().charAt(0));
			if(answer =='Y') {
				try {
					System.out.print("�¼� ��ȣ ���� (");
					Iterator<Integer> itr = seatNos.iterator();
					while(itr.hasNext())
						System.out.print(itr.next() + " ");
					System.out.print("�� ��1) : ");
					seatNo = CONSOLE.nextInt(); CONSOLE.nextLine();
					if(!seatNos.contains(seatNo) || seatNo <0 || seatNo >= reservations.length)
						throw new MenuChoiceException(seatNo);

					controller.getReservations()[seatNo-1] = true;

				} catch(MenuChoiceException e) {
					e.showWrongChoice();
					System.out.println(seatNo + "�� �ڸ��� ������ �� �����ϴ�.");
				}
			}
			else if(answer =='N') {
				System.out.println("���� ������ �����ϼ̽��ϴ�.");
			}
			else {
				System.out.println("Y/N���� �ٽ� �Է����ּ���.");
			}
		} while(answer!='Y' && answer!='N');

		return seatNo;
	}
	
	public int[] getFoodPrices() {
		return new int[] {PRICE_BURGER, PRICE_CHICKEN, PRICE_COKE, PRICE_MILK};
	}
}

package com.kh.food.view;

import java.util.Scanner;

public final class Constants {
	private Constants() {
		//restrict initialization
	}

	/* �ܼ� �Է� */
	public static final Scanner		CONSOLE		= new Scanner(System.in);


	/* Ȩ������ �޴���ȣ */
	public static final int			SIGNUP				= 1;
	public static final int			SIGNIN				= 2;
	public static final int			LOGOFF				= 3;
	public static final int			ORDER				= 4;
	public static final int			VIEW_ORDER			= 5;
	public static final int			SHOW_USERS			= 6;
	
	public static final int			MENU_EXIT			= 0;
	

	/* ���� �޴� ���� */
	//���� �޴���ȣ
	public static final int			MENU_BURGER			= 1;
	public static final int			MENU_CHICKEN		= 2;
	public static final int			MENU_COKE			= 3;
	public static final int			MENU_MILK			= 4;
	//���� �̸�
	public static final String		BURGER				= "BURGER";
	public static final String		CHICKEN				= "CHICKEN";
	public static final String		COKE				= "COKE";
	public static final String		MILK				= "MILK";
	//���� ����
	public static final int			PRICE_BURGER		= 2000;
	public static final int			PRICE_CHICKEN		= 9000;
	public static final int			PRICE_COKE			= 1000;
	public static final int			PRICE_MILK			= 500;


	/* User �α��� ���� */
	public static final boolean		OFF					= false;
	public static final boolean		ON					= true;
}

package month;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class Months {
	public int getDays(int months) {
		Map<Integer, Integer> map = new HashMap<Integer, Integer>();
		map.put(1, 31);

		Scanner sc = new Scanner(System.in);
		do {
			System.out.print("���� �Է��ϼ��� (1~12): ");
			int month = sc.nextInt();
			if(month <1 || month >12) {
				System.out.println("���� �ٽ� �Է����ּ���.");
				continue;
			}
			System.out.println("�Է¹��� ��: " + month + "��");
			System.out.println("������ ����: " + 31 + "��");
		} while(true);
	}
}

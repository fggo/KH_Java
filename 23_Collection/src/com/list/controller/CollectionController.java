package com.list.controller;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import com.list.model.vo.Employee;
import com.list.model.vo.Person;
import com.list.model.vo.Student;

public class CollectionController {
	public void listTest() {
		//ArrayList list�� ������ Ŭ���� ~ �迭�̶� �����!
		//new �����ڸ� ���� ��ü�� �����ؼ� ���!
		List list = new ArrayList(); //�迭 10�� ==Object[] list= new Object[10];
		list.add("ȫ�浿");
		System.out.println(list.size());
		
		list.add(1); //auto-boxing : int->Integer

		boolean isString = (list.get(0) instanceof String);
		boolean isInt = (list.get(1) instanceof Integer);
		System.out.println(isString);
		System.out.println(isInt);
		
		list.add(180.5);
		list.add(new Person());
		list.add(new Student());

		System.out.println(list);
		
		//�߰��� ���� list.add(index, Object);
		list.add(2, "�ٹ�");
		
		System.out.println(list);
		//list.get(index)�� Object�� ��ȯ
		//list�� ��������� (Ŭ����)�� ���Ե� ���, �� ��ü�� �ڷ����� Object�� ����ȯ
		//����ȯ �Ǿ� ��.(������). ������ü�� �����Ϸ��� �� ��ü�� ����ȯ�Ͽ� �����ؾ���
		((Person)list.get(4)).getName();

//		List<Person> perList = new ArrayList<Person>();
//		polymorphism can be used!!!
		
		list.remove(2); //�ε��� ��ȣ�� ������ 1�� �����
		printList(list);
		
		System.out.println(list.isEmpty()); // list�� �ڷᰡ �ִ��� Ȯ��
		if(list.size() > 0)
			System.out.println("list.isEmpty()�� false�� return");
//		list.clear();
		System.out.println(list.isEmpty());

		
		//ArrayList�� ��Ӱ��踦 ���� �θ�: List���ͤ����̽�
		List list2 = new ArrayList();
		list2.add(new Employee());
//		Collection list3 = new ArrayList();
		List list3 = new ArrayList();
		
		List list4;
		LinkedList linkedList = new LinkedList();
		list2= linkedList;
		list.add("���¿�");
		
		//list�ش� ��ü�� �ִ��� Ȯ���ϴ� �żҵ�
		//contains()�̿�
		System.out.println("��"+ list.contains("���¿�"));
		System.out.println("��"+ list.contains("������"));

		list.add(new Person("������",19,"��⵵ �����"));
		//����� ���� ��ü�� ã�ƺ���!
		Person com=new Person("������",19,"��⵵ �����");
		//equals �������̵��� ���������.
		System.out.println("��"+ list.contains(com));
		
		//sort ����
		list3.add("������");
		list3.add("�ڱ��");
		list3.add("������");
		list3.add("���ȣ");
		list3.add("������");
		System.out.println(list3);
		//�������� ����
		Collections.sort(list3);
		System.out.println(list3);
		//�������� ���� (using java8 lambda)
		Collections.sort(list3, (i,j)->((String)j).compareTo((String)i));
		System.out.println(list3);

		//�ߺ��� add ����
		list3.add("������");
		list3.add("������");
		list3.add("������");
		list3.add("������");
		Student s = new Student("aa", 1, "aa", 1, 1, "aa");
		list3.add(s);
		list3.add(s);
		System.out.println(list3);
		printList(list3);
	}
	
	public void setTest() {
		Set set = new HashSet();
		set.add("���¿�");
		set.add("����ö");
		set.add("������");
		set.add("������");
		set.add("������");
		set.add("������");
		set.add("������");
		set.add("������");
		set.add("������");
		set.add(new Student());
		//Employee�� equals() override �������Ƿ�, �ٸ������� ��� ��.
		set.add(new Employee("������", 28, "��õ", 10, "���ߺ�", "��������"));
		set.add(new Employee("������", 28, "��õ", 10, "���ߺ�", "��������"));
		set.add(new Employee("������", 28, "��õ", 10, "���ߺ�", "��������"));
		set.add(new Employee("������", 28, "��õ", 10, "���ߺ�", "��������"));
		set.add(new Employee("������", 28, "��õ", 10, "���ߺ�", "��������"));

		
		//equals() override �ߴµ���, �ٸ� ��ü��� �ν���
		//hashCode()�� override �ؾ���!! (�ּҰ�)
		//hashCode(){reurn Object.hashCode(name, age,address)
		//3���� �ϳ��� �ٸ��� �ٸ� �ּҰ� ��ȯ

		set.add(new Person("�����", 26, "����"));
		set.add(new Person("�����", 26, "����"));
		set.add(new Person("�����", 26, "����"));
		set.add(new Person("�����", 26, "����"));
		set.add(new Person("�����", 26, "����"));

//		Set<String> set2 = new HashSet<String> ();
		
		//����� ���� Iterator �ڵ� �ݺ��˻��⸦ ���!
		Iterator itr = set.iterator();
		
		String name = "";
		while(itr.hasNext()) {
//			String s = (String)itr.next();
			//Object ->String
			System.out.println(itr.next());
//			System.out.println(itr.next() instanceof String);
		}
		
		
		/* HashSet�� �̿��� List������ �ߺ��� ���� */
		List list = new ArrayList();
		list.add("������");
		list.add("������");
		list.add("������");
		list.add("������");
		list.add("������");
		list.add("������");
		list.add("������");
		list.add("������");
		list.add("������");
		list.add("������");
		list.add("������");
		list.add("���ؿ�");
		list.add("���ؿ�");
		list.add("���ؿ�");
		System.out.println("�ߺ� ���� ��: ");
		System.out.println(list);
		set = new HashSet(list);
		list = new ArrayList(set);
		System.out.println("�ߺ� ���� ��: ");
		System.out.println(list);

		System.out.println(set.contains("���ؿ�"));
		System.out.println(set.contains("������"));
		
		set.remove("���ؿ�");
		System.out.println(set.contains("���ؿ�"));
		System.out.println(set);
	}

	public void mapTest() {
		Map map = new HashMap();
		//map.put(key,value);
		//key, value�� �ڷ����� Object�� �Ǿ� �־�, ��� ��ü ���� ����
		map.put(1, new Student());
		map.put(2, "������");
		map.put("1", 180.5);
		map.put(1, new Person("������", 19, "��⵵"));
		/* key���� ��� String OR Integer������ �ۼ� 
		 * �Ѱ��� ������ Ű���� �ڷ����� ��ġ
		 * */
		//����ϴ� ���
		//get�̿��ϴ¹�� get(key��)
//		System.out.println(map.get(1));
//		System.out.println(map.get("1"));
//		System.out.println(map.get("����"));
		//get���� ����� �� �ִ°�?? ���� key�� ��  �˰� ������
		//map ���� key���� ��� entrySet()�żҵ�
		//entrySet() ��ȯ�� Set���� ��ȯ����.
		Set set=map.entrySet();
		Iterator it=set.iterator();
		while(it.hasNext()) {
			Object obj=it.next();
			System.out.println(obj+""+ map.get(obj));
		}
		//iterator�� �ѹ� ����ϸ� ������ �Ұ�����.
		//System.out.println(it.next());
		//map�� key���� �ߺ����� �ʽ��ϴ�.
		map.put("1",new Employee("������",19,"��⵵ �����",1000,"�ڹ��к�","����"));
		System.out.println("===========entrySet============");
		//key, value���� �ѹ��� �����ִ°�
		set=map.entrySet();
		it=set.iterator();
		while(it.hasNext()) {
			Map.Entry obj=(Map.Entry)it.next();
			System.out.println(obj.getKey()+" : "+obj.getValue());
		}
		System.out.println("===========keySet============");
		//key���� �ް� ó�� �ϴ°�
		set=map.keySet();
		it=set.iterator();
		while(it.hasNext()) {
			Object obj=it.next();
			System.out.println(obj+""+ map.get(obj));
		}
	}
	
	
//	Map (key,value) = (String String)
	public void propertiesTest() {
		//�����ϰ� �����Ͽ� ���Ͽ� �ִ� ���ڰ��� �ҷ����� ��ü.
		//test.properties
		Properties prop = new Properties();
		try {
			prop.load(new FileReader("test.properties"));
			System.out.println(prop.get("user"));
			System.out.println(prop.get("pw"));
			prop.setProperty("version", "10");
			prop.store(new FileWriter("test.properties"), "COMMENT");
		} catch(IOException e) {
			e.printStackTrace();
		}
	}

	public void printList(List list) {
		//���ε������� ��� get(�ε���)�޼ҵ� ���
//		for(int i =0; i<list.size(); i++)
//			System.out.println(list.get(i));

		//list ����Ҷ��� for-each ���� ���� �����.
		for(Object obj : list) {
			if(obj instanceof Person) {
				System.out.println((Person)obj);
			}
			else if(obj instanceof Student) {
				System.out.println((Student)obj);
			}
			else {
				System.out.println(obj);
			}
		}
	}
}

package practice;

import java.util.HashSet;
import java.util.Iterator;
import java.util.Objects;
import java.util.Set;

public class Employee {
	private String name;
	private int age;
	private String job;
	private int salary;
	
	public Employee() {
		// TODO Auto-generated constructor stub
	}
	
	public Employee(String name, int age, String job, int salary) {
		super();
		this.name = name;
		this.age = age;
		this.job = job;
		this.salary = salary;
	}
	
	@Override
	public String toString() {
		return name + " " + age + " " + job + " " + salary;
	}
	
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof Employee) {
			Employee e = (Employee)obj;
			if(this.name.equals(e.getName())
					&& this.age==e.getAge()
					&& this.job.equals(e.getJob())
					&& this.salary == e.getSalary())
					return true;
			else
				return false;
		}
		return false;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(name,age,job,salary);
	}

	public String getName() { return name; }
	public void setName(String name) { this.name = name; }
	public int getAge() { return age; }
	public void setAge(int age) { this.age = age; }
	public String getJob() { return job; }
	public void setJob(String job) { this.job = job; }
	public int getSalary() { return salary; }
	public void setSalary(int salary) { this.salary = salary; }
	
//	ȫ�浿 29 �븮 300
//	�̼��� 30 ���� 500
//	������ 18 ���� 1000
//	���� 85 �� 10
//	�뼮 26 ���� 1

//	1. arrayList�� �̿��� ������� �����غ���
//	   ���� �����͸� �ְ� ����غ���
//	2. set�� �̿��Ͽ� ��������� �غ���
//	   ���� �����͸� �ְ� ����غ���
//	   ��� �� ������ 18 ���� 1000�� �ٽ� �ְ� ����غ���(�ȵ��߰���?)
//	3. HashMap�� �̿��Ͽ� �����͸� �ְ� ����غ���

	public static void main(String[] args) {
//		List<Employee> list = new ArrayList<Employee>();
		Set<Employee> set = new HashSet<Employee>();
		set.add(new Employee("ȫ�浿", 29, "�븮", 300));
		set.add(new Employee("�̼���", 30, "����", 500));
		set.add(new Employee("������", 18, "����", 1000));
		set.add(new Employee("����", 85, "��", 10));
		set.add(new Employee("�뼮", 26, "����", 1));
		

		Iterator<Employee> itr = set.iterator();
		while(itr.hasNext())
			System.out.println(itr.next());
		System.out.println();

		set.add(new Employee("������", 18, "����", 1000));

		itr = set.iterator();
		while(itr.hasNext())
			System.out.println(itr.next());
	}
}

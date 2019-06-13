--NUMBER(p ��ü�ڸ� ��, s ��ü�ڸ��� �� �Ҽ��� ��);

CREATE TABLE NUMBERTEST(
    A NUMBER(7,3),
    B NUMBER(7),
    C NUMBER,
    D NUMBER(7,1),
    E NUMBER(5,-1)
);

SELECT * FROM NUMBERTEST;

INSERT INTO NUMBERTEST
    VALUES(1234.567, 1234.567, 1234.567, 1234.567, 1234.567);

--char �������� �ִ� 2000byte
--nchar �����ڵ� �������� (������ ó��) �ִ� ���ڼ� 1000��
--varchar2 �������� �ִ� 4000byte
--nvarchar2 �����ڵ� �������� �ִ� ���ڼ� 2000������
--���� �ڷ��� (����)
--char(10) 10 byte ��ŭ ������ �Ǵ� ����. ������ 10byte �� ���
--	���� ������ whitespace�� ä����
--varchar2(10) 10 byte��ŭ ������ �Ǵ� ����, ���ԵǴ� ����
--	ũ�⿡ ���� ��� ������ ������
--	����Ŭ express�������� �ѱ��� 3byte�� ó����
--	�ѱ� 4���� �̻� ERROR
--nchar(10) nvarchar(10) ���ڼ� ���� 10���� ��ŭ ����Ǵ�
--	���� Ȯ��

create table chartest(
	a char(6),
	b varchar2(6),
	c nchar(6),
	d nvarchar2(6)
);

insert into chartest values('abc','abc','abcdef','abcdef');

insert into chartest values('abcefg','abcefg','abcdef','abcdef');

--ERROR
insert into chartest values('abcefg123','abcefg123','abcdef','abcdef');

insert into chartest values('�ٹ�', '�ٹ�', '�ٹٹ�', '�ٹٹ�');

insert into chartest values('�ٹ�', '�ٹ�', '�ٹٹ�õ��', '�ٹٹ�õ��');

DELETE FROM CHARTEST;

select * from chartest;

--�޸� �������� �����ϰ� �ִ� ���� Ʈ������ ����!
--commit �ϱ� ���� sqlplus kh/kh�� select�ϸ� �ݿ� �ȵǾ� ����
--develop ������ �ȿ��� ������ �����ϰ� select �ϸ� ������ ��������
--sqlplus�δ� database(������ �������)���� ��ȸ�ϴ�, ������ �ȳ���
--commit���� ������ ��������� ��������� sqlplus��ȸ ����

commit;

--length
select a, length(a) length_A_char, lengthb(a) lengthb_A_char,
	b, length(b) length_B_varchar2, lengthb(b) lengthb_B_varchar2,
	c, length(c) length_C_nchar, lengthb(c) lengthb_C_nchar,
	d, length(d) length_D_nvarchar2, lengthb(d) lengthb_D_nvarchar2
from chartest;

--��¥�ڷ���
--���糯¥�� ǥ�����ִ� system �÷�: sysdate
--dual: ����Ŭ���� �����ϴ� template ���̺�(�׽�Ʈ��)
select sysdate from dual;

select length('ū���'), lengthb('ū���') from dual;

select * from dual;

--��¥�� ��� ����
select sysdate-1 ����, sysdate ����, sysdate+1 ���� from dual;

select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') "NOW" from dual;

--��¥�� ��¥������ ��� ����
--�ϼ�(int) ������ ���
select sysdate - to_date('19990224', 'yyyymmdd') from dual;

--�ð����� ���
select systimestamp from dual;

select to_date('19990224', 'yyyy-mm-dd') from dual;

create table datetest(
	today date,
	birthday date,
	temp timestamp);

insert into datetest 
values('19/06/13', '00/02/24', '19/06/13 11:15:00');

insert into datetest
values(to_date('20190613'), to_date('19990224'),
	to_timestamp('20190613111500'));
    
select * from datetest;

--���̺� �÷��� �ڷ����� Ȯ���ϰ� ������
desc chartest;

desc datetest;

create table member_table (
	id CHAR(15), --����x 6-15�ڸ�
	password VARCHAR2(15), --8-15�ڸ�
	name VARCHAR2(15), --�ѱ��Է�
	phone NUMBER(11), --�ڵ��� -����
	ssn NUMBER(13), --�ֹι�ȣ
	mileage NUMBER, --���ϸ���
	reg_date DATE);

select * from member_table;

desc member_table;

-- ���̺� �ִ� ������ ��ȸ�ϱ�
-- ��ɾ� select
-- ��ɱ��� select �÷�1,...,�÷�n from ���̺�� where �˻�����

select * from kh.employee;

select dept_id, dept_title from department;

select emp_name, email, phone, ent_date from employee;

--select �������� ��� ���굵 ����
--������ �ϱ� ���ؼ��� ������� �÷����� ���� ������
--������ ���ָ� �� ���� ���� �÷����� �ǰ�, ���� ����
--�� row�� ����.

--ERROR
select emp_name, salary, email*12 from employee;

--select bonus %12 from employee;
--%�����ڴ� �⺻ ��������ڷ� ��ϵǾ� ���� ����
--mod��� �Լ� �̿�

--nvl�Լ��� �÷������Ͱ� null�϶�,
--�� ���� ��ü���� ���� ����
--nvl(�÷���, null ��ü��)
select emp_name �̸�,
	salary*12 AS "1�� �޿�(����)",
	12*salary*(1+ nvl(bonus,0)) AS �Ѽ��ɾ�,
	12*salary*((1-.03) + nvl(bonus,0)) �Ǽ��ɾ�,
	'��' AS ��ȭ
from employee;

select emp_name, sysdate-hire_date from employee;

--DISTINCT �ߺ��� ���� ������ �ѹ��� ���
select emp_name, dept_code from employee;

select distinct dept_code from employee;

--(dept_code, job_code)�� �Ѱ� �����ͷ� distinct�� ���� select
select distinct dept_code, job_code from employee;

--�� ������ : where������
--where�� ����ϱ� : resultSet�� �ʿ��� row�鸸 ���͸�
--select �÷�1,...,�÷�n from ���̺�� where �÷��� �񱳿����� ��;
select * from employee where job_code = 'J5';

select * from tab where tname='EMPLOYEE';

select emp_name, salary, hire_date, phone from employee
where sal_level='S1';

select emp_name, salary,
	12*salary*(1+nvl(bonus, 0)-.03) AS �Ǽ��ɾ�
from employee
where 12*salary*(1-.03 + nvl(bonus,0)) > 50000000;

--�������� ����ϱ�
--AND/OR
select * from employee
where dept_code != 'D6' AND salary >= 3000000;

select emp_name, hire_date, salary from employee
where job_code='J3' OR sal_level='S5';

--�񱳿����ڸ� ������
select * from employee
where dept_code='D5'
	AND hire_date >'02/01/01';

select distinct sal_level from employee
--where job_code != 'J1'
where job_code ^= 'J1'
group by sal_level
order by sal_level;

select emp_name, salary
from employee
where salary between 3500000 and 6000000;
--where salary >=3500000 and salary <= 6000000;

select emp_no || emp_name || email from employee;

select emp_name ||'�� �ȳ��ϼ��� ����� '|| salary || '�� ��ŭ �޳���?' from employee;

select emp_name, hire_date, dept_code, salary from employee
where hire_date between '90/01/01' and '01/01/01';
--where hire_date >= '90/01/01' and hire_date <='01/01/01';

--���������ڸ� �̿��ϰ� ���� ���� ���� ����� �� ����
select emp_name, dept_code, hire_date from employee
where salary not between 3500000 and 6000000;

--LIKE ���� �����̿��Ͽ� �˻�
select * from employee where emp_name like '%��';

-- ����ٴ� �ڸ��� ǥ��
select * from employee where emp_name like '__��';

-- email ����° �ڸ��� 'n'�� ���
select * from employee where email like '__n%';

select * from employee where emp_name like '__��';

select * from employee where emp_name like '_��_';
    
select * from employee where emp_name like '%��%';

select * from employee
where email like '___#_%' ESCAPE '#';

select * from employee
where email like '____^_%' ESCAPE '^' 
	and dept_code in ('D6', 'D9')
	and hire_date between '90/01/01' and '00/12/01'
	and salary >= 2700000;

create table tbl_escape_watch(
	watchname	varchar2(40),
	description 	varchar2(200)
);

insert into tbl_escape_watch
values('�ݽð�', '���� 99.99% ���� ��޽ð�');

insert into tbl_escape_watch
values('���ð�', '�������� 99.99���� ȹ���� ��޽ð�');

--description�� '99.99%' ��� ���� �� �ִ� �ุ ����?
select * from tbl_escape_watch
where description like '%99.99^%%' ESCAPE '^';

select emp_name, phone from employee
where phone not like '010%';

select * from employee
where email like '%_____^_%' ESCAPE '^'
and dept_code in ('D6', 'D9')


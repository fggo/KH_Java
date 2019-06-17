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
--
--char(10) 10 byte ��ŭ ������ �Ǵ� ����. ������ 10byte �� ���
--	���� ������ whitespace�� ä����
--varchar2(10) 10 byte��ŭ ������ �Ǵ� ����, ���ԵǴ� ����
--	ũ�⿡ ���� ��� ������ ������
--	����Ŭ express�������� �ѱ��� 3byte�� ó��; �ѱ� 4�����̻� ERROR
--nchar(10) nvarchar(10) ���ڼ� ���� 10���� ��ŭ ����Ǵ� ���� Ȯ��

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

insert into datetest values('19/06/13', '00/02/24', '19/06/13 11:15:00');

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
    watchname   varchar2(40),
    description varchar2(200)
);

insert into tbl_escape_watch values('�ݽð�', '���� 99.99% ���� ��޽ð�');
insert into tbl_escape_watch values(
	'���ð�', '�������� 99.99���� ȹ���� ��޽ð�');

--description�� '99.99%' ��� ���� �� �ִ� �ุ ����?
select * from tbl_escape_watch
where description like '%99.99^%%' ESCAPE '^';

select emp_name, phone from employee
where phone not like '010%';

select * from employee
where email like '%_____^_%' ESCAPE '^'
and dept_code in ('D6', 'D9');


--is null / is not null : null���� ã���� ���
-- ���: �÷��� is null or �÷��� is not null
select * from employee where bonus is null;

select salary + bonus AS totalPay from employee
where bonus is not null;

select emp_name, salary, dept_code from employee
where dept_code is null;

select * from employee where nvl(bonus, 0)=0;


--subquery ������, �÷��� �Ѱ� �̻��϶�, 'IN' ���
--�������� or�� �����Ͽ� ������ϴ� ��!
-- ���: �÷��� in (�񱳰�1,...,�񱳰�n);

select * from employee
where job_code in ('J3', 'J2');
-- job_code ='J3' or job_code='J2';

select emp_name, job_code from employee
where job_code in
    (select job_code from employee
        where salary > 3000000);

select emp_name, dept_code, salary, sal_level from employee
where emp_name in ('������', '�����', '���¸�');

--AND�� OR���� �켱�� ��!

select * from employee
where dept_code='D9' or dept_code='D6'
    and hire_date between'99/01/01'and '00/12/01';

select * from employee
--where job_code='J7' or job_code='J2' and salary > 2000000;
--where (job_code='J7' or job_code='J2') and salary > 2000000;
where salary > 2000000 and job_code='J7' or job_code='J2';

--order by �� �̿��� ������ ����
--order by�� �������� �ۼ�
--order by �÷��� ASC(����Ʈ) DESC;
--�⺻������ primary key�� ����
--order by �÷�1, �÷�2;
select * from employee order by emp_name desc;

--null�� order by ASC ������ null�� �ǵڷ�
select emp_name, salary, bonus from employee
order by bonus DESC;

-- null�� ��������� �����ϰ� ������, nulls �ɼ� ���
select emp_name, salary, bonus from employee
order by bonus ASC nulls first;

select emp_name, salary, bonus from employee
order by bonus nulls last;

select emp_name, dept_code, job_code from employee
order by emp_name, dept_code desc;

--�÷����� �ƴ� index ��ȣ�� ���� ����
select emp_name, salary, bonus from employee
order by 2;
--order by salary;
--2��° select�÷� salary �������� ����

--�Լ� function
select emp_name, 
    length(emp_name), 
    lengthb(emp_name),
    email, 
    length(email),
    lengthb(email)
from employee;

desc employee;

select length('�ٹٹ�') from dual;
select lengthb('�ٹٹ�') from dual;

--INSTR(����, ã�¹���, +/-�����ĭ, ���°��������)
--�Ű� ������ ���� ���ڿ��� Ư�������� ��ġ�� ã����
select INSTR('�ٹٹ�', '��') from dual;

select INSTR('monkkky', 'k') from dual;

select INSTR('monkkkaaakay', 'k', -4, 2) from dual;

select INSTR('monkkkaaakay', 'a', -4, 2) from dual;

select INSTR('monkkkaaakay', 'a', 1, 1) from dual;

select email, INSTR(email, '_') from employee;

select email, substr(email, instr(email, '@'))
from employee;

select rpad('monkey', 10, '^') from dual;

select rpad('�ٹ�', 10, '^') from dual;

select rpad(emp_name, 8, '��') from employee;

--LTRIM/RTRIM ���ڿ��� ���� �Ǵ� �������� ������ ���ڸ� ����
--false ���ǵǴ� ���� TRIM �ߴ�
select LTRIM('     TRIM') from dual;

select 'kkkkktrim', LTRIM('kkkkktrim', 'k') from dual;

select LTRIM('hhhkhkhkhkhakhzzzz', 'kh') from dual;

select RTRIM('kkkkahhhhtrim', 'kh') from dual;

select substr('1523213213213������',
    instr('1523213213213������', '��')) from dual;

select LTRIM('321389219328913������', '0123456789') from dual;

select RTRIM(LTRIM('32132132132������321321321321',
    '0123456789'), '0123456789') from dual;

select SUBSTR('321312321������321321312',
    INSTR('321312321������321321312', '��'),3)
from dual;

select '    kh    ', TRIM('     kh    ') from dual;

--ERROR only one character
select 'zzzzzzkhzzzz', 
    TRIM(leading 'za' from 'zzzzzkhzzzz') from dual;
select 'zzzzzzkhzzzz', 
    TRIM(leading 'z' from 'zzzzzkhzzzz') from dual;
select 'zzzzzzkhzzzz', 
    TRIM(trailing 'z' from 'zzzzzkhzzzz') from dual;
select 'zzzzzzkhzzzz', 
    TRIM(both 'z' from 'zzzzzkhzzzz') from dual;

--substr Ư�� ���ڿ��� �߶�
select substr('abcdefg', 3,2) from dual;

select substr('showmethemoney', '5', '2') from dual;

select substr('showmethemoney', 5) from dual;

select substr('showmethemoney', -8, 3) from dual;

select substr('�����ٶ� �ٻ������ īŸ', 7, 5) from dual;

select distinct substr(emp_name,1,1) AS name from employee
--order by substr(emp_name,1,1);
--order by 1;
--order by emp_name --ERROR
--order by�� select���� �ִ� �÷���
order by name;


--������ �빮�� �ҹ��� camel case
--UPPER LOWER INITCAP
select upper('hello world'), lower('HELLO WORLD'), INITCAP('hello world')
from dual;

select INITCAP('show me the money') from dual;

--CONCAT ���ڿ��� �����ϴ� �Լ�
select CONCAT(emp_name, hire_date) from employee;
select emp_name || email from employee;

--REPLACE Ư�� ���ڸ� ����
select REPLACE('monkey', 'o', '@') from dual;

select REPLACE(email, substr(email, instr(email,'@')), '@naver.com')
from employee;

select * from employee
where substr(emp_no,8,1) = 1;

--���� ó���Լ� ABS MOD ROUND TRUNC FLOOR CEIL
select ABS(-3.1415) from dual;

select MOD(10, 3) from dual;

select ROUND(33.1415, -1) from dual;
select ROUND(33.1415, 1) from dual;
select ROUND(33.1415, 2) from dual;
select ROUND(33.1415, 3) from dual;
select ROUND(33.1415, 4) from dual;

select round(nvl(bonus,0), 2) from employee;

select round(sysdate-hire_date) from employee;

--FLOOR �Ҽ����� ���� ����
select FLOOR(33.1415) from dual;

select FLOOR(bonus) from employee;

--TRUNC Ư�� ��ġ���� �Ҽ����� ����
select TRUNC(33.1415, -1) from dual;
select TRUNC(33.1415, 1) from dual;
select TRUNC(33.1415, 2) from dual;
select TRUNC(33.1415, 3) from dual;
select TRUNC(33.1415, 4) from dual;

--CEIL �Ҽ��� ���� �ø�
select CEIL(nvl(bonus,0)) from employee;

create table tbl_files(
    fileno number(3), filepath varchar2(500));

insert into tbl_files values(1, 'c:\abc\deft\salesinfo.xls');
insert into tbl_files values(2, 'c:\music.mp3');
insert into tbl_files values(3, 'c:\documents\resume.hwp');

select * from tbl_files;

--���ϸ� ���
--select substr(filepath, instr(filepath, '\', -1) + 1)
--from tbl_files;


--��¥ ó�� �Լ�
select sysdate from dual;

select FLOOR(months_between(sysdate, to_date('20000224', 'yyyymmdd'))) ||''
from dual;

select ROUND(months_between(sysdate, hire_date), 0) months from employee;

select add_months(to_date('20000224', 'yyyy/mm/dd'), 3) from dual;

--���úη� ���� �Դ�, 1��6���� ������ �Ⱓ ����.
--1.������,2.����«���--�Ϸ翡 ����
select sysdate AS �Դ���,
    add_months(sysdate, 18) AS ������,
    add_months(sysdate,18) - sysdate AS ����Ȱ�ϼ�, 
    3*(add_months(sysdate,18) - sysdate) AS «���
from dual;

--next_day : ������ ��¥�� ������ ������ ��¥�� ������
--��:1 ��:2 ȭ:3 ��:4 ��:5 ��:6 ��:7
select next_day(sysdate, '������') from dual;
select next_day(sysdate, '��') from dual;
select next_day(sysdate, 2) from dual;

--�����Ͽ� ���� �����ϴ� �� �ٸ��� �ؾ�. �ѱ� ���� MON ��� �Ұ�
select next_day(sysdate, 'MON') from dual;
select next_day(sysdate, 'MONDAY') from dual;

select * from V$NLS_PARAMETERS;

alter session set NLS_LANGUAGE=AMERICAN;

alter session set NLS_LANGUAGE=KOREAN;

--LAST_DAY ���޹��� ��¥�� ���� ���� ������ ���� ǥ��

select LAST_DAY(sysdate) from dual;

select LAST_DAY('00/02/24') from dual;

--���� �� ��������
select LAST_DAY(ADD_MONTHS(sysdate, 3)) from dual;

--EXTRACT ��¥�� �� �� ���� ���� �����Ͽ� ����
select EXTRACT(year from sysdate) AS ��,
    EXTRACT(month from sysdate) AS ��,
    EXTRACT(day from sysdate) AS ��,
    EXTRACT(hour from CAST(sysdate as timestamp)) AS ��,
    EXTRACT(minute from CAST(sysdate as timestamp)) AS ��,
    EXTRACT(second from CAST(sysdate as timestamp)) AS ��
from dual;


--TO_CHAR ���ڿ��� �������ִ� �Լ�
--����� ���� ��ȣ
-- yyyy, yy (���� 4�ڸ�, 2�ڸ�)
-- month: locale ������ �°� ���
-- mm: ���� ���ڷ� ǥ��
-- mon: ���� ���ĺ����� ǥ��
-- dd: ��¥�� ǥ��
-- d: ���� ���ڷ� ǥ��
-- dy: ������ ���� ǥ��: ��ȭ���������
-- day: ���� (��: ������)
-- hh: �ð�, hh24: 24�ð�, hh12: 12�ð�
-- mi: ��
-- si: ��
select TO_CHAR(
sysdate, 'yyyy-mm-dd day hh24:mi:ss') from dual;

select TO_CHAR(
sysdate-1, 'yyyy-mm-dd dy hh24:mi:ss') from dual;

select TO_CHAR(
sysdate+1, 'yyyy-mm-dd dy hh24:mi:ss') from dual;

select emp_name,hire_date,
TO_CHAR(hire_date, 'yyyy/mm/dd hh24:mi:ss') from employee;

select emp_name, TO_CHAR(hire_date, 'yyyy-mm-dd(dy)') from employee;


--���ڿ��� ����� ��������
--, comma �������� ��ȯ(3°�ڸ��� , ���̱�) : 1,900,000
--. period �Ҽ��� �������� ��ȯ: 3.1415
--9 �ش��ڸ��� �����ǹ�: ���� ������� �Ҽ��� �̻��� ����, 
--      �Ҽ������ϴ� 0
--0 �ش��ڸ��� �����ǹ�: ���� ������� 0���� ������ ǥ��,
--      ���ڸ� ���������� ǥ���� ���
--$ ��ȭ ǥ��(��) : �޷�$ ǥ��
--L ������ȭ�� ǥ�� (��: ��ȭǥ��)
select TO_CHAR(123456, '999,999,999') from dual; --123,456

select TO_CHAR(123456, '000,000,000') from dual; --000,123,456

select TO_CHAR(123456, '99,999') from dual; --#######

select TO_CHAR(34.56, '$99.99') from dual;

select TO_CHAR(34.56, 'L99.99') from dual;

select TO_CHAR(1234.56, '99999.9999') from dual;

select TO_CHAR(1234.56, '00000.0000') from dual;

--1.salary�� ��ȭǥ�÷� ��ǥ �ٲ㼭
--2.������ ����Ͽ� ��ȭǥ�÷�
select emp_name, TO_CHAR(salary, 'L999,999,999') AS ����,
    TO_CHAR(12*salary, 'L999,999,999,999') AS ����
from employee;

--TO_DATE: ��¥�������� ��ȯ
-- �ۼ���: TO_DATE(char, format): ���ڸ� ��¥�� ����
--      TO_DATE(number, format): ���ڸ� ��¥�� ����
--  �ð����� ��¥�� ���氡��
select TO_CHAR(
TO_DATE('19500101 15:30:20', 'yyyymmdd hh24:mi:ss'),
'yyyymmdd hh24:mi:ss')
    AS ���� from dual;

select TO_CHAR(hire_date, 'yyyymmdd hh24:mi:ss')
from employee
where hire_date > '00/01/01';
--where hire_date > TO_DATE('20000101', 'yyyymmdd');

--���� ��¥�� ��ȯ
select TO_DATE(19960626, 'yyyy-mm-dd') from dual;

--ERROR! ����! �տ� 0�� ���� ������ ������ �ȵ�
select TO_DATE(010224, 'yy-mm-dd') from dual;
--OK!
select TO_DATE('010224', 'yy-mm-dd') from dual;


--DECODE ���ǹ� (switch���� ���)
-- ����: decode(���ǽ�,
--                  ����1, ����1���,
--                  ...
--                  ����n, ����n���,
--                  default)
select emp_name, emp_no,
    DECODE( substr(emp_no,8, 1),
        '1', '��', '2', '��',
        '3', '��', '4', '��') AS ����
from employee;

--dept_code: D1�̸�
select emp_name AS �����,
    nvl(dept_code,'NULL') AS �μ��ڵ�,
    DECODE(dept_code,
        'D1', '�λ����',
        'D2', 'ȸ�����',
        'D3', '������',
        'D4', '��������',
        'D5', '�ؿܿ���1',
        'D6', '�ؿܿ���2',
        'D8', '�������',
        'D9', '�ѹ�',
        '�μ�����') AS �μ���
from employee;

select emp_name AS �����,
    nvl(dept_code, 'NULL') AS �μ��ڵ�,
    CASE WHEN dept_code='D1' THEN '�λ����'
        WHEN dept_code='D2' THEN 'ȸ�����'
        WHEN dept_code='D3' THEN '������'
        WHEN dept_code='D4' THEN '��������'
        WHEN dept_code='D5' THEN '�ؿܿ���1'
        WHEN dept_code='D6' THEN '�ؿܿ���2'
        WHEN dept_code='D8' THEN '�������'
        WHEN dept_code='D9' THEN '�ѹ�'
    ELSE '�μ�����' END AS �μ���
from employee;

select emp_name AS �����, emp_no AS �ֹε�Ϲ�ȣ,
    CASE
        WHEN substr(emp_no, 8,1)=1 THEN '��'
        ELSE '��' END AS ����
from employee;

insert into employee values(
    '250', '��ι�', '470808-2123341', 'go@kh.or.kr', 
    null, 'D2', 'J2', 'S5', 448000, null, null, 
    TO_DATE('94/01/20', 'rr/mm/dd'), null, 'N');

commit;

select emp_id AS �����ȣ, 
    emp_name AS �����,
    RPAD(substr(emp_no, 1,8), 13, '*') AS �ֹι�ȣ,
    CASE WHEN substr(emp_no, 8,1)='1' THEN '��'
        WHEN substr(emp_no, 8,1)='2' THEN '��'
        WHEN substr(emp_no, 8,1)='3' THEN '��'
        WHEN substr(emp_no, 8,1)='4' THEN '��'
    ELSE '?' END AS ����,
    EXTRACT(year from sysdate) -
    EXTRACT(year from TO_DATE(substr(emp_no, 1,2), 'RR')) + 1 AS ����,
    TO_NUMBER(extract(year from sysdate))- 
    TO_NUMBER(substr(emp_no,1,2) + 
    CASE WHEN substr(emp_no,8,1) in(1,2) THEN 1900
        ELSE 2000 END) + 1 AS ���糪��
-- yy�� 20�� ����(���� ����).  rr�� ��ȯ
-- rr�� 1950 ������ �¾ ����� ������ 
--      ex) ��ι� 2019 - (1947->2047) + 1 = -27
--      rr�� 50���� ������ '20xx' 50���� ũ�� '19xx'
-- ��¥�� ������ yy �α��ڸ� �����ö�,
--      YY: ���� ����� ��� (99 -> 2099)
--      RR: 
--    TO_CHAR(sysdate, 'yyyy')- CONCAT(19,substr(emp_no,1,2)) +1 AS ����
from employee
order by ���糪�� DESC;

--RR ��ȯ ����
--���翬��   �Է¿���  ��꿬��
--  00~49      00~49   ���缼��
--  00~49      50~99   ���缼��
--  50~99      00~49   ���缼��
--  50~99      50~99   ���缼��

select TO_DATE('880101', 'RR') from dual;

--�׷��Լ�
--COUNT, MAX, SUM, AVG,
--result ���� �Ѱ��� row�� �Ǿ� �ֱ� ������,
--  �÷��� ������ �� ����.
select emp_name, sum(salary) from employee
--where substr(emp_no, 8,1) in (1,3);
where emp_name like '��__'
group by emp_name;

select sum(salary*12) AS ����,
    sum(12*salary*(1-.03 +nvl(bonus,0))) AS �Ǽ��ɾ�
from employee;

--null ���� sum���� �ڵ����� ����
select sum(bonus) from employee;

select bonus from employee
where bonus is not null;

--null�̸� ���ʽ� �հ踦 ���� ��� ����� �޶����Ƿ�
--���� ���̰� ��
select ROUND(avg(bonus), 3), ROUND(avg(nvl(bonus, 0)),3) from employee;

select ROUND(avg(bonus), 3) from employee where bonus is not null;

--���̺� ��ü �� ��
--count(�÷��� or *)
select count(*) from employee
where dept_code='D9';

select count(*) from employee
where salary >= 3000000;

select count(emp_name) from employee;

--dept_code null���� ������
select count(dept_code) from employee;
select count(*) from employee where dept_code is not null;

select count(distinct dept_code) from employee;

select max(salary), min(salary) from employee;

select max(hire_date), min(hire_date) from employee;

--GROUP BY
--�μ��� ������ ���
select dept_code, FLOOR(avg(salary)) from employee
GROUP BY dept_code;
--HAVING dept_code='D5';


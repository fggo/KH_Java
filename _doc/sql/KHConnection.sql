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

--��¥�� ��� ����
select sysdate-1 ����, sysdate ����, sysdate+1 ���� from dual;

select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') "NOW" from dual;

--��¥�� ��¥������ ��� ����
--�ϼ�(int) ������ ���
select sysdate - to_date('19990224', 'yyyymmdd') from dual;
select sysdate - to_date('19990224') from dual;

--�ð����� ���
select systimestamp from dual;

select to_date('19990224', 'yyyy-mm-dd') from dual;

create table datetest(
    today date,
    birthday date,
    temp timestamp);

insert into datetest values(
        '19/06/13', '00/02/24', '19/06/13 11:15:00');
insert into datetest values(
        to_date('20190613'), to_date('19990224'), to_timestamp('20190613111500'));
    
select * from datetest;

--���̺� �÷��� �ڷ����� Ȯ���ϰ� ������
DESC chartest;
DESC datetest;

create table member_table (
    id CHAR(15), --����x 6-15�ڸ�
    password VARCHAR2(15), --8-15�ڸ�
    name VARCHAR2(15), --�ѱ��Է�
    phone NUMBER(11), --�ڵ��� -����
    ssn NUMBER(13), --�ֹι�ȣ
    mileage NUMBER, --���ϸ���
    reg_date DATE);

select * from member_table;

-- ���̺� �ִ� ������ ��ȸ�ϱ�
-- ��ɾ� select
-- ��ɱ��� select �÷�1,...,�÷�n from ���̺�� where �˻�����
select emp_name, email, ent_date from kh.employee;
select emp_name, email, ent_date from employee;

select dept_id, dept_title from department;

--select �������� ��� ���굵 ����
--������ �ϱ� ���ؼ��� ������� �÷����� ���� ������
--������ ���ָ� �� ���� ���� �÷����� �ǰ�, ���� ����
--�� row�� ����.

--ERROR
select emp_name, salary, email*12 from employee;

--%�Լ� ����. MOD�̿�
--select bonus %12 from employee; --ERROR
select MOD(salary, 12) from employee;

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
select distinct dept_code from employee;

--(dept_code, job_code)�� �Ѱ� �����ͷ� distinct�� ���� select
select distinct dept_code, job_code from employee;

--�� ������: where clause filters resultset
--select �÷�1,...,�÷�n from ���̺�� where �÷��� �񱳿����� ��;
select * from employee where job_code = 'J5';

select emp_name, salary, hire_date, phone from employee
    where sal_level='S1';

select emp_name, salary,
    12*salary*(1+nvl(bonus, 0)-.03) AS �Ǽ��ɾ�
from employee
where 12*salary*(1-.03 + nvl(bonus,0)) > 50000000;

--�������� ����ϱ� AND/OR
select * from employee
    where dept_code != 'D6' AND salary >= 3000000;

select emp_name, hire_date, salary from employee
    where job_code='J3' OR sal_level='S5';

--�񱳿����ڸ� ������
select * from employee where dept_code='D5' AND hire_date >'02/01/01';

select distinct sal_level from employee
where job_code ^= 'J1'; --job_code != 'J1'

select emp_no || emp_name || email from employee;
select emp_name ||'�� '|| salary || '��' from employee;

select emp_name, salary from employee
where salary between 3500000 and 6000000;
--where salary >=3500000 and salary <= 6000000;

select emp_name, dept_code, hire_date from employee
    where salary not between 3500000 and 6000000;

select emp_name, hire_date, dept_code, salary from employee
    where hire_date between '90/01/01' and '01/01/01';
--where hire_date >= '90/01/01' and hire_date <='01/01/01';

--LIKE ���� �����̿��Ͽ� �˻�
select * from employee where emp_name like '%��';

-- ����ٴ� �ڸ��� ǥ��
select * from employee where emp_name like '__��';

-- email ����° �ڸ��� 'n'�� ���
select * from employee where email like '__n%';

select * from employee where emp_name like '__��';

select * from employee where emp_name like '_��_';
    
select * from employee where emp_name like '%��%';

--ESCAPE CHARACTER
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

--description�� '99.99%' ��� ���� �� �ִ� �ุ �����ϼ���
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

select * from employee where job_code in ('J3', 'J2');
-- job_code ='J3' or job_code='J2';

select emp_name, job_code from employee
where job_code in (select job_code from employee
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

--order by�� �������� �ۼ� ASC(����Ʈ), DESC;
--�⺻������ primary key�� ���ĵ�
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
select length(emp_name), lengthb(emp_name),
       length(email), lengthb(email)
from employee;

select length('�ٹٹ�') from dual;
select lengthb('�ٹٹ�') from dual;

--INSTR(����, ã�¹���, +/-�����ĭ, ���°��������)
--�Ű� ������ ���� ���ڿ��� Ư�������� ��ġ�� ã����
select INSTR('monkkky', 'k') from dual;
select INSTR('monkkkaaakay', 'k', -4, 2) from dual;
select INSTR('monkkkaaakay', 'a', -4, 2) from dual;
select INSTR('monkkkaaakay', 'a', 1, 1) from dual;

select email, INSTR(email, '_') from employee;

select email, substr(email, 1, instr(email, '@') -1) from employee;

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
    CASE WHEN substr(emp_no, 8,1) in (1,3) THEN '��'
        WHEN substr(emp_no, 8,1) in (2,4) THEN '��'
    ELSE '?' END AS ����,
    EXTRACT(year from sysdate) 
        - EXTRACT(year from TO_DATE(substr(emp_no, 1,2), 'RR')) + 1 AS ����,
    TO_NUMBER(EXTRACT(year from sysdate))- 
        TO_NUMBER(substr(emp_no,1,2) + 
            CASE WHEN substr(emp_no,8,1) in(1,2) THEN 1900
                    ELSE 2000 END) + 1 AS ���糪��
from employee
order by ���糪�� DESC;
-- yy�� 20�� ����(���� ����).  rr�� ��ȯ
-- rr�� 1950 ������ �¾ ����� ������ 
--      ex) ��ι� 2019 - (1947->2047) + 1 = -27
--      rr�� 50���� ������ '20xx' 50���� ũ�� '19xx'
-- ��¥�� ������ yy �α��ڸ� �����ö�,
--      YY: ���� ����� ��� (99 -> 2099)
--      RR: 
--    TO_CHAR(sysdate, 'yyyy')- CONCAT(19,substr(emp_no,1,2)) +1 AS ����


--RR ��ȯ ����
--���翬��   �Է¿���  ��꿬��
-------------------------------
--  00~49      00~49   ���缼��
--  00~49      50~99   ������
--  50~99      00~49   ��������
--  50~99      50~99   ���缼��

select TO_DATE('880101', 'RR') from dual;

--�׷��Լ�
--COUNT, MAX, SUM, AVG,
--result ���� �Ѱ��� row�� �Ǿ� �ֱ� ������,
--  �÷��� ������ �� ����.
select emp_name, SUM(salary) from employee
--where substr(emp_no, 8,1) in (1,3);
where emp_name like '��__'
GROUP BY emp_name;

select SUM(salary*12) AS ����,
    SUM(12*salary*(1-.03 +nvl(bonus,0))) AS �Ǽ��ɾ�
from employee;

--null ���� sum���� �ڵ����� ����
select SUM(bonus) from employee;

select bonus from employee
where bonus is not null;

--null�̸� ���ʽ� �հ踦 ���� ��� ����� �޶����Ƿ�
--���� ���̰� ��
select ROUND(avg(bonus), 3), ROUND(AVG(nvl(bonus, 0)),3) from employee;

select ROUND(avg(bonus), 3) from employee
where bonus is not null;

--���̺� ��ü �� ��
--count(�÷��� or *)
select COUNT(*) from employee
where dept_code='D9';

select COUNT(*) from employee
where salary >= 3000000;

select COUNT(emp_name) from employee;

--dept_code null���� ������
select COUNT(dept_code) from employee;
select COUNT(*) from employee where dept_code is not null;

select COUNT(distinct dept_code) from employee;

select MAX(salary), MIN(salary) from employee;

select MAX(hire_date), MIN(hire_date) from employee;

--GROUP BY
--�μ��� ������ ���
select dept_code, FLOOR(AVG(salary)) from employee
GROUP BY dept_code
HAVING dept_code='D5';

--group by �����ϸ� �� �׷����� ���Ǵ� �׷��Լ��� ��밡��
select dept_code, count(dept_code), sum(salary),
floor(avg(salary)), min(salary)
from employee
GROUP BY dept_code
HAVING dept_code IS NOT NULL
order by dept_code;

--�����÷����� ���� ��տ���, �հ� �ο���
select CASE WHEN substr(emp_no, 8,1)=1 then '��'
            ELSE '��'
           END AS GENDER,
       COUNT(*) AS �ο���,
       TO_CHAR(sum(salary), 'L999,999,999') AS �����հ�,
       TO_CHAR(FLOOR(AVG(salary)), 'L999,999,999') AS �������
from employee
GROUP BY 
        CASE WHEN substr(emp_no, 8,1)=1 THEN '��'
        ELSE '��'
END;

--dept_code�� �������� salary �հ�� ���
--WHERE������ �׷��Լ� ���� ����.
--HAVING���� �׷��Լ� ���� ����
select job_code,
    sum(salary) AS �����Ѿ�,
    FLOOR(avg(salary)) AS �������
from employee
where dept_code is not NULL
GROUP BY job_code
HAVING sum(salary) > 9000000
ORDER BY job_code;

--�μ��ο����� 4���̻��� �μ���
select dept_code, count(*)
    from employee
where dept_code is not null
GROUP BY dept_code
HAVING count(*) >= 4
order by dept_code;

--GROUP BY�� ���� �� �Ӿƴ϶�
--�׷����� �Լ� ROLLUP CUBE�� �׷쿡 ���� ���հ� ����
--�ΰ��̻� �÷��� GROUP BY �ϸ� CUBE�� 

select dept_code, sum(salary)
from employee
GROUP BY dept_code
order by 1;

select dept_code, sum(salary)
from employee
GROUP BY ROLLUP(dept_code)
order by 1;

--�ΰ� �÷��� ���� �Ѱ踦 ���
--�հ�� �տ� �ִ� dept_code�� �������� ����
select dept_code, job_code, sum(salary)
from employee
GROUP BY ROLLUP(dept_code, job_code)
order by 1;
--D1 J7�� ���� row�� �Ѱ��� �׷��� ��
--(dept_code, job_code)�� �׷��� ��
--job_code=null �ΰ��� dept_code�� ���� �հ�
--�ٸ� 
--dept_code is null: �ΰ��� 
--	J6	2320000
--	J7	2890000

select job_code, dept_code, sum(salary)
from employee
GROUP BY ROLLUP(job_code, dept_code)
order by 1;

--�μ��� �ο� ������ ����ϴµ�, ���ο����� ���
select dept_code, count(*) AS �ο�
from employee
GROUP BY ROLLUP(dept_code);
--GROUP BY CUBE(dept_code); --������ group �϶��� CUBE�ϰ� �������

--�μ���, ���޺� �ο��� ����ϰ� �μ��� �Ұ���ü �Ѱ踦 ���
select dept_code, job_code, 
    count(*) AS �ο���,
    sum(salary) AS �����հ�
from employee
GROUP BY ROLLUP(dept_code, job_code)
order by 1;

--CUBE�� �Ѱ� �׷츸 ó���Ҷ��� ROLLUP�� ��� ����
--  �ΰ� �̻� �÷��� �׷����� ������ ��� �߰���
--  �ι�° �̻� �÷� �������� �հ赵 ���� ����
-- 1.job_code �������� Group + �հ�
-- 2.dept_code���� Group,
-- 3.(job_code,dept_code) ���� Group


select dept_code, job_code,
    count(*) AS �ο���, 
    sum(salary) AS �����հ�
from employee
GROUP BY CUBE(dept_code, job_code)
order by 1;
-- (null)   J6	1	2320000  --dept_code NULL�� ��
-- (null)   J6	6	15746240 --job_code=6�� ���� �հ�

--D1   NULL   3	7820000
--D2   NULL   4	6968000
--D5   NULL   6	15760000
--D6   NULL   3	10100000
--D8   NULL   3	6986240
--D9   NULL   3	17700000
--NULL NULL   2	5210000 --DEPT_CODE=NULL�� ��
--
--NULL J1     1	 8000000
--NULL J2     3	 10148000
--NULL J3	  3	 10800000
--NULL J4	  4	 9320000
--NULL J5	  3  8460000
--NULL J6	  6	 15746240
--NULL J7	  4	 8070000
--NULL NULL   24 70544240

--GROUP�� �Լ�
select dept_code, job_code,
count(*) AS �ο���,
sum(salary) AS �ѿ���,
CASE
    WHEN GROUPING(dept_code)=0 AND GROUPING(job_code)=1
        THEN '�μ����հ�'
    WHEN GROUPING(dept_code)=1 AND GROUPING(job_code)=0
        THEN '���޺��հ�'
    WHEN GROUPING(dept_code)=1 AND GROUPING(job_code)=1
        THEN '���հ�'
    WHEN GROUPING(dept_code)=0 AND GROUPING(job_code)=0
        THEN '�׷캰 �հ�'
    ELSE '??' END
  AS "GROUPING"
from employee
GROUP BY CUBE(dept_code, job_code)
order by "GROUPING", 1, 2;

--���� ������ (set operation)
--UNION UNION ALL
-- 1.�÷��� ��ġ�ؾ� 2.�ڷ��� ��ġ�ؾ�
select emp_id, emp_name, dept_code, salary
    from employee
    where dept_code= 'D5'    
UNION
select emp_id, emp_name, dept_code, salary
    from employee
    where salary >= 3000000
order by dept_code;

--UNION
--�÷� �����ʹ� �� �÷��� �䱸�ϴ�
--�ڷᰡ ���� �ʾƵ� ��:
--���� ������ �ڷ����� ���� ������ UNION ����
select emp_name, emp_no
from employee
where salary > 3000000
UNION
select dept_title, dept_id
from department;

--�ٸ� �÷��� UNION�ҋ� ������ ������ 
--ū������ ĳ���� �Ǿ� ��
select dept_title, dept_id
from department
UNION
select emp_name, emp_no
from employee
where salary > 3000000;

--UNION ALL �ߺ��� ��� ���
select emp_id, emp_name, dept_code, salary
    from employee
    where dept_code= 'D5'
UNION ALL
select emp_id, emp_name, dept_code, salary
    from employee
    where salary >= 3000000
order by dept_code;

--INTERSECT: �ΰ��̻��� result set�� �ߺ����� ���
select emp_id, emp_name , dept_code, salary
from employee
where dept_code = 'D5'
INTERSECT
select emp_id, emp_name , dept_code, salary
from employee
where salary > 3000000;

--MINUS: �ΰ� �̻��� result set����
--�� select ������ �ߺ����� ������
select emp_id, emp_name , dept_code, salary
from employee
where dept_code = 'D5'
MINUS
select emp_id, emp_name , dept_code, salary
from employee
where salary > 3000000;

--INTERSECT�� �����Ƿ�, ���� select�� result �״�� ��ȸ
select emp_id, emp_name , dept_code, salary
from employee
where dept_code = 'D8'
MINUS
select emp_id, emp_name , dept_code, salary
from employee
where salary > 3000000;

select dept_code
from employee
where dept_code = 'D8'
MINUS
select dept_id
from department;

--GROUPING SETS: GROUP BY �� result ���̺��� ���� ������
--group by GROUPING SETS
--group by�� �����Ǿ� �ִ� result set���� �����Ͽ� ������
--GROUPING SETS�� ���� �������
select dept_code, job_code, manager_id,
    count(*) AS �ο���,
    floor(AVG(salary))
from employee
group by GROUPING SETS(
    (dept_code, job_code, manager_id),
    (dept_code, manager_id),
    (job_code, manager_id)
)
order by 1 NULLS LAST, 2 NULLS LAST, 3 NULLS LAST;

--���� GROUPING_SETS�� �ؿ� 3���� ��ģ��
select dept_code, job_code, manager_id,
    count(*) AS �ο���,
    floor(AVG(salary))
from employee
group by dept_code, job_code, manager_id
order by 1,2;

select dept_code, manager_id,
    count(*) AS �ο���,
    floor(AVG(salary))
from employee
group by dept_code, manager_id
order by 1,2;

select job_code, manager_id,
    count(*) AS �ο���,
    floor(AVG(salary))
from employee
group by job_code, manager_id
order by 1,2;

--JOIN : �ΰ��� ���̺��� �����Ͽ�, �Ѱ��� ���̺�� ���
--row ������ �����ϱ� ������, ���� ���εǴ� ���� �ʿ���
--��κ��� ��� : ���̺�1�� FOREGIN KEY�� 
--                ���̺�2�� PRIMARY KEY�� �����

--1. ����Ŭ ���� INNER JOIN(or JOIN)
select emp_name, e.job_code, j.job_name
from employee e, job j
where e.job_code = j.job_code;

select e.emp_name, d.dept_id, d.dept_title
from employee e, department d
where dept_code = dept_id
order by 2,1;

--2. ANSI ǥ�� = SQL ǥ�� INNER JOIN
--(1). �÷����� ��ġ�Ҷ�
--  select �÷�1,...,�÷�n 
--  from ���̺�1 JOIN ���̺�2
--  USING ���÷�
--   where [����]
select emp_id, emp_name, job_code, job_name
from employee
JOIN JOB USING(JOB_CODE);

--(2). �÷����� �ٸ���
--  select �÷�1,...,�÷�n 
--  from ���̺�1 JOIN ���̺�2
--   on ���÷�1=���÷�2
--  where [����]
select emp_name, job_name
from employee e JOIN job j 
    ON e.job_code = j.job_code;

select emp_name, dept_title
from employee INNER JOIN department 
    ON dept_code= dept_id
where dept_title='�ѹ���';

--OUTER JOIN
--������ �Ǵ� ���̶� ��ġ�ϴ� ���� ������ �� row��
--������� ����.
--22�� ��µ�: dept_code �� null�� row ����
select count(*) from employee
    JOIN department ON dept_code = dept_id;

--�����÷��� ���(null), OUTER JOIN����
--����(LEFT, RIGHT)�������� ������ ��� ��°���

--LEFT JOIN : ������ �÷��� �������� 
select e.emp_name, e.dept_code, d.dept_title
    from employee e LEFT JOIN department d
        ON e.dept_code = d.dept_id;

select d.dept_title, e.dept_code, e.emp_name
    from department d LEFT JOIN employee e
        ON e.dept_code = d.dept_id;

--RIGHT JOIN : ������ �÷��� �������� 
select e.emp_name, e.dept_code, d.dept_title
    from employee e RIGHT JOIN department d
        ON e.dept_code = d.dept_id;

select d.dept_title, e.emp_name, e.dept_code
    from department d RIGHT JOIN employee e
        ON e.dept_code = d.dept_id;

--����Ŭ OUTER ���� ���
-- +���°��� ����: LEFT JOIN
select emp_name, dept_code, dept_title, dept_id
from employee, department
where dept_code =dept_id(+);

--RIGHT JOIN
select emp_name, dept_code, dept_title, dept_id
from employee, department
where dept_code(+) =dept_id;

--FULL JOIN : ��ġ�Ǵ°��� ���
--���� ���̺� ������ ��� ���
select emp_name, dept_code, dept_title, dept_id
from employee FULL JOIN department 
        ON dept_code=dept_id;

--CARTESIAN product (NOT USED OFTEN)
--28 * 9
select emp_name, dept_code, dept_title, dept_id
from employee, department
order by 1,3;
--from employee department;
--������ row�� �����

--NON-EQUAL JOIN: ����񱳰� �ƴ϶�, ��ũ�� �񱳷� ����
select emp_name, salary, s.sal_level, s.min_sal, s.max_sal
from employee JOIN sal_grade s
    ON (salary between min_sal and max_sal);

--SELF JOIN: ���� ���̺��� ���������Ͽ� �����ϴ� ��
--  �ڱ� ���̺��� �÷���(���еǴ�)�� �����ִ� �÷��� �����ؾ���
-- employee : emp_id = manager_id
--1. SELF INNER JOIN
select E.emp_id, E.emp_name ����̸�, E.dept_code, 
    E.manager_ID AS �Ŵ���ID,
    M.emp_name AS �Ŵ����̸�
from employee E JOIN employee M
    ON E.manager_id = M.emp_id;

--2. SELF OUTER JOIN
--    M �Ŵ��� ������ NULL�ΰ͵� ��µǵ���
select E.emp_id, E.emp_name ����̸�, E.dept_code, 
    E.manager_ID �Ŵ���, M.emp_name AS �Ŵ����̸�
from employee E LEFT JOIN employee M
    ON E.manager_id = M.emp_id;
--where E.emp_name = '������';

--  manager_id�� 100�� �߸��� ������!
--  FOREIGN KEY�� �����ϸ� 100 ��ü�� �ȳ����� ����

--����JOIN: ���̺��� �ΰ��̻� �����ϴ� ���� �ǹ��Ѵ�
--  from ���� join������ ��� ����ϸ� ��
--  join�� �Ҷ� ����Ǵ� �÷��� �ݵ�� ������ ���յ� ���̺� ����
select E.emp_id, nvl(D.dept_title, '����') �μ���, 
    E.dept_code,
    J.job_name,
    E.job_code,
    E.emp_name,
    L.local_name
from employee E
    LEFT JOIN department D ON(E.dept_code=D.dept_id)
    JOIN location L ON D.location_id = L.local_code
    JOIN job J ON E.job_code = J.job_code;
--    JOIN job J USING (job_code);


--SUBQUERY ��������
--  JOIN�� SUBQUERY���� ������ ����

--������ ��������
select dept_id, dept_title
from department
where dept_id=
    (select dept_id from department where dept_title='�ؿܿ���1��');

select emp_name, salary, dept_code from employee
where salary > (select avg(salary) from employee);

select emp_name, dept_code, salary
from employee
where dept_code = (select dept_id 
                    from department where dept_title='�ѹ���')
    and salary > (select AVG(salary) from employee);

--������ �������� : result set�� ���� �������� ���
--  ���߱� �ڳ����� �����μ��� ������
select emp_name, dept_code, salary
from employee
where dept_code in (select dept_code from employee 
    where emp_name in ('������', '�ڳ���'));


--���߿� ��������: select������ �÷��� �ټ������ϴ� ���
--�񱳴�� 1:1��Ī�� �Ǿ� �Ѵ�.
--  ����� �������� ���� ����, ���� �μ��� ���
select emp_name, emp_no, job_code, dept_code, ent_yn
from employee 
where (job_code, dept_code) IN
    (select job_code, dept_code from employee where
        substr(emp_no, 8,1) in (2,4) and ent_yn='Y');

--���߿� ���߼�������: ���������� result set��
--  ��� row�� 2���̻�, column�� 2���̻��� ����� ������ 
--  select���� ��� ������.
--  ���޺� �ּұ޿��� �޴� ������
--  ��� �̸� ���� �޿� ��ȸ
select emp_id, emp_name, job_code, salary
from employee where (job_code, salary) in
    (select job_code, MIN(salary)
        from employee group by job_code)
order by job_code;


--������ ���������� ��Һ� �Ҷ� ANY, ALL


--ALL: ���������� ����� �ϳ��� ���̸� ���̴�.
--  x>ANY(subquery) ������� ũ�⸸ �ϸ� ��

--�ּҰ����� ũ�� ��
select emp_name, salary from employee 
where salary > ANY(select min(salary) from employee);

select emp_name, salary from employee 
where salary = ANY(select salary from employee);

--�ִ밪���ٸ� ������ ��
select emp_name, salary from employee 
where salary < ANY(select salary from employee);

--ALL: ���������� ����� ��� ���̸� ��
-- X > ALL : ���������� ��� ������ ũ�� ��
--      �ִ밪���� ũ�� ��.
-- X < ALL : ���������� ��� ������ ������ ��
--      �ּҰ����� ������ ��.
select emp_name, salary from employee 
where salary > ALL(select min(salary) from employee
                    HAVING min(salary) < 6000000);

--��� ��������: MAIN select���� subselect���� ���� ����� ������ �ִ°�
--�Ŵ��� ���̵� �ִ� ������ return
--���ذ� E.manager_id�� �����Ǵ� ���� EXIST�ΰ�� ��� M.emp_id IS NOT NULL
select emp_id, emp_name, manager_id
from employee E
where EXISTS(select * from employee M
                where E.manager_id = M.emp_id);
                
--���ذ� E.manager_id�� �����Ǵ� ���� NOT EXIST�ΰ�� ��� M.emp_id IS NULL
select emp_id, emp_name, manager_id
from employee E
where NOT EXISTS(select * from employee M
                where E.manager_id = M.emp_id);


--������ J1, J2, J3�� �ƴ� ����߿��� 
--�ڽ��� �μ��� ��ձ޿����� ���� �޿��� �޴� ������.
-- �μ��ڵ�, �����, �޿�, �μ��� �޿����
select E.dept_code, E.emp_name, E.salary, E2.AVG_SAL
from employee E
    JOIN ( select dept_code, ROUND(avg(salary)) AVG_SAL
            from employee
            group by dept_code) E2 ON (E.dept_code = E2.dept_code)
where EXISTS(select E3.dept_code, avg(E3.salary) from employee E3
        where E.dept_code = E3.dept_code
        group by E3.dept_code
        HAVING E.salary > avg(E3.salary))
    and E.job_code not in ('J1','J2','J3')
order by dept_code;


select E1.dept_code, emp_name, salary, E2.AVG_SAL
from employee E1
    JOIN ( select dept_code, 
                  round(avg(salary)) AS AVG_SAL
            from employee
        GROUP BY dept_code) E2 ON E1.dept_code = E2.dept_code
where job_code NOT IN ('J1', 'J2', 'J3')
    AND salary > E2.AVG_SAL
order by dept_code;


--��Į�� ��������: ��������ε� �װ�� result set�� ������ �Ѱ��� �ִ°�!
--AVG_SAL�� where������ ���� ����. select���� �������� ���� �ǹǷ�
--��Į��: sql���� ���ϰ��� ���� �����͸� ��Į�� ��� ��.
--  ���: 1. select���� column���� ��밡��
--        2. where�������� ��� ����
--        3. order by�������� ��� ����
select dept_code, emp_name, salary, 
    (select round(avg(salary))
        from employee E2
      where E1.dept_code = E2.dept_code) AS AVG_SAL
from employee E1
where E1.job_code NOT IN ('J1', 'J2', 'J3')
    and E1.salary > (select round(avg(salary))
                       from employee E2
                       where E1.dept_code = E2.dept_code)
order by dept_code;

--select���� ��Į�� �������� ����ϱ�
--������� ���, �̸�, �����ڻ��, �����ڸ� ��ȸ
select E.emp_id, E.emp_name, E.manager_id, M.emp_name
from employee E
    JOIN employee M ON E.mananger_id=M.emp_id;

--��Į��� ��ȯ (������: manager_id null�̾ null�� ��µ�)
--(select ���ϰ� from ���̺�)���θ� ��Į�� �������� ���� ����
select emp_id, emp_name, manager_id, 
    nvl((select emp_id 
        from employee M 
      where E.manager_id = M.emp_id), '����') AS �����ڸ�
from employee E;

--�����, �μ��ڵ�, �μ���,�μ��� ����ӱ��� ���������� �̿������
select emp_name, dept_code, D.dept_title, 
    (select round(avg(salary))
        from employee E2
        where E2.dept_code = E1.dept_code) AS �μ�������ӱ�
from employee E1
   JOIN department D ON E1.dept_code=D.dept_id
order by dept_code;

--������ J1 �ƴѻ���� �ڽ��� �μ��� ��� �޿����� ���� �޿��޴� �����
--�μ��ڵ�, �����, �޿�, �μ��� �޿����
select dept_code, emp_name, salary,
    (select round(avg(salary))
        from employee E2
        where E1.dept_code = E2.dept_code) AS �μ����޿����
from employee E1
where E1.job_code <> 'J1'
    and E1.salary < (select round(avg(salary))
                        from employee E2
                        where E1.dept_code = E2.dept_code)
order by dept_code;

--��Į�� where���� ����ϱ�
--�ڽ��� ���� ������ ��ձ޿����� ���� �޴� ������ 
--�̸�, ����, �޿��� ��ȸ
select emp_name, J.job_name, salary
from  employee E1
    JOIN job J ON E1.job_code = J.job_code
where E1.salary > (select round(avg(salary))
                        from employee E2
                        where E1.job_code= E2.job_code)
order by E1.job_code;

--��Į�� ���������� order by��
--��� ������ ���, �̸�, �ҼӺμ� ��ȸ��, �μ������� ��������
select emp_id, emp_name, dept_code
from employee E
order by (select dept_title from department D
            where E.dept_code = D.dept_id) DESC nulls last;

--���������� FROM ���� ���
select emp_id, emp_name, dept_code,
    DECODE(substr(emp_no,8,1), 1,'��', 2,'��') AS ����
from employee
where substr(emp_no,8,1) in (1,3);

select * 
from (select emp_id AS ���, emp_name AS �����, 
             dept_code AS �μ��ڵ�,
             DECODE(substr(emp_no,8,1), 1,'��', 2,'��') AS ����
        from employee)
        --where emp_id like '20%');
where ����='��' and ���='200'; --�÷����� �ٲ�. where�� emp_id ���Ұ�

--INLINE VIEW
--Employee ���̺��� 1990�⵵�� �Ի��� ����� 
--���, �����, �Ի�⵵
select *
from (select emp_id, emp_name, EXTRACT(year from hire_date) AS �Ի�⵵
        from employee
        where EXTRACT(year from hire_date) like '199_'
        order by emp_id, hire_date);
--where �Ի�⵵ - 1990 between 0 and 9

--Employee ���̺��� ����� 30, 40���� ���ڻ���� 
--���, �μ���, ����, ���̸� ���
select *
from (select emp_id, emp_name, dept_title, 
        DECODE(substr(emp_no,8,1), 1,'��',2,'��') AS ����, 
        EXTRACT(year from sysdate)
            - TO_NUMBER(DECODE(substr(emp_no,8,1),1,19,2,19,20)
              || substr(emp_no,1,2)) + 1 AS ����
        from employee E
            LEFT JOIN department D ON dept_code=dept_id)
where ����='��'
    and substr(����,1,1) in(3,4);
--and (trunc(����/10)) in (3,4);

--WITH AS
--���������� ��Ī �ο��Ͽ� �� ��Ī���� ���������� ����ϴ� ��
WITH TT AS(select emp_id, emp_name, salary 
            from employee
            order by salary desc)
select TT.emp_id, TT.emp_name, TT.salary 
    from TT;

--RANKING ������ ��ȸ�ϴ� ��ȸ���� �˾ƺ���.
--  ���޸��� top3�� ��ȸ
--����Ŭ�� ���̺��̸� �����ϴ� �÷�
--ROWNUM : �÷��� ���� �ڵ����� 1~�������� ��ȣ�ο�
--ROWID : row�� ã�ư� �� �ְ� ���ִ� �ּҰ�!
CREATE TABLE TEST(
    BOARDNO NUMBER,
    TITLE VARCHAR2(10),
    CONTENT VARCHAR2(200),
    WRITER VARCHAR2(10)
);

select ROWID, ROWNUM, boardno, title, content, writer from test;

--ROWNUM�� ���̺� ������ Insert������� ���������� ������ ��. (������ ����)
--�׷��Ƿ�, order by�� ���� ROWNUM�� ������ �ʴ´�.
--���� select * from (select ROWNUM R, ... from TABLE)
--���� ����� order by salary�� ���� ������ ��µ��� �ʴ´�.
select ROWNUM, emp_id, emp_name, salary
    from employee
where ROWNUM <=3
order by salary desc;

--ROWNUM �ڵ����� ���ںο�. �ο��Ǵ� ������ FROM(��������)
--ORDER BY�� FROM ���� �������� ����ǹǷ�
--INLINE VIEW�� �̸� �־��
--������, ROWNUM�� 1���� row�� ���õǸ鼭 �����ϹǷ�, ROWNUM >=3�� ��� ����
select ROWNUM, E.*
from (select emp_id, emp_name, salary 
        from employee order by salary desc) E
where ROWNUM <=3;

--ERROR!
select ROWNUM, * from employee;
--OK!
select ROWNUM, EMPLOYEE.* from employee;

--D5�μ����� ���� ���� 3���� �������
--����, ���, �����, ����
select ROWNUM, E.*
from (select emp_id, emp_name,
        TO_CHAR(12*salary, 'L999,999,999') AS ����
        from employee 
        where dept_code='D5' order by ���� DESC) E
where ROWNUM <=3;

--������ 5����� 10�����
--�����, ����
--�ȳ���!! ROWNUM BETWEEN A and B (A=1�ƴϸ� ��¾ȵ�)
--NOT WORKING!
select ROWNUM, E.*
    from (select emp_name, salary
            from employee order by salary DESC) E
where ROWNUM between 5 and 10; --NOT SHOWING ANY RESULTS

--paging ó���ÿ� �ʼ�
--INLINE VIEW�� �ι� �����
--ROWNUM����������� selected�ɶ� ���� �ο���,
--�� where���� �������� row�� ���õǸ鼭 �ο��ǹǷ�,
--row>N�϶� (N>1) 

--When assigning ROWNUM to a row, 
--Oracle starts at 1 and only increments the value when a row 
--is selected; that is, when all conditions in the WHERE clause are met. 
--Since our condition requires that ROWNUM is greater than 2,
--no rows are selected and ROWNUM is never incremented beyond 1.
select *
from ( select ROWNUM RNUM, E.*
       from (select emp_name, salary
               from employee order by salary DESC) E
    )
where RNUM between 5 and 10;

--������ ����
--      ������ ����, �޴�, �亯�� �Խ���(���)
--  FROM ������ �ɼ� ���� ����ؼ� ó����
--  START WITH: �θ���(��Ʈ���) ����
--  CONNECT BY: �θ�-�ڽİ��� ����
--  PRIOR: START WITH ������ ������ �θ����� �����÷��� ����
--  LEVEL: ���������� ��Ÿ���� ������ �÷�
-- ��� �ý��� ���鶧 ���
select LEVEL, emp_id, emp_name, manager_id
from employee
start with emp_id=200
connect by prior emp_id = manager_id
order by LEVEL;

select LPAD(' ', (LEVEL-1)*5, ' ') || 
    EMP_NAME ||NVL2(MANAGER_ID, '(' || MANAGER_ID||')', '') AS ������
from employee
start with manager_id IS NULL
connect by prior emp_id=manager_id;

--RANK() �������Լ�: ����Ŭ�� �����ϴ� ������ȸ �Լ�
--  ROWNUM�� �� ���� ��.
select ����, emp_name, salary
from (select emp_name, salary,
            RANK() OVER(order by salary desc) AS ����
            from employee order by salary desc);

select ����, emp_name, salary
from (select emp_name, salary,
            DENSE_RANK() OVER(order by salary desc) AS ����
            from employee order by salary desc)
where ���� between 5 and 10;

--DML
--  Manipulates Table Data
--      INSERT: add Row(s) to table
--      UPDATE: modify specific Row(s) and specific Column
--      DELETE: delete specific Row(s)

-- col(1~N) or ALL col(in order)
--INSERT into TABLE_NAME(COL1,... COLN)
--    VALUES(VAL1,...VALN);
--INSERT into TABLE_NAME
--    VALUES(VAL_1,...VAL_TOTALCOLNUM);

--oracle�� DEFAULT ����ؾߵ�, 
--mysql�� �ڵ����� �����尪 ������
INSERT INTO employee VALUES(
    900, '��ä��', '901123-1080503', 'jang_ch@kh.or.kr', '01055569512',
    'D1', 'J8', 'S3', 4300000, 0.2, '200', SYSDATE, DEFAULT, DEFAULT);

INSERT INTO employee VALUES(
    901, '������', '781020-2123453', 'hamham@kh.or.kr', '01012341234',
    'D1', 'J4', 'S3', 4500000, DEFAULT, 
        (SELECT emp_id from employee where emp_name='�̿���'), 
        SYSDATE, DEFAULT, DEFAULT);

INSERT INTO employee(emp_id, emp_name, emp_no, email, phone,
    dept_code, job_code, sal_level, salary, bonus, manager_id)
VALUES(903, '������', '000224-3123412', 'prince0324@naver.com',
        '01036446259', 'D2','J1','S1', '99900000', 0.8, '200');

select * from employee where emp_name in('��ä��', '������', '������');

COMMIT;
 
--NOT NULL CONSTRAINTS : 
--  "SAL_LEVEL" IS NOT NULL
--  "JOB_CODE" IS NOT NULL
--  "EMP_NO" IS NOT NULL
--  "EMP_NAME" IS NOT NULL
--  "EMP_ID" IS NOT NULL
INSERT INTO employee(emp_id, emp_name, emp_no, sal_level, job_code)
    VALUES(904, '������', '910804-2123412', 'S1', 'J3');

--INSERT���� �������� �̿��ϱ�
CREATE TABLE emp_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    EMP_TITLE VARCHAR2(20));

INSERT INTO emp_01 VALUES(999, '������', '��ǥ�̻�');

INSERT INTO emp_01( select emp_id, emp_name, J.job_name
    from employee E JOIN job J ON E.job_code = J.job_code);

select * from emp_01;

--CREATE�� �ڵ� COMMIT ��
CREATE TABLE emp_hire_date(
    emp_id NUMBER,
    emp_name VARCHAR2(30),
    hire_date DATE);

CREATE TABLE emp_manager(
    emp_id NUMBER,
    emp_name VARCHAR2(30),
    manager_id NUMBER);

--INSERT using sub-query
INSERT INTO emp_hire_date( select emp_id, emp_name, hire_date
                            from employee);

INSERT INTO emp_manager( select emp_id, emp_name, manager_id
                            from employee);
select * from emp_hire_date;
select * from emp_manager;

ROLLBACK;
COMMIT;

--INSERT ALL
INSERT ALL
    INTO emp_hire_date VALUES(emp_id, emp_name, hire_date)
    INTO emp_manager VALUES(emp_id, emp_name, manager_id)
select emp_id, emp_name, hire_date, manager_id
    from employee;

--INSERT ALL ���� ���̺� �ѹ��� ���� ����
--���� ������, ���ǿ� ���� ���� ���� �� ����.
--CASE �� �� ����� WHEN�� ����ؼ� ó����.
CREATE TABLE emp_old(
    emp_id NUMBER,
    emp_name VARCHAR2(30),
    hire_date DATE,
    salary NUMBER);

CREATE TABLE emp_new(
    emp_id NUMBER,
    emp_name VARCHAR2(30),
    hire_date DATE,
    salary NUMBER);

--OLD employee���̺��� 00.01.01 ���� �Ի��� ���
--NEW employee���̺��� 00.01.01 ���� �Ի��� ���
INSERT INTO emp_old( select emp_id , emp_name, hire_date, salary
                    from employee
                    where hire_date < '00/01/01');

INSERT INTO emp_new( select emp_id , emp_name, hire_date, salary
                    from employee
                    where hire_date >= '00/01/01');
select * from emp_old;
select * from emp_new;

INSERT ALL 
    WHEN hire_date <'00/01/01' 
        THEN INTO emp_old 
            VALUES(emp_id, emp_name, hire_date, salary)
    WHEN hire_date >='00/01/01'
        THEN INTO emp_new
            VALUES(emp_id, emp_name, hire_date, salary)
select emp_id, emp_name, hire_date, salary
from employee;

--UPDATE ���̺��� ������ �����ϴ� ��
--  UPDATE table_name SET ������÷�=����ɰ�;
CREATE TABLE copy_dept 
    AS select * from department;

--�ѹ��� -> ������ȹ��
UPDATE copy_dept SET dept_title='������ȹ��', location_id='L1'
where dept_id='D9';

--UPDATE���� ���������� �̿��� �� ����
CREATE table emp_salary
AS select emp_id, emp_name, salary, bonus from employee;

UPDATE emp_salary SET bonus = ( select bonus from emp_salary
            where emp_name='������')
    where emp_id = ( select emp_id from emp_salary
            where emp_name='������');

--�μ��� ȸ������� �� ������� ���ʽ��� .4�� ����
CREATE table emp_salary1
AS select emp_id, emp_name, dept_code, salary, bonus
    from employee;

UPDATE emp_salary1
SET bonus=.4
where dept_code=(
    select dept_code from department
        where dept_title = 'ȸ�������');

select * from emp_salary1;

--�ѹ��� ����� ������ 100000�� ������Ű��
UPDATE emp_salary1
SET salary = (salary+100000)
where dept_code= (select dept_id from department
                where dept_title='�ѹ���');

--���� �� UPDATE
select emp_name, salary, bonus from emp_salary1
where emp_name in ('�����', '����');

UPDATE emp_salary1
SET (salary, bonus) = (select salary, bonus
from emp_salary1 where emp_name ='�����')
where emp_name = '����';

CREATE table emp_local
as select * from employee;

--�ٹ������� ������ ��� ���ʽ��� .5
UPDATE emp_local
SET bonus =.5
where dept_code = (select dept_id
    from department JOIN location ON location_id= local_code
        where local_name='EU');

select bonus from emp_local where dept_code='D8';

--MERGE �ΰ��� ���̺�����ġ�� �۾�
--  ���: row���� ����
--  MERGE INTO ���̺�� USING ���������̺��
--      ON (�����ұ��ذ�)
--  WHEN MATCHED THEN UPDATE����
--  WHEN NOT MATCHED THEN INSERT����
CREATE TABLE MERGE_TEST
    AS (select * from employee);

CREATE TABLE MERGE_TEST2
    AS (select * from employee where dept_code='D8');

select * from merge_test where dept_code ='D8';
select * from merge_test2;

INSERT INTO merge_test2
VALUES(998, '�ٹ�', '171230-1234555','baba@b.com',
    '01011112222', 'D2', 'J2', 'S2', 100, .1, 
    NULL, sysdate, DEFAULT, DEFAULT);

UPDATE merge_test2
SET salary=10, bonus=20
where dept_code='D8';

MERGE INTO merge_test USING merge_test2
ON(merge_test.emp_id = merge_test2.emp_id)
WHEN MATCHED THEN 
    UPDATE SET merge_test.salary = merge_test2.salary,
           merge_test.bonus = merge_test2.bonus
    --��� �÷� UPDATE SET(��� ������ ���� MERGE �Ϸ���)
    --merge_test.emp_name = merge_test2.emp_name, ...
WHEN NOT MATCHED THEN
    INSERT VALUES( merge_test2.EMP_ID, merge_test2.EMP_NAME, 
        merge_test2.EMP_NO, merge_test2.EMAIL, merge_test2.PHONE, 
        merge_test2.DEPT_CODE, merge_test2.JOB_CODE, merge_test2.SAL_LEVEL, 
        merge_test2.SALARY, merge_test2.BONUS, merge_test2.MANAGER_ID, 
        merge_test2.HIRE_DATE, merge_test2.ENT_DATE, merge_test2.ENT_YN);

select emp_name, dept_code, salary, bonus from merge_test
where dept_code='D8';

--DELETE: where���� pk �÷� �ַ� ��
DELETE from merge_test where emp_name='������';

ALTER TABLE EMPLOYEE ADD FOREIGN KEY(dept_code)
    REFERENCES DEPARTMENT(dept_id);

--ERROR!
--FOREIGN KEY VIOLATION
--  ORA-02291: integrity constraint 
--  (KH.SYS_C007055) violated - parent key not found
INSERT INTO EMPLOYEE(emp_id, emp_name, emp_no, 
        sal_level, dept_code, job_code)
    VALUES(997, '���', '990101-1311333', 'S2','D0', 'J2');

INSERT INTO EMPLOYEE(emp_id, emp_name, emp_no, 
        sal_level, dept_code, job_code)
    VALUES(997, '���', '990101-1311333', 'S2','D1', 'J2');

--NO RESULT!
select * from department where dept_id='D0';
select * from department where dept_id='D1';
select * from department where dept_id='D4';

--ERROR! - child record found!
DELETE from department where dept_id='D1';

--OK! Because 'D4' has NO CHILD RECORD!
DELETE from department where dept_id='D4';

--TRUNCATE (DELETE�� ������, ROLLBACK �ȵ�)
DELETE from merge_test;
ROLLBACK; --OK

TRUNCATE TABLE merge_test;
ROLLBACK; --CANNOT retrieve data...

--DDL
--  CREATE ������Ʈ ����
--  ALTER ������Ʈ ����
--  DROP ������Ʈ ����
--  ������Ʈ: table ,view, index, sequence, user ...
--���: CREATE ������Ʈ���� ������Ʈ��Ī
CREATE TABLE member1(
    mem_name VARCHAR2(20),
    mem_password VARCHAR2(30),
    mem_id VARCHAR2(20)
);

select * from member1;

--���̺� �÷��� �ּ��ޱ�.
COMMENT ON COLUMN member1.mem_name IS 'ȸ�� �̸�';
COMMENT ON COLUMN member1.mem_password IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN member1.mem_id IS 'ȸ�� ���̵�';

--select * from all_tab_comments where table_name='MEMBER1';
select * from user_col_comments where table_name='MEMBER1';

--CONSTRAINTS ��������
--  NOT NULL
--  UNIQUE
--  PRIMARY KEY(NOT NULL & UNIQUE)
--  FOREIGN KEY
--  CHECK

CREATE TABLE member2(
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_ID VARCHAR2(10) UNIQUE,
    MEM_PASSWORD varchar2(20));

--CONSTRAINT_TYPE='C' CHECK �Ǵ� NOT NULL
--CONSTRAINT_TYPE='R' FOREIGN KEY ������
--CONSTRAINT_TYPE='P' PRIMARY KEY ������
--CONSTRAINT_TYPE='U' UNIQUE ������

select * from user_cons_columns;
select * from user_constraints;
select table_name, constraint_name, constraint_type
    from user_constraints 
    where table_name in ('MEMBER1', 'MEMBER2');

--NOT NULL Ư�� �÷��� ������ �����͸� �־�� �� ��
--NULL�� ���� ���������� �������� ������ ������ NULL ���
--ID, PW, NO���� ���� �ݵ�� �ʿ�. NULL���� ����� ���� ����
CREATE TABLE user_ncons(
    user_no NUMBER NOT NULL,
    user_id VARCHAR2(30) NOT NULL,
    user_pw VARCHAR2(30) NOT NULL,
    user_name VARCHAR2(20),
    gender VARCHAR2(30),
    phone VARCHAR2(30),
    email VARCHAR2(50));

--ERROR! CONSTRAINTS
INSERT INTO user_ncons(user_no, user_id, user_pw) VALUES(1, NULL, NULL);
--OK
INSERT INTO user_ncons(user_no, user_id, user_pw) VALUES(1, 'admin', 1234);

--UNIQUE
CREATE TABLE user_nuni(
    user_no NUMBER NOT NULL,
    user_id VARCHAR2(30) NOT NULL,
    user_pw VARCHAR2(30) NOT NULL,
    user_name VARCHAR2(20),
    gender VARCHAR2(30),
    phone VARCHAR2(30),
    email VARCHAR2(50));
--DUPLICATES inserted
INSERT INTO user_nuni VALUES(
    1, 'admin', 1234, 'administrator', 'M', '01012345555', 'admin@a.com');
INSERT INTO user_nuni VALUES(
    2, 'admin', 1234, 'administrator2', 'F', '01012345555', 'admin@a.com');

select * from user_nuni;

--COLUMN LEVEL CONSTRAINTS
CREATE TABLE user_uni(
    user_no NUMBER NOT NULL,
    user_id VARCHAR2(30) NOT NULL UNIQUE,
    user_pw VARCHAR2(30) NOT NULL,
    user_name VARCHAR2(20),
    gender VARCHAR2(30),
    phone VARCHAR2(30),
    email VARCHAR2(50));

--TABLE LEVEL CONSTRAINTS DEFINITION - UNIQUE
--  UNIQUE, PK, FK can be defined in TABLE LEVEL
--  NOT NULL : can only be defined in COLUMN LEVEL definition
CREATE TABLE user_uni2(
    user_no NUMBER NOT NULL,
    user_id VARCHAR2(30) NOT NULL,
    user_pw VARCHAR2(30) NOT NULL,
    user_name VARCHAR2(20),
    gender VARCHAR2(30),
    phone VARCHAR2(30),
    email VARCHAR2(50),

    UNIQUE(user_id)
  --  UNIQUE(user_no, user_id) --unique pair
  --  NOT NULL(user_id) --NOT ALLOWED! ERROR!
);

INSERT INTO user_uni VALUES(
1, 'admin', 1234, 'administrator', 'M', '01012345555', 'admin@a.com');
--ERROR! ORA-00001: unique constraint (KH.SYS_C007066) violated
INSERT INTO user_uni VALUES(
2, 'admin', 1234, 'administrator2', 'F', '01012345555', 'admin@a.com');
--OK! NULL�� �ߺ� ��� �ȵ� -> NOT NULL CONSTRAINT�� NULL insert �����ؾ���.
INSERT INTO user_uni VALUES(
3, NULL, 1234, 'administrator2', 'F', '01012345555', 'admin@a.com');

select * from user_uni;
select * from user_uni2;

CREATE TABLE cons_uni_group(
    user_no NUMBER,
    user_id VARCHAR2(20),
    user_pw VARCHAR2(20),
    user_name VARCHAR2(30),

    UNIQUE(user_no, user_id)
);
--OK
INSERT INTO cons_uni_group VALUES(1, 'admin', '1234', 'administrator');
INSERT INTO cons_uni_group VALUES(2, 'admin', '1234', 'administrator');
INSERT INTO cons_uni_group VALUES(1, 'user01', '1234', 'administrator');
--ERROR! should be unique pair
INSERT INTO cons_uni_group VALUES(1, 'admin', '1234', 'administrator');

select * from cons_uni_group;

--PRIMARY KEY : distinguish rows
--  not null & unique - ONLY ONE can exist in a table.
-- INDEX is created for pk.
CREATE TABLE user_primary (
    user_no NUMBER PRIMARY KEY,
    user_id VARCHAR2(20),
    user_pw VARCHAR2(30),
    user_name VARCHAR2(20),
    gender VARCHAR2(30),
    phone VARCHAR2(30),
    email VARCHAR2(50)
);
--EQUIVALENT constraint deifinition
CREATE TABLE user_primary_tb (
    user_no NUMBER,
    user_id VARCHAR2(20),
    user_pw VARCHAR2(30),
    user_name VARCHAR2(20),
    gender VARCHAR2(30),
    phone VARCHAR2(30),
    email VARCHAR2(50),

    PRIMARY KEY(user_no)
);

--OK
INSERT INTO user_primary VALUES(
1, 'admin', '1234', 'administrator', 'M', '01012345555', 'admin@email.com');
INSERT INTO user_primary VALUES(
2, 'user01', '5555', 'administrator', 'F', '01012345555', 'admin@email.com');

--ERROR pk(not null)
INSERT INTO user_primary VALUES(
NULL, 'user01', '5555', 'administrator', 'F', '01012345555', 'admin@email.com');
--ERROR pk(unique)
INSERT INTO user_primary VALUES(
1, 'user01', '5555', 'administrator', 'F', '01012345555', 'admin@email.com');

select * from user_primary;

--PRIMARY KEY (COMPOSITE)
--  PRIMARY KEY ����Ű�� ���̺����� ����
--user(n), product(n) �̾��ִ� ���̺�� ���� ����
CREATE TABLE tbl_composite_key(
    proc_no VARCHAR2(20),
    user_id VARCHAR2(20),
    order_date DATE,
    order_num NUMBER,
    PRIMARY KEY(proc_no, user_id, order_date)
);
INSERT INTO tbl_composite_key VALUES('P111', 'user01', sysdate, 10);
INSERT INTO tbl_composite_key VALUES('P111', 'user01', sysdate, 10); --OK! SYSDATE differs every seconds

INSERT INTO tbl_composite_key VALUES('P111', 'user01', '19/06/25', 10);
INSERT INTO tbl_composite_key VALUES('P111', 'user01', '19/06/25', 10); --ERROR! DUPLICATE! fixed time(hr,min,sec all 0s)

select * from tbl_composite_key;


--FOREIGN KEY : �����Ǵ� �÷� �� NULL ����
--�ܺ� ���̺��� ���� �������°�!
--REFERENCE ������ �÷� �����ϸ�, �����ϴ� ���̺��� primary key�� ����!
CREATE TABLE user_grade(
    grade_no NUMBER PRIMARY KEY,
    grade_name VARCHAR2(10)
);

INSERT INTO user_grade VALUES(10, '�Ϲ�');
INSERT INTO user_grade VALUES(20, '�ǹ�');
INSERT INTO user_grade VALUES(30, '���');

select * from user_grade;

CREATE TABLE member_foreign(
    user_no NUMBER PRIMARY KEY,
    user_id VARCHAR2(20) NOT NULL UNIQUE,
    user_pw VARCHAR2(20) NOT NULL,
    user_name VARCHAR2(20),
    grade_no NUMBER,

    FOREIGN KEY(grade_no) REFERENCES user_grade(grade_no)
);

--ERROR - foreign key. (10,20,30) are allowed as 'grade_no'
INSERT INTO member_foreign VALUES(1, 'user01', '1234', 'baba', 50);
--OK
INSERT INTO member_foreign VALUES(1, 'user01', '1234', 'baba', 10);

select * from member_foreign;

--OMIT column name in a referenced table
--  In default, it references PK COLUMN of a referenced table
CREATE TABLE member_foreign1(
    user_no NUMBER PRIMARY KEY,
    user_id VARCHAR2(20) NOT NULL UNIQUE,
    user_pw VARCHAR2(20) NOT NULL,
    user_name VARCHAR2(20),
    grade_no NUMBER,

--  references PK column(grade_no) in default
    FOREIGN KEY(grade_no) REFERENCES user_grade
    --CONSTRAINT fk_grade_no FOREIGN KEY(grade_no) REFERENCES user_grade(grade_no)
);
--ERROR foregin key violated
INSERT INTO member_foreign1 VALUES(1, 'user01', '1234', 'baba', 50);
--OK
INSERT INTO member_foreign1 VALUES(1, 'user01', '1234', 'baba', 10);
INSERT INTO member_foreign1 VALUES(2, 'user02', '1234', 'baba', 30);

select * from member_foreign1;

CREATE TABLE member_foreign2(
    user_no NUMBER PRIMARY KEY,
    user_id VARCHAR2(20) NOT NULL UNIQUE,
    user_pw VARCHAR2(20) NOT NULL,
    user_name VARCHAR2(20),

    grade_no NUMBER REFERENCES user_grade
  --grade_no NUMBER REFERENCES user_grade(grade_no) --OK
    --FOREIGN KEY(grade_no) REFERENCES user_grade
);
--ERROR foregin key violated
INSERT INTO member_foreign2 VALUES(1, 'user01', '1234', 'baba', 50);
--OK
INSERT INTO member_foreign2 VALUES(1, 'user01', '1234', 'baba', 10);
INSERT INTO member_foreign2 VALUES(2, 'user02', '1234', 'baba', 30);

select * from member_foreign2;

CREATE TABLE member_foreign3(
    user_no NUMBER PRIMARY KEY,
    user_id VARCHAR2(20) NOT NULL UNIQUE,
    user_pw VARCHAR2(20) NOT NULL,
    user_name VARCHAR2(20),
    grade_no NUMBER,

    CONSTRAINT fk_grade_no FOREIGN KEY(grade_no) REFERENCES user_grade(grade_no)
);

CREATE TABLE user_tbl(
    user_id VARCHAR2(20) PRIMARY KEY,
    user_pw VARCHAR2(20) NOT NULL,
    user_name VARCHAR2(20) NOT NULL,
    email VARCHAR2(30) NOT NULL
);

CREATE TABLE product_tbl(
    pro_id VARCHAR2(20) PRIMARY KEY,
    pro_name VARCHAR2(20),
    price NUMBER
);

INSERT INTO user_tbl VALUES('USER01', '1234', 'auauau', 'aa@rr.com');
INSERT INTO user_tbl VALUES('USER02', '1234', 'bububu', 'bb@rr.com');
INSERT INTO user_tbl VALUES('USER03', '1234', 'cucucu', 'cc@rr.com');

INSERT INTO product_tbl VAlUES('F01', 'ħ��', 1000000);
INSERT INTO product_tbl VAlUES('F02', '��ǻ��', 1200000);
INSERT INTO product_tbl VAlUES('F03', '������', 2000000);

CREATE TABLE shop(
    user_id VARCHAR2(20),
    pro_id VARCHAR2(20),
    purchaseDay DATE
);

INSERT INTO shop VALUES('user03', 'f01', sysdate);

select * from shop;

--user_id ��ҹ��� �޶� ��ã��
select * from shop S
    LEFT JOIN user_tbl U ON S.user_id = U.user_id;

CREATE TABLE shop1(
    user_id VARCHAR2(20) NOT NULL REFERENCES user_tbl(user_id),
    pro_id VARCHAR2(20) NOT NULL REFERENCES product_tbl(pro_id),
    purchaseDay DATE
);

--ERROR! FOREIGN KEY rule violated
INSERT INTO shop1 VALUES('user03', 'f01', sysdate);
--OK
INSERT INTO shop1 VALUES('USER03', 'F01', sysdate);

select * from shop1 S
    LEFT JOIN user_tbl U ON S.user_id = U.user_id;

--FOREIGN KEY���� NULL ���Ե� �������� NOT NULL�� �߰�
INSERT INTO shop1 VALUES(NULL, NULL, sysdate);

select * from shop1;

select * from user_tbl;
select * from product_tbl;

--cannot delete (fk constraint and data parent&child exist)
delete from user_tbl where user_id = 'USER03';
--OK
delete from user_tbl where user_id = 'USER01';

--fk�� reference �ɷ��ִ� ������ ���� �ǵ���
--���̺� ������ �ɼ� ����
--����Ű�� ������ ���� �ɼ��� ������ �� ����
--  ON DELETE �ɼ�
--    SET NULL : NULL�� �ٲ���(�θ�reference �Ǿ��־ �ڽ��÷� NULL ��ȯ��)
--    SET CASCADE : �θ� �������� �ڽĵ����͵� ���� ����
select * from user_tbl;

CREATE TABLE shop2(
    user_id VARCHAR2(20) NOT NULL 
                         REFERENCES user_tbl(user_id) ON DELETE SET NULL,
    pro_id VARCHAR2(20) NOT NULL
                        REFERENCES product_tbl(pro_id) ON DELETE SET NULL,
    purchaseDay DATE
    --CONSTRAINT fk_user_id FOREIGN_KEY(user_id) REFERENCES user_tbl(user_id) ON DELETE SET NULL,
    --CONSTRAINT fk_pro_id FOREIGN_KEY(pro_id) REFERENCES product_tbl(pro_id) ON DELETE SET NULL
);

INSERT INTO shop2 VALUES('USER02', 'F01', sysdate);

select * from shop2;

--ERROR --shop1 has 'USER03'
DELETE from user_tbl where user_id='USER03';
--ERROR...  would be OK if NOT NULL CONSTRAINT is not set, 
--(since ON DELETE SET NULL is specified)
-- shop2 has 'USER02'
DELETE from user_tbl where user_id='USER02';

CREATE TABLE shop3(
    user_id VARCHAR2(20) REFERENCES user_tbl(user_id) ON DELETE SET NULL,
    pro_id VARCHAR2(20) REFERENCES product_tbl(pro_id) ON DELETE SET NULL,
    purchaseDay DATE
);

INSERT INTO shop3 VALUES('USER02', 'F01', sysdate);

--ERROR -- shop1 has 'USER03'
DELETE from user_tbl where user_id='USER03';
--OK user_id set to NULL
DELETE from user_tbl where user_id='USER02';

select * from shop3;

--CASCADE delete all regardless of Foreign Key references
CREATE TABLE shop4(
    user_id VARCHAR2(20) REFERENCES user_tbl(user_id) ON DELETE CASCADE,
    pro_id VARCHAR2(20) REFERENCES product_tbl(pro_id) ON DELETE CASCADE,
    purchaseDay DATE
);
INSERT INTO user_tbl VALUES('USER01', '123', 'lulu','lalala@la.com');
INSERT INTO shop4 VALUES('USER03', 'F02', sysdate);

DELETE from user_tbl where user_id='USER01';
DELETE from user_tbl where user_id='USER03';

select * from user_tbl;
select * from shop4;

--CHECK ��������: �����ͷ� �����°��� Ư�������� ����
CREATE TABLE check_tbl(
    username VARCHAR2(20),
    gender VARCHAR2(10) CHECK(gender in ('��','��'))
);
INSERT INTO check_tbl VALUES('�ٹٹ�', '����'); --ERROR
INSERT INTO check_tbl VALUES('�ٹٹ�', '��'); --OK

--SUBQUERY �̿��� CREATE TABLE
CREATE TABLE employee_tbl
AS select * from employee 
    JOIN department ON dept_id= dept_code
    JOIN job USING (job_code)
    JOIN location ON local_code = location_id;

select emp_name, dept_title, job_name from employee_tbl;

--�÷��� ���� WHERE 1=0
CREATE TABLE temp AS select emp_name, salary, bonus 
        from employee where 1=0;
select * from temp;

-- ALTER TABLE ���̺�� ADD (COL DataType);
-- ���̺� ������ ������ �߰� ����, ���� ������ �߰�/����
select * from user_tbl;

ALTER TABLE user_tbl ADD(age NUMBER);

ALTER TABLE user_tbl ADD(address VARCHAR2(30));

select * from user_tbl;

--COLUMN �߰��� DEFAULT �� ��������
CREATE TABLE defaulttest(
    age NUMBER default 10
);

INSERT INTO defaulttest VALUES(19);
INSERT INTO defaulttest VALUES(default);

select * from defaulttest;

--DEFAULT -> NOT NULL
--�÷� �߰��ϸ鼭 �������� ����
ALTER TABLE user_tbl ADD(
    national VARCHAR2(20) DEFAULT '�ѱ�');
ALTER TABLE user_tbl ADD(
    user_no VARCHAR2(20) UNIQUE);
ALTER TABLE user_tbl ADD(
    gender VARCHAR2(10) DEFAULT '��' check(gender in ('��','��')));

select * from user_tbl;


--�������� ���̺� ���� �Ŀ� ���� �߰�
CREATE TABLE add_cons(
    emp_no NUMBER,
    emp_id VARCHAR2(20),
    emp_pw VARCHAR2(20)
);

ALTER TABLE add_cons
ADD CONSTRAINT pk_add_cons PRIMARY KEY (emp_no);
 
--emp_id unique �������� ����!
ALTER TABLE add_cons
ADD CONSTRAINT unq_cons UNIQUE(emp_id);

--ERROR �ȵ�!
--emp_pwd not null �������� ����! 
--null able �⺻ ���������� null�� �̹� ���� �Ǿ� ����
--���������� �߰��ϴ� ���� �ƴ϶�, �̹� ������
--null -> not null;
--ERROR!!
ALTER TABLE add_cons
ADD CONSTRAINT nn_cons NOT NULL(emp_pw);
--OK
ALTER TABLE add_cons
MODIFY emp_pw CONSTRAINT nn_cons NOT NULL;

--�÷��� ������ ����(�ڷ���, ����)
ALTER TABLE add_cons
MODIFY emp_no VARCHAR2(20);


--emp_id ���̸� 100���� ����
--���̸� ����Ҷ�, ������ �����ϸ� ���� �Ұ�.
ALTER TABLE add_cons
MODIFY emp_id VARCHAR2(100);

--�÷� �����ϱ�
--ALTER TABLE ���̺�� DROP COLUMN �÷���
ALTER TABLE add_cons DROP COLUMN emp_pw;

--�������� ����
--ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�
select * from user_constraints;
--PK_ADD_CONS
--UNQ_CONS

ALTER TABLE add_cons DROP CONSTRAINT PK_ADD_CONS;

--�÷� ��Ī�� ����
--ALTER TABLE ���̺�� RENAME COLUMN ��� to ���氪
ALTER TABLE add_cons RENAME COLUMN emp_no TO no;
ALTER TABLE add_cons RENAME COLUMN no TO emp_no;

select * from add_cons;

--���̺� �̸� ����
ALTER TABLE add_cons RENAME TO add_training;
ALTER TABLE add_training RENAME TO add_cons;

select * from add_training;
select * from add_cons;

RENAME add_training TO add_cons;
RENAME add_cons TO add_training;

--���̺� ����
DROP TABLE add_cons;
DROP TABLE add_training;
DROP TABLE shop2;

--����� ����
DROP USER user_name;

--DCL(Data Control Language)
--�����Ϳ� ����, ����, ���� �� �����͸� �����ϴ� ����� ����
--grant(���Ѻο�), revoke(����ȸ��), 
--commit(������Ȯ��), rollback(�ǵ�����)

--GRANT ���Ѹ�(select, update, delete, ...) 
--  || role(���ѵ��� ����, �׷� ��Ű��ȭ e.g. resource)
-- TO ���user [option]
--  option = "with admin option"(�ο����� ������ �� �ٸ�������� �ο�����)
CONN sys/oracle

select * from dba_sys_privs
where GRANTEE='KH';  --tablespace ���̺� ���� �� �ִ� ����

select * from dba_role_privs
where GRANTEE='KH';

GRANT select, update ON scott.emp TO KH;

CONN kh/kh

select * from scott.emp;

UPDATE scott.emp SET comm=30 where empno=7934;

select * from user_sys_privs;
select * from user_role_privs;

REVOKE update ON scott.emp FROM kh;

--ROLE �ο��� ���Ѻ���
select * from dba_sys_privs
    where grantee in ('CONNECT', 'RESOURCE');

--VIEW ���� ���̺�
--  select ������ ����� ȭ�鿡 ��� ��ü
--  select ���� ��ü�� �����Ͽ� ȣ���� ������ �ش����� ����
--  ���������� DB�� �����ϰ� ���� ����.
--  �˻��� ȿ����: ���� ã���� �ϴ� ������ ��ȸ
--  ���ȼ�: ���̺��� ������ ���� �� ����
--  CREATE or REPLACE VIEW view_name[col1 ��Ī1, col2 ��Ī2, ...]
--      AS (select emp_id, emp_name, dept_code from employee);
--  SELECT * from view_name;
--  GRANT CREATE VIEW To db_user; --VIEW �� GRANT ���� �ο�(conn system/oracle)
CONN system/oracle
GRANT CREATE VIEW TO KH;
CONN kh/kh

CREATE OR REPLACE VIEW view_emp AS (
    select emp_id, emp_name, email, phone, job_code, sal_level
    from employee);

select * from view_emp;

select * from user_views where view_name='VIEW_EMP';

--���, �̸�, ���޸�, �μ���, �ٹ�������
--v_resultset_emp ��� �信
CREATE OR REPLACE VIEW v_resultset_emp AS(
    select emp_id AS ���, emp_name, J.job_name, D.dept_title, L.local_name
        from employee E
            LEFT JOIN job J USING (job_code)
            LEFT JOIN department D ON E.dept_code = D.dept_id
            LEFT JOIN location L ON D.location_id = L.local_code);

select * from v_resultset_emp V where V.��� = '205';

--TABLE ����� VIEW���� �Բ� �����: VIEW���� '���߾�'
--  VIEW���� �������� ����Ǿ� �����Ƿ�.
UPDATE employee  SET emp_name='���߾�' WHERE emp_id='205';
select * from v_resultset_emp V where V.��� = '205';

--VIEW Ư¡
--1.�÷��� �ƴ϶�, ������� ó���� view ������ ����
CREATE OR REPLACE VIEW view_emp_salary AS(
    select emp_name AS �����, 12*salary*(1+nvl(bonus,0)) AS ����
    from employee);

select * from view_emp_salary;

--JOIN �� �̿��� view�� ���� ����
--employee���� ���, ����̸�, ����, �μ���
--�÷�(����NULL -> ����) view_emp_read
CREATE OR REPLACE VIEW view_emp_read AS(
    select emp_id, emp_name, nvl(job_name, '����') AS ����, dept_title
    from employee
        LEFT JOIN department ON dept_code= dept_id
        LEFT JOIN job USING (job_code));

select * from view_emp_read;

--VIEW������ ������ �߰�,����,������ ����
-- ���� 6���� ��Ȳ������ �Ұ���
--1. �信 ���ǵ��� ���� �÷� ����
--2. �信 ������ �ʴ� �÷� �� NOT NULL �������� ���� �÷� �������
--3. ��� ������ ����� �÷��� ���� ���
--4. JOIN�� ���� �������̺��� ������ ���
--    ��ȸ�� ���̺��� ���� �߿� �⺻Ű�� 
--    �� �Ѱ��� ���� ���� ����
--5. DISTINCT�� ����Ͽ� ���� �������� ������ ��Ȯ���� ���� ���
--6. �׷��Լ��� GROUP BY ������ ����ؼ� ��ȸ�� ������ ���
UPDATE view_emp SET emp_no='881123-2000123' where emp_id=500; 
DELETE FROM view_emp where emp_id=500;

select * from view_emp where emp_name='������';

--1. �信 ���ǵ��� ���� �÷��� ����
CREATE OR REPLACE VIEW V_JOB AS(
    select job_code from job);

INSERT INTO v_job VALUES('J8', '����'); --ERROR
UPDATE v_job SET job_name='����' where job_code is null; --ERROR

--2. �信 ������ �ʴ� �÷� ��
--   NOT NULL �������� ���� �÷� �������
--VIEW�� DML ���: ������ VIEW�� ������ DML ������ ��� ����
--  DML ������ ������ view ���̺� ������ �����ϸ� ���� ���̺� ����
--vim_emp -> emp_id, emp_name, email, phone, job_code, sal_level
--ORA-01400: cannot insert NULL into ("KH"."EMPLOYEE"."EMP_NO")
CREATE OR REPLACE VIEW view_emp AS (
    select emp_id, emp_name, email, phone, job_code, sal_level
    from employee);
--ERROR
INSERT INTO view_emp VALUES(500, '������', 'kang@a.com', 
            '01012345555', 'J5', 'S3');
DROP VIEW view_emp;

CREATE OR REPLACE VIEW view_emp AS (
    select emp_id, emp_no, emp_name, email, phone, job_code, sal_level
    from employee);
--OK! EMPLOYEE ���̺��� �����Ͱ� �߰���!!!
INSERT INTO view_emp VALUES(500, '790626-1034555', '������', 'kang@a.com', 
            '01012345555', 'J5', 'S3');

--����! VIEW�� INSERT�ϸ� TABLE �����͵� �Բ� �����!
DELETE FROM view_emp where emp_name='������';
DELETE FROM EMPLOYEE where emp_name='������';
select * from view_emp;
select * from view_emp where emp_name='������';
select * from employee where emp_name='������';

--3. ��� ������ ����� �÷��� ���� ���
CREATE OR REPLACE VIEW v_emp_sal AS(
    select emp_id, emp_name, salary, 
           12*salary*(1+nvl(bonus,0)) AS ����
    from employee);

--ERROR! virtual column not allowed here
INSERT INTO v_emp_sal VALUES(901, '���︸', 3000000,40000000);

--4. JOIN�� ���� �������̺��� ������ ���
CREATE OR REPLACE VIEW v_join_emp AS(
    select emp_id, emp_name, dept_title from employee
        LEFT JOIN department ON dept_id=dept_code);

INSERT INTO v_join_emp VALUES(911, '�����', '���������'); --ERROR
UPDATE v_join_emp SET dept_title='���������' where emp_id=218; --ERROR

--4-1 ��ȸ�� ���̺��� ���� �߿� �⺻Ű�� �� �Ѱ��� ���� ���� ����
--OK
DELETE from v_join_emp where dept_title = '���������';
ROLLBACK;
COMMIT;

select * from v_join_emp;
select * from department;
select * from employee;

--5. DISTINCT�� ����Ͽ� ���� �������� ������ ��Ȯ���� ���� ���
CREATE OR REPLACE VIEW v_dept_emp AS (
    select distinct dept_code from employee);
INSERT INTO v_dept_emp VALUES('D0'); --ERROR
DELETE FROM v_dept_emp where dept_code='D9'; --ERROR --  ��� �����͸� ������ distinct ������ �Ҹ�Ȯ��.

select * from v_dept_emp;

--6. �׷��Լ��� GROUP BY ������ ����ؼ� ��ȸ�� ������ ���
CREATE OR REPLACE VIEW v_group_dept AS (
    select dept_code, SUM(salary) AS �հ�, TRUNC(AVG(salary),-4) AS ���
    from employee GROUP BY dept_code);
--ERROR : virtual column not allowed here
INSERT INTO v_group_dept VALUES('D10', 50000, 50000);
UPDATE v_group_dept SET dept_code='D10' where dept_code='D5';
DELETE FROM v_group_dept where dept_code='D6';


--VIEW ������ ������ �� �ִ� �ɼ�
--  OR REPLACE: ���� �� �̸� �並 replace(�����)
--  FORCE / NO FORCE : ���������� �ҿ��
--      ���̺��� ��� �ϴ� VIEW�� ����(force)
--  WITH CHECK / READ ONLY:
--      CHECK: ������ �÷����� ���� ���ϰ� ����
--      READ ONLY: �信�� � �÷��� VIEW�� ���ؼ� �������� ���ϵ���
CREATE OR REPLACE FORCE VIEW v_emp AS (
    select t_code, t_name, t_content from test_table);

select * from v_emp;
select * from user_views where view_name = 'V_EMP';
DROP VIEW v_emp;

--NO FORCE ������ view�� ���̺��� ���� ���� ������,�並 �������� �ʰڴ�.
-- ������ ���� NOFORCE
CREATE OR REPLACE NOFORCE VIEW v_emp AS (
    select t_code, t_name, t_content from test_table);

--WITH CHECK ���� �÷��� ���� ���ϰ�.
CREATE OR REPLACE VIEW v_emp AS
    select * from employee WITH CHECK OPTION;

--ERROR! CHECK option������
INSERT INTO v_emp VALUES(810, '������', '101010-1234567',
            'ryu@kh.co.kr', '01012345555', 'D1', 'J7', 'S1',
            800000, .1, 200, SYSDATE, NULL, DEFAULT);
select * from v_emp;

--DELETE�� ����
DELETE from v_emp where emp_id=500;

--WITH READ ONLY: ������ �Է�/����/���� ���� ����
CREATE OR REPLACE VIEW v_emp AS
    select * from employee WITH READ ONLY;

--ERROR
INSERT INTO v_emp VALUES(810, '������', '101010-1234567',
            'ryu@kh.co.kr', '01012345555', 'D1', 'J7', 'S1',
            800000, .1, 200, SYSDATE, NULL, DEFAULT);
DELETE from v_emp where t_id=200;
DELETE from v_emp where emp_id='200';

--SEQUENCE
--1,2,3,4,5 �̷��� �������� ���� �����͸� 
-- �ڵ����� ī��Ʈ �ϴ� ��ü
--CREATE sequence ��������
--  [INCREMENT BY ����] : �������� ���� ������ġ. ������, 1�� ����
--  INCREMENT BY 5;
--  INCREMENT BY -5;
--  [START WITH ����] : ���۰�. ������ 1�� ����
--  [MAX VALUE ���� | NOMAXVALUE] : �߻� ��ų ���� �ִ밪 ����
--      10^27-1 ���� ����
--  [MIN VALUE ���� | NOMINVALUE] : �ּҰ� ����
--      -10^26
--  [CYCLE | NOCYCLE] ���� ��ȯ ����
--  [CACHE ����Ʈ ũ�� | NOCACHE] ���� �̸� ���س���,
--      �������� �ݿ��� �� Ȱ���ϴ� ����
--      �⺻�� 20Byte | �ּҰ� 2Byte

CREATE SEQUENCE seq_empid
START WITH 300
INCREMENT BY 5
MAXVALUE 320
NOCYCLE
NOCACHE;

select seq_empid.nextval from dual;
select seq_empid.currval from dual;

--START WITH �������� �ٲ� �� ����
ALTER SEQUENCE seq_empid
--START WITH 300
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

select * from user_sequences;

--SEQUENCE:
--  SELECT �������� ������ ��ȸ�� ��밡��
--  INSERT UPDATE������ ��밡��
--  VIEW������ sequence ���Ұ�

--������ �����ϱ�
DROP SEQUENCE seq_empid;

CREATE SEQUENCE seq_eid
START WITH 300
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

select seq_eid.nextval from dual;
select seq_eid.currval from dual;
DROP SEQUENCE seq_eid;
select * from user_sequences;

--������ �߰�
INSERT INTO EMPLOYEE VALUES(
    seq_eid.NEXTVAL, '���ֹ�', '121203-1234567',
    'song@kh.co.kr', '01012334556', 'D2', 'J7',
    'S1', 5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
);

select emp_id, emp_name, dept_code, job_code, sal_level
from employee where emp_name='���ֹ�';

--D9�μ��� J7 ������ ��� 4���� �������� Ȱ���Ͽ� �߰�
INSERT INTO EMPLOYEE VALUES( seq_eid.NEXTVAL, 'AGENT1', '881111-1234567',
    'agent1@kh.co.kr', '01012334556', 'D9', 'J7',
    'S1', 9000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
);
INSERT INTO EMPLOYEE VALUES( seq_eid.NEXTVAL, 'AGENT2', '891111-1234567',
    'agent2@kh.co.kr', '01012334556', 'D9', 'J7',
    'S1', 9000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
);
INSERT INTO EMPLOYEE VALUES( seq_eid.NEXTVAL, 'AGENT3', '821111-1234567',
    'agent3@kh.co.kr', '01012334556', 'D9', 'J7',
    'S1', 9000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
);
INSERT INTO EMPLOYEE VALUES( seq_eid.NEXTVAL, 'AGENT4', '831010-1234567',
    'agent4@kh.co.kr', '01012334556', 'D9', 'J7',
    'S1', 9000000, 0.1, 200, SYSDATE, NULL, DEFAULT);
);

select * from employee
where emp_name like '%AGENT%';

--SEQUENCE �ɼ� CYCLE/CACHE
--  CYCLE : ������ ���� �ִ�/�ּҰ� ����������, 
--      �ٽ� �ݴ� ������ �����ϴ� �ɼ�
CREATE SEQUENCE seq_cycle
START WITH 200
INCREMENT BY 10
MAXVALUE 230
MINVALUE 15
CYCLE
NOCACHE;

--ERROR! SEQ_CYCLE.CURRVAL is not yet defined in this session
select seq_cycle.currval from dual;
--after nextval executed first time
select seq_cycle.nextval from dual;

DROP SEQUENCE seq_cycle;

select * from user_sequences;

--CACHE / NOCACHE

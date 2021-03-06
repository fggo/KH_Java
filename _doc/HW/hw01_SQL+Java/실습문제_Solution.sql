-----叔柔庚薦-----
--1
select emp_name AS 戚硯, email AS 戚五析, length(email) AS 戚五析掩戚 from employee;

--2
select emp_name AS 戚硯, substr(email, 1, instr(email, '@')-1) AS 戚五析焼戚巨 from employee;

--3
select emp_name AS 送据誤,
    TO_NUMBER(substr(emp_no,1,2))+1900 AS 鰍持,
    nvl(bonus, 0) AS 左格什
from employee
where substr(emp_no,1,1) =6;

--4
select count(*) ||'誤' AS 昔据
from employee
where substr(phone,1,3) !='010';

--5
select emp_name as 送据誤,
    EXTRACT(year from hire_date) || '鰍 ' 
        || EXTRACT(month from hire_date) || '杉' as 脊紫鰍杉
from employee;

--6
select emp_name AS 送据誤,
    RPAD(substr(emp_no,1,8), 13, '*') AS 爽肯腰硲
from employee;

--7
select emp_name 送据誤, dept_code 送厭坪球, 
    TO_CHAR(salary, 'L999,999,999') AS 尻裟
from employee;

--8
select emp_id 紫腰,
    emp_name 紫据誤,
    dept_code 採辞坪球,
    hire_date 脊紫析
from employee
where dept_code in('D5', 'D9')
    and EXTRACT(year from hire_date) = 2004;

--9
select emp_name 送据誤,
    hire_date 脊紫析,
    TO_CHAR(FLOOR(sysdate-hire_date), '999,999') ||'析' 悦巷析呪
from employee;

--10. 送据誤, 採辞坪球, 持鰍杉析, 蟹戚(幻) 繕噺
--   舘, 持鰍杉析精 爽肯腰硲拭辞 蓄窒背辞, 
--   しししし鰍 しし杉 しし析稽 窒径鞠惟 敗.
--   蟹戚澗 爽肯腰硲拭辞 蓄窒背辞 劾促汽戚斗稽 痕発廃 陥製, 域至敗
--	* 爽肯腰硲亜 戚雌廃 紫寓級精 薦須獣徹壱 遭楳 馬亀系(200,201,214 腰 薦須)
--	* HINT : NOT IN 紫遂
select emp_name AS 送据誤,
    dept_code AS 採辞誤,
    TO_DATE(substr(emp_no, 1,6)) AS 持鰍杉析,
    TO_NUMBER(EXTRACT(year from sysdate))
        - TO_NUMBER(substr(emp_no,1,2)
            + CASE WHEN substr(emp_no, 8,1) in (1,2) THEN 1900
                    ELSE 2000 END) 
        + TO_NUMBER( CASE WHEN REPLACE(substr(sysdate,4), '/', '')
                        - substr(emp_no, 3,4) > 0 THEN 0 ELSE -1 END)
            AS "蟹戚(幻)"
from employee
where emp_id not in (200, 201,214);

--11
select emp_name 紫据誤, dept_code 採辞坪球,
    CASE WHEN dept_code='D5' THEN '恥巷採'
        WHEN dept_code='D6' THEN '奄塙採'
        WHEN dept_code='D9' THEN '慎穣採' END
    AS 採辞誤
from employee
where dept_code in ('D5', 'D6','D9')
order by dept_code;

--12
select job_code 送厭, count(*) 昔据呪, 
TO_CHAR(FLOOR(avg(salary)), 'L999,999,999') 汝液厭食
from employee
where job_code != 'J1'
group by job_code
order by job_code;

--13
select EXTRACT(year from hire_date) 脊紫鰍亀, count(*) 昔据呪
from employee
where job_code != 'J1'
GROUP BY EXTRACT(year from hire_date)
order by EXTRACT(year from hire_date);

--14
select
    CASE WHEN substr(emp_no, 8,1) in (1,3) THEN '害'
        WHEN substr(emp_no, 8,1) in (2,4) THEN '食' END
            AS 失紺,
    TO_CHAR(FLOOR(avg(salary)), 'L999,999,999') 厭食汝液,
    TO_CHAR(sum(salary), 'L999,999,999') 厭食杯域,
    count(*) 昔据呪
from employee
GROUP BY
    CASE WHEN substr(emp_no, 8,1) in (1,3) THEN '害'
        WHEN substr(emp_no, 8,1) in (2,4) THEN '食' END
order by count(*);

--15
select dept_code 採辞坪球, job_code 送厭坪球, count(*) 昔据呪
from employee
GROUP BY dept_code, job_code
HAVING count(*) >= 3
order by dept_code, job_code;


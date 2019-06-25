--16
select G.class_no, C.class_name, ROUND(AVG(point),8)
from tb_grade G
    JOIN tb_class C ON G.class_no = C.class_no
    JOIN tb_department D ON C.department_no = D.department_no
where D.department_name='ȯ�������а�'
GROUP BY G.class_no, C.class_name
order by G.class_no;

--17
select S1.student_name, S1.student_address
from tb_student S1 JOIN tb_student S2 USING(department_no)
where S2.student_name='�ְ���';

--18
--select S1.student_no, student_name, G.point
--from tb_student S1 
--    JOIN tb_department D USING (department_no)
--    JOIN tb_grade G ON S1.student_no = G.student_no
--where department_name='������а�';

-- MyBatis

--SELECT * FROM TAB;
--select * from user_constraints;
SELECT * FROM STUDENT;

CREATE TABLE STUDENT(
  STUDENT_NO NUMBER PRIMARY KEY,
  STUDENT_NAME VARCHAR2(30) NOT NULL,
  STUDENT_TEL CHAR(11) NOT NULL,
  STUDENT_EMAIL VARCHAR2(50),
  STUDENT_ADDR VARCHAR2(256),
  REG_DATE DATE DEFAULT SYSDATE
);
COMMIT;
--�ڷ���
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
    VALUES(1234.567,
        1234.567,
        1234.567,
        1234.567,
        1234.567);


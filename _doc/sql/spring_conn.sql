
SELECT * FROM DEV;
SELECT * FROM MEMBER;
select * from board;
select * from attachment;

INSERT INTO SPRING.MEMBER VALUES ('abcde','1234','아무개','M',25,'abcde@naver.com','01012345678','서울시 강남구','운동,등산,독서',DEFAULT);
INSERT INTO SPRING.MEMBER VALUES ('qwerty','1234','김말년','F',30,'qwerty@naver.com','01098765432','서울시 관악구','운동,등산',DEFAULT);
INSERT INTO SPRING.MEMBER VALUES ('admin','1234','관리자','F',33,'admin@naver.com','01012345678','서울시 강남구','독서',DEFAULT);

commit;

CREATE TABLE DEV (
  DEVNO NUMBER PRIMARY KEY,
  DEVNAME VARCHAR2(50) NOT NULL,
  DEVAGE NUMBER,
  DEVEMAIL VARCHAR2(100) NOT NULL,
  DEVGENDER CHAR(1) CHECK(DEVGENDER IN ('M','F')),
  DEVLANG VARCHAR2(100) NOT NULL
);

CREATE TABLE MEMBER(
  USERID VARCHAR2(15) PRIMARY KEY
 ,PASSWORD VARCHAR2(300) NOT NULL
 ,USERNAME  VARCHAR2(20) NOT NULL
 ,GENDER CHAR(1) CHECK (GENDER IN ('M','F'))
 ,AGE NUMBER
 ,EMAIL VARCHAR2(30)
 ,PHONE CHAR(11)  NOT NULL
 ,ADDRESS VARCHAR2(100)
 ,HOBBY VARCHAR2(50)
 ,ENROLLDATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_DEV_NO
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
NOCACHE;

--MEMO
--select * from memo

CREATE TABLE MEMO(
    MEMONO NUMBER PRIMARY KEY,
    MEMO VARCHAR2(2000),
    PASSWORD VARCHAR2(4),
    MEMODATE DATE DEFAULT SYSDATE
);

CREATE SEQUENCE SEQ_MEMONO
    START WITH 1
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    NOCYCLE
    NOCACHE;

INSERT INTO MEMO VALUES(SEQ_MEMONO.NEXTVAL, '반갑습니다. AOP', '1234', DEFAULT);


commit;

select * from board;
CREATE TABLE BOARD (   
            "BOARDNO" NUMBER, 
            "BOARDTITLE" VARCHAR2(50), 
            "BOARDWRITER" VARCHAR2(15),
            "BOARDCONTENT" VARCHAR2(2000), 
            "BOARDDATE" DATE DEFAULT SYSDATE, 
            "BOARDREADCOUNT" NUMBER DEFAULT 0, 
            CONSTRAINT PK_BOARDNO PRIMARY KEY(BOARDNO),
            CONSTRAINT FK_BOARDWRITER FOREIGN KEY(BOARDWRITER) REFERENCES MEMBER(USERID) ON DELETE SET NULL
        );
        
 COMMENT ON COLUMN "BOARD"."BOARDNO" IS '게시글번호';
        COMMENT ON COLUMN "BOARD"."BOARDTITLE" IS '게시글제목';
        COMMENT ON COLUMN "BOARD"."BOARDWRITER" IS '게시글작성자 아이디';
        COMMENT ON COLUMN "BOARD"."BOARDCONTENT" IS '게시글내용';
        COMMENT ON COLUMN "BOARD"."BOARDDATE" IS '게시글올린날짜';
        COMMENT ON COLUMN "BOARD"."BOARDREADCOUNT" IS '조회수';
        
CREATE SEQUENCE SEQ_BOARDNO
        START WITH 1
        INCREMENT BY 1
        NOMINVALUE
        NOMAXVALUE
        NOCYCLE
        NOCACHE;
CREATE TABLE ATTACHMENT (
            ATTACHMENTNO NUMBER PRIMARY KEY,
            BOARDNO NUMBER NOT NULL,
            ORIGINALFILENAME VARCHAR2(255) NOT NULL,
            RENAMEDFILENAME VARCHAR2(255) NOT NULL,
            UPLOADDATE DATE DEFAULT SYSDATE,
            DOWNLOADCOUNT NUMBER DEFAULT 0,
            STATUS VARCHAR2(1) DEFAULT 'Y',
            CONSTRAINT FK_BOARDNO FOREIGN KEY(BOARDNO) REFERENCES BOARD(BOARDNO) ON DELETE CASCADE
        );
        COMMENT ON COLUMN ATTACHMENT.ATTACHMENTNO IS '첨부파일번호(PK)';
        COMMENT ON COLUMN ATTACHMENT.BOARDNO IS '게시판글번호(FK)';
        COMMENT ON COLUMN ATTACHMENT.ORIGINALFILENAME IS '업로드한 첨부파일명';
        COMMENT ON COLUMN ATTACHMENT.RENAMEDFILENAME IS '서버에 저장된 첨부파일명';
        COMMENT ON COLUMN ATTACHMENT.UPLOADDATE IS '업로드일자';
        COMMENT ON COLUMN ATTACHMENT.DOWNLOADCOUNT IS '다운로드 횟수';
        COMMENT ON COLUMN ATTACHMENT.STATUS IS '사용여부';
CREATE SEQUENCE SEQ_ATTACHMENTNO
        START WITH 2
        INCREMENT BY 1
        NOMINVALUE
        NOMAXVALUE
        NOCYCLE
        NOCACHE;
        
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 1','abcde','반갑습니다',to_date('18/02/10','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 2','qwerty','안녕하세요',to_date('18/02/12','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 3','admin','반갑습니다',to_date('18/02/13','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 4','abcde','안녕하세요',to_date('18/02/14','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 5','qwerty','반갑습니다',to_date('18/02/15','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 6','admin','안녕하세요',to_date('18/02/16','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 7','abcde','반갑습니다',to_date('18/02/17','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 8','qwerty','안녕하세요',to_date('18/02/18','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 9','admin','반갑습니다',to_date('18/02/19','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 10','abcde','안녕하세',to_date('18/02/20','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 11','qwerty','반갑습니다',to_date('18/03/11','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 12','admin','안녕하세',to_date('18/03/12','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 13','abcde','반갑습니다',to_date('18/03/13','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 14','qwerty','안녕하세',to_date('18/03/14','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 15','admin','반갑습니다',to_date('18/03/15','RR/MM/DD'),0);


Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 16','abcde','안녕하세',to_date('18/03/16','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 17','qwerty','반갑습니다',to_date('18/03/17','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 18','admin','안녕하세',to_date('18/03/18','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 19','abcde','반갑습니다',to_date('18/03/19','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 20','qwerty','안녕하세',to_date('18/03/20','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 21','admin','반갑습니다',to_date('18/04/01','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 22','abcde','안녕하세',to_date('18/04/02','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 23','qwerty','반갑습니다',to_date('18/04/03','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 24','admin','안녕하세',to_date('18/04/04','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 25','abcde','반갑습니다',to_date('18/04/05','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 26','qwerty','안녕하세',to_date('18/04/06','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 27','admin','반갑습니다',to_date('18/04/07','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 28','abcde','안녕하세',to_date('18/04/08','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 29','qwerty','반갑습니다',to_date('18/04/09','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 30','admin','안녕하세',to_date('18/04/10','RR/MM/DD'),0);

Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 31','abcde','반갑습니다',to_date('18/04/16','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 32','qwerty','안녕하세',to_date('18/04/17','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 33','admin','반갑습니다',to_date('18/04/18','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 34','abcde','안녕하세',to_date('18/04/19','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 35','qwerty','반갑습니다',to_date('18/04/20','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 36','admin','안녕하세',to_date('18/05/01','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 37','abcde','반갑습니다',to_date('18/05/02','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 38','qwerty','안녕하세',to_date('18/05/03','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 39','admin','반갑습니다',to_date('18/05/04','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 40','abcde','안녕하세',to_date('18/05/05','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 41','qwerty','반갑습니다',to_date('18/05/06','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 42','admin','안녕하세',to_date('18/05/07','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 43','abcde','반갑습니다',to_date('18/05/08','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 44','qwerty','안녕하세',to_date('18/05/09','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 45','admin','반갑습니다',to_date('18/05/10','RR/MM/DD'),0);

Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 46','abcde','안녕하세',to_date('18/05/16','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 47','qwerty','반갑습니다',to_date('18/05/17','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 48','admin','안녕하세',to_date('18/05/18','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 49','abcde','반갑습니다',to_date('18/05/19','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 50','qwerty','안녕하세',to_date('18/05/20','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 51','admin','반갑습니다',to_date('18/05/01','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 52','abcde','안녕하세',to_date('18/06/02','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 53','qwerty','반갑습니다',to_date('18/06/03','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 54','admin','안녕하세',to_date('18/06/04','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 55','abcde','반갑습니다',to_date('18/06/05','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 56','qwerty','안녕하세',to_date('18/06/06','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 57','admin','반갑습니다',to_date('18/06/07','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 58','abcde','안녕하세',to_date('18/06/08','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 59','qwerty','반갑습니다',to_date('18/06/09','RR/MM/DD'),0);
Insert into SPRING.BOARD (BOARDNO,BOARDTITLE,BOARDWRITER,BOARDCONTENT,BOARDDATE,BOARDREADCOUNT) values (SEQ_BOARDNO.nextval,'안녕하세요, 게시판입니다 - 60','admin','안녕하세',to_date('18/06/10','RR/MM/DD'),0);
commit;
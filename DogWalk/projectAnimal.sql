/* ȸ�� */
DROP TABLE MEMBERS 
	CASCADE CONSTRAINTS;

/* ȸ�� */
CREATE TABLE MEMBERS (
	NICK VARCHAR2(40) NOT NULL, /* �г��� */
	IDX NUMBER(8) NOT NULL, /* ȸ����ȣ */
	RRN2 CHAR(7) NOT NULL, /* �ֹι�ȣ2 */
	USERID VARCHAR2(40) NOT NULL, /* ���̵� */
	NAME VARCHAR2(30) NOT NULL, /* �̸� */
	PWD VARCHAR(100) NOT NULL, /* ��й�ȣ */
	HP1 CHAR(3) NOT NULL, /* �޴���1 */
	HP2 CHAR(4) NOT NULL, /* �޴���2 */
	HP3 CHAR(4) NOT NULL, /* �޴���3 */
	POST CHAR(5), /* �����ȣ */
	ADDR1 VARCHAR2(100), /* �ּ�1 */
	ADDR2 VARCHAR2(100), /* �ּ�2 */
	INDATE DATE, /* ���Գ�¥ */
	STATUS NUMBER(10), /* ȸ������ */
	RRN1 CHAR(6) NOT NULL, /* �ֹι�ȣ1 */
	MAIL VARCHAR2(100), /* ���� */
	SNSTYPE VARCHAR2(50) /* sns�ΰ��Կ��� */
);

ALTER TABLE MEMBERS
   ADD
      CONSTRAINT PK_MEMBERS1
      PRIMARY KEY (
         RRN2
      );
      
ALTER TABLE MEMBERS
   ADD
      CONSTRAINT PK_MEMBERS2
      PRIMARY KEY (
         USERID
      );
      
ALTER TABLE MEMBERS
   ADD
      CONSTRAINT PK_MEMBERS3
      PRIMARY KEY (
         IDX
      );

ALTER TABLE MEMBERS ADD CONSTRAINT UK_MEMBERS1 UNIQUE(USERID) ; 

ALTER TABLE MEMBERS ADD CONSTRAINT UK_MEMBERS2 UNIQUE(NICK) ; 

   
create sequence MEMBERS_seq
start with 1
increment by 1
nocache;

/* ���� */
DROP TABLE com_ani_board 
   CASCADE CONSTRAINTS;

/* ���� */
CREATE TABLE com_ani_board (
   cnum NUMBER(8) NOT NULL, /* �۹�ȣ */
   userid varchar2(20) not null,
   nick VARCHAR2(30) NOT NULL, /* �г��� */
   cpass VARCHAR2(20), /* �ۺ�й�ȣ */
   title VARCHAR2(200) NOT NULL, /* ������ */
   content VARCHAR2(2000), /* �۳��� */
   wdate DATE default sysdate, /* �ۼ��� */
   cnt NUMBER(8) default 0, /* ��ȸ�� */
   filename VARCHAR2(500), /* ÷�����ϸ� */
   originFilename VARCHAR2(500), /* �������ϸ� */
   filesize NUMBER(8), /* ÷������ ũ�� */
   pet VARCHAR2(30), /* ���� */
   price NUMBER(8), /* ����(���û���) */
   myaddr VARCHAR2(30) /* �����ٵ��� */
);


create sequence com_ani_board_seq
start with 1
increment by 1
nocache;

CREATE UNIQUE INDEX PK_com_ani_board
   ON com_ani_board (
      cnum ASC
   );

ALTER TABLE com_ani_board
   ADD
      CONSTRAINT PK_com_ani_board
      PRIMARY KEY (
         cnum
      );
 ALTER TABLE com_ani_board
	ADD
		CONSTRAINT FK_USER_TO_com_ani_board -- ȸ�� -> ����/�˻� 
		FOREIGN KEY (
			NICK -- USERID
		)
		REFERENCES MEMBERS ( -- ȸ��
			NICK -- USERID
		)
		ON DELETE CASCADE; 
 ALTER TABLE com_ani_board
	ADD
		CONSTRAINT FK_USER_TO_com_ani_board -- ȸ�� -> ����/�˻� 
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- ȸ��
			USERID -- USERID
		)
		ON DELETE CASCADE; 
-------PET-----------

DROP TABLE PET 
   CASCADE CONSTRAINTS;

CREATE TABLE PET (
	PETINDEX  INT  PRIMARY KEY , -- �����ĺ���ȣ
	USERID    VARCHAR(40)  NOT NULL, -- USERID
	MCATEGORY VARCHAR(20)  NOT NULL, -- ��з��ڵ�
	SCATEGORY VARCHAR(20)  NOT NULL, -- �Һз��ڵ�
	PETNAME   VARCHAR(20)  NOT NULL, -- �ݷ�������
	SEX       VARCHAR(20)  NOT NULL, -- ����
	AGE       INT    NOT NULL, -- ����
	PETSIZE      VARCHAR(20)  NOT NULL, -- ũ��
	WEIGHT    VARCHAR(40)  NULL,     -- ������
	HLENGTH   VARCHAR(40)  NULL,     -- �б���
	NSTATE    VARCHAR(4)   NOT NULL, -- �߼�ȭ����
	PETIMG    VARCHAR(500) NULL,     -- ����
	MEMO      VARCHAR(200) NULL      -- �޸�
);

create sequence PET_seq
start with 1
increment by 1
nocache;

-- ����ī�װ�/��з�
DROP TABLE MAINCATEGORY
   CASCADE CONSTRAINTS;
CREATE TABLE MAINCATEGORY (
	MCATEGORY VARCHAR(20) NOT NULL, -- ��з��ڵ�
	MCANAME   VARCHAR(20) NOT NULL  -- ��з���
);

 -- ����ī�װ�/�Һз�
 DROP TABLE SUBCATEGORY
   CASCADE CONSTRAINTS;
CREATE TABLE SUBCATEGORY (
	SCATEGORY VARCHAR(20) NOT NULL, -- �Һз��ڵ�
	MCATEGORY VARCHAR(20) NOT NULL, -- ��з��ڵ�
	SCANAME   VARCHAR(100) NULL      -- �Һз���
);

-- ����ī�װ�/��з�
ALTER TABLE MAINCATEGORY
	ADD
		CONSTRAINT PK_MAINCATEGORY -- ����ī�װ�/��з� �⺻Ű
		PRIMARY KEY (
			MCATEGORY -- ��з��ڵ�
		);
ALTER TABLE PET
	ADD
		CONSTRAINT FK_MAINCATEGORY_TO_PET -- ����ī�װ�/��з� -> �ݷ�����
		FOREIGN KEY (
			MCATEGORY -- ��з��ڵ�
		)
		REFERENCES MAINCATEGORY ( -- ����ī�װ�/��з�
			MCATEGORY -- ��з��ڵ�
		)
		ON DELETE CASCADE;
        
-- ����ī�װ�/�Һз�
ALTER TABLE SUBCATEGORY
	ADD
		CONSTRAINT PK_SUBCATEGORY -- ����ī�װ�/�Һз� �⺻Ű2
		PRIMARY KEY (
			SCATEGORY -- �Һз��ڵ�
		);     
-- �Һз�
ALTER TABLE PET
	ADD
		CONSTRAINT FK_SUBCATEGORY_TO_PET -- ����ī�װ�/�Һз� -> �ݷ�����
		FOREIGN KEY (
			SCATEGORY -- �Һз��ڵ�
		)
		REFERENCES SUBCATEGORY ( -- ����ī�װ�/�Һз�
			SCATEGORY -- �Һз��ڵ�
		)
		ON DELETE CASCADE;
-- ���ã��/�ݷ�����  
DROP TABLE  PETLIKE 
   CASCADE CONSTRAINTS;
   
CREATE TABLE PETLIKE (
	LINDEX   INT   PRIMARY KEY, -- ���ã���ȣ
	USERID   VARCHAR(40) NOT NULL, -- USERID
	PETINDEX INT         NOT NULL  -- �����ĺ���ȣ
);

create sequence PETLIKE_seq
    start with 1
    increment by 1
    nocache;

-- ���ã��(�ȷο�)/�ݷ�����
ALTER TABLE PETLIKE
	ADD
		CONSTRAINT FK_PET_TO_PETLIKE -- �ݷ����� -> ���ã��/�ݷ�����
		FOREIGN KEY (
			PETINDEX -- �����ĺ���ȣ
		)
		REFERENCES PET ( -- �ݷ�����
			PETINDEX -- �����ĺ���ȣ
		)
		ON DELETE CASCADE;

-- ���ã��(�ȷο�)/�ݷ�����
ALTER TABLE PETLIKE
	ADD
		CONSTRAINT FK_USER_TO_PETLIKE -- ȸ�� -> ���ã��/�ݷ�����
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- ȸ��
			USERID -- USERID
		)
		ON DELETE CASCADE;
-- ����/�˻� 
 DROP TABLE INSPECTION
   CASCADE CONSTRAINTS;
   
CREATE TABLE INSPECTION (
	IINDEX   INT          PRIMARY KEY , -- �۹�ȣ
	PETINDEX INT          NOT NULL, -- �����ĺ���ȣ
	USERID   VARCHAR(40)  NOT NULL, -- USERID
	LIST     VARCHAR(100) NOT NULL, -- �׸�
	VADATE    TIMESTAMP   NULL,  -- ������
	EVDATE    TIMESTAMP    NULL,     -- ����������(Estimated Vadate)
	VSTATE   VARCHAR(4)   NULL,     -- ��������
	VCOUNT   INT          NULL      -- �ܿ�����Ƚ��
);
create sequence INSPECTION_seq
start with 1
increment by 1
nocache;
ALTER TABLE INSPECTION
	ADD
		CONSTRAINT FK_PET_TO_INSPECTION -- �ݷ����� -> ����/�˻� 
		FOREIGN KEY (
			PETINDEX -- �����ĺ���ȣ
		)
		REFERENCES PET ( -- �ݷ�����
			PETINDEX -- �����ĺ���ȣ
		)
		ON DELETE CASCADE;
-- ����/�˻� 
ALTER TABLE INSPECTION
	ADD
		CONSTRAINT FK_USER_TO_INSPECTION -- ȸ�� -> ����/�˻� 
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- ȸ��
			USERID -- USERID
		)
		ON DELETE CASCADE;
-- ���� ���� �̿� ���
 DROP TABLE MRECORD
   CASCADE CONSTRAINTS;

CREATE TABLE MRECORD (
	MINDEX   INT         PRIMARY KEY , -- �۹�ȣ
	PETINDEX INT         NOT NULL, -- �����ĺ���ȣ
	USERID   VARCHAR(40) NOT NULL, -- USERID
	VDATE    TIMESTAMP   NOT NULL, -- �湮��¥
	VREASON  VARCHAR(60) NOT NULL, -- �湮 ����
	HNAME    VARCHAR(20) NOT NULL  -- ������
);
create sequence MRECORD_seq
start with 1
increment by 1
nocache;
-- ���� ���� �̿� ���
ALTER TABLE MRECORD
	ADD
		CONSTRAINT FK_USER_TO_MRECORD -- ȸ�� -> ���� ���� �̿� ���
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- ȸ��
			USERID -- USERID
		)
		ON DELETE CASCADE;

DROP TABLE SCHEDULE 
   CASCADE CONSTRAINTS;
-- ����
CREATE TABLE SCHEDULE (
	SINDEX      INT          PRIMARY KEY , -- �۹�ȣ
	PETINDEX    INT          NOT NULL, -- �����ĺ���ȣ
	USERID      VARCHAR(40)  NOT NULL, -- USERID
	TITLE       VARCHAR(60)  NOT NULL, -- ����
	CONTENT     VARCHAR(400) , -- ����
	IS_COMPLETE VARCHAR(4)   ,     -- �ϷῩ��
	START_date       TIMESTAMP    NOT NULL, -- ���۳�¥
	END_date         TIMESTAMP    ,     -- ������¥
	ALLDAY      VARCHAR(10)  NULL, -- �Ϸ����� ����
	DAYSOFWEEK  VARCHAR(40)  NULL, -- �ݺ��ֱ�
	ADNCDNOTI   VARCHAR(40)  , -- �̸��˸�
	COLOR       VARCHAR(20)  NULL, -- ����
	GROUPID     VARCHAR(100) NULL -- ���� �ֱ��� ���� �׷�ID
	
);

create sequence SCHEDULE_seq
start with 1
increment by 1
nocache;
-- ����
ALTER TABLE SCHEDULE
	ADD
		CONSTRAINT FK_PET_TO_SCHEDULE -- �ݷ����� -> ����
		FOREIGN KEY (
			PETINDEX -- �����ĺ���ȣ
		)
		REFERENCES PET ( -- �ݷ�����
			PETINDEX -- �����ĺ���ȣ
		)
		ON DELETE CASCADE;

-- ����
ALTER TABLE SCHEDULE
	ADD
		CONSTRAINT FK_USER_TO_SCHEDULE -- ȸ�� -> ����
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- ȸ��
			USERID -- USERID
		)
       
		ON DELETE CASCADE;
INSERT INTO MAINCATEGORY (MCATEGORY, MCANAME) VALUES ('1', '��');
INSERT INTO MAINCATEGORY (MCATEGORY, MCANAME) VALUES ('2', '�����');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('1', '1', '����');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('2', '1', '���޶�Ͼ�');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('3', '1', '������');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('4', '1', 'ġ�Ϳ�');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('5', '2', '�丣�þ�');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('6', '2', '���þȺ��');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('7', '2', '�ڸ��ȼ����');


-- ä�� �������
DROP TABLE ChatMember 
   CASCADE CONSTRAINTS;
CREATE TABLE ChatMember (
	MEM_NUMBER   VARCHAR(40)  NOT NULL, -- ��ȣ
	ROOM_NUMBER     VARCHAR(20)  NOT NULL, -- ��ȣ
	USER_EMAIL      VARCHAR(100) NULL,     -- �̸���
	USER_NICKNAME      VARCHAR(100) NULL -- �г���
	  
);
DROP TABLE ChatRoom 
   CASCADE CONSTRAINTS;
-- ä�ù�
CREATE TABLE ChatRoom (
	ROOM_NUMBER   INT  PRIMARY KEY ,  -- ��ȣ
	ROOM_TITLE     VARCHAR(20)  NOT NULL, -- ����
	USER_EMAIL      VARCHAR(100) NOT NULL,     -- �̸���
	ROOM_COUNT      VARCHAR(100) NOT NULL, -- ī��Ʈ
	ROOM_SECRET VARCHAR(40)  NOT NULL, -- ã��
	ROOM_PWD  VARCHAR(4)   NULL, -- ���
	USER_NICKNAME VARCHAR(100) NOT NULL,     -- �г���
	
	CURRENT_COUNT      VARCHAR(40)  NULL     -- ����ī��Ʈ
	
);
create sequence ChatRoom_seq
start with 1
increment by 1
nocache;
----�޽���----
DROP TABLE MESSAGE 
   CASCADE CONSTRAINTS;

CREATE TABLE CHATROOM_CONTENT (
	MSINDEX   INT          PRIMARY KEY , -- ������ȣ
	RUSERID   VARCHAR(40)  , -- �������ID
	SUSERID   VARCHAR(40)  , -- �������ID
	CONTENT   VARCHAR(100) , -- ��������
	SENDTIME  TIMESTAMP    , -- �����Ͻ�
	READTIME  TIMESTAMP    , -- �����Ͻ�
	READSTATE VARCHAR(4)   NULL      -- ��������
);
commit;
create sequence MESSAGE_seq
    start with 1
    increment by 1
    nocache;
----�޽���----
ALTER TABLE MESSAGE 
ADD CONSTRAINT FK_USER_TO_MESSAGE FOREIGN KEY(RUSERID) 
REFERENCES MEMBERS(USERID);

----�޽���----
ALTER TABLE MESSAGE 
ADD CONSTRAINT FK_USER_TO_MESSAGE_2 FOREIGN KEY(SUSERID) 
REFERENCES MEMBERS(USERID);


DROP TABLE  QNAREPLY 
   CASCADE CONSTRAINTS;
-- ����������
CREATE TABLE QNAREPLY (
	TITLE   VARCHAR(100) NOT NULL, -- ����
	ID      VARCHAR(20)  NOT NULL, -- ID
	QAINDEX INT          NOT NULL, -- �۹�ȣ
	CONTENT VARCHAR(500) NOT NULL, -- ����
	QARTIME TIMESTAMP  NOT NULL  -- ��Ͻð�
);

-- ����������
ALTER TABLE QNAREPLY
	ADD
		CONSTRAINT PK_QNAREPLY -- ���������� �⺻Ű
		PRIMARY KEY (
			TITLE -- ����
		);

DROP TABLE  QNA 
   CASCADE CONSTRAINTS;
-- ��������
CREATE TABLE QNA (
   QAINDEX  INT          PRIMARY KEY , -- �۹�ȣ
   USERID   VARCHAR(40)  NULL,     -- USERID
   TITLE    VARCHAR(100) NOT NULL, -- ����
   QATIME   VARCHAR(40)  NOT NULL, -- ��Ͻð�
   COUNT    INT          NOT NULL, -- ��ȸ��
   SCSTATE  VARCHAR(4)   NOT NULL, -- �������
   CONTENT  VARCHAR(500) NOT NULL, -- ����
   FILENAME VARCHAR(100) NULL,     -- ÷������
   AWSTATE  VARCHAR(20)   NOT NULL,  -- �亯�ϷῩ��
   REPLYCONTENT VARCHAR(500)  -- ������ ��۳���
    
);
create sequence QNA_seq
    start with 1
    increment by 1
    nocache;
    
    
-- QNA ���
DROP TABLE  QNACOMMENT 
   CASCADE CONSTRAINTS;
   
CREATE TABLE QNACOMMENT (
   QNAINDEX INT          PRIMARY KEY , -- ��۹�ȣ
   QAINDEX  INT          NOT NULL, -- �۹�ȣ
   USERID  VARCHAR(40)  NOT NULL, -- USERID
   QNALIKE  INT          NULL,     -- ��õ��(����)
   CONTENT VARCHAR(400) NOT NULL, -- ����
   SCSTATE VARCHAR(4)   NOT NULL, -- �������
   RTIME   TIMESTAMP    NOT NULL, -- ��Ͻð�
   REFER   INT          NOT NULL, -- refer
   DEPTH   INT          NOT NULL, -- depth
   STEP    INT          NOT NULL  -- step
);

create sequence QNACOMMENT_seq
    start with 1
    increment by 1
    nocache;

-- ����������
ALTER TABLE QNAREPLY
	ADD
		CONSTRAINT FK_QNA_TO_QNAREPLY -- �������� -> ����������2
		FOREIGN KEY (
			QAINDEX -- �۹�ȣ
		)
		REFERENCES QNA ( -- ��������
			QAINDEX -- �۹�ȣ
		)
		ON DELETE CASCADE;

-- QNA��� USER FK
ALTER TABLE QNACOMMENT
   ADD
      CONSTRAINT FK_USER_TO_QNACOMMENT -- ȸ�� -> ���2
      FOREIGN KEY (
         USERID -- USERID
      )
      REFERENCES MEMBERS ( -- ȸ��
         USERID -- USERID
      )
      ON DELETE CASCADE;

-- QA��� QNA FK
ALTER TABLE QNACOMMENT
   ADD
      CONSTRAINT FK_QNA_TO_QNACOMMENT -- �Խñ� -> ���2
      FOREIGN KEY (
         QAINDEX -- �۹�ȣ
      )
      REFERENCES QNA ( -- �Խñ�
         QAINDEX -- �۹�ȣ
      )
      ON DELETE CASCADE;

-- ��������
ALTER TABLE QNA
	ADD
		CONSTRAINT FK_USER_TO_QNA -- ȸ�� -> ��������2
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- ȸ��
			USERID -- USERID
		)
		ON DELETE CASCADE;
        



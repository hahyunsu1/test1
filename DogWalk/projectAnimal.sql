/* 회원 */
DROP TABLE MEMBERS 
	CASCADE CONSTRAINTS;

/* 회원 */
CREATE TABLE MEMBERS (
	NICK VARCHAR2(40) NOT NULL, /* 닉네임 */
	IDX NUMBER(8) NOT NULL, /* 회원번호 */
	RRN2 CHAR(7) NOT NULL, /* 주민번호2 */
	USERID VARCHAR2(40) NOT NULL, /* 아이디 */
	NAME VARCHAR2(30) NOT NULL, /* 이름 */
	PWD VARCHAR(100) NOT NULL, /* 비밀번호 */
	HP1 CHAR(3) NOT NULL, /* 휴대폰1 */
	HP2 CHAR(4) NOT NULL, /* 휴대폰2 */
	HP3 CHAR(4) NOT NULL, /* 휴대폰3 */
	POST CHAR(5), /* 우편번호 */
	ADDR1 VARCHAR2(100), /* 주소1 */
	ADDR2 VARCHAR2(100), /* 주소2 */
	INDATE DATE, /* 가입날짜 */
	STATUS NUMBER(10), /* 회원상태 */
	RRN1 CHAR(6) NOT NULL, /* 주민번호1 */
	MAIL VARCHAR2(100), /* 메일 */
	SNSTYPE VARCHAR2(50) /* sns로가입여부 */
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

/* 돌봄 */
DROP TABLE com_ani_board 
   CASCADE CONSTRAINTS;

/* 돌봄 */
CREATE TABLE com_ani_board (
   cnum NUMBER(8) NOT NULL, /* 글번호 */
   userid varchar2(20) not null,
   nick VARCHAR2(30) NOT NULL, /* 닉네임 */
   cpass VARCHAR2(20), /* 글비밀번호 */
   title VARCHAR2(200) NOT NULL, /* 글제목 */
   content VARCHAR2(2000), /* 글내용 */
   wdate DATE default sysdate, /* 작성일 */
   cnt NUMBER(8) default 0, /* 조회수 */
   filename VARCHAR2(500), /* 첨부파일명 */
   originFilename VARCHAR2(500), /* 원본파일명 */
   filesize NUMBER(8), /* 첨부파일 크기 */
   pet VARCHAR2(30), /* 동물 */
   price NUMBER(8), /* 가격(선택사항) */
   myaddr VARCHAR2(30) /* 보여줄동네 */
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
		CONSTRAINT FK_USER_TO_com_ani_board -- 회원 -> 접종/검사 
		FOREIGN KEY (
			NICK -- USERID
		)
		REFERENCES MEMBERS ( -- 회원
			NICK -- USERID
		)
		ON DELETE CASCADE; 
 ALTER TABLE com_ani_board
	ADD
		CONSTRAINT FK_USER_TO_com_ani_board -- 회원 -> 접종/검사 
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- 회원
			USERID -- USERID
		)
		ON DELETE CASCADE; 
-------PET-----------

DROP TABLE PET 
   CASCADE CONSTRAINTS;

CREATE TABLE PET (
	PETINDEX  INT  PRIMARY KEY , -- 동물식별번호
	USERID    VARCHAR(40)  NOT NULL, -- USERID
	MCATEGORY VARCHAR(20)  NOT NULL, -- 대분류코드
	SCATEGORY VARCHAR(20)  NOT NULL, -- 소분류코드
	PETNAME   VARCHAR(20)  NOT NULL, -- 반려동물명
	SEX       VARCHAR(20)  NOT NULL, -- 성별
	AGE       INT    NOT NULL, -- 나이
	PETSIZE      VARCHAR(20)  NOT NULL, -- 크기
	WEIGHT    VARCHAR(40)  NULL,     -- 몸무게
	HLENGTH   VARCHAR(40)  NULL,     -- 털길이
	NSTATE    VARCHAR(4)   NOT NULL, -- 중성화여부
	PETIMG    VARCHAR(500) NULL,     -- 사진
	MEMO      VARCHAR(200) NULL      -- 메모
);

create sequence PET_seq
start with 1
increment by 1
nocache;

-- 동물카테고리/대분류
DROP TABLE MAINCATEGORY
   CASCADE CONSTRAINTS;
CREATE TABLE MAINCATEGORY (
	MCATEGORY VARCHAR(20) NOT NULL, -- 대분류코드
	MCANAME   VARCHAR(20) NOT NULL  -- 대분류명
);

 -- 동물카테고리/소분류
 DROP TABLE SUBCATEGORY
   CASCADE CONSTRAINTS;
CREATE TABLE SUBCATEGORY (
	SCATEGORY VARCHAR(20) NOT NULL, -- 소분류코드
	MCATEGORY VARCHAR(20) NOT NULL, -- 대분류코드
	SCANAME   VARCHAR(100) NULL      -- 소분류명
);

-- 동물카테고리/대분류
ALTER TABLE MAINCATEGORY
	ADD
		CONSTRAINT PK_MAINCATEGORY -- 동물카테고리/대분류 기본키
		PRIMARY KEY (
			MCATEGORY -- 대분류코드
		);
ALTER TABLE PET
	ADD
		CONSTRAINT FK_MAINCATEGORY_TO_PET -- 동물카테고리/대분류 -> 반려동물
		FOREIGN KEY (
			MCATEGORY -- 대분류코드
		)
		REFERENCES MAINCATEGORY ( -- 동물카테고리/대분류
			MCATEGORY -- 대분류코드
		)
		ON DELETE CASCADE;
        
-- 동물카테고리/소분류
ALTER TABLE SUBCATEGORY
	ADD
		CONSTRAINT PK_SUBCATEGORY -- 동물카테고리/소분류 기본키2
		PRIMARY KEY (
			SCATEGORY -- 소분류코드
		);     
-- 소분류
ALTER TABLE PET
	ADD
		CONSTRAINT FK_SUBCATEGORY_TO_PET -- 동물카테고리/소분류 -> 반려동물
		FOREIGN KEY (
			SCATEGORY -- 소분류코드
		)
		REFERENCES SUBCATEGORY ( -- 동물카테고리/소분류
			SCATEGORY -- 소분류코드
		)
		ON DELETE CASCADE;
-- 즐겨찾기/반려동물  
DROP TABLE  PETLIKE 
   CASCADE CONSTRAINTS;
   
CREATE TABLE PETLIKE (
	LINDEX   INT   PRIMARY KEY, -- 즐겨찾기번호
	USERID   VARCHAR(40) NOT NULL, -- USERID
	PETINDEX INT         NOT NULL  -- 동물식별번호
);

create sequence PETLIKE_seq
    start with 1
    increment by 1
    nocache;

-- 즐겨찾기(팔로우)/반려동물
ALTER TABLE PETLIKE
	ADD
		CONSTRAINT FK_PET_TO_PETLIKE -- 반려동물 -> 즐겨찾기/반려동물
		FOREIGN KEY (
			PETINDEX -- 동물식별번호
		)
		REFERENCES PET ( -- 반려동물
			PETINDEX -- 동물식별번호
		)
		ON DELETE CASCADE;

-- 즐겨찾기(팔로우)/반려동물
ALTER TABLE PETLIKE
	ADD
		CONSTRAINT FK_USER_TO_PETLIKE -- 회원 -> 즐겨찾기/반려동물
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- 회원
			USERID -- USERID
		)
		ON DELETE CASCADE;
-- 접종/검사 
 DROP TABLE INSPECTION
   CASCADE CONSTRAINTS;
   
CREATE TABLE INSPECTION (
	IINDEX   INT          PRIMARY KEY , -- 글번호
	PETINDEX INT          NOT NULL, -- 동물식별번호
	USERID   VARCHAR(40)  NOT NULL, -- USERID
	LIST     VARCHAR(100) NOT NULL, -- 항목
	VADATE    TIMESTAMP   NULL,  -- 접종일
	EVDATE    TIMESTAMP    NULL,     -- 접종예정일(Estimated Vadate)
	VSTATE   VARCHAR(4)   NULL,     -- 접종여부
	VCOUNT   INT          NULL      -- 잔여접종횟수
);
create sequence INSPECTION_seq
start with 1
increment by 1
nocache;
ALTER TABLE INSPECTION
	ADD
		CONSTRAINT FK_PET_TO_INSPECTION -- 반려동물 -> 접종/검사 
		FOREIGN KEY (
			PETINDEX -- 동물식별번호
		)
		REFERENCES PET ( -- 반려동물
			PETINDEX -- 동물식별번호
		)
		ON DELETE CASCADE;
-- 접종/검사 
ALTER TABLE INSPECTION
	ADD
		CONSTRAINT FK_USER_TO_INSPECTION -- 회원 -> 접종/검사 
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- 회원
			USERID -- USERID
		)
		ON DELETE CASCADE;
-- 동물 병원 이용 기록
 DROP TABLE MRECORD
   CASCADE CONSTRAINTS;

CREATE TABLE MRECORD (
	MINDEX   INT         PRIMARY KEY , -- 글번호
	PETINDEX INT         NOT NULL, -- 동물식별번호
	USERID   VARCHAR(40) NOT NULL, -- USERID
	VDATE    TIMESTAMP   NOT NULL, -- 방문날짜
	VREASON  VARCHAR(60) NOT NULL, -- 방문 사유
	HNAME    VARCHAR(20) NOT NULL  -- 병원명
);
create sequence MRECORD_seq
start with 1
increment by 1
nocache;
-- 동물 병원 이용 기록
ALTER TABLE MRECORD
	ADD
		CONSTRAINT FK_USER_TO_MRECORD -- 회원 -> 동물 병원 이용 기록
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- 회원
			USERID -- USERID
		)
		ON DELETE CASCADE;

DROP TABLE SCHEDULE 
   CASCADE CONSTRAINTS;
-- 일정
CREATE TABLE SCHEDULE (
	SINDEX      INT          PRIMARY KEY , -- 글번호
	PETINDEX    INT          NOT NULL, -- 동물식별번호
	USERID      VARCHAR(40)  NOT NULL, -- USERID
	TITLE       VARCHAR(60)  NOT NULL, -- 제목
	CONTENT     VARCHAR(400) , -- 내용
	IS_COMPLETE VARCHAR(4)   ,     -- 완료여부
	START_date       TIMESTAMP    NOT NULL, -- 시작날짜
	END_date         TIMESTAMP    ,     -- 마감날짜
	ALLDAY      VARCHAR(10)  NULL, -- 하루종일 여부
	DAYSOFWEEK  VARCHAR(40)  NULL, -- 반복주기
	ADNCDNOTI   VARCHAR(40)  , -- 미리알림
	COLOR       VARCHAR(20)  NULL, -- 색깔
	GROUPID     VARCHAR(100) NULL -- 같은 주기의 일정 그룹ID
	
);

create sequence SCHEDULE_seq
start with 1
increment by 1
nocache;
-- 일정
ALTER TABLE SCHEDULE
	ADD
		CONSTRAINT FK_PET_TO_SCHEDULE -- 반려동물 -> 일정
		FOREIGN KEY (
			PETINDEX -- 동물식별번호
		)
		REFERENCES PET ( -- 반려동물
			PETINDEX -- 동물식별번호
		)
		ON DELETE CASCADE;

-- 일정
ALTER TABLE SCHEDULE
	ADD
		CONSTRAINT FK_USER_TO_SCHEDULE -- 회원 -> 일정
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- 회원
			USERID -- USERID
		)
       
		ON DELETE CASCADE;
INSERT INTO MAINCATEGORY (MCATEGORY, MCANAME) VALUES ('1', '개');
INSERT INTO MAINCATEGORY (MCATEGORY, MCANAME) VALUES ('2', '고양이');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('1', '1', '시츄');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('2', '1', '포메라니안');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('3', '1', '진돗개');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('4', '1', '치와와');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('5', '2', '페르시안');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('6', '2', '러시안블루');
INSERT INTO SUBCATEGORY (SCATEGORY, MCATEGORY, SCANAME)
VALUES ('7', '2', '코리안숏헤어');


-- 채팅 참여멤버
DROP TABLE ChatMember 
   CASCADE CONSTRAINTS;
CREATE TABLE ChatMember (
	MEM_NUMBER   VARCHAR(40)  NOT NULL, -- 번호
	ROOM_NUMBER     VARCHAR(20)  NOT NULL, -- 번호
	USER_EMAIL      VARCHAR(100) NULL,     -- 이메일
	USER_NICKNAME      VARCHAR(100) NULL -- 닉네임
	  
);
DROP TABLE ChatRoom 
   CASCADE CONSTRAINTS;
-- 채팅방
CREATE TABLE ChatRoom (
	ROOM_NUMBER   INT  PRIMARY KEY ,  -- 번호
	ROOM_TITLE     VARCHAR(20)  NOT NULL, -- 제목
	USER_EMAIL      VARCHAR(100) NOT NULL,     -- 이메일
	ROOM_COUNT      VARCHAR(100) NOT NULL, -- 카운트
	ROOM_SECRET VARCHAR(40)  NOT NULL, -- 찾기
	ROOM_PWD  VARCHAR(4)   NULL, -- 비번
	USER_NICKNAME VARCHAR(100) NOT NULL,     -- 닉네임
	
	CURRENT_COUNT      VARCHAR(40)  NULL     -- 현재카운트
	
);
create sequence ChatRoom_seq
start with 1
increment by 1
nocache;
----메시지----
DROP TABLE MESSAGE 
   CASCADE CONSTRAINTS;

CREATE TABLE CHATROOM_CONTENT (
	MSINDEX   INT          PRIMARY KEY , -- 쪽지번호
	RUSERID   VARCHAR(40)  , -- 받은사람ID
	SUSERID   VARCHAR(40)  , -- 보낸사람ID
	CONTENT   VARCHAR(100) , -- 쪽지내용
	SENDTIME  TIMESTAMP    , -- 보낸일시
	READTIME  TIMESTAMP    , -- 읽은일시
	READSTATE VARCHAR(4)   NULL      -- 읽음여부
);
commit;
create sequence MESSAGE_seq
    start with 1
    increment by 1
    nocache;
----메시지----
ALTER TABLE MESSAGE 
ADD CONSTRAINT FK_USER_TO_MESSAGE FOREIGN KEY(RUSERID) 
REFERENCES MEMBERS(USERID);

----메시지----
ALTER TABLE MESSAGE 
ADD CONSTRAINT FK_USER_TO_MESSAGE_2 FOREIGN KEY(SUSERID) 
REFERENCES MEMBERS(USERID);


DROP TABLE  QNAREPLY 
   CASCADE CONSTRAINTS;
-- 질의응답댓글
CREATE TABLE QNAREPLY (
	TITLE   VARCHAR(100) NOT NULL, -- 제목
	ID      VARCHAR(20)  NOT NULL, -- ID
	QAINDEX INT          NOT NULL, -- 글번호
	CONTENT VARCHAR(500) NOT NULL, -- 내용
	QARTIME TIMESTAMP  NOT NULL  -- 등록시간
);

-- 질의응답댓글
ALTER TABLE QNAREPLY
	ADD
		CONSTRAINT PK_QNAREPLY -- 질의응답댓글 기본키
		PRIMARY KEY (
			TITLE -- 제목
		);

DROP TABLE  QNA 
   CASCADE CONSTRAINTS;
-- 질의응답
CREATE TABLE QNA (
   QAINDEX  INT          PRIMARY KEY , -- 글번호
   USERID   VARCHAR(40)  NULL,     -- USERID
   TITLE    VARCHAR(100) NOT NULL, -- 제목
   QATIME   VARCHAR(40)  NOT NULL, -- 등록시간
   COUNT    INT          NOT NULL, -- 조회수
   SCSTATE  VARCHAR(4)   NOT NULL, -- 비밀유무
   CONTENT  VARCHAR(500) NOT NULL, -- 내용
   FILENAME VARCHAR(100) NULL,     -- 첨부파일
   AWSTATE  VARCHAR(20)   NOT NULL,  -- 답변완료여부
   REPLYCONTENT VARCHAR(500)  -- 관리자 답글내용
    
);
create sequence QNA_seq
    start with 1
    increment by 1
    nocache;
    
    
-- QNA 댓글
DROP TABLE  QNACOMMENT 
   CASCADE CONSTRAINTS;
   
CREATE TABLE QNACOMMENT (
   QNAINDEX INT          PRIMARY KEY , -- 댓글번호
   QAINDEX  INT          NOT NULL, -- 글번호
   USERID  VARCHAR(40)  NOT NULL, -- USERID
   QNALIKE  INT          NULL,     -- 추천수(보류)
   CONTENT VARCHAR(400) NOT NULL, -- 내용
   SCSTATE VARCHAR(4)   NOT NULL, -- 비밀유무
   RTIME   TIMESTAMP    NOT NULL, -- 등록시간
   REFER   INT          NOT NULL, -- refer
   DEPTH   INT          NOT NULL, -- depth
   STEP    INT          NOT NULL  -- step
);

create sequence QNACOMMENT_seq
    start with 1
    increment by 1
    nocache;

-- 질의응답댓글
ALTER TABLE QNAREPLY
	ADD
		CONSTRAINT FK_QNA_TO_QNAREPLY -- 질의응답 -> 질의응답댓글2
		FOREIGN KEY (
			QAINDEX -- 글번호
		)
		REFERENCES QNA ( -- 질의응답
			QAINDEX -- 글번호
		)
		ON DELETE CASCADE;

-- QNA댓글 USER FK
ALTER TABLE QNACOMMENT
   ADD
      CONSTRAINT FK_USER_TO_QNACOMMENT -- 회원 -> 댓글2
      FOREIGN KEY (
         USERID -- USERID
      )
      REFERENCES MEMBERS ( -- 회원
         USERID -- USERID
      )
      ON DELETE CASCADE;

-- QA댓글 QNA FK
ALTER TABLE QNACOMMENT
   ADD
      CONSTRAINT FK_QNA_TO_QNACOMMENT -- 게시글 -> 댓글2
      FOREIGN KEY (
         QAINDEX -- 글번호
      )
      REFERENCES QNA ( -- 게시글
         QAINDEX -- 글번호
      )
      ON DELETE CASCADE;

-- 질의응답
ALTER TABLE QNA
	ADD
		CONSTRAINT FK_USER_TO_QNA -- 회원 -> 질의응답2
		FOREIGN KEY (
			USERID -- USERID
		)
		REFERENCES MEMBERS ( -- 회원
			USERID -- USERID
		)
		ON DELETE CASCADE;
        



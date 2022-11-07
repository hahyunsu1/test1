create table [스키마.]테이블명(
    칼럼명 자료형 default 기본값 constraint 제약조건이름 제약조건유형,
    ....
    );
    

create table TEST_TAB1(
    NO number(2) constraint TEST_TAB1_NO_PK PRIMARY KEY,
    NAME VARCHAR2(20)
    );
    
desc test_tab1;

select*
from user_constraints where table_name='TEST_TAB1';

insert into test_tab1(no,name)
values(1,null);

select * from test_tab1;

create table test_tab2(
    no number(2),
    name varchar2(20),
    constraint test_tab2_no_pk primary key(no));
    
select * from user_constraints
where table_name='TEST_TAB2';

alter table test_tab2
drop constraint test_tab2_no_pk;

alter table test_tab2
add constraint test_tab2_no_pk2 primary key(no);

alter table test_tab2
rename constraint test_tab2_no_pk2 to test_tab2_no_pk;

#Foreign key 제약조건
부모 테이블(MASTER)의 pk를 지식테이블(DETAIL)에서 FK로 참조
==>FK는 DETAIL테이블에서 정의해야 함
MASTER 테이블의 PK,UK로 정의된 컬럼을 FK로 지정할 수 있다
컬럼의 자료형이 일치해야 한다.크기는 일치하지 않아도 상관없음
ON DELETE CASCADE 연산자와 함께 정의된 외래키의 데이터는  
그 기본키가 삭제 될 때 같이 삭제된다

Create table dept_tab(
deptno number(2),
dname varchar2(15),
loc varchar2(15),
constraint dept_tab_deptno_pk primary key(deptno)
);

create table emp_tab(
empno number(4),
ename varchar2(20),
job varchar2(10),
mgr number(4) constraint emp_tab_mgr_fk references emp_tab(empno),
hiredate date,
sal number(7,2),
comm number(7,2),
deptno number(2),
--테이블 수준에서 fk주기
constraint emp_tab_deptno_fk foreign key (deptno)
references dept_tab(deptno),
constraint emp_tab_empno_pk primary key (empno)
);
insert into dept_tab values(10,'기획부','서울');
insert into dept_tab values(20,'인사부','인천');
DROP TABLE emp_tab;
select*from dept_tab;
--사원정보 INSERT하기
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
values(1000,'홍길동','기획',NULL,10);
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
values(1001,'이철수','인사',NULL,20);
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
values(1002,'이영희','인사',NULL,20);
select*from emp_tab;

INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
values(1003,'김순희','노무',1002,20);
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
values(1004,'김길동','재무',1000,20);
commit;
dept_tab에서 기획부를 삭제해보기
delete from dept_tab where deptno=10;
==>자식 레코드가 있을 경우는 부모테이블의 레코드를 삭제할 수 없다.

홍길동을 20번부서로 부서이동 하세요
update emp_tab set deptno=20 where ename='홍길동';

select*from emp_tab;
select*from dept_tab;



BOARD_TAB
NO NUMBER(8) PK
USERID VARCHAR2(20) NOT NULL,
TITLE VARCHAR2(100),
CONTENT VARCHAR2(1000)
WDATE DATE 기본값 SYSDATE

자식테이블
REPLY_TAB
RNO NUMBER(8) PK
CONTENT VARCHAR2(300)
USERID VARCHAR2(20) not null,
NO_FK NUMBER(8)==>fk로 주되 ON DElETE CASCADE 옵션을 기술하기

CREATE TABLE BOARD_TAB(
no number(8) primary key,
userid varchar2(20) not null,
title varchar2(100),
content varchar2(1000),
wdate date default sysdate);

create table reply_tab(
    rno number(8) primary key,
    content varchar2(300),
    userid varchar2(20) not null,
    no_fk number(8) references board_tab(no) on delete cascade
);
select *from user_constraints where table_name='REPLY_TAB';
insert into board_tab values(1,'HAHA','반가워요','안녕',SYSDATE);
commit;

select*from board_tab;
댓글달기
insert into reply_tab values(3,'반갑습니다','KIM',1);
commit;
select*from reply_tab;

borad_tab과 reply_tab을 join해서 같이 출력하세요
select b.no,b.title,b.userid,b.wdate,r.content,r.userid
from board_tab B join reply_tab r
on b.no = r.no_fk;

delete from board_tab where no=2;
--on delete cascade 옵션을 주었기 때문에 부모글을 삭제하면 자식글도 함께 삭제된다.

# UNIQUE KEY
컬럼수준 제약
create table uni_tab1(
deptno number(2) constraint uni_tab1_deptno_uk unique,
dname char(20),
loc char(10));

select*from user_constraints where table_name='UNI_TAB1';
insert into uni_tab1 values(null,'영업부3','서울');
select*from uni_tab1;
commit;

테이블 수준 제약
create table uni_tab2(
deptno number(2),
dname char(20),
loc char(10),
constraint uno_tab2_deptno_uk unique(deptno));

# not null 제약조건 - 체크제약조건의 일종
-not null 제약조건은 컬럼 수준에서만 제약할 수 있다.

create table nn_tab(
deptno number(2) constraint nn_tab_deptno_nn not null,
dname char(20) not null,
loc char(10)
--constraint loc_nn not null (loc) [X]
);




#CHECK 제약조건
- 행이 만족해야하는 조건을 정의한다

create table ck_tab(
deptno number(2) constraint ck_tab_deptno_ck check(deptno in(10,20,30,40)),
dname char(20));
select*from user_constraints where table_name='CK_TAB';
intsert into ck_tab values(50,'BAA');--[x]

create table ck_tab2(
deptno number(2),
dname char(20),
loc char(10),
primary key(deptno),
check(loc in('서울','수원'))
);
select*from user_constraints where table_name='CK_TAB2';


create table zip_code(
post1 char(3),
post2 char(3),
addr varchar2(60) constraint zip_code_addr not null,
constraint zip_code_post_pk primary key(post1,post2));
desc zip_code;

create table member_tab(
id number(4,0) ,
name varchar2(10) constraint member_tap_name_nn not null,
gender char(1) ,
jumin1 char(6),
jumin2 char(7),
tel varchar2(15),
post1 char(3),
post2 char(3),
addr varchar2(60),
constraint member_tab_id_pk primary key (id),
constraint member_tab_gender_ck check(gender in('F','M')),
constraint member_tab_jumin_uk unique (jumin1,jumin2),
constraint member_tab_post_fk foreign key (post1,post2)
references zip_code(post1,post2)
);
drop table member_tab2;
desc member_tab;
select * from user_constraints where table_name=upper('MEMBER_TAB');
create table member_tab2(
id number(4,0) primary key,
name varchar2(10),
gender char(1) constraint member_tab_gender_ck check(gender in('F','M')),
jumin1 char(6),
jumin2 char(7),
tel varchar2(15),
post1 char(3),
post2 char(3),
addr varchar2(60),
constraint member_tab_jumin_uk unique(jumin1,jumin2),
constraint member_tab_fk foreign key (post1,post2)
references zip_code(post1,post2)
);

#subquery를 이용한 테이블 생성
--[실습] 사원 테이블에서 30번 부서에 근무하는 사원의 정보만 추출하여
--EMP_30 테이블을 생성하여라. 단 열은 사번,이름,업무,입사일자,
--급여,보너스를 포함한다.
create table emp_30(eno,ename,job,hdate,sal,comm)
as
select empno,ename,job,hiredate,sal,comm
from emp where deptno=30;

select * from emp_30;
--[문제1]
--EMP테이블에서 부서별로 인원수,평균 급여, 급여의 합, 최소 급여,
--최대 급여를 포함하는 EMP_DEPTNO 테이블을 생성하라.
create table emp_deptno
as
select deptno,count(empno) cnt,round(avg(sal))avg_sal,sum(sal)sum_sal,
min(sal)min_sal,max(sal)max_sal
from emp group by deptno;	
select * from emp_deptno;
--[문제2]	EMP테이블에서 사번,이름,업무,입사일자,부서번호만 포함하는
--EMP_TEMP 테이블을 생성하는데 자료는 포함하지 않고 구조만
--생성하여라
create table emp_temp
as
select empno,ename,job,hiredate,deptno
from emp where 1=2;

select * from emp_temp;


--#DDL
--create,drop,alter,rename,truncate
--#컬럼 추가 변경 삭제
--alter table 테이블명 add 추가할컬럼정보[default 값]

create table temp(
no number(4)
);
desc temp;
drop table temp;
alter table temp add name varchar2(10) not null;
alter table temp add indate date default sysdate;

products 테이블에 prod_desc 컬럼을 추가하되 not null제약조건을 주세요

alter table products add prod_desc varchar2(1000);


temp테이블의 no 컬럼의 자료형을 char(4)로 수정하세요
alter table temp modify no char(4);
temp테이블의 no 컬럼명을 num으로 변경하세요
alter table temp rename column no to num;
temp테이블의 indate컬럼을 삭제하세요
alter table temp drop column indate;
desc temp;
alter table products drop column prod_desc;

temp 테이블의 num컬럼에 primary key 제약조건을 추가하세요

alter table temp add constraint temp_num_pk primary key(num);

insert into temp values(1,'AAA');

제약조건 비활성화

ALTER TABLE 테이블명 DISABLE CONSTRAINT 제약조건명[cascade];

temp의 pk제약조건을 비활성화 시키세요
alter table temp disable constraint temp_num_pk;

select * from user_constraints where table_name='TEMP';

delete from temp;
commit;
제약조건 활성화
alter table 테이블명 enable constraint 제약조건명 [cascade];

객체 이름 변경
RENAME OLO_NAME TO NEW_NAME;
temp 테이블명을 test테이블로 변경하세요
rename temp to test2;
select * from tab;
#테이블 삭제
DROP TABLE 테이블명[CASCADE CONSTRAINT);

drop table test2 cascade constraint;
temp의 pk제약 조건을 활성화 시키세요
alter table temp enable constraint temp_num_pk;

drop table test purge;

테이블 모든 구조와 데이터가 삭제된다.
관련 인덱스도 모두 삭제된다.
VIEW,SYNONYM 정보는 데이터 사전에는 남아 있지만 사용하면 에러 발생한다

select *from memo;
SELECT idx, name, msg, wdate FROM memo ORDER BY idx DESC;

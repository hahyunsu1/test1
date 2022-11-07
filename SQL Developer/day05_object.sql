/*#시퀸스
구문
CREATE SEQUENCE 시퀸스명
[INCREMENT BY n] --증가치
[START WITH n] --시작값
[(MAXVALUE n | NOMAXVALUE)]--최대값
[(MINVALUE n | NOMINVALUE)]--최소값
[(CYCLE|NOCYCLE)]-- 최대,최소에 도달한 후 계속 값을 생성할지 여부를 지정,nocycledl rlqhs
[(CACHE|NOCACHE)]--메모리 캐시 디폴트 사이즈 20
*/
create sequence dept2_seq
start with 50
increment by 5
maxvalue 95
cache 20
nocycle;

데이터사전에서 시퀀스 조회
select *from user_sequences;
-NEXTVAL : 시퀸스 다음값
-CURRVAL : 시퀸스 현재값
[주의] NEXTVAL 이 호출되지 않은 상태에서 CURRVAL이 사용되면 에러가난다.

select dept2_seq.currval from dual; ==> 에러 발생함

select dept2_seq.nextval from dual;
select dept2_seq.currval from dual;

insert into dept2(deptno,dname,loc)
values(dept2_seq.nextval,'SALES','SEOUL');

select * from dept2;

create sequence dept2_seq
start with 50
increment by 5
maxvalue 95
cache 20
nocycle;

--시퀀스명: TEMP_SEQ
--시작값: 100부터 시작
--증가치: 5만큼씩 감소
--최소값은 0으로
--CYCLE 옵션 주기
--캐시사용 하지 않도록
create sequence temp_seq
start with 100
increment by -5
maxvalue 100
minvalue 0
nocache
cycle;

select temp_seq.nextval from dual;

--#시퀸스 수정
--[주의사항]시작값은 수정할 수 없다. 시작값을 수정할려면 drop하고 다시 create한다.
--
--ALTER SEQUENCE 시퀸스명
--[INCREMENT BY n] --증가치
--[START WITH n] --시작값
--[(MAXVALUE n | NOMAXVALUE)]--최대값
--[(MINVALUE n | NOMINVALUE)]--최소값
--[(CYCLE|NOCYCLE)]-- 최대,최소에 도달한 후 계속 값을 생성할지 여부를 지정,nocycledl rlqhs
--[(CACHE|NOCACHE)]--메모리 캐시 디폴트 사이즈 20

dept2_seq를 수정하되 maxvalue는 1000까지
증가치 1씩 증가하도록 수정하세요

alter sequence dept2_seq
maxvalue 1000
increment by 1;
--start with 10;
--cannot alter starting sequence number

#시퀸스 삭제

--drop sequence 시퀸스명

drop sequence temp_seq;
select*from user_sequences where sequence_name='DEPT2_SEQ';
insert into dept2 values(dept2_seq.nextval,'TEST','TEST');
select*from dept2;

select dept2_seq.currval from dual;

--
--#VIEW
--[주의사항]view를 생성할려면 CREATE VIEW 권한을 가져야 한다.
--CREATE VIEW 뷰이름
--AS
--SELECT 컬럼명1,컬럼명2....
--FROM 뷰에 사용할 테이블명
--WHERE 조건

--EMP테이블에서 20번 부서의 모든 컬럼을 포함하는 EMP20_VIEW를 생성하라.

system
sasa9551   
계정으로 접속한 뒤
grant create view to scott;

create view emp20_view
as
select *
from emp
where deptno=20;

select * from emp20_view;
select * from user_views;
desc emp20_view;
#view 삭제
drop view emp20_view;

#VIEW 수정
CREATE OR REPLACE 뷰이름
AS SELECT문;
--[문제] 
--	고객테이블의 고객 정보 중 나이가 19세 이상인
--	고객의 정보를
--	확인하는 뷰를 만들어보세요.
--	단 뷰의 이름은 MEMBER_19로 하세요.

create or replace view member_19
as
select * from member where age >=19;
select * from member_19;

create or replace view member_19
as
select * from member where age >=30;
--EMP테이블에서 30번 부서만 EMPNO를 EMP_NO로 ENAME을 NAME으로
--	SAL를 SALARY로 바꾸어 EMP30_VIEW를 생성하여라.
create or replace view emp30_view
as
select  empno emp_no,ename name,sal salary from emp
where deptno=30;
select * from emp30_view;

create or replace view emp30_view(eno,name,salary,dno)
as select empno,ename,sal,deptno from emp
where deptno=30;
update emp set deptno=20 where empno=7499;
select*from emp30_view;

emp와 dept 테이블을 join해서 view를 만드세요
create or replace view emp_dept_view
as
select * from dept d join emp e
using(deptno);

create or replace view emp_dept_view
as
select e.deptno,dname,ename,job from dept d join emp e
on d.deptno = e.deptno;

select*from emp_dept_view order by 1;
--#WITH READ ONLY 옵션
--WITH READ ONLY 옵션을 주면 뷰에 DML문장을 수행할 수 없다.
create or replace view emp10_view
as select empno,ename,job,deptno
from emp where deptno=10
with read only;
select * from emp10_view;

update emp10_view set job='SALESMAN' where empno=7782;
--cannot perform a DML operation on a read-only view

--#WITH CHECK OPTION 옵션
create or replace view emp_sales_view
as select*from emp where job='SALESMAN'
WITH CHECK OPTION;
select * from emp_sales_view;
update emp_sales_view set deptno=10 where empno=7499;
==>수정가능함

update emp_sales_view set job='MANAGER' WHERE ENAME='WARD';
--view WITH CHECK OPTION where-clause violation

--원테이블을 수정하면 관련된 뷰도 수정된다.
--뷰를 수정하면 원테이블은?


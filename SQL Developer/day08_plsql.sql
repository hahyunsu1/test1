--# 패키지
--여러 개의 프로시저, 함수, 커서 등을 하나의 패키지로 묶어 관리할 수 있다.
--- 선언부
--- 본몬(package body)

create or replace package empInfo as
procedure allEmp;
procedure allSal;
end empInfo;
/

--패키지 본문 구성
create or replace package body empInfo as
    procedure allEmp
    is
    cursor empCr is
    select empno,ename,hiredate from emp
    order by 3;
    
    begin
    for k in empCr loop
        dbms_output.put_line(k.empno||lpad(k.ename,16,' ')||lpad(k.hiredate,16,' '));
    end loop;
    exception
        when others then
        dbms_output.put_line(SQLERRM||'에러가 발생함');
    end allEmp;
    -- allSal은 전체 급여 합계, 사원수, 급여평균, 최대급여, 최소급여를 가져와 출력하는 프로시저
    procedure allSal
    is
    begin
        dbms_output.put_line('급여총합'||lpad('사원수',10,' ')||lpad('급여평균',10,' ')||
            lpad('최대급여',10,' ')||lpad('최소급여',10,' '));
        for k in (select sum(sal) sm,count(empno) cnt, round(avg(sal)) av,
        max(sal)mx,min(sal)mn from emp ) loop
            dbms_output.put_line(k.sm||lpad(k.cnt,10,' ')||lpad(k.av,10,' ')||
            lpad(k.mx,10,' ')||lpad(k.mn,10,' '));
        end loop;
    end allSal;
end empInfo;
/
set serveroutput on
exec empInfo.allEmp;
exec empInfo.allSal;

--# TRIGGER
--INSERT,UPDATE,DELETE 문이 실행될떄 묵시적으로 수행되는 일종의 프로시저

create or replace trigger trg_dept
before
update on dept
for each row
begin 
    dbms_output.put_line('변경 전 컬럼값: '|| :OLD.DNAME);
    dbms_output.put_line('변경 후 컬럼값: '|| :NEW.DNAME);
end;
/
select * from dept;
update dept set dname='운영부' where deptno=40;
rollback;

--트리거 비활성화
alter trigger trg_dept disable;
--트리거 활성화
alter trigger trg_dept enable;
--데이터사전에서 조회
select* from user_triggers where trigger_name='trg_dept';
--트리거 삭제
drop trigger trg_dept;
--EMP 테이블에 데이터가 INSERT되거나 UPDATE될 경우 (BEFORE)
--전체 사원들의 평균급여를 출력하는 트리거를 작성하세요.
create or replace trigger trg_emp
before

insert or update on emp
for each row
--when : new.empno > 0
declare
avg_sal number;
begin 
select round(avg(sal),2)
into avg_sal
from emp;
    dbms_output.put_line('급여 평균 : '|| avg_sal);    
end;
/
insert into emp(empno,ename,deptno,sal)
values(9000,'PETER',20,5000);
update emp set sal=sal*1.1 where deptno=10;
drop trigger trg_emp;
rollback;
select avg(sal) from emp where deptno=10;
alter trigger trg_emp disable;

--[트리거 실습 1]
--입고 테이블에 상품이 입고될 경우
--상품 테이블에 상품 보유수량이 자동으로 변경되는 
--트리거를 작성해봅시다.
create table myproduct(
pcode char(6) primary key,
pname varchar2(20) not null,
pcompany varchar2(20),
price number(8),
pqty number default 0
);
--'A001','A002'
create sequence myproduct_seq
start with 1
increment by 1
nocache;

insert into myproduct
values('A00'||myproduct_seq.nextval,'노트북','A사',800000,10);
insert into myproduct
values('A00'||myproduct_seq.nextval,'자전거','B사',100000,20);
insert into myproduct
values('A00'||myproduct_seq.nextval,'킥보드','C사',70000,30);
commit;
select * from myproduct;
--입고 테이블
create table myinput(
    incode number primary key,--입고번호
    pcode_fk char(6) references myproduct (pcode),--입고상품코드
    indate date default sysdate,--입고일
    inqty number(6),
    inprice number(8)
);
create sequence myinput_seq nocache;
--입고 테이블에 상품이 들어오면
--상품 테이블의 보유수량을 변경하는 트리거를 작성하세요
create or replace trigger trg_input_product
after
insert on myinput
for each row
declare 
    cnt number := :new.inqty;
    code char(6) := :new.pcode_fk;
begin
    update myproduct set pqty = pqty+cnt where pcode = code;
    dbms_output.put_line(code||'상품이 추가로 '||cnt||'개 들어옴');
end;
/
--입고 테이블에 A001상품을 10개 500000원에 insert하기
select * from myproduct;
insert into myinput
values(myinput_seq.nextval,'A002',sysdate,8,50000);
rollback;
--입고 테이블의 수량이 변경될 경우 -update문이 실행될 떄
--상품 테이블의 수량을 수정하는 트리거를 작성하세요
create or replace trigger trg_input_product
before
update on myproduct
for each row
declare 
   
begin
    update myproduct set pqty = pqty+cnt where pcode = code;
    dbms_output.put_line(code||'상품이 추가로 '||cnt||'개 들어옴');
end;
/
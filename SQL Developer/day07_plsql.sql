--# IN OUT PARAMETER
--프로시저가 읽고 쓰는 작업을 동시에 할 수 있는 파라미터
create or replace procedure inout_test(
    a1 in number,
    a2 in varchar2,
    a3 in out varchar2,
    a4 out varchar2
)
is
    msg varchar2(30) := '';
begin
     dbms_output.put_line('---------------');
     dbms_output.put_line('프로시저 시작 전');
     dbms_output.put_line('---------------');
     dbms_output.put_line('A1: '||a1);
     dbms_output.put_line('A2: '||a2);
     dbms_output.put_line('A3: '||a3);
     dbms_output.put_line('A4: '||a4);
     a3 := '프로시저 외부에서 이 값을 받을 수 있을까요?';
    msg := 'SUCCESS';
     a4 := msg;
     dbms_output.put_line('---------------');
     dbms_output.put_line('프로시저 시작 후');
     dbms_output.put_line('---------------');
     dbms_output.put_line('A1: '||a1);
     dbms_output.put_line('A2: '||a2);
     dbms_output.put_line('A3: '||a3);
     dbms_output.put_line('A4: '||a4);
 end;
 /
 variable c varchar2(100);
  variable d varchar2(100);
  exec inout_test(5000,'안녕',:c, :d);
  print d
  print c
--사번을 인파라미터로 전달하면 사원의 부서번호에 따라 소속된 부서명을
--문자열로 출력하는 프로시저
--10 회계부서
--20 연구부서
--30 영업부서
--40 운영부서
create or replace procedure dept_find(pno in emp.empno%type)
is
vdno emp.deptno%type;
vename emp.ename%type;
vdname varchar2(20);
begin
    select ename,deptno into vename,vdno
    from emp
    where empno = pno;
    if VDNO=10 then VDNAME :='회계부서';
    elsif VDNO=20 then VDNAME :='연구부서';
    elsif VDNO=30 then VDNAME :='영업부서';
    elsif VDNO=40 then VDNAME :='운영부서';
    else VDNAME:='아직 부서 배정 못받음';
    end if;
    dbms_output.put_line(VENAME||'님은 '||VDNO||'번 '||VDNAME||'에 있습니다');
end;
/
set serveroutput on
exec dept_find(7499);
--
--사원명을 인파라미터로 전달하면
--해당 사원의 연봉을 계산해서 출력하는 프로시저를 작성하되,
--연봉은 COMM이 NULL인 경우와 NULL아 아닌경우를 나눠서 계산하세요
--출력문
--사원명  월급여  보너스 연봉 
--출력하세요

create or replace procedure emp_sal(pname in emp.ename%type)
is
vsal emp.sal%type;
vcomm emp.comm%type;
total number(8);
begin
    select sal,comm into vsal,vcomm
    from emp
    where ename = upper(pname);
    if vcomm is null then total := vsal*12;
    else total := vsal*12+vcomm;
    end if;
    dbms_output.put_line(pname||'-------');
    dbms_output.put_line('월급여: '||vsal);
    dbms_output.put_line('보너스: '||vcomm);
    dbms_output.put_line('연 봉: '||total);
    exception
    when no_data_found then
    dbms_output.put_line(pname||'님은 없습니다.');
    when too_many_rows then
     dbms_output.put_line(pname||'님 데이터가 2건 이상입니다.');
end;
/
exec emp_sal('martin');
exec emp_sal('king');
exec emp_sal('dfd');
exec emp_sal('tom');
insert into emp(empno,ename,sal,comm)
values(8002,'TOM',2000,3000);
commit;

--# FOR LOOP문
declare
vsum number(4) :=0;
begin
    --1부터 10까지의 합
    for i in reverse 1 .. 10 loop
    dbms_output.put_line(i);
    vsum:=vsum+i;
    end loop;
    dbms_output.put_line('까지의 합:'||vsum);
end;
/
--JOB을 인파라미터로 전달하면 해당 업무를 수행하는 사원들의 정보
--사번, 사원명, 부서번호, 부서명, 업무를 출력하세요
--FOR LOOP를 이용해서 풀되 서브쿼리를 이용하세요
select *from emp;
select *from dept;
create or replace procedure emp_job(pjob in emp.job%type)
is

begin
for e in(select empno,ename,deptno,job,(
        select dname from dept where deptno = emp.deptno) dname
        from emp
        where job=pjob) loop
        dbms_output.put_line(e.empno||lpad(e.ename,10,' ')||lpad(e.deptno,8,' ')
                            ||lpad(e.job,12,' ')||lpad(e.dname,16,' '));
        end loop;
end;
/
exec emp_job('ANALYST');


--1~100까지의 숫자 중 짝수만 출력하기
-- exit when 조건;
-- coninue when 조건;

declare
vsum number(4) :=0;
begin
    --1부터 100까지의 합
    for k in  1 .. 100 loop
    continue when mod(k,2)=1;
    dbms_output.put_line(k);
    end loop;    
end;
/
--#LOOP 문
--LOOP
-- 실행문장;
--EXIT [WHEN 조건문]
--end loop;

--EMP테이블에 사원정보를 등록하되 LOOP문 이용해서 등록해봅시다.
--'NONAME1'

declare
vcnt number(3) := 100;
begin
    loop
        insert into emp(empno,ename,hiredate)
        values(vcnt+8000,'noname'||vcnt,sysdate);
    vcnt := vcnt+1;
    exit when vcnt > 105;
    dbms_output.put_line(vcnt-100||'건의 데이터 입력 완료');
    end loop;
end;
/
rollback;

# WHILE LOOP문
--while 조건 loop
-- 실행문
-- exit when 조건;
-- end loop;
declare
vcnt number(3) :=0;
begin
    while vcnt < 10 loop
        vcnt := vcnt+2;
        continue when vcnt=4;
        dbms_output.put_line(vcnt);
        
    end loop;
end;
/
--# case문
--case 비교기준
-- when 값1 then 실행문;
-- when 값2 then 실행문;
-- ...
--else
-- 실행문
--end case;
--평균점수를 인파라미터로 전달하면
--학점을 출력하는 프로시저를 작성하세요
--프로시저명: GRADE_AVG
--100~90 : A
--81 => B
--77 => C
--60점대 => D
--나머지 => F

create or replace procedure grade_avg(score in number)
is 
hak char(1) :='F';
begin 
case 
when score >=90 then hak:='A';
when score >=80 then hak:='B';
when score >=70 then hak:='C';
when score >=60 then hak:='D';
else hak:='F';
end case;
dbms_output.put_line(score||'점 '||hak||'학점');
end;
/
exec grade_avg(70);

CREATE OR REPLACE PROCEDURE GRADE_AVG (SCORE IN NUMBER)
IS
BEGIN
    CASE FLOOR(SCORE/10)
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A');
        WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('A');
        WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('B');
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('C');
        WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('D');
        ELSE 
        DBMS_OUTPUT.PUT_LINE('F');
    END CASE;
END;
/
#암시적 커서
create or replace procedure implicit_cursor
(pno in emp.empno%type)
is
vsal emp.sal%type;
update_row number;
begin
    select sal into vsal
    from emp where empno = pno;
    --검색된 데이터가 있다면
    if sql%found then
    dbms_output.put_line(pno||'번 사원의 월급여는 '||vsal||'입니다.10% 인상예정입니다');
    end if;
    update emp set sal=sal*1.1 where empno=pno;
    update_row:= sql%rowcount;
    dbms_output.put_line(update_row||'명의 사원이 급여가 인상되었어요');
    select sal into vsal
    from emp where empno = pno;
     if sql%found then
    dbms_output.put_line(pno||'번 사원의 인상된 월급여는 '||vsal||'입니다.');
    end if;
end;
/
exec implicit_cursor(7788);
rollback;
/*
# 명시적 커서
커서 선언
커서 OPEN
반복문 돌면서
커서에서 fetch한다.
커서 close
*/
create or replace procedure emp_all
is
vno emp.empno%type;
vname emp.ename%type;
vdate emp.hiredate%type;
--커서 선언
cursor emp_cr is
    select empno,ename,hiredate     
    from emp order by 1 asc;
begin
    --커서 오픈
    open emp_cr;
    loop
    fetch emp_cr into
    vno,vname,vdate;
    exit when emp_cr%notfound;
    dbms_output.put_line(vno||lpad(vname,12,' ')||lpad(vdate,12,' '));
    end loop;    
    --커서 닫기
    close emp_cr;
end;
/
execute emp_all;
--[실습] 부서별 사원수, 평균급여, 최대급여, 최소급여를 가져와 출력하는
--      프로시저를 작성하세요.
select*from emp;
select*from dept;
create or replace procedure emp_crs
is
vdeptno emp.deptno%type;
vcnt number;
vavg number;
vmax number;
vmin number;
cursor cr is
select deptno,count(empno) cnt,round(avg(sal),1) avg_sal,max(sal) max_sal,min(sal) min_sal
from emp group by deptno having deptno is not null order by 1;
begin
    --for 루프에서 커서를 이용하면 별도로 open,fetch,close할 필요가 없음
    for k in cr loop
    
    dbms_output.put_line(k.deptno||lpad(k.cnt,10,' ')||lpad(k.avg_sal,10,' ')||
    lpad(k.max_sal,10,' ')||lpad(k.min_sal,10,' '));
    
    end loop;
end;
/
exec emp_crs;

--부서테이블의 모든 정보를 가져와 출력하는 프로시저를 작성하되
--FOR LOOP이용하기
create or replace procedure dept_all
is
begin
    for k in (select * from dept order by deptno) loop
        dbms_output.put_line(k.deptno||lpad(k.dname,12,' ')||lpad(k.loc,12,' '));
        end loop;
end;
/
exec dept_all;
rollback;
#미리 정의된 예외 처리하기
select * from member;
--MEMBER 테이블의 USERID 컬럼에 UNIQUE 제약조건을 추가하되 제약조건 이름 주어 추가하세요
alter table member add constraint member_userid_uk unique(userid); 

create sequence member_seq
start with 11
increment by 1
nocache;
--MEMBER테이블에 새로운 레코드를 추가하는 프로시저를 작성하되
--인파라미터로 회원명, 아이디, 비밀번호, 나이, 직업, 주소
--를 주고 해당 데이터를 INSERT 하는 프로시저를 작성하세요
create or replace procedure member_add(
pname in member.name%type,
pid in member.userid%type,
pwd in member.passwd%type,
page in number,
pjob in member.job%type,
paddr in member.addr%type)
is
vname member.name%type;
vuid member.userid%type;
begin
insert into member(num,userid,name,passwd,age,job,addr,reg_date)
values(member_seq.nextval,pid,pname,pwd,page,pjob,paddr,sysdate);
if sql%rowcount>0 then
dbms_output.put_line('회원가입 완료');
end if;
select name,userid into vname,vuid
from member where name=pname;
dbms_output.put_line(PNAME||'님 '||VUID||'아이디로 등록되었습니다');

exception
when dup_val_on_index then
dbms_output.put_line('등록할려는 아이디는 이미 등록되어 있어요');
when too_many_rows then
dbms_output.put_line(pname||'님 데이터는 2건 이상 있습니다');
when others then
dbms_output.put_line('기타 예상치 못했던 예외 발생: '||sqlerrm||sqlcode);
end;
/
exec member_add('김희원','KIM2','123',22,'학생','서울 마포구');

select * from member order by reg_date desc;

# 사용자 정의 예외 만들고 발생시키기

select count(*) from emp
group by deptno;
--부서 인원이 5명 미만이면 사용자정의 예외를 만들어 발생시키자
create or replace procedure user_except
(pdno in dept.deptno%type)
is
--예외 선언
    my_define_error exception;
    vcnt number;
begin
    select count(empno) into vcnt
    from emp where deptno = pdno;
    --2. 예외 발생시키기=> RAISE문을 이용
    if vcnt < 5 then
        raise my_define_error;
    end if;
    dbms_output.put_line(pdno||'번 부서 인원은 '||vcnt||'명 입니다');
    --3.예외 처리 단계
    exception
        when my_define_error then
            raise_application_error(-20001,'부서 인원이 5명 미만인 부서는 안돼요');
end;
/
exec user_except(60);
# FUNCTION
-실행 환경에 반드시 하나의 값을 RETURN해야 한다.

--사원명을 입력하면 해당 사원이 소속된 부서명을 반환하는 함수를 작성하세요
create or replace function get_dname(
pname in emp.ename%type)
--반환해줄 데이터 유형을 지정
return varchar2
is
vdno emp.deptno%type;
vdname dept.dname%type;
begin
    select deptno into vdno from emp
    where ename=pname;
    select dname into vdname from dept
    where deptno = vdno;
    return vdname; -- 값을 반환 한다.
    exception
    when no_data_found then
    dbms_output.put_line(pname||'사원은 없습니다');
    return sqlerrm;
    when too_many_rows then
    dbms_output.put_line(pname||'사원 데이터가 2건 이상입니다');
    return sqlerrm;
end;
/

var gname varchar2;
exec :gname := get_dname('TOM');
print gname;

--#모든 메모 목록을 가져오는 프로시저를 작성해서 자바와 연동해봅시다.
create or replace procedure memo_all(
mycr out SYS_REFCURSOR)
is
begin
open mycr for
select idx,name,msg,wdate from memo
order by idx desc;
end;
/

select *from emp;
select *from dept;
create or replace procedure emp_mycr(
pdeptno in emp.deptno%type,
mycr out SYS_REFCURSOR
)
is

begin
open mycr for 
select d.deptno ename,job,hiredate,dname,loc from
(select * from emp where emp.deptno=pdeptno) a join dept d
on a.deptno =d.deptno;
        
end;
/

select * from memo;
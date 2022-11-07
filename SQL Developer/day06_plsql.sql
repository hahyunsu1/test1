--프로시저 익명 블럭
---선언부
---실행부
---예외처리부;
DECLARE
--선언부에서는 변수 선언을 할 수 있다.
I_MSG VARCHAR2(100);
BEGIN
--실행부에는 SQL 또는 PL/SQL문이 올 수 있다.
I_MSG :='HELLO ORACLE';
DBMS_OUTPUT.PUT_LINE(I_MSG);
END;
/
SET SERVEROUTPUT ON


--[2] 이름을 갖는 프로시저
create or replace procedure print_time
is
--선언부
    vtime1 timestamp;
    vtime2 timestamp;
begin
--실행부 날짜 + 숫자 : 일수를 다함,  날짜+숫자/24 : 시간을 더함
    select systimestamp - 1/24 into vtime1 from dual;
    select systimestamp + 2/24 into vtime2 from dual;
    dbms_output.put_line('한 시간 전: '||vtime1);
    dbms_output.put_line('두 시간 후: '||vtime2);

end;
/

--프로시저 실행방법
EXECUTE PRINT_TIME;

select systimestamp from dual;



create or replace procedure emp_info(pno in number)
is
vno number(4);--스칼라 타입
vname emp.ename%type;-- emp테이블의 ename컬럼과 같은 자료유형으로 하겠다는 의미
vdname dept.dname%type;
vjob emp.job%type;
vdno emp.deptno%type;
begin
--SELECT INTO로 가져온 데이터 변수에 할당하기
SELECT ename,job,deptno into vname,vjob,vdno
from emp where empno=pno;
select dname into vdname from dept
where deptno=vdno;
--dbms로 출력하기
dbms_output.put_line('----'||pno||'번 사원정보----');
dbms_output.put_line('사원명: '||vname);
dbms_output.put_line('담당업무: '||vjob);
dbms_output.put_line('부 서 명: '||vdname);
exception
 when no_data_found then 
 dbms_output.put_line(pno||'번 사원은 존재하지 않아요');
end;
/
EXECUTE emp_info(8499);

%TYPE : REFERENCE 타입. 테이블명/컬럼명%TYPE
%ROWTYPE : COMPOSITE 타입 테이블명%ROWTYPE : 테이블의 행과 같은 타입

부서번호를 인파라미터로 주면
해당 부서의 부서명과 근무지를 출력하는 프로시저를 작성합시다

create or replace procedure rtype(pdno in dept.deptno%type)
is
vdept dept%rowtype;
begin
select dname,loc into vdept.dname,vdept.loc
from dept where deptno=pdno;

dbms_output.put_line('부서번호: '||pdno);
dbms_output.put_line('부 서 명: '||vdept.dname);
dbms_output.put_line('부서위치: '||vdept.loc);
exception
when no_data_found then
dbms_output.put_line(pdno||'번 부서 정보는 없습니다.');

end;
/
execute rtype(50);

# TABLE TYPE : COMPOSITE TYPE(복합데이터 타입) => 배열과 비슷함
--TABLE 타입에 접근하기 위한 인덱스가 있는데 BINARY_INTEGER 데이터 형의 인덱스
--를 이용할 수 있다.


--TYPE table_type_name IS TABLE OF
--[column_type | variable%TYPE| table.column%TYPE) [NOT NULL]
-- [INDEX BY BINARY_INTEGER];
-- identifier table_type_name;

사원들의 업무 정보를 담을 테이블 타입의 변수를 선언하고
사원들의 업무 정보를 저장하기 
반복문 이용해서 이름과 업무 정보를 출력하기

create or replace procedure table_type(pdno in emp.deptno%type)
is
--테이블 선언
    type ename_table is table of emp.ename%type    
    index by binary_integer;
    type job_table is table of emp.job%type
    index by binary_integer;
--테이블 타입의 변수 선언
    ename_tab ename_table;    
    i binary_integer :=0;
    job_tab job_table;
begin
    for k in (select ename,job from emp where deptno=pdno) loop
    i:=i+1;
--테이블 변수에 가져온 값들을 저장하자.
    ename_tab(i) :=k.ename;
    job_tab(i) := k.job;
    end loop;
    
--테이블 타입에 저장된 값을 출력하자.
    for j in 1..i loop
    dbms_output.put_line(ename_tab(j)||': '||job_tab(j));
     
    end loop;
end;
/
execute table_type(30);

상품번호를 입력하면 해당상품의 상품명, 판매가, 제조사를 출력하는 프로시저를 작성하세요

accept pnum prompt'조회할 사원의 이름을 입력하세요'
--pnum을 사용할 때는 &pnum
declare
    type prod_record_type is record(
        vpname products.products_name%type,
        vprice products.output_price%type,
        vcomp products.company%type,
        
    );
--레코드 타입의 변수 선언
    prod_rec prod_record_type;
    VPNUM NUMBER :='&PNUM';
    
begin
    select products_name,output_price, company
    into prod_rec
    from products
    where PNUM=VPNUM;
    dbms_output.put_line(&PNUM||'번 상품 정보-------');
    dbms_output.put_line('상품명 '||prod_rec.vpname);    
    dbms_output.put_line('제조사 '||prod_rec.vcomp);  
    dbms_output.put_line('가격 '||LTRIM(TO_CHAR(prod_rec.vprice,'999,999,999'))||'원');
end;
/
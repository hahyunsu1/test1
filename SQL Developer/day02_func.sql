1. 단일행 함수
2. 그룹함수
3. 기타 함수


#
[1] 문자형 함수
[2] 숫자형 함수
[3] 날짜형 함수
[4] 변환 함수
[5] 일반 함수

#[1] 문자형 함수
select lower('HAPPY BIRTHDAY'), UPPER('Happy Birthday') FROM DUAL;

--select * from dual;
--1행 1열을 갖는 더미 테이블

select 9*7 from dual;

#initcap(): 첫문자만 대문자로 변환
select deptno,dname,initcap(dname),initcap(loc) from dept;

# concat(변수1,변수2) : 2개 이상의 문자를 결합해준다.
select concat('abc','1234') from dual;

-- [문제] 사원 테이블에서 SCOTT의 사번,이름,담당업무(소문자로),부서번호를
--		출력하세요.
select empno,ename,lower(job),deptno from emp;
--	 상품 테이블에서 판매가를 화면에 보여줄 때 금액의 단위를 함께 
--	 붙여서 출력하세요.
 select products_name,output_price ||'원', concat(output_price,'원')"판매가"
 from products;
--	 고객테이블에서 고객 이름과 나이를 하나의 컬럼으로 만들어 결과값을 화면에
--	       보여주세요.
select concat(name,age) from member;

# substr(변수,i,len) : 문자 i 인덱스로 시작한 len 문자 길이만큼의 변수를 반환함
i가 양수일경우: 앞에서부터 인덱스를 찾음
음수일경우: 뒤에서부터 인덱스를 찾음
select substr('ABCDEFG',3,4),substr('ABCDEFG',-3,2) from dual;
select substr('881203-1012369',8) from dual;
select substr('881203-1012369',-7) from dual;

# LENGTH(변수) : 문장ㄹ길이 반환

select length('991203-1012369') from dual;


--[문제]
--	사원 테이블에서 첫글자가 'K'보다 크고 'Y'보다 작은 사원의
--	  사번,이름,업무,급여를 출력하세요. 단 이름순으로 정렬하세요.
select empno,ename,job,sal from emp 
where substr(ename,1,1) > 'K' and substr(ename,1,1) <'Y';

--	사원테이블에서 부서가 20번인 사원의 사번,이름,이름자릿수,
--	급여,급여의 자릿수를 출력하세요.
select empno,ename,length(ename),sal,length(sal)
from emp
where deptno=20;
--	사원테이블의 사원이름 중 6자리 이상을 차지하는 사원의이름과 
--	이름자릿수를 보여주세요.

select ename, length(ename) from emp
where length(ename) >=6;

#LPAD/RPAD
--LPAD(컬럼,변수1,변수2): 문자값을 왼쪽부터 체운다.
--RPAD(컬럼,변수1,변수2): 문자값을 오른족부터 채운다.

select ename, lpad(ename,15,'*'),sal,lpad(sal,10,'*') from emp
where deptno=10;


select dname, RPAD(DNAME,15,'#') from dept;


#LTRIM/RTRIM
LTRIM(변수1,변수2): 변수1의 값중 변수2와 같은 단어가 있으면 
                    그분자를 삭제한 나머지값을 반환함
                    
select ltrim('TTTHELLO TEST','T'),rtrim('TTTHELLO TEST','T') from dual;
select rtrim(ltrim('   HELLO ORACLE   ')) A from dual;

#replace(컬럼,변수1,변수2): 컬럼값중 변수1에 해당하는 문자를 변수2로 대체한다

select replace('ORACLE TEST','TEST','HI') from dual;

--사원테이블에서 담당업무 중 좌측에 'A'를 삭제하고
--급여중 좌측의 1을 삭제하여 출력하세요.
select job,ltrim(job, 'A' ),ltrim(sal ,1) from emp;
--사원테이블에서 10번 부서의 사원에 대해 담당업무 중 우측에'T'를
--	삭제하고 급여중 우측의 0을 삭제하여 출력하세요.
select job, rtrim(job,'T'),rtrim(sal,0) from emp;
--사원테이블 JOB에서 'A'를 '$'로 바꾸어 출력하세요.
select job, REPLACE(JOB,'A','$') from emp;
--고객 테이블의 직업에 해당하는 컬럼에서 직업 정보가 학생인 정보를 모두
--	 대학생으로 변경해 출력되게 하세요.
select job, REPLACE(JOB,'학생','대학생') from MEMBER;	

-- 고객 테이블 주소에서 서울시를 서울특별시로 수정하세요.
select name,addr from member;

update member set addr = replace(addr,'서울시','서울특별시');

rollback;

#[2]숫자형 함수
#ROUND(값,ROUND(값,자리수):반올림 함수
자리수가 양수면 소수자리를,
자리수가 음수면 정수자리를 반올림한다
select round(4567.567),ROUND(456.567,0),ROUND(4567.567,2),
ROUND(4567.567,-2) from dual;

#TRUC() : 절삭함
select FLOOR(4567.567),trunc(4567.567),
trunc(4567.567,0),trunc(4567.567,2),
trunc(4567.567,-2) from dual;

#MOD(값1,값2) : 나머지값을 반환
--고객 테이블에서 회원이름, 마일리지,나이, 마일리지를 나이로 나눈값을 반올림하여 출력하세요
select name,mileage,age,ROUND(MILEAGE/age,1) from member;
--상품 테이블의 상품 정보가운데 백원 단위까지 버린 배송비를 비교하여 출력하세요.
select products_name,trans_cost,TRUNC(trans_cost,-3) from products;
--사원테이블에서 부서번호가 10인 사원의 급여를 	30으로 나눈 나머지를 출력하세요
select deptno,ename,sal,TRUNC(sal/30),mod(sal,30) from emp
where deptno=10;

select chr(65),ascii('A') from dual;

# ABS(값): 절대값을 구하는 함수
select name,age,age-40,abs(age-40) from member;

#CEIL(값):올림값
#FLOOR(값):내림값

select CEIL(123.001),FLOOR(123.001) from dual;

#POWER()
#SQRT()
#SIGN()
select power(2,7),sqrt(64),sqrt(133) from dual;

select age-40,sign(age-40) from member;

[3] 날짜형 함수

select SYSDATE,SYSTIMESTAMP FROM dual;
날짜 + 숫자 : 일수를 날짜에 더함
select SYSDATE +3 "3윌 뒤", SYSDATE -2 "이틀전" from dual;

select SYSTIMESTAMP,to_char(SYSTIMESTAMP+2/24,'YY/MM/DD HH24:MI:SS') 
"두시간뒤" from dual;
--사원테이블에서 현재까지의 근무 일수가 몇 주 몇일인가를 출력하세요
--단 근무 일수가 많은 사람순으로 출력하세요
select concat(round((sysdate-hiredate)/7),'주'),
concat(floor(mod(sysdate-hiredate,7)),'일') from emp;

select hiredate,sysdate,trunc(sysdate-hiredate),trunc((sysdate-hiredate)/7)
weeks, trunc(mod((sysdate-hiredate),7)) days from emp;

#MONTHS_BETWEEN(DATE1,DATE2) : 날짜2과 날짜2 사이의 월수를 계산함

select months_between(sysdate,TO_DATE('22-07-26','YY-MM-DD')) from emp;

#ADD_MONTHS(DATE,N) : 날짜에 N개월을 더함
select ADD_MONTHS(SYSDATE,2),ADD_MONTHS(SYSDATE,-2)from dual;

#LAST_DAY(D) : 월의 마지말 날짜를 반환함(평년/윤년 자동 계산함)
select LAST_DAY('22-02-01'),LAST_DAY('20-02-01'),LAST_DAY(SYSDATE) from dual;

--고객 테이블이 두 달의 기간을 가진 유료 회원이라는 가정하에 등록일을 기준으로
--유료 회원인 고객의 정보를 보여주세요.
select* from member;
select name,reg_date,ADD_MONTHS(REG_DATE,2) "서비스 만기일" from member;

select sysdate from dual;

select TO_CHAR(sysdate,'YY-MM-DD HH:MI:SS') FROM DUAL;

select TO_CHAR(SYSDATE,'CC YYYY-MONTH-ddd day') from dual;

select TO_CHAR(SYSDATE,'CC YEAR-MONTH-ddd day') from dual;

[4]변환 함수

TO_CHAR()
TO_DATE()
TO_NUMBER()

#TO_CHAR(날짜) : 날짜유형을 문자열로 변환한다
 TO_CHAR(숫자) : 숫자유형을 문자열로 변환한다
 
 TO_CHAR(D,출력형식)
 SELECT TO_CHAR(SYSDATE),TO_CHAR(SYSDATE,'yy-mm-dd hh12:mi:ss')from dual;

--고객테이블의 등록일자를 0000-00-00 의 형태로 출력하세요.
select name,reg_date,TO_CHAR(reg_date,'yyyy-mm-dd') from member;
--고객테이블에 있는 고객 정보 중 등록연도가 2003년인 
--고객의 정보를 보여주세요.
 SELECT * FROM MEMBER WHERE TO_CHAR(REG_DATE,'YYYY')='2013';

--고객테이블에 있는 고객 정보 중 등록일자가 2003년 5월1일보다 
--늦은 정보를 출력하세요. 
--단, 고객등록 정보는 년, 월만 보이도록 합니다.
select name,reg_date,TO_CHAR(reg_date,'yyyy-mm')from member where
TO_CHAR(reg_date,'yyyy-mm-dd')>'2013-05-01' ;   

TO_CHAR(N,출력형식) : 숫자형을 문자열로 변환

select TO_CHAR(100000,'999,999'),TO_CHAR(100000,'$999,999') from dual;


--73] 상품 테이블에서 상품의 공급 금액을 가격 표시 방법으로 표시하세요.
--	  천자리 마다 , 를 표시합니다.
select products_name,input_price,TO_CHAR(INPUT_PRICE,'999,999,999')"공급가격"
from products;
--74] 상품 테이블에서 상품의 판매가를 출력하되 주화를 표시할 때 사용하는 방법을
--사용하여 출력하세요.[예: \10,000]
select products_name,output_price,to_char(output_price,'L999,999,999')"판매가격"
from products;


# TO_DATE(STR,출력형식) : 문자열을 날짜유형으로 변환한다
 select to_date('20221128','yyyymmdd')+2 from dual;
 
 select *from member
 where reg_date > to_date('20130601','yyyymmdd');
 
 #TO_NUMBER(STR,출력형식) : 문자열을 숫자형식으로 변환한다
 select TO_NUMBER('10,000','99,999')*2 from dual;
 
-- '$8,590' ==> 숫자로 변환해보세요

select to_number('$8,590','$999g999')+10 from dual;

#그룹함수
-여러개의 행 또는 테이블 전체에 적용하여 하나의 결과를 반환하는 함수

select count(empno) from emp;
select count(comm) from emp;
--null값을 무시하고 센다
select count(distinct mgr) from emp;

create table test(a number,b number,c number);

desc test;
insert into test values(null,null,null);
commit;
select*from test;
select count(a) from test;
select count(*) from test;

select count(deptno) from dept;

AVG()
MAX()
MIN()
SUM()
--emp테이블에서 모든 SALESMAN에 대하여 급여의 평균,
--		 최고액,최저액,합계를 구하여 출력하세요.
select avg(sal),max(sal),min(sal),sum(sal),count(empno) from emp
where job='SALESMAN';
--EMP테이블에 등록되어 있는 인원수, 보너스에 NULL이 아닌 인원수,
--		보너스의 평균,등록되어 있는 부서의 수를 구하여 출력하세요.
select count(empno),count(comm),avg(comm),count(deptno) from emp;

 #그룹함수는 group by 절과 함께 사용된다
 emp에서 엄무별 인원수를 보여주세요
 
 select job,count(empno) from emp
 group by job;
 
 group by절을 이용할때에는 group by 절에서 사용한 컬럼과 그룹함수만 select 할수있다
--17] 고객 테이블에서 직업의 종류, 각 직업에 속한 최대 마일리지 정보를 보여주세요.
select job,max(mileage) from member
group by job;

--18] 상품 테이블에서 각 상품카테고리별로 총 몇 개의 상품이 있는지 보여주세요.
--또한 최대 판매가와 최소 판매가를 함께 보여주세요.
select CATEGORY_fk,count(pnum),max(output_price),min(output_price) from products
group by CATEGORY_fk order by 1;
--19] 상품 테이블에서 각 공급업체 코드별로 공급한 상품의 평균입고가를 보여주세요
select ep_code_fk,trunc(avg(input_price)) from products
group by EP_CODE_FK;

--문제1] 사원 테이블에서 입사한 년도별로 사원 수를 보여주세요.
select to_char(hiredate,'YY'),count(empno) from emp 
group by to_char(hiredate,'YY') order by 1;
 

--문제2] 사원 테이블에서 해당년도 각 월별로 입사한 사원수를 보여주세요.
select to_char(hiredate,'yy-mm'),count(empno) from emp 
group by to_char(hiredate,'yy-mm') order by 1;
--문제3] 사원 테이블에서 업무별 최대 연봉, 최소 연봉을 출력하세요.
select job,max(sal*12),min(sal*12) from emp
group by job;

#WGHO 
# HAVING 절
- GROUP BY 의 결과에 조건을 주어 제한할 떄 사용한다.
 
-- 20] 고객 테이블에서 직업의 종류와 각 직업에 속한 사람의 수가 
--	     2명 이상인 직업군의 정보를 보여주시오.
select count(num) from member
group by job having count(num) >=2;

--21] 고객 테이블에서 직업의 종류와 각 직업에 속한 최대 마일리지 정보를 보여주세요.
--	      단, 직업군의 최대 마일리지가 0인 경우는 제외시킵시다.
select job,max(mileage) from member
group by job having max(mileage) <> 0;
--	문제1] 상품 테이블에서 각 카테고리별로 상품을 묶은 경우, 해당 카테고리의 상품이 2개인 
--	      상품군의 정보를 보여주세요.
select category_fk,count(pnum) from products
group by category_fk having count(pnum) = 2;
--	문제2] 상품 테이블에서 각 공급업체 코드별로 상품 판매가의 평균값 중 단위가 100단위로 떨어
--	      지는 항목의 정보를 보여주세요.
select ep_code_fk,avg(output_price) from products
group by ep_code_fk having mod(avg(output_price),100)=0;
 
 
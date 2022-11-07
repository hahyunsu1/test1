부서테이블과 사원테이블을 조인해보자


select d.deptno, dname, e.deptno, ename,job,sal
from dept d,emp e
where d.deptno = e.deptno order by 1;

명시적 조인절을 이용한 조인 => 표준

select d.*,e.*
from dept d join emp e
on d.deptno = e.deptno order by 1;

--SALESMAN의 사원번호,이름,급여,부서명,근무지를 출력하여라.
select e.*,d.*
from emp e join dept d
on e.deptno = d.deptno and e.job='SALESMAN';

--서로 연관이 있는 카테고리 테이블과 상품 테이블을 이용하여 각 상품별로 카테고리
--이름과 상품 이름을 함께 보여주세요.
select category_name,products_name
from category c join products p
on c.category_code = p.category_fk ;


--카테고리 테이블과 상품 테이블을 조인하여 화면에 출력하되 상품의 정보 중
--제조업체가 삼성인 상품의 정보만 추출하여 카테고리 이름과 상품이름, 상품가격
--제조사 등의 정보를 화면에 보여주세요.

select category_name,products_name,output_price,company
from category c join products p
on c.category_code = p.category_fk and p.company='삼성';
--각 상품별로 카테고리 및 상품명, 가격을 출력하세요. 단 카테고리가 'TV'인 것은 
--제외하고 나머지 정보는 상품의 가격이 저렴한 순으로 정렬하세요
select category_name,products_name,output_price
from category c join products p
on c.category_code = p.category_fk and c.category_name <> 'TV' order by 3;

select d.dname,e.ename
from dept d join emp e
using(deptno);

emp의 sal ==> salgrade의 losal~hisal 사이에 있음
select empno,ename,sal,grade,losal,hisal
from emp e join salgrade s
on e.sal between s.losal and s.hisal;

--97] 공급업체 테이블과 상품 테이블을 조인하여 공급업체 이름, 상품명,
--		공급가를 표시하되 상품의 공급가가 100000원 이상의 상품 정보
--		만 표시하세요. 단, 여기서는 공급업체A와 공급업체B가 모두 표시
--		되도록 해야 합니다.

select ep_name,products_name,input_price
from supply_comp s join products p
on (s.ep_name='공급업체A' or s.ep_name='공급업체B') and p.input_price >= 100000

select d.*,e.*
from dept d,emp e
where d.deptno=e.deptno;

# OUTER JOIN
EQUAL 조건에 만족하지 않는 데이터가 있더라도 null로 설정하여 출력해줌

select d.deptno,dname,ename,job
from dept d, emp e
where d.deptno = e.deptno(+) order by 1;

명시적 조인절일 경우
[1] LEFT OUTER JOIN : 왼쪽 테이블을 기준으로 출력
[2] RIGHT OUTER JOIN : 오른쪽 테이블을 기준으로 출력
[3] FULL OUTER JOIN : 양쪽 다 아우터 조인을 거는 경우 

[1] LEFT OUTER JOIN
select distinct(e.deptno),d.deptno
from dept d left outer join emp e
on d.deptno = e.deptno order by 2;

[2] RIGHT OUTER JOIN
select distinct(e.deptno),d.deptno
from dept d right outer join emp e
on d.deptno = e.deptno order by 2;

[3] FULL OUTER JOIN
select distinct(e.deptno),d.deptno
from dept d full outer join emp e
on d.deptno = e.deptno order by 2;


--문제98] 상품테이블의 모든 상품을 공급업체, 공급업체코드, 상품이름, 
--상품공급가, 상품 판매가 순서로 출력하되 공급업체가 없는
--상품도 출력하세요(상품을 기준으로).
select   s.ep_code,ep_name,products_name,input_price,output_price
from supply_comp s right outer join products p
on s.ep_code = p.ep_code_fk;

--문제99] 상품테이블의 모든 상품을 공급업체, 카테고리명, 상품명, 상품판매가
--순서로 출력하세요. 단, 공급업체나 상품 카테고리가 없는 상품도
--출력합니다.
select   ep_name,category_name,products_name,output_price
from supply_comp s right outer join products p
on s.ep_code = p.ep_code_fk
left outer join category c
on p.category_fk = c.category_code;


# SELF JOIN
자기 테이블과 조인하는 경우
각 사원의 정보를 출력하되 사원들의 관리자 이름도 함께 보여주세요

select e.empno,e.ename,e.mgr,m.empno,m.ename "MANAGER"
from emp e join emp m
on e.mgr = m.empno;

[문제] emp테이블에서 "누구의 관리자는 누구이다"는 내용을 출력하세요

select e.ename||'의 관리자는 '||m.ename||'이다'
from emp e join emp m
on e.mgr = m.empno;

#UNION: 합집합
select deptno from dept union
select deptno from emp;

#UNION ALL
select deptno from dept union all
select deptno from emp;


#INTERSECT: 교집합
select deptno from dept intersect
select deptno from emp;
#MINUS: 차집합
#UNION: 합집합
select deptno from dept MINUS
select deptno from emp;

--1. emp테이블에서 모든 사원에 대한 이름,부서번호,부서명을 출력하는 
--   문장을 작성하세요.
select ename,job,sal,dname,loc
from emp e join dept d
on e.deptno = d.deptno and d.loc='NEW YORK';

--2. emp테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름,업무,급여,
--    부서명을 출력하는 SELECT문을 작성하세요.
select ename,dname, loc,comm
from dept d join emp e
on d.deptno = e.deptno and comm is not null;

--5. 아래의 결과를 출력하는 문장을 작성하에요(관리자가 없는 King을 포함하여
--	모든 사원을 출력)
select e.ename Employee,e.empno "Emp#",
m.ename Manager,m.empno "Mgr#"
from emp e left outer join emp m
on e.mgr = m.empno order by 3 desc;

select e.ename Employee,e.empno "Emp#",
m.ename Manager,m.empno "Mgr#"
from emp e , emp m
where e.mgr = m.empno(+) order by 3 desc;
--	---------------------------------------------
--	Emplyee		Emp#		Manager	Mgr#
--	---------------------------------------------
--	KING		7839
--	BLAKE		7698		KING		7839
--	CKARK		7782		KING		7839
--	.....
--	---------------------------------------------

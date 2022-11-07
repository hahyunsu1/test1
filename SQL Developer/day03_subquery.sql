-- ������̺��� scott�� �޿����� ���� ����� �����ȣ,�̸�,����
--	�޿��� ����ϼ���.


select sal from emp where ename=upper('scott');

select empno,ename,job,sal from emp
where sal > 3000;

select empno,ename,job,sal from emp
where sal>(select sal from emp where ename=upper('scott'));
--����2]������̺��� �޿��� ��պ��� ���� ����� ���,�̸�
--	����,�޿�,�μ���ȣ�� ����ϼ���.
select empno,ename,job,sal,deptno from emp
where sal<(select avg(sal) from emp);

--������̺��� ����� �޿��� 20�� �μ��� �ּұ޿�
--		���� ���� �μ��� ����ϼ���

select deptno,min(sal)
from emp
group by deptno
having min(sal)>(select min(sal) from emp where deptno=20);
--
--# ������ ��������
--: ���������� 1�� �̻��� ���� ��ȯ�ϴ� ���
--=>������ �������� �����ڸ� ����ؾ� �Ѵ�.
--in������
any
all
exists
--- �������� �ִ� �޿��� �޴� ����� 
--	 �����ȣ�� �̸��� ����ϼ���.
select job,empno,ename,sal from emp
where (job, sal) in(
select job,max(sal)
from emp group by job) order by 1;

# any ������

select deptno, ename, sal from emp
where deptno <> 20 and sal > any (select sal from emp where job='SALESMAN');

==> SALESMAN�� ����� �ּұ޿����� �����鼭 20���μ��� �ƴ� ��������� ����϶� �ǹ�

# ALL ������
select deptno, ename, sal from emp
where deptno <> 20 and sal > ALL (select sal from emp where job='SALESMAN');

==> SALESMAN�� ����� �ִ�޿����� �����鼭 20���μ��� �ƴ� ��������� ����϶� �ǹ�

# EXISTS : �������� ������ ���翩�θ� ���� �����ϴ� ���鸸 ����� ��ȯ�Ѵ�
-- ������ ������ ������ �����ּ���
select empno,ename, sal from emp e
where exists(select empno from emp where e.empno = mgr);

# ���߿� ��������

--�μ����� �ּұ޿��� �޴� ����� ���,�̸�,�޿�,�μ���ȣ�� ����ϼ���

select empno,ename,sal,deptno
from emp
where (deptno,sal)in(select deptno,min(sal) from emp group by deptno);
--84] �� ���̺� �ִ� �� ���� �� ���ϸ����� 
--���� ���� �ݾ��� �� ������ �����ּ���.
SELECT * FROM MEMBER
WHERE MILEAGE = (SELECT MAX(MILEAGE) FROM MEMBER);

--85] ��ǰ ���̺� �ִ� ��ü ��ǰ ���� �� ��ǰ�� �ǸŰ����� 
--�ǸŰ����� ��պ��� ū  ��ǰ�� ����� �����ּ���. 
--��, ����� ���� ���� ����� ������ ���� �Ǹ� ������
--50������ �Ѿ�� ��ǰ�� ���ܽ�Ű����.
SELECT * FROM PRODUCTS
WHERE OUTPUT_PRICE > ( SELECT AVG(OUTPUT_PRICE) FROM PRODUCTS
WHERE OUTPUT_PRICE<=500000)AND OUTPUT_PRICE <= 500000;
--86] ��ǰ ���̺� �ִ� �ǸŰ��ݿ��� ��հ��� �̻��� ��ǰ ����� ���ϵ� �����
--���� �� �ǸŰ����� �ִ��� ��ǰ�� �����ϰ� ����� ���ϼ���.
SELECT * FROM PRODUCTS
WHERE OUTPUT_PRICE >= ( SELECT AVG(OUTPUT_PRICE) FROM PRODUCTS
WHERE OUTPUT_PRICE<>(SELECT MAX(OUTPUT_PRICE)FROM PRODUCTS));

--87] ��ǰ ī�װ� ���̺��� ī�װ� �̸��� ��ǻ�Ͷ�� �ܾ ���Ե� ī�װ���
--���ϴ� ��ǰ ����� �����ּ���.
select * from products
where category_fk in(select category_code from category 
where category_name like '%��ǻ��%');
--88] �� ���̺� �ִ� ������ �� ������ �������� ���� ���̰� ���� ����� ������
--ȭ�鿡 �����ּ���.
select*from member
where (job,age)in(
select job,max(age) from member
group by job);
--* UPDATE������ ���

--89] �� ���̺� �ִ� �� ���� �� ���ϸ����� ���� ���� �ݾ���
--������ ������ ���ʽ� ���ϸ��� 5000���� �� �ִ� SQL�� �ۼ��ϼ���.
update member set mileage =	mileage + 5000 where mileage in 
(select max(mileage)from member);
select * from member;
rollback;

--90] �� ���̺��� ���ϸ����� ���� ���� ������ڸ� �� ���̺��� 
--������� �� ���� �ڿ� ����� ��¥�� ���ϴ� ������ �����ϼ���.
update member set reg_date = ( select max(reg_date)from member)
where MiLeage = 0;
--* DELETE������ ���
DELETE FROM ���̺�� WHERE ������;
--91] ��ǰ ���̺� �ִ� ��ǰ ���� �� ���ް��� ���� ū ��ǰ�� ���� ��Ű�� 
-- SQL���� �ۼ��ϼ���.
delete from products where input_price =(select max(input_price) 
from products);
select * from products;
rollback;




--92] ��ǰ ���̺��� ��ǰ ����� ���� ��ü���� ������ ��,
--�� ���޾�ü���� �ּ� �Ǹ� ������ ���� ��ǰ�� �����ϼ���.

select * from products order by category_fk;
         delete from products where output_price<=(
         select min(output_price) from products);
         select * from products;
         rollback;
--# INSERT���� SUBQUERY ���        
--CATEGORY���̺��� ī���ؼ� CATEGORY_COPY�� ����� �����ʹ� ���� ������ �����ϼ���
--�׷��� CATEGORY ���̺��� ������ǰ���� �����ͼ� CATEGORY_COPY�� INSERT�ϼ���

drop table category_copy;

create table category_copy
as
select * from category where 1=2;

select * from category_copy;

insert into category_copy
select * from category
where category_code like '0001%';

--EMP���� EMP_COPY ���̺�� ������ �����ϱ�         
--�޿������ 3��޿� ���ϴ� ��������鸸 EMP_COPY�� INSERT�ϼ���

create table emp_copy
as
select*from emp where 1=2;

select*from emp_copy;
insert into emp_copy
select e.* from emp e join salgrade s
on e.sal between s.losal and s.hisal and s.grade=3;

commit;

# FROM �������� �������� ===> INLINE VIEW
--EMP�� DEPT ���̺��� ������ MANAGER�� ����� �̸�, ����,�μ���,
--�ٹ����� ����ϼ���.
SELECT ENAME, JOB,DNAME,LOC
FROM EMP E JOIN DEPT D
USING(DEPTNO)
WHERE JOB='MANAGER';

--SUBQUERY �� ������ ������ Ǯ���
SELECT A.ENAME, JOB,DNAME,LOC FROM
(SELECT * FROM EMP WHERE JOB='MANAGER') A
JOIN DEPT D ON A.DEPTNO = D.DEPTNO;

RANK() OVER() �Լ� : �м����� �������� ��ŷ�� �Ű��ִ� �Լ�

SELECT ENAME,SAL FROM EMP
ORDER BY SAL DESC;
SELECT * FROM(
SELECT RANK()OVER(ORDER BY SAL DESC)RNK,EMP.*FROM EMP)
WHERE RNK <=5;

# ROW_NUMBER() OVER() : ���ȣ�� �Ű��ִ� �Լ�
SELECT*FROM(
SELECT ROWNUM RN, A.* FROM (
SELECT*FROM EMP ORDER BY HIREDATE DESC)A
)
WHERE RN <=5;
SELECT *FROM(
SELECT ROW_NUMBER() OVER(ORDER BY HIREDATE DESC) RN,EMP.*
FROM EMP) WHERE RN <=5;

select * from memo;
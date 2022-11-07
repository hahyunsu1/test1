�μ����̺�� ������̺��� �����غ���


select d.deptno, dname, e.deptno, ename,job,sal
from dept d,emp e
where d.deptno = e.deptno order by 1;

����� �������� �̿��� ���� => ǥ��

select d.*,e.*
from dept d join emp e
on d.deptno = e.deptno order by 1;

--SALESMAN�� �����ȣ,�̸�,�޿�,�μ���,�ٹ����� ����Ͽ���.
select e.*,d.*
from emp e join dept d
on e.deptno = d.deptno and e.job='SALESMAN';

--���� ������ �ִ� ī�װ� ���̺�� ��ǰ ���̺��� �̿��Ͽ� �� ��ǰ���� ī�װ�
--�̸��� ��ǰ �̸��� �Բ� �����ּ���.
select category_name,products_name
from category c join products p
on c.category_code = p.category_fk ;


--ī�װ� ���̺�� ��ǰ ���̺��� �����Ͽ� ȭ�鿡 ����ϵ� ��ǰ�� ���� ��
--������ü�� �Ｚ�� ��ǰ�� ������ �����Ͽ� ī�װ� �̸��� ��ǰ�̸�, ��ǰ����
--������ ���� ������ ȭ�鿡 �����ּ���.

select category_name,products_name,output_price,company
from category c join products p
on c.category_code = p.category_fk and p.company='�Ｚ';
--�� ��ǰ���� ī�װ� �� ��ǰ��, ������ ����ϼ���. �� ī�װ��� 'TV'�� ���� 
--�����ϰ� ������ ������ ��ǰ�� ������ ������ ������ �����ϼ���
select category_name,products_name,output_price
from category c join products p
on c.category_code = p.category_fk and c.category_name <> 'TV' order by 3;

select d.dname,e.ename
from dept d join emp e
using(deptno);

emp�� sal ==> salgrade�� losal~hisal ���̿� ����
select empno,ename,sal,grade,losal,hisal
from emp e join salgrade s
on e.sal between s.losal and s.hisal;

--97] ���޾�ü ���̺�� ��ǰ ���̺��� �����Ͽ� ���޾�ü �̸�, ��ǰ��,
--		���ް��� ǥ���ϵ� ��ǰ�� ���ް��� 100000�� �̻��� ��ǰ ����
--		�� ǥ���ϼ���. ��, ���⼭�� ���޾�üA�� ���޾�üB�� ��� ǥ��
--		�ǵ��� �ؾ� �մϴ�.

select ep_name,products_name,input_price
from supply_comp s join products p
on (s.ep_name='���޾�üA' or s.ep_name='���޾�üB') and p.input_price >= 100000

select d.*,e.*
from dept d,emp e
where d.deptno=e.deptno;

# OUTER JOIN
EQUAL ���ǿ� �������� �ʴ� �����Ͱ� �ִ��� null�� �����Ͽ� �������

select d.deptno,dname,ename,job
from dept d, emp e
where d.deptno = e.deptno(+) order by 1;

����� �������� ���
[1] LEFT OUTER JOIN : ���� ���̺��� �������� ���
[2] RIGHT OUTER JOIN : ������ ���̺��� �������� ���
[3] FULL OUTER JOIN : ���� �� �ƿ��� ������ �Ŵ� ��� 

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


--����98] ��ǰ���̺��� ��� ��ǰ�� ���޾�ü, ���޾�ü�ڵ�, ��ǰ�̸�, 
--��ǰ���ް�, ��ǰ �ǸŰ� ������ ����ϵ� ���޾�ü�� ����
--��ǰ�� ����ϼ���(��ǰ�� ��������).
select   s.ep_code,ep_name,products_name,input_price,output_price
from supply_comp s right outer join products p
on s.ep_code = p.ep_code_fk;

--����99] ��ǰ���̺��� ��� ��ǰ�� ���޾�ü, ī�װ���, ��ǰ��, ��ǰ�ǸŰ�
--������ ����ϼ���. ��, ���޾�ü�� ��ǰ ī�װ��� ���� ��ǰ��
--����մϴ�.
select   ep_name,category_name,products_name,output_price
from supply_comp s right outer join products p
on s.ep_code = p.ep_code_fk
left outer join category c
on p.category_fk = c.category_code;


# SELF JOIN
�ڱ� ���̺�� �����ϴ� ���
�� ����� ������ ����ϵ� ������� ������ �̸��� �Բ� �����ּ���

select e.empno,e.ename,e.mgr,m.empno,m.ename "MANAGER"
from emp e join emp m
on e.mgr = m.empno;

[����] emp���̺��� "������ �����ڴ� �����̴�"�� ������ ����ϼ���

select e.ename||'�� �����ڴ� '||m.ename||'�̴�'
from emp e join emp m
on e.mgr = m.empno;

#UNION: ������
select deptno from dept union
select deptno from emp;

#UNION ALL
select deptno from dept union all
select deptno from emp;


#INTERSECT: ������
select deptno from dept intersect
select deptno from emp;
#MINUS: ������
#UNION: ������
select deptno from dept MINUS
select deptno from emp;

--1. emp���̺��� ��� ����� ���� �̸�,�μ���ȣ,�μ����� ����ϴ� 
--   ������ �ۼ��ϼ���.
select ename,job,sal,dname,loc
from emp e join dept d
on e.deptno = d.deptno and d.loc='NEW YORK';

--2. emp���̺��� NEW YORK���� �ٹ��ϰ� �ִ� ����� ���Ͽ� �̸�,����,�޿�,
--    �μ����� ����ϴ� SELECT���� �ۼ��ϼ���.
select ename,dname, loc,comm
from dept d join emp e
on d.deptno = e.deptno and comm is not null;

--5. �Ʒ��� ����� ����ϴ� ������ �ۼ��Ͽ���(�����ڰ� ���� King�� �����Ͽ�
--	��� ����� ���)
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

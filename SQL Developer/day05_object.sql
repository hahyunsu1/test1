/*#������
����
CREATE SEQUENCE ��������
[INCREMENT BY n] --����ġ
[START WITH n] --���۰�
[(MAXVALUE n | NOMAXVALUE)]--�ִ밪
[(MINVALUE n | NOMINVALUE)]--�ּҰ�
[(CYCLE|NOCYCLE)]-- �ִ�,�ּҿ� ������ �� ��� ���� �������� ���θ� ����,nocycledl rlqhs
[(CACHE|NOCACHE)]--�޸� ĳ�� ����Ʈ ������ 20
*/
create sequence dept2_seq
start with 50
increment by 5
maxvalue 95
cache 20
nocycle;

�����ͻ������� ������ ��ȸ
select *from user_sequences;
-NEXTVAL : ������ ������
-CURRVAL : ������ ���簪
[����] NEXTVAL �� ȣ����� ���� ���¿��� CURRVAL�� ���Ǹ� ����������.

select dept2_seq.currval from dual; ==> ���� �߻���

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

--��������: TEMP_SEQ
--���۰�: 100���� ����
--����ġ: 5��ŭ�� ����
--�ּҰ��� 0����
--CYCLE �ɼ� �ֱ�
--ĳ�û�� ���� �ʵ���
create sequence temp_seq
start with 100
increment by -5
maxvalue 100
minvalue 0
nocache
cycle;

select temp_seq.nextval from dual;

--#������ ����
--[���ǻ���]���۰��� ������ �� ����. ���۰��� �����ҷ��� drop�ϰ� �ٽ� create�Ѵ�.
--
--ALTER SEQUENCE ��������
--[INCREMENT BY n] --����ġ
--[START WITH n] --���۰�
--[(MAXVALUE n | NOMAXVALUE)]--�ִ밪
--[(MINVALUE n | NOMINVALUE)]--�ּҰ�
--[(CYCLE|NOCYCLE)]-- �ִ�,�ּҿ� ������ �� ��� ���� �������� ���θ� ����,nocycledl rlqhs
--[(CACHE|NOCACHE)]--�޸� ĳ�� ����Ʈ ������ 20

dept2_seq�� �����ϵ� maxvalue�� 1000����
����ġ 1�� �����ϵ��� �����ϼ���

alter sequence dept2_seq
maxvalue 1000
increment by 1;
--start with 10;
--cannot alter starting sequence number

#������ ����

--drop sequence ��������

drop sequence temp_seq;
select*from user_sequences where sequence_name='DEPT2_SEQ';
insert into dept2 values(dept2_seq.nextval,'TEST','TEST');
select*from dept2;

select dept2_seq.currval from dual;

--
--#VIEW
--[���ǻ���]view�� �����ҷ��� CREATE VIEW ������ ������ �Ѵ�.
--CREATE VIEW ���̸�
--AS
--SELECT �÷���1,�÷���2....
--FROM �信 ����� ���̺��
--WHERE ����

--EMP���̺��� 20�� �μ��� ��� �÷��� �����ϴ� EMP20_VIEW�� �����϶�.

system
sasa9551   
�������� ������ ��
grant create view to scott;

create view emp20_view
as
select *
from emp
where deptno=20;

select * from emp20_view;
select * from user_views;
desc emp20_view;
#view ����
drop view emp20_view;

#VIEW ����
CREATE OR REPLACE ���̸�
AS SELECT��;
--[����] 
--	�����̺��� �� ���� �� ���̰� 19�� �̻���
--	���� ������
--	Ȯ���ϴ� �並 ��������.
--	�� ���� �̸��� MEMBER_19�� �ϼ���.

create or replace view member_19
as
select * from member where age >=19;
select * from member_19;

create or replace view member_19
as
select * from member where age >=30;
--EMP���̺��� 30�� �μ��� EMPNO�� EMP_NO�� ENAME�� NAME����
--	SAL�� SALARY�� �ٲپ� EMP30_VIEW�� �����Ͽ���.
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

emp�� dept ���̺��� join�ؼ� view�� ���弼��
create or replace view emp_dept_view
as
select * from dept d join emp e
using(deptno);

create or replace view emp_dept_view
as
select e.deptno,dname,ename,job from dept d join emp e
on d.deptno = e.deptno;

select*from emp_dept_view order by 1;
--#WITH READ ONLY �ɼ�
--WITH READ ONLY �ɼ��� �ָ� �信 DML������ ������ �� ����.
create or replace view emp10_view
as select empno,ename,job,deptno
from emp where deptno=10
with read only;
select * from emp10_view;

update emp10_view set job='SALESMAN' where empno=7782;
--cannot perform a DML operation on a read-only view

--#WITH CHECK OPTION �ɼ�
create or replace view emp_sales_view
as select*from emp where job='SALESMAN'
WITH CHECK OPTION;
select * from emp_sales_view;
update emp_sales_view set deptno=10 where empno=7499;
==>����������

update emp_sales_view set job='MANAGER' WHERE ENAME='WARD';
--view WITH CHECK OPTION where-clause violation

--�����̺��� �����ϸ� ���õ� �䵵 �����ȴ�.
--�並 �����ϸ� �����̺���?


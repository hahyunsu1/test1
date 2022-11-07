1. ������ �Լ�
2. �׷��Լ�
3. ��Ÿ �Լ�


#
[1] ������ �Լ�
[2] ������ �Լ�
[3] ��¥�� �Լ�
[4] ��ȯ �Լ�
[5] �Ϲ� �Լ�

#[1] ������ �Լ�
select lower('HAPPY BIRTHDAY'), UPPER('Happy Birthday') FROM DUAL;

--select * from dual;
--1�� 1���� ���� ���� ���̺�

select 9*7 from dual;

#initcap(): ù���ڸ� �빮�ڷ� ��ȯ
select deptno,dname,initcap(dname),initcap(loc) from dept;

# concat(����1,����2) : 2�� �̻��� ���ڸ� �������ش�.
select concat('abc','1234') from dual;

-- [����] ��� ���̺��� SCOTT�� ���,�̸�,������(�ҹ��ڷ�),�μ���ȣ��
--		����ϼ���.
select empno,ename,lower(job),deptno from emp;
--	 ��ǰ ���̺��� �ǸŰ��� ȭ�鿡 ������ �� �ݾ��� ������ �Բ� 
--	 �ٿ��� ����ϼ���.
 select products_name,output_price ||'��', concat(output_price,'��')"�ǸŰ�"
 from products;
--	 �����̺��� �� �̸��� ���̸� �ϳ��� �÷����� ����� ������� ȭ�鿡
--	       �����ּ���.
select concat(name,age) from member;

# substr(����,i,len) : ���� i �ε����� ������ len ���� ���̸�ŭ�� ������ ��ȯ��
i�� ����ϰ��: �տ������� �ε����� ã��
�����ϰ��: �ڿ������� �ε����� ã��
select substr('ABCDEFG',3,4),substr('ABCDEFG',-3,2) from dual;
select substr('881203-1012369',8) from dual;
select substr('881203-1012369',-7) from dual;

# LENGTH(����) : ���天���� ��ȯ

select length('991203-1012369') from dual;


--[����]
--	��� ���̺��� ù���ڰ� 'K'���� ũ�� 'Y'���� ���� �����
--	  ���,�̸�,����,�޿��� ����ϼ���. �� �̸������� �����ϼ���.
select empno,ename,job,sal from emp 
where substr(ename,1,1) > 'K' and substr(ename,1,1) <'Y';

--	������̺��� �μ��� 20���� ����� ���,�̸�,�̸��ڸ���,
--	�޿�,�޿��� �ڸ����� ����ϼ���.
select empno,ename,length(ename),sal,length(sal)
from emp
where deptno=20;
--	������̺��� ����̸� �� 6�ڸ� �̻��� �����ϴ� ������̸��� 
--	�̸��ڸ����� �����ּ���.

select ename, length(ename) from emp
where length(ename) >=6;

#LPAD/RPAD
--LPAD(�÷�,����1,����2): ���ڰ��� ���ʺ��� ü���.
--RPAD(�÷�,����1,����2): ���ڰ��� ���������� ä���.

select ename, lpad(ename,15,'*'),sal,lpad(sal,10,'*') from emp
where deptno=10;


select dname, RPAD(DNAME,15,'#') from dept;


#LTRIM/RTRIM
LTRIM(����1,����2): ����1�� ���� ����2�� ���� �ܾ ������ 
                    �׺��ڸ� ������ ���������� ��ȯ��
                    
select ltrim('TTTHELLO TEST','T'),rtrim('TTTHELLO TEST','T') from dual;
select rtrim(ltrim('   HELLO ORACLE   ')) A from dual;

#replace(�÷�,����1,����2): �÷����� ����1�� �ش��ϴ� ���ڸ� ����2�� ��ü�Ѵ�

select replace('ORACLE TEST','TEST','HI') from dual;

--������̺��� ������ �� ������ 'A'�� �����ϰ�
--�޿��� ������ 1�� �����Ͽ� ����ϼ���.
select job,ltrim(job, 'A' ),ltrim(sal ,1) from emp;
--������̺��� 10�� �μ��� ����� ���� ������ �� ������'T'��
--	�����ϰ� �޿��� ������ 0�� �����Ͽ� ����ϼ���.
select job, rtrim(job,'T'),rtrim(sal,0) from emp;
--������̺� JOB���� 'A'�� '$'�� �ٲپ� ����ϼ���.
select job, REPLACE(JOB,'A','$') from emp;
--�� ���̺��� ������ �ش��ϴ� �÷����� ���� ������ �л��� ������ ���
--	 ���л����� ������ ��µǰ� �ϼ���.
select job, REPLACE(JOB,'�л�','���л�') from MEMBER;	

-- �� ���̺� �ּҿ��� ����ø� ����Ư���÷� �����ϼ���.
select name,addr from member;

update member set addr = replace(addr,'�����','����Ư����');

rollback;

#[2]������ �Լ�
#ROUND(��,ROUND(��,�ڸ���):�ݿø� �Լ�
�ڸ����� ����� �Ҽ��ڸ���,
�ڸ����� ������ �����ڸ��� �ݿø��Ѵ�
select round(4567.567),ROUND(456.567,0),ROUND(4567.567,2),
ROUND(4567.567,-2) from dual;

#TRUC() : ������
select FLOOR(4567.567),trunc(4567.567),
trunc(4567.567,0),trunc(4567.567,2),
trunc(4567.567,-2) from dual;

#MOD(��1,��2) : ���������� ��ȯ
--�� ���̺��� ȸ���̸�, ���ϸ���,����, ���ϸ����� ���̷� �������� �ݿø��Ͽ� ����ϼ���
select name,mileage,age,ROUND(MILEAGE/age,1) from member;
--��ǰ ���̺��� ��ǰ ������� ��� �������� ���� ��ۺ� ���Ͽ� ����ϼ���.
select products_name,trans_cost,TRUNC(trans_cost,-3) from products;
--������̺��� �μ���ȣ�� 10�� ����� �޿��� 	30���� ���� �������� ����ϼ���
select deptno,ename,sal,TRUNC(sal/30),mod(sal,30) from emp
where deptno=10;

select chr(65),ascii('A') from dual;

# ABS(��): ���밪�� ���ϴ� �Լ�
select name,age,age-40,abs(age-40) from member;

#CEIL(��):�ø���
#FLOOR(��):������

select CEIL(123.001),FLOOR(123.001) from dual;

#POWER()
#SQRT()
#SIGN()
select power(2,7),sqrt(64),sqrt(133) from dual;

select age-40,sign(age-40) from member;

[3] ��¥�� �Լ�

select SYSDATE,SYSTIMESTAMP FROM dual;
��¥ + ���� : �ϼ��� ��¥�� ����
select SYSDATE +3 "3�� ��", SYSDATE -2 "��Ʋ��" from dual;

select SYSTIMESTAMP,to_char(SYSTIMESTAMP+2/24,'YY/MM/DD HH24:MI:SS') 
"�νð���" from dual;
--������̺��� ��������� �ٹ� �ϼ��� �� �� �����ΰ��� ����ϼ���
--�� �ٹ� �ϼ��� ���� ��������� ����ϼ���
select concat(round((sysdate-hiredate)/7),'��'),
concat(floor(mod(sysdate-hiredate,7)),'��') from emp;

select hiredate,sysdate,trunc(sysdate-hiredate),trunc((sysdate-hiredate)/7)
weeks, trunc(mod((sysdate-hiredate),7)) days from emp;

#MONTHS_BETWEEN(DATE1,DATE2) : ��¥2�� ��¥2 ������ ������ �����

select months_between(sysdate,TO_DATE('22-07-26','YY-MM-DD')) from emp;

#ADD_MONTHS(DATE,N) : ��¥�� N������ ����
select ADD_MONTHS(SYSDATE,2),ADD_MONTHS(SYSDATE,-2)from dual;

#LAST_DAY(D) : ���� ������ ��¥�� ��ȯ��(���/���� �ڵ� �����)
select LAST_DAY('22-02-01'),LAST_DAY('20-02-01'),LAST_DAY(SYSDATE) from dual;

--�� ���̺��� �� ���� �Ⱓ�� ���� ���� ȸ���̶�� �����Ͽ� ������� ��������
--���� ȸ���� ���� ������ �����ּ���.
select* from member;
select name,reg_date,ADD_MONTHS(REG_DATE,2) "���� ������" from member;

select sysdate from dual;

select TO_CHAR(sysdate,'YY-MM-DD HH:MI:SS') FROM DUAL;

select TO_CHAR(SYSDATE,'CC YYYY-MONTH-ddd day') from dual;

select TO_CHAR(SYSDATE,'CC YEAR-MONTH-ddd day') from dual;

[4]��ȯ �Լ�

TO_CHAR()
TO_DATE()
TO_NUMBER()

#TO_CHAR(��¥) : ��¥������ ���ڿ��� ��ȯ�Ѵ�
 TO_CHAR(����) : ���������� ���ڿ��� ��ȯ�Ѵ�
 
 TO_CHAR(D,�������)
 SELECT TO_CHAR(SYSDATE),TO_CHAR(SYSDATE,'yy-mm-dd hh12:mi:ss')from dual;

--�����̺��� ������ڸ� 0000-00-00 �� ���·� ����ϼ���.
select name,reg_date,TO_CHAR(reg_date,'yyyy-mm-dd') from member;
--�����̺� �ִ� �� ���� �� ��Ͽ����� 2003���� 
--���� ������ �����ּ���.
 SELECT * FROM MEMBER WHERE TO_CHAR(REG_DATE,'YYYY')='2013';

--�����̺� �ִ� �� ���� �� ������ڰ� 2003�� 5��1�Ϻ��� 
--���� ������ ����ϼ���. 
--��, ����� ������ ��, ���� ���̵��� �մϴ�.
select name,reg_date,TO_CHAR(reg_date,'yyyy-mm')from member where
TO_CHAR(reg_date,'yyyy-mm-dd')>'2013-05-01' ;   

TO_CHAR(N,�������) : �������� ���ڿ��� ��ȯ

select TO_CHAR(100000,'999,999'),TO_CHAR(100000,'$999,999') from dual;


--73] ��ǰ ���̺��� ��ǰ�� ���� �ݾ��� ���� ǥ�� ������� ǥ���ϼ���.
--	  õ�ڸ� ���� , �� ǥ���մϴ�.
select products_name,input_price,TO_CHAR(INPUT_PRICE,'999,999,999')"���ް���"
from products;
--74] ��ǰ ���̺��� ��ǰ�� �ǸŰ��� ����ϵ� ��ȭ�� ǥ���� �� ����ϴ� �����
--����Ͽ� ����ϼ���.[��: \10,000]
select products_name,output_price,to_char(output_price,'L999,999,999')"�ǸŰ���"
from products;


# TO_DATE(STR,�������) : ���ڿ��� ��¥�������� ��ȯ�Ѵ�
 select to_date('20221128','yyyymmdd')+2 from dual;
 
 select *from member
 where reg_date > to_date('20130601','yyyymmdd');
 
 #TO_NUMBER(STR,�������) : ���ڿ��� ������������ ��ȯ�Ѵ�
 select TO_NUMBER('10,000','99,999')*2 from dual;
 
-- '$8,590' ==> ���ڷ� ��ȯ�غ�����

select to_number('$8,590','$999g999')+10 from dual;

#�׷��Լ�
-�������� �� �Ǵ� ���̺� ��ü�� �����Ͽ� �ϳ��� ����� ��ȯ�ϴ� �Լ�

select count(empno) from emp;
select count(comm) from emp;
--null���� �����ϰ� ����
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
--emp���̺��� ��� SALESMAN�� ���Ͽ� �޿��� ���,
--		 �ְ��,������,�հ踦 ���Ͽ� ����ϼ���.
select avg(sal),max(sal),min(sal),sum(sal),count(empno) from emp
where job='SALESMAN';
--EMP���̺� ��ϵǾ� �ִ� �ο���, ���ʽ��� NULL�� �ƴ� �ο���,
--		���ʽ��� ���,��ϵǾ� �ִ� �μ��� ���� ���Ͽ� ����ϼ���.
select count(empno),count(comm),avg(comm),count(deptno) from emp;

 #�׷��Լ��� group by ���� �Բ� ���ȴ�
 emp���� ������ �ο����� �����ּ���
 
 select job,count(empno) from emp
 group by job;
 
 group by���� �̿��Ҷ����� group by ������ ����� �÷��� �׷��Լ��� select �Ҽ��ִ�
--17] �� ���̺��� ������ ����, �� ������ ���� �ִ� ���ϸ��� ������ �����ּ���.
select job,max(mileage) from member
group by job;

--18] ��ǰ ���̺��� �� ��ǰī�װ����� �� �� ���� ��ǰ�� �ִ��� �����ּ���.
--���� �ִ� �ǸŰ��� �ּ� �ǸŰ��� �Բ� �����ּ���.
select CATEGORY_fk,count(pnum),max(output_price),min(output_price) from products
group by CATEGORY_fk order by 1;
--19] ��ǰ ���̺��� �� ���޾�ü �ڵ庰�� ������ ��ǰ�� ����԰��� �����ּ���
select ep_code_fk,trunc(avg(input_price)) from products
group by EP_CODE_FK;

--����1] ��� ���̺��� �Ի��� �⵵���� ��� ���� �����ּ���.
select to_char(hiredate,'YY'),count(empno) from emp 
group by to_char(hiredate,'YY') order by 1;
 

--����2] ��� ���̺��� �ش�⵵ �� ������ �Ի��� ������� �����ּ���.
select to_char(hiredate,'yy-mm'),count(empno) from emp 
group by to_char(hiredate,'yy-mm') order by 1;
--����3] ��� ���̺��� ������ �ִ� ����, �ּ� ������ ����ϼ���.
select job,max(sal*12),min(sal*12) from emp
group by job;

#WGHO 
# HAVING ��
- GROUP BY �� ����� ������ �־� ������ �� ����Ѵ�.
 
-- 20] �� ���̺��� ������ ������ �� ������ ���� ����� ���� 
--	     2�� �̻��� �������� ������ �����ֽÿ�.
select count(num) from member
group by job having count(num) >=2;

--21] �� ���̺��� ������ ������ �� ������ ���� �ִ� ���ϸ��� ������ �����ּ���.
--	      ��, �������� �ִ� ���ϸ����� 0�� ���� ���ܽ�ŵ�ô�.
select job,max(mileage) from member
group by job having max(mileage) <> 0;
--	����1] ��ǰ ���̺��� �� ī�װ����� ��ǰ�� ���� ���, �ش� ī�װ��� ��ǰ�� 2���� 
--	      ��ǰ���� ������ �����ּ���.
select category_fk,count(pnum) from products
group by category_fk having count(pnum) = 2;
--	����2] ��ǰ ���̺��� �� ���޾�ü �ڵ庰�� ��ǰ �ǸŰ��� ��հ� �� ������ 100������ ����
--	      ���� �׸��� ������ �����ּ���.
select ep_code_fk,avg(output_price) from products
group by ep_code_fk having mod(avg(output_price),100)=0;
 
 
create table [��Ű��.]���̺��(
    Į���� �ڷ��� default �⺻�� constraint ���������̸� ������������,
    ....
    );
    

create table TEST_TAB1(
    NO number(2) constraint TEST_TAB1_NO_PK PRIMARY KEY,
    NAME VARCHAR2(20)
    );
    
desc test_tab1;

select*
from user_constraints where table_name='TEST_TAB1';

insert into test_tab1(no,name)
values(1,null);

select * from test_tab1;

create table test_tab2(
    no number(2),
    name varchar2(20),
    constraint test_tab2_no_pk primary key(no));
    
select * from user_constraints
where table_name='TEST_TAB2';

alter table test_tab2
drop constraint test_tab2_no_pk;

alter table test_tab2
add constraint test_tab2_no_pk2 primary key(no);

alter table test_tab2
rename constraint test_tab2_no_pk2 to test_tab2_no_pk;

#Foreign key ��������
�θ� ���̺�(MASTER)�� pk�� �������̺�(DETAIL)���� FK�� ����
==>FK�� DETAIL���̺��� �����ؾ� ��
MASTER ���̺��� PK,UK�� ���ǵ� �÷��� FK�� ������ �� �ִ�
�÷��� �ڷ����� ��ġ�ؾ� �Ѵ�.ũ��� ��ġ���� �ʾƵ� �������
ON DELETE CASCADE �����ڿ� �Բ� ���ǵ� �ܷ�Ű�� �����ʹ�  
�� �⺻Ű�� ���� �� �� ���� �����ȴ�

Create table dept_tab(
deptno number(2),
dname varchar2(15),
loc varchar2(15),
constraint dept_tab_deptno_pk primary key(deptno)
);

create table emp_tab(
empno number(4),
ename varchar2(20),
job varchar2(10),
mgr number(4) constraint emp_tab_mgr_fk references emp_tab(empno),
hiredate date,
sal number(7,2),
comm number(7,2),
deptno number(2),
--���̺� ���ؿ��� fk�ֱ�
constraint emp_tab_deptno_fk foreign key (deptno)
references dept_tab(deptno),
constraint emp_tab_empno_pk primary key (empno)
);
insert into dept_tab values(10,'��ȹ��','����');
insert into dept_tab values(20,'�λ��','��õ');
DROP TABLE emp_tab;
select*from dept_tab;
--������� INSERT�ϱ�
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
values(1000,'ȫ�浿','��ȹ',NULL,10);
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
values(1001,'��ö��','�λ�',NULL,20);
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
values(1002,'�̿���','�λ�',NULL,20);
select*from emp_tab;

INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
values(1003,'�����','�빫',1002,20);
INSERT INTO EMP_TAB(EMPNO,ENAME,JOB,MGR,DEPTNO)
values(1004,'��浿','�繫',1000,20);
commit;
dept_tab���� ��ȹ�θ� �����غ���
delete from dept_tab where deptno=10;
==>�ڽ� ���ڵ尡 ���� ���� �θ����̺��� ���ڵ带 ������ �� ����.

ȫ�浿�� 20���μ��� �μ��̵� �ϼ���
update emp_tab set deptno=20 where ename='ȫ�浿';

select*from emp_tab;
select*from dept_tab;



BOARD_TAB
NO NUMBER(8) PK
USERID VARCHAR2(20) NOT NULL,
TITLE VARCHAR2(100),
CONTENT VARCHAR2(1000)
WDATE DATE �⺻�� SYSDATE

�ڽ����̺�
REPLY_TAB
RNO NUMBER(8) PK
CONTENT VARCHAR2(300)
USERID VARCHAR2(20) not null,
NO_FK NUMBER(8)==>fk�� �ֵ� ON DElETE CASCADE �ɼ��� ����ϱ�

CREATE TABLE BOARD_TAB(
no number(8) primary key,
userid varchar2(20) not null,
title varchar2(100),
content varchar2(1000),
wdate date default sysdate);

create table reply_tab(
    rno number(8) primary key,
    content varchar2(300),
    userid varchar2(20) not null,
    no_fk number(8) references board_tab(no) on delete cascade
);
select *from user_constraints where table_name='REPLY_TAB';
insert into board_tab values(1,'HAHA','�ݰ�����','�ȳ�',SYSDATE);
commit;

select*from board_tab;
��۴ޱ�
insert into reply_tab values(3,'�ݰ����ϴ�','KIM',1);
commit;
select*from reply_tab;

borad_tab�� reply_tab�� join�ؼ� ���� ����ϼ���
select b.no,b.title,b.userid,b.wdate,r.content,r.userid
from board_tab B join reply_tab r
on b.no = r.no_fk;

delete from board_tab where no=2;
--on delete cascade �ɼ��� �־��� ������ �θ���� �����ϸ� �ڽı۵� �Բ� �����ȴ�.

# UNIQUE KEY
�÷����� ����
create table uni_tab1(
deptno number(2) constraint uni_tab1_deptno_uk unique,
dname char(20),
loc char(10));

select*from user_constraints where table_name='UNI_TAB1';
insert into uni_tab1 values(null,'������3','����');
select*from uni_tab1;
commit;

���̺� ���� ����
create table uni_tab2(
deptno number(2),
dname char(20),
loc char(10),
constraint uno_tab2_deptno_uk unique(deptno));

# not null �������� - üũ���������� ����
-not null ���������� �÷� ���ؿ����� ������ �� �ִ�.

create table nn_tab(
deptno number(2) constraint nn_tab_deptno_nn not null,
dname char(20) not null,
loc char(10)
--constraint loc_nn not null (loc) [X]
);




#CHECK ��������
- ���� �����ؾ��ϴ� ������ �����Ѵ�

create table ck_tab(
deptno number(2) constraint ck_tab_deptno_ck check(deptno in(10,20,30,40)),
dname char(20));
select*from user_constraints where table_name='CK_TAB';
intsert into ck_tab values(50,'BAA');--[x]

create table ck_tab2(
deptno number(2),
dname char(20),
loc char(10),
primary key(deptno),
check(loc in('����','����'))
);
select*from user_constraints where table_name='CK_TAB2';


create table zip_code(
post1 char(3),
post2 char(3),
addr varchar2(60) constraint zip_code_addr not null,
constraint zip_code_post_pk primary key(post1,post2));
desc zip_code;

create table member_tab(
id number(4,0) ,
name varchar2(10) constraint member_tap_name_nn not null,
gender char(1) ,
jumin1 char(6),
jumin2 char(7),
tel varchar2(15),
post1 char(3),
post2 char(3),
addr varchar2(60),
constraint member_tab_id_pk primary key (id),
constraint member_tab_gender_ck check(gender in('F','M')),
constraint member_tab_jumin_uk unique (jumin1,jumin2),
constraint member_tab_post_fk foreign key (post1,post2)
references zip_code(post1,post2)
);
drop table member_tab2;
desc member_tab;
select * from user_constraints where table_name=upper('MEMBER_TAB');
create table member_tab2(
id number(4,0) primary key,
name varchar2(10),
gender char(1) constraint member_tab_gender_ck check(gender in('F','M')),
jumin1 char(6),
jumin2 char(7),
tel varchar2(15),
post1 char(3),
post2 char(3),
addr varchar2(60),
constraint member_tab_jumin_uk unique(jumin1,jumin2),
constraint member_tab_fk foreign key (post1,post2)
references zip_code(post1,post2)
);

#subquery�� �̿��� ���̺� ����
--[�ǽ�] ��� ���̺��� 30�� �μ��� �ٹ��ϴ� ����� ������ �����Ͽ�
--EMP_30 ���̺��� �����Ͽ���. �� ���� ���,�̸�,����,�Ի�����,
--�޿�,���ʽ��� �����Ѵ�.
create table emp_30(eno,ename,job,hdate,sal,comm)
as
select empno,ename,job,hiredate,sal,comm
from emp where deptno=30;

select * from emp_30;
--[����1]
--EMP���̺��� �μ����� �ο���,��� �޿�, �޿��� ��, �ּ� �޿�,
--�ִ� �޿��� �����ϴ� EMP_DEPTNO ���̺��� �����϶�.
create table emp_deptno
as
select deptno,count(empno) cnt,round(avg(sal))avg_sal,sum(sal)sum_sal,
min(sal)min_sal,max(sal)max_sal
from emp group by deptno;	
select * from emp_deptno;
--[����2]	EMP���̺��� ���,�̸�,����,�Ի�����,�μ���ȣ�� �����ϴ�
--EMP_TEMP ���̺��� �����ϴµ� �ڷ�� �������� �ʰ� ������
--�����Ͽ���
create table emp_temp
as
select empno,ename,job,hiredate,deptno
from emp where 1=2;

select * from emp_temp;


--#DDL
--create,drop,alter,rename,truncate
--#�÷� �߰� ���� ����
--alter table ���̺�� add �߰����÷�����[default ��]

create table temp(
no number(4)
);
desc temp;
drop table temp;
alter table temp add name varchar2(10) not null;
alter table temp add indate date default sysdate;

products ���̺� prod_desc �÷��� �߰��ϵ� not null���������� �ּ���

alter table products add prod_desc varchar2(1000);


temp���̺��� no �÷��� �ڷ����� char(4)�� �����ϼ���
alter table temp modify no char(4);
temp���̺��� no �÷����� num���� �����ϼ���
alter table temp rename column no to num;
temp���̺��� indate�÷��� �����ϼ���
alter table temp drop column indate;
desc temp;
alter table products drop column prod_desc;

temp ���̺��� num�÷��� primary key ���������� �߰��ϼ���

alter table temp add constraint temp_num_pk primary key(num);

insert into temp values(1,'AAA');

�������� ��Ȱ��ȭ

ALTER TABLE ���̺�� DISABLE CONSTRAINT �������Ǹ�[cascade];

temp�� pk���������� ��Ȱ��ȭ ��Ű����
alter table temp disable constraint temp_num_pk;

select * from user_constraints where table_name='TEMP';

delete from temp;
commit;
�������� Ȱ��ȭ
alter table ���̺�� enable constraint �������Ǹ� [cascade];

��ü �̸� ����
RENAME OLO_NAME TO NEW_NAME;
temp ���̺���� test���̺�� �����ϼ���
rename temp to test2;
select * from tab;
#���̺� ����
DROP TABLE ���̺��[CASCADE CONSTRAINT);

drop table test2 cascade constraint;
temp�� pk���� ������ Ȱ��ȭ ��Ű����
alter table temp enable constraint temp_num_pk;

drop table test purge;

���̺� ��� ������ �����Ͱ� �����ȴ�.
���� �ε����� ��� �����ȴ�.
VIEW,SYNONYM ������ ������ �������� ���� ������ ����ϸ� ���� �߻��Ѵ�

select *from memo;
SELECT idx, name, msg, wdate FROM memo ORDER BY idx DESC;

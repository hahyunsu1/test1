--# ��Ű��
--���� ���� ���ν���, �Լ�, Ŀ�� ���� �ϳ��� ��Ű���� ���� ������ �� �ִ�.
--- �����
--- ����(package body)

create or replace package empInfo as
procedure allEmp;
procedure allSal;
end empInfo;
/

--��Ű�� ���� ����
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
        dbms_output.put_line(SQLERRM||'������ �߻���');
    end allEmp;
    -- allSal�� ��ü �޿� �հ�, �����, �޿����, �ִ�޿�, �ּұ޿��� ������ ����ϴ� ���ν���
    procedure allSal
    is
    begin
        dbms_output.put_line('�޿�����'||lpad('�����',10,' ')||lpad('�޿����',10,' ')||
            lpad('�ִ�޿�',10,' ')||lpad('�ּұ޿�',10,' '));
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
--INSERT,UPDATE,DELETE ���� ����ɋ� ���������� ����Ǵ� ������ ���ν���

create or replace trigger trg_dept
before
update on dept
for each row
begin 
    dbms_output.put_line('���� �� �÷���: '|| :OLD.DNAME);
    dbms_output.put_line('���� �� �÷���: '|| :NEW.DNAME);
end;
/
select * from dept;
update dept set dname='���' where deptno=40;
rollback;

--Ʈ���� ��Ȱ��ȭ
alter trigger trg_dept disable;
--Ʈ���� Ȱ��ȭ
alter trigger trg_dept enable;
--�����ͻ������� ��ȸ
select* from user_triggers where trigger_name='trg_dept';
--Ʈ���� ����
drop trigger trg_dept;
--EMP ���̺� �����Ͱ� INSERT�ǰų� UPDATE�� ��� (BEFORE)
--��ü ������� ��ձ޿��� ����ϴ� Ʈ���Ÿ� �ۼ��ϼ���.
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
    dbms_output.put_line('�޿� ��� : '|| avg_sal);    
end;
/
insert into emp(empno,ename,deptno,sal)
values(9000,'PETER',20,5000);
update emp set sal=sal*1.1 where deptno=10;
drop trigger trg_emp;
rollback;
select avg(sal) from emp where deptno=10;
alter trigger trg_emp disable;

--[Ʈ���� �ǽ� 1]
--�԰� ���̺� ��ǰ�� �԰�� ���
--��ǰ ���̺� ��ǰ ���������� �ڵ����� ����Ǵ� 
--Ʈ���Ÿ� �ۼ��غ��ô�.
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
values('A00'||myproduct_seq.nextval,'��Ʈ��','A��',800000,10);
insert into myproduct
values('A00'||myproduct_seq.nextval,'������','B��',100000,20);
insert into myproduct
values('A00'||myproduct_seq.nextval,'ű����','C��',70000,30);
commit;
select * from myproduct;
--�԰� ���̺�
create table myinput(
    incode number primary key,--�԰��ȣ
    pcode_fk char(6) references myproduct (pcode),--�԰��ǰ�ڵ�
    indate date default sysdate,--�԰���
    inqty number(6),
    inprice number(8)
);
create sequence myinput_seq nocache;
--�԰� ���̺� ��ǰ�� ������
--��ǰ ���̺��� ���������� �����ϴ� Ʈ���Ÿ� �ۼ��ϼ���
create or replace trigger trg_input_product
after
insert on myinput
for each row
declare 
    cnt number := :new.inqty;
    code char(6) := :new.pcode_fk;
begin
    update myproduct set pqty = pqty+cnt where pcode = code;
    dbms_output.put_line(code||'��ǰ�� �߰��� '||cnt||'�� ����');
end;
/
--�԰� ���̺� A001��ǰ�� 10�� 500000���� insert�ϱ�
select * from myproduct;
insert into myinput
values(myinput_seq.nextval,'A002',sysdate,8,50000);
rollback;
--�԰� ���̺��� ������ ����� ��� -update���� ����� ��
--��ǰ ���̺��� ������ �����ϴ� Ʈ���Ÿ� �ۼ��ϼ���
create or replace trigger trg_input_product
before
update on myproduct
for each row
declare 
   
begin
    update myproduct set pqty = pqty+cnt where pcode = code;
    dbms_output.put_line(code||'��ǰ�� �߰��� '||cnt||'�� ����');
end;
/
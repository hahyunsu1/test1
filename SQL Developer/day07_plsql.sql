--# IN OUT PARAMETER
--���ν����� �а� ���� �۾��� ���ÿ� �� �� �ִ� �Ķ����
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
     dbms_output.put_line('���ν��� ���� ��');
     dbms_output.put_line('---------------');
     dbms_output.put_line('A1: '||a1);
     dbms_output.put_line('A2: '||a2);
     dbms_output.put_line('A3: '||a3);
     dbms_output.put_line('A4: '||a4);
     a3 := '���ν��� �ܺο��� �� ���� ���� �� �������?';
    msg := 'SUCCESS';
     a4 := msg;
     dbms_output.put_line('---------------');
     dbms_output.put_line('���ν��� ���� ��');
     dbms_output.put_line('---------------');
     dbms_output.put_line('A1: '||a1);
     dbms_output.put_line('A2: '||a2);
     dbms_output.put_line('A3: '||a3);
     dbms_output.put_line('A4: '||a4);
 end;
 /
 variable c varchar2(100);
  variable d varchar2(100);
  exec inout_test(5000,'�ȳ�',:c, :d);
  print d
  print c
--����� ���Ķ���ͷ� �����ϸ� ����� �μ���ȣ�� ���� �Ҽӵ� �μ�����
--���ڿ��� ����ϴ� ���ν���
--10 ȸ��μ�
--20 �����μ�
--30 �����μ�
--40 ��μ�
create or replace procedure dept_find(pno in emp.empno%type)
is
vdno emp.deptno%type;
vename emp.ename%type;
vdname varchar2(20);
begin
    select ename,deptno into vename,vdno
    from emp
    where empno = pno;
    if VDNO=10 then VDNAME :='ȸ��μ�';
    elsif VDNO=20 then VDNAME :='�����μ�';
    elsif VDNO=30 then VDNAME :='�����μ�';
    elsif VDNO=40 then VDNAME :='��μ�';
    else VDNAME:='���� �μ� ���� ������';
    end if;
    dbms_output.put_line(VENAME||'���� '||VDNO||'�� '||VDNAME||'�� �ֽ��ϴ�');
end;
/
set serveroutput on
exec dept_find(7499);
--
--������� ���Ķ���ͷ� �����ϸ�
--�ش� ����� ������ ����ؼ� ����ϴ� ���ν����� �ۼ��ϵ�,
--������ COMM�� NULL�� ���� NULL�� �ƴѰ�츦 ������ ����ϼ���
--��¹�
--�����  ���޿�  ���ʽ� ���� 
--����ϼ���

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
    dbms_output.put_line('���޿�: '||vsal);
    dbms_output.put_line('���ʽ�: '||vcomm);
    dbms_output.put_line('�� ��: '||total);
    exception
    when no_data_found then
    dbms_output.put_line(pname||'���� �����ϴ�.');
    when too_many_rows then
     dbms_output.put_line(pname||'�� �����Ͱ� 2�� �̻��Դϴ�.');
end;
/
exec emp_sal('martin');
exec emp_sal('king');
exec emp_sal('dfd');
exec emp_sal('tom');
insert into emp(empno,ename,sal,comm)
values(8002,'TOM',2000,3000);
commit;

--# FOR LOOP��
declare
vsum number(4) :=0;
begin
    --1���� 10������ ��
    for i in reverse 1 .. 10 loop
    dbms_output.put_line(i);
    vsum:=vsum+i;
    end loop;
    dbms_output.put_line('������ ��:'||vsum);
end;
/
--JOB�� ���Ķ���ͷ� �����ϸ� �ش� ������ �����ϴ� ������� ����
--���, �����, �μ���ȣ, �μ���, ������ ����ϼ���
--FOR LOOP�� �̿��ؼ� Ǯ�� ���������� �̿��ϼ���
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


--1~100������ ���� �� ¦���� ����ϱ�
-- exit when ����;
-- coninue when ����;

declare
vsum number(4) :=0;
begin
    --1���� 100������ ��
    for k in  1 .. 100 loop
    continue when mod(k,2)=1;
    dbms_output.put_line(k);
    end loop;    
end;
/
--#LOOP ��
--LOOP
-- ���๮��;
--EXIT [WHEN ���ǹ�]
--end loop;

--EMP���̺��� ��������� ����ϵ� LOOP�� �̿��ؼ� ����غ��ô�.
--'NONAME1'

declare
vcnt number(3) := 100;
begin
    loop
        insert into emp(empno,ename,hiredate)
        values(vcnt+8000,'noname'||vcnt,sysdate);
    vcnt := vcnt+1;
    exit when vcnt > 105;
    dbms_output.put_line(vcnt-100||'���� ������ �Է� �Ϸ�');
    end loop;
end;
/
rollback;

# WHILE LOOP��
--while ���� loop
-- ���๮
-- exit when ����;
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
--# case��
--case �񱳱���
-- when ��1 then ���๮;
-- when ��2 then ���๮;
-- ...
--else
-- ���๮
--end case;
--��������� ���Ķ���ͷ� �����ϸ�
--������ ����ϴ� ���ν����� �ۼ��ϼ���
--���ν�����: GRADE_AVG
--100~90 : A
--81 => B
--77 => C
--60���� => D
--������ => F

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
dbms_output.put_line(score||'�� '||hak||'����');
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
#�Ͻ��� Ŀ��
create or replace procedure implicit_cursor
(pno in emp.empno%type)
is
vsal emp.sal%type;
update_row number;
begin
    select sal into vsal
    from emp where empno = pno;
    --�˻��� �����Ͱ� �ִٸ�
    if sql%found then
    dbms_output.put_line(pno||'�� ����� ���޿��� '||vsal||'�Դϴ�.10% �λ����Դϴ�');
    end if;
    update emp set sal=sal*1.1 where empno=pno;
    update_row:= sql%rowcount;
    dbms_output.put_line(update_row||'���� ����� �޿��� �λ�Ǿ����');
    select sal into vsal
    from emp where empno = pno;
     if sql%found then
    dbms_output.put_line(pno||'�� ����� �λ�� ���޿��� '||vsal||'�Դϴ�.');
    end if;
end;
/
exec implicit_cursor(7788);
rollback;
/*
# ������ Ŀ��
Ŀ�� ����
Ŀ�� OPEN
�ݺ��� ���鼭
Ŀ������ fetch�Ѵ�.
Ŀ�� close
*/
create or replace procedure emp_all
is
vno emp.empno%type;
vname emp.ename%type;
vdate emp.hiredate%type;
--Ŀ�� ����
cursor emp_cr is
    select empno,ename,hiredate     
    from emp order by 1 asc;
begin
    --Ŀ�� ����
    open emp_cr;
    loop
    fetch emp_cr into
    vno,vname,vdate;
    exit when emp_cr%notfound;
    dbms_output.put_line(vno||lpad(vname,12,' ')||lpad(vdate,12,' '));
    end loop;    
    --Ŀ�� �ݱ�
    close emp_cr;
end;
/
execute emp_all;
--[�ǽ�] �μ��� �����, ��ձ޿�, �ִ�޿�, �ּұ޿��� ������ ����ϴ�
--      ���ν����� �ۼ��ϼ���.
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
    --for �������� Ŀ���� �̿��ϸ� ������ open,fetch,close�� �ʿ䰡 ����
    for k in cr loop
    
    dbms_output.put_line(k.deptno||lpad(k.cnt,10,' ')||lpad(k.avg_sal,10,' ')||
    lpad(k.max_sal,10,' ')||lpad(k.min_sal,10,' '));
    
    end loop;
end;
/
exec emp_crs;

--�μ����̺��� ��� ������ ������ ����ϴ� ���ν����� �ۼ��ϵ�
--FOR LOOP�̿��ϱ�
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
#�̸� ���ǵ� ���� ó���ϱ�
select * from member;
--MEMBER ���̺��� USERID �÷��� UNIQUE ���������� �߰��ϵ� �������� �̸� �־� �߰��ϼ���
alter table member add constraint member_userid_uk unique(userid); 

create sequence member_seq
start with 11
increment by 1
nocache;
--MEMBER���̺��� ���ο� ���ڵ带 �߰��ϴ� ���ν����� �ۼ��ϵ�
--���Ķ���ͷ� ȸ����, ���̵�, ��й�ȣ, ����, ����, �ּ�
--�� �ְ� �ش� �����͸� INSERT �ϴ� ���ν����� �ۼ��ϼ���
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
dbms_output.put_line('ȸ������ �Ϸ�');
end if;
select name,userid into vname,vuid
from member where name=pname;
dbms_output.put_line(PNAME||'�� '||VUID||'���̵�� ��ϵǾ����ϴ�');

exception
when dup_val_on_index then
dbms_output.put_line('����ҷ��� ���̵�� �̹� ��ϵǾ� �־��');
when too_many_rows then
dbms_output.put_line(pname||'�� �����ʹ� 2�� �̻� �ֽ��ϴ�');
when others then
dbms_output.put_line('��Ÿ ����ġ ���ߴ� ���� �߻�: '||sqlerrm||sqlcode);
end;
/
exec member_add('�����','KIM2','123',22,'�л�','���� ������');

select * from member order by reg_date desc;

# ����� ���� ���� ����� �߻���Ű��

select count(*) from emp
group by deptno;
--�μ� �ο��� 5�� �̸��̸� ��������� ���ܸ� ����� �߻���Ű��
create or replace procedure user_except
(pdno in dept.deptno%type)
is
--���� ����
    my_define_error exception;
    vcnt number;
begin
    select count(empno) into vcnt
    from emp where deptno = pdno;
    --2. ���� �߻���Ű��=> RAISE���� �̿�
    if vcnt < 5 then
        raise my_define_error;
    end if;
    dbms_output.put_line(pdno||'�� �μ� �ο��� '||vcnt||'�� �Դϴ�');
    --3.���� ó�� �ܰ�
    exception
        when my_define_error then
            raise_application_error(-20001,'�μ� �ο��� 5�� �̸��� �μ��� �ȵſ�');
end;
/
exec user_except(60);
# FUNCTION
-���� ȯ�濡 �ݵ�� �ϳ��� ���� RETURN�ؾ� �Ѵ�.

--������� �Է��ϸ� �ش� ����� �Ҽӵ� �μ����� ��ȯ�ϴ� �Լ��� �ۼ��ϼ���
create or replace function get_dname(
pname in emp.ename%type)
--��ȯ���� ������ ������ ����
return varchar2
is
vdno emp.deptno%type;
vdname dept.dname%type;
begin
    select deptno into vdno from emp
    where ename=pname;
    select dname into vdname from dept
    where deptno = vdno;
    return vdname; -- ���� ��ȯ �Ѵ�.
    exception
    when no_data_found then
    dbms_output.put_line(pname||'����� �����ϴ�');
    return sqlerrm;
    when too_many_rows then
    dbms_output.put_line(pname||'��� �����Ͱ� 2�� �̻��Դϴ�');
    return sqlerrm;
end;
/

var gname varchar2;
exec :gname := get_dname('TOM');
print gname;

--#��� �޸� ����� �������� ���ν����� �ۼ��ؼ� �ڹٿ� �����غ��ô�.
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
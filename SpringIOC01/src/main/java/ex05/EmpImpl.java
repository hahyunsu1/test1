package ex05;

import java.util.Random;

public class EmpImpl implements Emp {
	
	//property
	private String dept;
	private String name;
	private int sal;
	private Random ran;
	
	public EmpImpl() {
		
	}
	

	public EmpImpl(String name) {
		super();
		this.name = name;
	}

	public EmpImpl(String dept, String name) {
		super();
		this.dept = dept;
		this.name = name;
	}
	

	public EmpImpl(String dept, String name, int sal) {
		super();
		this.dept = dept;
		this.name = name;
		this.sal = sal;
	}
	public EmpImpl(Random ran) {
		super();
		this.ran = ran;
	}
	@Override
	public void info1() {
		System.out.println("Name: "+name);
	}
	@Override
	public void info2() {
		this.info1();//이름
		System.out.println("Dept: "+dept);
	}

	@Override
	public void info3() {
		this.info2();//이름, 부서
		System.out.println("Salary: "+sal);
	}

	@Override
	public void info4() {
		System.out.println("Lucky Number: "+ran.nextInt(100));
	}

}

package ex13;

public class Emp {
	private String name;
	private String dept;
	private int salary;
	
	public Emp() {
		
		
	}
	public Emp(String n,String d,int s) {
		name=n;dept=d;salary=s;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	@Override
	public String toString() {
		return "Emp [name=" + name + ", dept=" + dept + ", salary=" + salary + "]";
	}
	
	
}

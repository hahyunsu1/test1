package ex09;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringAppTest {

	public static void main(String[] args) {
		ApplicationContext ctx=new AnnotationConfigApplicationContext(ex09.Config.class);
		Emp emp=ctx.getBean("emp", Emp.class);//xml에 등록한 빈
		System.out.println(emp);
		
		Service svc=ctx.getBean("Service",Service.class);
		svc.test1();
	}

}

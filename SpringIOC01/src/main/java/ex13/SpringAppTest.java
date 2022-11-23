package ex13;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class SpringAppTest {

	public static void main(String[] args) {
		ApplicationContext ctx=new AnnotationConfigApplicationContext(ex13.Config.class);
		
		Service s=ctx.getBean("service",Service.class);
		
		s.test2();		
		
		s.test1();

	}

}

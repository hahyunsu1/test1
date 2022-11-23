package ex10;

import org.springframework.context.ApplicationContext;

import org.springframework.context.support.GenericXmlApplicationContext;

public class SpringAppTest {

	public static void main(String[] args) {
		ApplicationContext ctx=new GenericXmlApplicationContext("classpath:ex10/application.xml");
		MessageBean mb=ctx.getBean("mb",MessageBean.class);
		mb.sayHello();
		mb.sayHi("영희","순희","철이");

	}

}

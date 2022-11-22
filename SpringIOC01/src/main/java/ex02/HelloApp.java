package ex02;
//HelloApp과 MessageBeanEn간의 결합력이 느슨해짐
public class HelloApp {

	public static void main(String[] args) {
		MessageBean mb=new MessageBeanEn();//new MessageBeanKo();
		mb.sayHello("Scott");

	}

}

package ex01;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;

public class AroundAdvice implements MethodInterceptor{
	
	@Override
	public Object invoke(MethodInvocation invo) throws Throwable{
		Object obj=null;
		System.out.println("I am AroundAdvice1: "+invo.getMethod()+"호출 전 =============");
		obj=invo.proceed();//매서드가 수행
		System.out.println("I am AroundAdvice2: "+invo.getMethod()+"호출 후 =============");
		return obj;
	}
}

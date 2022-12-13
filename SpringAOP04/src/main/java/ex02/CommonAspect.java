package ex02;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;

//Aspect:Advice + Pointcut
//핵심 로직은 아니지만 코드를 온전하게 만들기 위해 필요한 공통관심사항 + 어느 지점에 적용할 것인지
public class CommonAspect {
	
	public void trace1(JoinPoint jp) {
		Signature  sign=jp.getSignature();
		System.out.println("before=====================["+sign.toShortString()+"]");
	}
	public void trace2(JoinPoint jp) {
		Signature sign=jp.getSignature();
		System.out.println("after=====================["+sign.toShortString()+"]");
	}
	public void trace3(JoinPoint jp, Integer result) {
		Signature sign=jp.getSignature();
		System.out.println("after=====================["+sign.toShortString()+"]==반환값"+result);
	}
	public void trace4(JoinPoint jp, Exception ex) {
		Signature sign=jp.getSignature();
		System.out.println("after=====================["+sign.toShortString()+"]==");
		if(ex!=null)
			System.out.println(ex);
	}
	//around
	public Integer trace5(ProceedingJoinPoint jp) {
		Signature  sign=jp.getSignature();
		System.out.println("around(before)=====================["+sign.toShortString()+"] start===");
		
		try {
			Integer n=(Integer)jp.proceed();
			return n;
		} catch (Throwable e) {			
			e.printStackTrace();
			return -1;
		}finally {
			System.out.println("around(after)=====================["+sign.toShortString()+"] end===");
		}
	}
}

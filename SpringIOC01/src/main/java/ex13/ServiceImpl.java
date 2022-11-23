package ex13;
//기본자료형 값을 주입할 때는 @value(값)을 사용
/* @Value :기본자료형, String 유형을 주입할 때 사용
 * @Autowired : byType으로 주입한다. 자료유형이 같은 객체가 있으면 주입한다. 찾는순서: 자료형> @Qualifier("빈이름")
 * @Resource  : byName으로 주입한다.
 * @Inject : ==>pom.xml에 라이브러리를 등록해야 사용 가능하다. byType> @Qualifier
 * 
 * */

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

public class ServiceImpl implements Service {
	
	/*@Autowired
	@Qualifier("emp1")*/
	@Resource(name="emp1")
	private Emp emp;
	
	@Autowired
	private Member user;

	@Override
	public void test1() {
		System.out.println("-----Emp정보----------------");
		System.out.println(emp);

	}

	@Override
	public void test2() {
		System.out.println("-----Member정보----------------");
		user.showInfo();

	}

}

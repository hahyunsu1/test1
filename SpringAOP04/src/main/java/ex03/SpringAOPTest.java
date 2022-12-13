package ex03;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringAOPTest {

	public static void main(String[] args) {
		ApplicationContext ctx=new ClassPathXmlApplicationContext("ex03/aop.xml");
		BoardService bs=ctx.getBean("boardSvc",BoardService.class);
		BoardVO vo=new BoardVO(2,"두번째 글을 작성합니다","noname");
		bs.insertBoard(vo);

	}

}

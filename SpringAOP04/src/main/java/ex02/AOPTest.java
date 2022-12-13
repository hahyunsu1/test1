package ex02;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AOPTest {

	public static void main(String[] args) {
		ApplicationContext ctx=new ClassPathXmlApplicationContext("ex02/aop.xml");
		BoardService bs=ctx.getBean("boardSvc", BoardService.class);
		BoardVO vo=new BoardVO(1,"첫번째 게시글을 등록합니다","홍길동");
		bs.insertBoard(vo);
		
	}

}

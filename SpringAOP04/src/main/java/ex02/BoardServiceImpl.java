package ex02;

import java.util.ArrayList;
import java.util.List;

public class BoardServiceImpl implements BoardService {
	
	List<BoardVO> boardArr=new ArrayList<>();
	@Override
	public int insertBoard(BoardVO vo) {
		System.out.println("핵심 로직을 수행하는 매서드: insertBoard "+vo.getTitle()+"글을 등록합니다...***");
		boardArr.add(vo);
		boardArr.add(vo);
		boardArr=null;
		boardArr.add(vo);
		return boardArr.size();
	}

}

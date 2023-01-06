package com.family.board.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.family.board.service.BoardService;

//보드와 관련된 모든 요청 처리
//동기 -- web/board/insert/----, delete, list
//restful -->> web/board/{idx}
//@RestController
@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject // 객체 생성
	private BoardService boardService;
	// @Getmapping , PostMapping, DeleteMapping
	@RequestMapping("/list")	// URL을 설정한다.
	public String boardList(Model m) {
		int result = boardService.boardCount();
		
		m.addAttribute("boardCnt",result);
		return "board/boardList";  // WEB-INF 아래의 views아래에 있는 .jsp 파일 위치.
	}
	
	
	
	
	
}

package com.family.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

	@RequestMapping("/index")
	public void index() {
		//"/WEB-INF/views/index.jsp
	}
	@RequestMapping("/top")
	public void top() {
		//"/WEB-INF/views/index.jsp
	}
	
	@RequestMapping("/foot")
	public void foot() {
		//"/WEB-INF/views/index.jsp
	}
}

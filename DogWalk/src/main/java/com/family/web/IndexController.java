package com.family.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

	@RequestMapping("/index")
	public void index() {
		//"/WEB-INF/views/index.jsp
	}
	
	@RequestMapping("/weather")
	public void weather() {
		//"/WEB-INF/views/index.jsp
	}
}

package com.obj.test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class APIController {
	
	@Autowired
	private OCRService ocrService;
	
	// OCR	
	//ocrView.jsp 페이지로 이동
	@RequestMapping("/clovaOCRForm")
	public String clovaOCRForm() {
		return "/management/ocr";
	}
}
package com.obj.test;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import net.minidev.json.JSONObject;





@RestController
public class APIRestController {

	@Autowired
	private OCRService ocrService;
	
	// OCR 요청 받아서 서비스 호출하고 결과 받아서 반환
	@PostMapping(value="/management/clovaOCR")
	public Object  faceRecogCel(@RequestParam("uploadFile") MultipartFile file,HttpSession ses) {		
		String result = "";
		List<String> OCRlist =new ArrayList<String>();
		Map<String, Object> retVal = new HashMap<String, Object>();
		
		try {
			// 1. 파일 저장 경로 설정 : 실제 서비스되는 위치 (프로젝트 외부에 저장)
			String uploadPath = ses.getServletContext().getRealPath("/file"); // 절대경로 어떻게 할것인가?
			
			// 2. 원본 파일 이름 알아오기
			String originalFileName = file.getOriginalFilename();
			String filePathName = uploadPath + originalFileName;
			
			// 3. 파일 생성
			File file1 = new File(filePathName);
			
			// 4. 서버로 전송
			file.transferTo(file1);				
			
			// 서비스에 파일 path와 파일명 전달  -> 서비스 메소드에서 변경
			// 서비스에서 반환된 텍스트를 result에 저장
			result = ocrService.clovaOCRService(filePathName);
			System.out.println(result);
//			JSONParser jsonParser =new JSONParser();
//			
//			FileOutputStream output=new FileOutputStream(result,false);
//	        //true로 두면 이어서 쓰고 , false로 쓰면 새로 씀
//			OutputStreamWriter writer=new OutputStreamWriter(output,"UTF-8");
//	        BufferedWriter out=new BufferedWriter(writer);
//			Object obj = jsonParser.parse(null)
//			
//			JSONObject jsonObj =(JSONObject) obj;
//			System.out.println(jsonObj.get("inferText"));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String[] splitStr = result.split(" ");
		for(int i=0; i<splitStr.length;i++) {
			OCRlist.add(splitStr[i]);
		}
		
		System.out.println("OCRlist==="+OCRlist);
		retVal.put("OCRlist", OCRlist);
		return retVal;
	}
}

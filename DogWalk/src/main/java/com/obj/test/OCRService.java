package com.obj.test;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class OCRService {
	public String clovaOCRService(String filePathName) {
		// API 복사
		String apiURL = "https://zkp5riirnk.apigw.ntruss.com/custom/v1/20096/dd62c43cae804a7227f072e4eb50445653c668db182e60e29f577bf20e8bff2e/general";
		String secretKey = "SFJJZUZYd25YRHFHTmhwR1hzVWxhbFloYmtHQVRDZ1c=";
		String imageFile = filePathName; // 사용자가 직접 파일을 업로드 하게 함. 
		String result = "";
		

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setUseCaches(false);
			con.setDoInput(true);
			con.setDoOutput(true);
			con.setReadTimeout(30000);
			con.setRequestMethod("POST");
			String boundary = "----" + UUID.randomUUID().toString().replaceAll("-", "");
			con.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
			con.setRequestProperty("X-OCR-SECRET", secretKey);

			JSONObject json = new JSONObject();
			json.put("version", "V2");
			json.put("requestId", UUID.randomUUID().toString());
			json.put("timestamp", System.currentTimeMillis());
			JSONObject image = new JSONObject();
			image.put("format", "jpg");
			image.put("name", "demo");
			JSONArray images = new JSONArray();
			images.put(image);
			json.put("images", images);
			String postParams = json.toString();

			con.connect();
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			long start = System.currentTimeMillis();
			File file = new File(imageFile);
			writeMultiPart(wr, postParams, file, boundary);	// writeMultiPart 없다고 나옴
			wr.close();

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8"));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();

			System.out.println("response===="+response); // API 호출 결과를 콘솔에 출력
			
			// jsonToString() 메소드 호출하고 결과 받아옴
			result = jsonToString(response.toString());
			
			System.out.println("result==="+result); // 뭔가가 있는 줄 알았어요
			
		} catch (Exception e) {
			System.out.println(e);
		}
		
		return result;
		
	}//clovaOCRService
	
		
	private static void writeMultiPart(OutputStream out, String jsonMessage, File file, String boundary) throws
		IOException {
		StringBuilder sb = new StringBuilder();
		sb.append("--").append(boundary).append("\r\n");
		sb.append("Content-Disposition:form-data; name=\"message\"\r\n\r\n");
		sb.append(jsonMessage);
		sb.append("\r\n");
	
		out.write(sb.toString().getBytes("UTF-8"));
		out.flush();
	
		if (file != null && file.isFile()) {
			out.write(("--" + boundary + "\r\n").getBytes("UTF-8"));
			StringBuilder fileString = new StringBuilder();
			fileString
				.append("Content-Disposition:form-data; name=\"file\"; filename=");
			fileString.append("\"" + file.getName() + "\"\r\n");
			fileString.append("Content-Type: application/octet-stream\r\n\r\n");
			out.write(fileString.toString().getBytes("UTF-8"));
			out.flush();
	
			try (FileInputStream fis = new FileInputStream(file)) {
				byte[] buffer = new byte[8192];
				int count;
				while ((count = fis.read(buffer)) != -1) {
					out.write(buffer, 0, count);
				}
				out.write("\r\n".getBytes());
			}
	
			out.write(("--" + boundary + "--\r\n").getBytes("UTF-8"));
		}
		out.flush();
		
	} // writeMultiPart
		
	
	public String jsonToString(String jsonResultStr) {
		String resultText = "";
		
		// API 호출 결과 받은 JSON 형태 문자열에서 텍스트 추출
		// JSONParser  사용하지 않음
		
		// images / 0 / fields / inferText 추출
		JSONObject jsonObj = new JSONObject(jsonResultStr);
		JSONArray imageArray = (JSONArray) jsonObj.get("images");		
		
		if(imageArray != null) {
			JSONObject tempObj = (JSONObject) imageArray.get(0);
			JSONArray fieldArray = (JSONArray) tempObj.get("fields");
			
			if(fieldArray != null) {
				for(int i=0; i<fieldArray.length(); i++) {
					tempObj = (JSONObject) fieldArray.get(i);
					//resultText +="["+tempObj+"] \r\n";
					resultText += (String) tempObj.get("inferText") + " ";
				}
				
			}
		} else {
			System.out.println("없음");
		}		
		
		return resultText;
	} //jsonToString
	
	
} //OCRService

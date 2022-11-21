<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.*,java.util.*,net.sf.json.*"%>
<%
	BookDAO dao=new BookDAO();
	List<BookDTO> arr=dao.getAllBook();
	JSONArray jsonArr=JSONArray.fromObject(arr);
	//fromObject(arr) : static매서드,ArrayList를 JSONArray유형으로 변환해서 반환함
%>
<%=jsonArr.toString()%>
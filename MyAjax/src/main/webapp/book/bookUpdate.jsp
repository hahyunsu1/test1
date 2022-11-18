<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.*"%>
<%
  	request.setCharacterEncoding("utf-8");
  	String isbn=request.getParameter("isbn");
  	String title=request.getParameter("title");
  	String publish=request.getParameter("publish");
  	String priceStr=request.getParameter("price");
  	
  	int price=Integer.parseInt(priceStr);
  	BookDAO dao=new BookDAO();
  	BookDTO book=new BookDTO(isbn,title,publish,price,null,null);
  	int n=dao.updateBook(book);
  %>
  <result><%=n%></result>
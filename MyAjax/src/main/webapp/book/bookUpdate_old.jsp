<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.*"%>
<jsp:useBean id="bookDto" class="ajax.book.BookDTO" scope="page"/>
<jsp:setProperty property="*" name="bookDto"/>
<%
  /*	request.setCharacterEncoding("utf-8");
  	String isbn=request.getParameter("isbn");
  	String title=request.getParameter("title");
  	String publish=request.getParameter("publish");
  	String priceStr=request.getParameter("price");
  	
  	int price=Integer.parseInt(priceStr);
  	BookDAO dao=new BookDAO();
  	BookDTO book=new BookDTO(isbn,title,publish,price,null,null);
  	int n=dao.updateBook(book);*/
  	BookDAO dao=new BookDAO();
  	int n=dao.updateBook(bookDto);
  %>

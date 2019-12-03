<%@page import="secure.cryptRsa"%>
<%@page import="java.security.PrivateKey"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>복호화 페이지</title>
</head>
<body>
<%
	String securedUsername = request.getParameter("securedUsername");
String securedPassword = request.getParameter("securedPassword");
String username = "";
String password = "";

PrivateKey privateKey = (PrivateKey)session.getAttribute("_rsaPrivateKey_");
session.removeAttribute("_rsaPrivateKey_");						//세션에서 개인키값 삭제로 재사용방지

if(privateKey == null){
	out.print("<script>alert('세션에서 보안키를 찾을 수 없습니다.');</script>");
}
try{
	username = new cryptRsa().decryptRsa(privateKey, securedUsername);
	password = new cryptRsa().decryptRsa(privateKey, securedPassword);
}catch(Exception e){
	e.printStackTrace();
}
%>
<jsp:useBean id="decrypt" class="secure.cryptRsa"/>
<h1>ID : <%=username %></h1>
<h1>PW : <%=password %></h1>
</body>
</html>
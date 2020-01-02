<%@page import="secure.cryptedRsa"%>
<%@page import="java.io.IOException"%>
<%@page import="java.security.InvalidKeyException"%>
<%@page import="java.security.spec.RSAPublicKeySpec"%>
<%@page import="java.security.PrivateKey"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.KeyFactory"%>
<%@page import="java.security.KeyPair"%>
<%@page import="java.security.KeyPairGenerator"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	new cryptedRsa().encryptRsa(request, response, "Login2.jsp");			//키 생성후 로그인 페이지로 이동
%>
</body>
</html>

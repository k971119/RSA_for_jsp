<%@page import="secure.cryptedRsa"%>
<%@page import="java.io.IOException"%>
<%@page import="java.security.InvalidKeyException"%>
<%@page import="java.security.spec.RSAPublicKeySpec"%>
<%@page import="java.security.PrivateKey"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.KeyFactory"%>
<%@page import="java.security.KeyPair"%>
<%@page import="java.security.KeyPairGenerator"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	new cryptedRsa().encryptRsa(request, response, "Sec.jsp");
%>
</body>
</html>

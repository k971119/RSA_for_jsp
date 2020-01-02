<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인</title>
</head>
<body>
		<script type="text/javascript" src="lib/js/rsa/jsbn.js"></script>
        <script type="text/javascript" src="lib/js/rsa/rsa.js"></script>
        <script type="text/javascript" src="lib/js/rsa/prng4.js"></script>
        <script type="text/javascript" src="lib/js/rsa/rng.js"></script>
    </head>
    <body>
        <div>
            <label for="username">사용자ID : <input type="text" id="username" size="16"/></label>
            <label for="password">비밀번호 : <input type="password" id="password" size="16" /></label>
            <input type="hidden" id="rsaPublicKeyModulus" value="<%=request.getAttribute("publicKeyModulus")%>" />
            <input type="hidden" id="rsaPublicKeyExponent" value="<%=request.getAttribute("publicKeyExponent")%>" />
        </div>
        <form id="securedLoginForm" name="securedLoginForm" onsubmit="validateEncryptedForm()" action="main.jsp" method="post">
            <input type="hidden" name="securedUsername" id="securedUsername" value="" />
            <input type="hidden" name="securedPassword" id="securedPassword" value="" />
            <input type="submit" value="로그인">
        </form>
</body>
<script type="text/javascript">
function validateEncryptedForm(){			//로그인 버튼 클릭시 호출
	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	try{
		var rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
		var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
		submitEncryptedForm(username, password, rsaPublicKeyModulus, rsaPublicKeyExponent);			//복호화 호출
	}catch(err){
		alert("Error");
		alert(err);
	}
	return false;
}

function submitEncryptedForm(username, password, rsaPublicKeyModulus, rsaPublicKeyExponent){		//복호화 함수
	var rsa = new RSAKey();
	rsa.setPublic(rsaPublicKeyModulus, rsaPublicKeyExponent);
	
	var sUsername = rsa.encrypt(username);
	var sPassword = rsa.encrypt(password);
	
	var securedLoginForm = document.getElementById('securedLoginForm');
	
	securedLoginForm.securedUsername.value = sUsername;
	securedLoginForm.securedPassword.value = sPassword
}
</script>
</html>
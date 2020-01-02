<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Î°úÍ∑∏Ïù∏</title>
</head>
<body>
		<script type="text/javascript" src="lib/js/rsa/jsbn.js"></script>
        <script type="text/javascript" src="lib/js/rsa/rsa.js"></script>
        <script type="text/javascript" src="lib/js/rsa/prng4.js"></script>
        <script type="text/javascript" src="lib/js/rsa/rng.js"></script>
    </head>
    <body>
        <div>
            <label for="username">ÏÇ¨Ïö©ÏûêID : <input type="text" id="username" size="16"/></label>
            <label for="password">ÎπÑÎ∞ÄÎ≤àÌò∏ : <input type="password" id="password" size="16" /></label>
            <input type="hidden" id="rsaPublicKeyModulus" value="<%=request.getAttribute("publicKeyModulus")%>" />
            <input type="hidden" id="rsaPublicKeyExponent" value="<%=request.getAttribute("publicKeyExponent")%>" />
        </div>
        <form id="securedLoginForm" name="securedLoginForm" onsubmit="validateEncryptedForm()" action="main.jsp" method="post">
            <input type="hidden" name="securedUsername" id="securedUsername" value="" />
            <input type="hidden" name="securedPassword" id="securedPassword" value="" />
            <input type="submit" value="Î°úÍ∑∏Ïù∏">
        </form>
</body>
<script type="text/javascript">
function validateEncryptedForm(){			//∑Œ±◊¿Œ πˆ∆∞ ≈¨∏ØΩ√ »£√‚
	var username = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	try{
		var rsaPublicKeyModulus = document.getElementById("rsaPublicKeyModulus").value;
		var rsaPublicKeyExponent = document.getElementById("rsaPublicKeyExponent").value;
		submitEncryptedForm(username, password, rsaPublicKeyModulus, rsaPublicKeyExponent);			//∫π»£»≠ »£√‚
	}catch(err){
		alert("Error");
		alert(err);
	}
	return false;
}

function submitEncryptedForm(username, password, rsaPublicKeyModulus, rsaPublicKeyExponent){		//∫π»£»≠ «‘ºˆ
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

package secure;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class cryptedRsa {
	/**
	 * ��ȣȭ�� ���� Ŭ����
	 * @param privateKey	���� Ű��
	 * @param securedValue 	�ؼ��� ����
	 * @return
	 * @throws Exception
	 */
	public static String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception{
		System.out.println("will decrypt : "+ securedValue);
		Cipher cipher = Cipher.getInstance("RSA");
		byte[] encryptedBytes = hexToByteArray(securedValue);
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
		String decryptedValue = new String(decryptedBytes,"utf-8");
		return decryptedValue;
	}
	/**
	 * 16�� ���ڿ��� byte �迭�� ��ȯ
	 * @param hex
	 * @return
	 */
	public static byte[] hexToByteArray(String hex) {
		if(hex == null || hex.length()%2 !=0) {
			System.out.println("���� �����ϴ�.");
		}
		
		byte[] bytes = new byte[hex.length()/2];
		for(int i=0;i<hex.length();i+=2) {
			byte value = (byte)Integer.parseInt(hex.substring(i,i+2),16);
			bytes[(int)Math.floor(i/2)] = value;
		}
		return bytes;
	}
	/**
	 * ��ȣȭ�� ���� Ű�� ����
	 * @param request
	 * @param response
	 * @param path
	 * @throws NoSuchAlgorithmException
	 */
	public static void encryptRsa(HttpServletRequest request, HttpServletResponse response, String path) throws NoSuchAlgorithmException{
		KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
		generator.initialize(2048);

		KeyPair keypair = generator.genKeyPair();
		KeyFactory keyFactory = KeyFactory.getInstance("RSA");

		PublicKey publicKey = keypair.getPublic();
		PrivateKey privateKey = keypair.getPrivate();

		//���ǿ� ����Ű ���
		HttpSession session = request.getSession();
		session.setAttribute("_rsaPrivateKey_", privateKey);

		String publicKeyModulus = "";
		String publicKeyExponent = "";

		try {
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec)keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			publicKeyModulus = publicSpec.getModulus().toString(16);
			publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			request.setAttribute("publicKeyModulus", publicKeyModulus);
			request.setAttribute("publicKeyExponent", publicKeyExponent);
			
			request.getRequestDispatcher(path).forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

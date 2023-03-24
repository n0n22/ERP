package com.ndcnc.erp.login.model.vo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.SecureRandom;

import javax.servlet.http.HttpSession;

import lombok.Data;

@Data
public class NaverLoginBO {
	
	
	private final static String CLIENT_ID = "";
	private final static String CLIENT_SECRET = "";
	
	private final static String CALLBACK_URL = "http://localhost:8088/erp/callbackNaver.do";
	
	
	// 네이버 로그인 인증 요청문 생성
	public String getAuthenticationRequest(HttpSession session) {
		
		/*
			https://nid.naver.com/oauth2.0/authorize?
			client_id={클라이언트 아이디}&
			response_type=code&
			redirect_uri={개발자 센터에 등록한 콜백 URL(URL 인코딩)}&
			state={상태 토큰}
		*/
		
		String requestUrl = "https://nid.naver.com/oauth2.0/authorize?";
		requestUrl += "client_id=" + CLIENT_ID
					 + "&response_type=code"
					 + "&redirect_uri=" + CALLBACK_URL
					 + "&state=" + getState(session);
	
        /* Scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네아로 인증 URL 생성 
        OAuth20Service oauthService = new ServiceBuilder()                                                   
                .apiKey(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .callback(CALLBACK_URL)
                .state(getState(session)) //앞서 생성한 난수값을 인증 URL생성시 사용함
                .build(Login.instance());

        return oauthService.getAuthorizationUrl();
		*/
		
		
		return requestUrl;
	}
	
	
	// 접근토큰 요청
	public String getAccessToken(HttpSession session, String state, String code) throws IOException {
		
	/*
		https://nid.naver.com/oauth2.0/token?
		client_id={클라이언트 아이디}&
		client_secret={클라이언트 시크릿}&
		grant_type=authorization_code&
		state={상태 토큰}&
		code={인증 코드}
	*/
		
		String url = "https://nid.naver.com/oauth2.0/token?";
		url += "client_id=" + CLIENT_ID
			+ "&client_secret=" + CLIENT_SECRET
			+ "&grant_type=authorization_code"
			+ "&state=" + state
			+ "&code=" + code;
		
		System.out.println("접근토큰 요청 URL" + url);
		
		URL requestUrl = new URL(url);
		HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection();
		urlConnection.setRequestMethod("GET");
			   
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
			   
		String responseText = br.readLine();
		
		br.close();
		urlConnection.disconnect();

		System.out.println(responseText);
		
		return responseText;
	}
	
	
	
	
	
	
	
	// ------------------ 상태토큰  ----------------
	
	// 랜덤문자열 생성
	private String generateState() {
	    SecureRandom random = new SecureRandom();
	    return new BigInteger(130, random).toString(32);
	}
	
	// 랜덤문자열 생성하여 만든 상태토큰 반환
	private String getState(HttpSession session) {
		// 상태 토큰으로 사용할 랜덤 문자열 생성
		String state = generateState();
		// 세션에 상태 토큰을 저장
		session.setAttribute("state", state);
		return state;		
	}


	// --------------------------------------------

	
	
	

}

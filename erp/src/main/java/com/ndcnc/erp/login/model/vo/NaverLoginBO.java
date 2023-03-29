package com.ndcnc.erp.login.model.vo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.SecureRandom;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import lombok.Data;

@Data
public class NaverLoginBO {
	
	
	private final static String CLIENT_ID = "";
	private final static String CLIENT_SECRET = "";
	
	private final static String CALLBACK_URL = "http://localhost:8088/erp/callbackNaver.do";
	
	// OAuth20Service객체 생성
	private final OAuth20Service service = new ServiceBuilder(CLIENT_ID)
									            .apiSecret(CLIENT_SECRET)
									            .callback(CALLBACK_URL)
									            .build(NaverApi.instance());
	
	private static final String PROTECTED_RESOURCE_URL = "https://openapi.naver.com/v1/nid/me";
	
	// 네이버 로그인 인증 요청문 생성
	public String getAuthenticationRequest(HttpSession session) {
		
		String authorizationUrl = service.getAuthorizationUrl(getState(session));
		
		return authorizationUrl;
	}
	
	
	// 접근토큰 요청
	public OAuth2AccessToken getAccessToken(HttpSession session, String state, String code) throws IOException, Exception, ExecutionException {
		
		OAuth2AccessToken accessToken = service.getAccessToken(code);
		
		session.setAttribute("accessToken", accessToken);
		
		return accessToken;
	}
	
	
	// 사용자 프로필 정보 요청
	public JSONObject getUserProfile(OAuth2AccessToken accessToken) throws IOException, InterruptedException, ExecutionException {
		
		JSONObject userInfo = null; // 반환할 JSONObject
		
		OAuthRequest request = new OAuthRequest(Verb.GET, PROTECTED_RESOURCE_URL);
        service.signRequest(accessToken, request);
        
        Response response = service.execute(request);
        int code = response.getCode();
        System.out.println(code);
        if(code == 200) { // 응답 성공 시,
        	String responseText = response.getBody();
        	
        	JSONObject jsonOb = responseToJson(responseText);
        	userInfo = (JSONObject)jsonOb.get("response");  	
        }
        
        return userInfo;
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

	
	private JSONObject responseToJson(String response) {
		
		JSONParser jsonParser = new JSONParser();
		JSONObject response_obj = null;
		
		try {
			response_obj = (JSONObject) jsonParser.parse(response);
			System.out.println("json변환 완료" + response_obj);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return response_obj;
	}
	
	
	
	
	// --------------------------------------------------------------------------------------------------------------
	// --------------------------------------------------  이    전   코   드   -----------------------------------------------
	// --------------------------------------------------------------------------------------------------------------
	
	
	/*
	public String getAuthenticationRequest(HttpSession session) {

		//		https://nid.naver.com/oauth2.0/authorize?
		//		client_id={클라이언트 아이디}&
		//		response_type=code&
		//		redirect_uri={개발자 센터에 등록한 콜백 URL(URL 인코딩)}&
		//		state={상태 토큰}

		
		String requestUrl = "https://nid.naver.com/oauth2.0/authorize?";
		requestUrl += "client_id=" + CLIENT_ID
					 + "&response_type=code"
					 + "&redirect_uri=" + CALLBACK_URL
					 + "&state=" + getState(session);
		
		return requestUrl;
	}
	
	*/
	

	/*
	// 접근토큰 요청
	public String getAccessToken(HttpSession session, String state, String code) throws IOException, Exception, ExecutionException {
	
	//		https://nid.naver.com/oauth2.0/token?
	//		client_id={클라이언트 아이디}&
	//		client_secret={클라이언트 시크릿}&
	//		grant_type=authorization_code&
	//		state={상태 토큰}&
	//		code={인증 코드}
		

		String url = "https://nid.naver.com/oauth2.0/token?";
		url += "client_id=" + CLIENT_ID
			+ "&client_secret=" + CLIENT_SECRET
			+ "&grant_type=authorization_code"
			+ "&state=" + state
			+ "&code=" + code;
		
		URL requestUrl = new URL(url);
		HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection();
		urlConnection.setRequestMethod("POST");
			   
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		String responseText = br.readLine();
		
		br.close();
		urlConnection.disconnect();
		
	//		{
	//   	 "access_token": "AAAAQosjWDJieBiQZc3to9YQp6HDLvrmyKC+6+iZ3gq7qrkqf50ljZC+Lgoqrg",
	//   	 "refresh_token": "c8ceMEJisO4Se7uGisHoX0f5JEii7JnipglQipkOn5Zp3tyP7dHQoP0zNKHUq2gY",
	//   	 "token_type": "bearer",
	//  	 "expires_in": "3600"
	//		}
	
		JSONObject responseJson = responseToJson(responseText);
		return (String)responseJson.get("access_token");

	}
	*/
	
	
	
	/*
	// 사용자 프로필 정보 요청
	public JSONObject getUserProfile(OAuth2AccessToken accessToken) throws IOException, InterruptedException, ExecutionException {

	//		User-Agent: curl/7.12.1 (i686-redhat-linux-gnu) libcurl/7.12.1 OpenSSL/0.9.7a zlib/1.2.1.2 libidn/0.5.6
	//		Host: openapi.naver.com
	//		Pragma: no-cache
	//		Accept: 별/별
	//		Authorization: Bearer AAAAOLtP40eH6P5S4Z4FpFl77n3FD5I+W3ost3oDZq/nbcS+7MAYXwX
	//		bT3Y7Ib3dnvcqHkcK0e5/rw6ajF7S/QlJAgUukpp1OGkG0vzi16hcRNYX6RcQ6kPxB0oAvqfUPJiJw==


		String url = "https://openapi.naver.com/v1/nid/me";
		URL requestUrl = new URL(url);
		HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection();
		// 헤더 설정
		urlConnection.setRequestProperty("User-Agent", "curl/7.12.1 (i686-redhat-linux-gnu) libcurl/7.12.1 OpenSSL/0.9.7a zlib/1.2.1.2 libidn/0.5.6");
		urlConnection.setRequestProperty("Host", "openapi.naver.com");
		urlConnection.setRequestProperty("Pragma", "no-cache");
		urlConnection.setRequestProperty("Accept", "*");/*
		urlConnection.setRequestProperty("Authorization", "Bearer " + accessToken);
		urlConnection.setRequestMethod("POST");
		   
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		String responseText = br.readLine();
		
		br.close();
		urlConnection.disconnect();
		
		JSONObject jsonOb = responseToJson(responseText);
		JSONObject userInfo = (JSONObject)jsonOb.get("response");
		
		return userInfo;
	}
	*/
	
	
	
	// 접근토큰 삭제
	public String deleteAccessToken(String accessToken) throws IOException {
	
	//		https://nid.naver.com/oauth2.0/token?grant_type=delete
	//		&client_id={클라이언트 아이디}
	//		&client_secret={클라이언트 시크릿}
	//		&access_token={접근 토큰}
	//		&service_provider=NAVER
		
		String url = "https://nid.naver.com/oauth2.0/token?grant_type=delete";
		url += "&client_id=" + CLIENT_ID
		     + "&client_secret=" + CLIENT_SECRET
		     + "&access_token=" + accessToken
		     + "&service_provider=NAVER";
		
		URL requestUrl = new URL(url);
		HttpURLConnection urlConnection = (HttpURLConnection) requestUrl.openConnection();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		String responseText = br.readLine();
		
		br.close();
		urlConnection.disconnect();
		
		// System.out.println(responseText);
		JSONObject jsonOb = responseToJson(responseText);
		String result = (String)jsonOb.get("result");
		
		return result;
	}

	
	
	
	

}

package com.ndcnc.erp.login.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ndcnc.erp.login.model.service.LoginService;
import com.ndcnc.erp.login.model.vo.NaverLoginBO;
import com.ndcnc.erp.login.model.vo.NaverLoginUser;


@Controller
public class NaverLoginController {
	
	
	private NaverLoginBO naverLoginBO = new NaverLoginBO();
	
	@Autowired
	private LoginService loginService;
	
	
	/*
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	*/
	
	
	// 로그인 화면으로 이동
	// naver로 로그인 하는 사람을 위해 네이버 로그인 인증 url을 보내줌
	@RequestMapping("/loginForm")
	public String loginForm(HttpSession session, Model model) {
		
		String url =  naverLoginBO.getAuthenticationRequest(session);
		model.addAttribute("url", url);
		
		return "login_form";
	}
	
	
	// 네이버로 로그인 성공하면 이쪽으로 보내줌
	@RequestMapping("/callbackNaver.do")
	public String callbackNaver(@RequestParam String state, @RequestParam String code, HttpSession session) throws IOException {
	/*
		{개발자 센터에 등록한 콜백 URL}?state={상태 토큰}&code={인증 코드}
	*/
		String returnState = (String)session.getAttribute("state");
		String accessToken = "";
		// 내가 보낸 상태토큰과 돌아온 값이 일치하는지 비교
		if(state.equals(returnState)) { // 일치하면 접근토큰 요청
			accessToken = naverLoginBO.getAccessToken(session, returnState, code);		
		} else {
			return "login_form";
		}
		JSONObject userInfo = naverLoginBO.getUserProfile(accessToken);
		
		NaverLoginUser user = new NaverLoginUser((String)userInfo.get("name"),
												 (String)userInfo.get("birthday"),
												 (String)userInfo.get("gender"),
												 (String)userInfo.get("mobile"));
		
		System.out.println("네이버로 로그인한 회원 정보 : " + user);
		
		// 기존에 등록했는지 확인해서 아닐 경우에만 새로 입력
		
		
		
		
		
		
		return "main";
	}
	
	
	
	
	
	
}

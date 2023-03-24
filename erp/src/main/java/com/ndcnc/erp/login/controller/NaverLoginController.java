package com.ndcnc.erp.login.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ndcnc.erp.login.model.vo.NaverLoginBO;


@Controller
public class NaverLoginController {
	
	// Autowired가 왜 안되지??
	private NaverLoginBO naverLoginBO = new NaverLoginBO();
	
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
		// 내가 보낸 상태토큰과 돌아온 값이 일치하는지 비교
		if(state.equals(returnState)) { // 일치하면 접근토큰 요청
			naverLoginBO.getAccessToken(session, returnState, code);		
			
		} 
		
		return "main";
	}
	
	
	
	
	
	
}

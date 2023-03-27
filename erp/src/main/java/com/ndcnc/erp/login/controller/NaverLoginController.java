package com.ndcnc.erp.login.controller;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.ndcnc.erp.login.model.service.LoginService;
import com.ndcnc.erp.login.model.vo.NaverLoginBO;
import com.ndcnc.erp.login.model.vo.NaverLoginUser;


@Controller
public class NaverLoginController {
	
	@Autowired
	private NaverLoginBO naverLoginBO;
	
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
	public String loginForm(HttpSession session, Model model) throws IOException {
		
		String url =  naverLoginBO.getAuthenticationRequest(session);
		model.addAttribute("url", url);
		
		return "login_form";
	}
	
	
	// 네이버로 로그인 성공하면 이쪽으로 보내줌
	@RequestMapping("/callbackNaver.do")
	public String callbackNaver(@RequestParam String state, @RequestParam String code, HttpSession session) throws ExecutionException, Exception {
	/*
		{개발자 센터에 등록한 콜백 URL}?state={상태 토큰}&code={인증 코드}
	*/
		String returnState = (String)session.getAttribute("state");
		OAuth2AccessToken accessToken = null;
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
		
		session.setAttribute("loginUser", user);		
		
		return "redirect:/";
	}
	
	
	@RequestMapping("/")
	public String loginSuccess() {
		return "staff_search_form";
	}
	
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) throws IOException {
	
		session.setAttribute("loginUser", null);
		session.setAttribute("accessToken", null);
		session.setAttribute("state", null);
		session.setAttribute("alertMsg", "로그아웃 되었습니다.");
		
		return "redirect:/";
	}
	
	
	@RequestMapping("/deleteNaverLogin.do")
	public String deleteNaverLogin(HttpSession session) throws IOException {
		
		// naver로 로그인 했을 때
		if(session.getAttribute("accessToken") != null) {
			OAuth2AccessToken accessToken = (OAuth2AccessToken)session.getAttribute("accessToken");
			
			if(naverLoginBO.deleteAccessToken(accessToken.getAccessToken()).equals("success")) {
				
				session.setAttribute("loginUser", null);
				session.setAttribute("accessToken", null);
				session.setAttribute("state", null);
				session.setAttribute("alertMsg", "네이버 로그인 연동이 해제되었습니다.");
				
			}
					
		}
		
		return "redirect:/";
	}
	
	
	
	
	
}

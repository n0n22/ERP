package com.ndcnc.erp.login.controller;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.ndcnc.erp.login.model.service.LoginService;
import com.ndcnc.erp.login.model.vo.Member;
import com.ndcnc.erp.login.model.vo.NaverLoginBO;


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
	@RequestMapping("/login")
	public String loginForm(HttpSession session, Model model) throws IOException {
		
		String url =  naverLoginBO.getAuthenticationRequest(session);
		model.addAttribute("url", url);
		
		return "login_form";
	}
	
	// 회원가입 화면으로 이동
	@RequestMapping("/signIn")
	public String signIn_select(HttpSession session, Model model) throws IOException {
		
		String url =  naverLoginBO.getAuthenticationRequest(session);
		model.addAttribute("url", url);
		
		return "signIn_select";
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
		System.out.println(userInfo);
		
		Member mem = new Member();
		mem.setMemEmail((String)userInfo.get("email"));
		mem.setMemMobile((String)userInfo.get("mobile"));
		mem.setMemName((String)userInfo.get("name"));
		
		int count = loginService.selectCountByEmail(mem);
		
		if(count != 0) { // 조회된 회원 - 이미 가입이 되어있음
			Member loginMember = loginService.selectMemByEmail(mem);
			session.setAttribute("loginMember", loginMember);
			session.setAttribute("alertMsg", "반갑습니다. " + loginMember.getMemName() + "님!");
			return "redirect:/";
		} else { // 조회되지 않은 회원 - 테이블에 등록
			session.setAttribute("mem", mem);
			return "naverEnroll";
		}
			
	}
	
	
	@RequestMapping("/naverEnroll")
	public String naverEnroll(@ModelAttribute Member mem, HttpSession session) {

		int memNo = loginService.insertNaverLogin(mem);

		Member loginMember = loginService.selectMemByEmail(mem);

		session.setAttribute("loginMember", loginMember);
		session.setAttribute("alertMsg", "회원가입에 성공했습니다. 반갑습니다. " + loginMember.getMemName() + "님!");
		return "redirect:/";
	}
	

	@RequestMapping("/")
	public String loginSuccess() {
		return "staff_search_form";
	}
	
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) throws IOException {
	
		session.setAttribute("loginMember", null);
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
				
				loginService.deleteMember(((Member)session.getAttribute("loginMember")).getMemNo());
				
				session.setAttribute("loginMember", null);
				session.setAttribute("accessToken", null);
				session.setAttribute("state", null);
				session.setAttribute("alertMsg", "네이버 로그인 연동이 해제되었습니다.");
				
			}
					
		}
		
		return "redirect:/";
	}
	
	
	
	
	
}

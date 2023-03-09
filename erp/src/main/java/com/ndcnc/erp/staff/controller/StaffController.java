package com.ndcnc.erp.staff.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ndcnc.erp.staff.model.service.StaffService;
import com.ndcnc.erp.staff.model.vo.PageInfo;
import com.ndcnc.erp.staff.model.vo.SearchCondition;
import com.ndcnc.erp.staff.model.vo.Staff;

@Controller
public class StaffController {

	@Autowired
	private StaffService staffService;
	
	// 등록 페이지로 이동
	@RequestMapping("staffInputForm.do")
	public String inputStaffForm() {
		return "staff_input_form";
	}
	
	// 사원 등록
	@RequestMapping("staffInput.do")
	public ModelAndView inputStaff(@ModelAttribute Staff newStaff, ModelAndView mv) {
		
		if(staffService.inputStaff(newStaff) > 0) {
			mv.addObject("alertMsg", "등록되었습니다.").setViewName("staff_input_form");
		} else {
			mv.addObject("alertMsg", "등록에 실패하였습니다.");
		}
	
		return mv;
	}
	
	
	// 전체 사원 검색
	@ResponseBody
	@RequestMapping(value="selectAll.do", produces="application/json; charset=UTF-8")
	public String selectAll(@RequestParam int cpage) {
		
		PageInfo pi = getPageInfo(staffService.selectAllListCount(), cpage, 5, 5);
		ArrayList<Staff> list = staffService.selectAllList(pi);
		
		HashMap<String, Object> map = new HashMap();
		map.put("list", list);
		map.put("pi", pi);

	    return new Gson().toJson(map);	
	}
	
	
	// 사원 검색
	@ResponseBody
	@RequestMapping(value="searchStaff.do", produces="application/json; charset=UTF-8")
	public String selectStaff(@ModelAttribute SearchCondition sc) {
		
		System.out.println(sc);
		
		PageInfo pi = getPageInfo(staffService.selectStaffCount(sc), sc.getCpage(), 5, 5);
		
		
		
		return "main";
	}
	
	
	
	
	
	
	
	
	
	
	
	// 페이지 관련 변수 생성
	public PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) endPage = maxPage;
		
		return new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
	}
	
	
}

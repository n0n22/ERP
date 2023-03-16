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
		
		if(newStaff.getSkill_name() != null) { // 기술이 있을 때
			if(staffService.inputStaff(newStaff) >= 2) {
				mv.addObject("alertMsg", "등록되었습니다.");
			} else {
				mv.addObject("alertMsg", "사원 등록을 실패했습니다.");			
			}
		} else { // 기술이 없을 때
			if (staffService.inputStaffOnly(newStaff) > 0) {
				mv.addObject("alertMsg", "등록되었습니다.");
			} else {
				mv.addObject("alertMsg", "사원 등록을 실패했습니다.");			
			}
		}
		
		mv.setViewName("staff_input_form");
		return mv;
	}
	
	
	// 전체 사원 검색
	@ResponseBody
	@RequestMapping(value="selectAll.do", produces="application/json; charset=UTF-8")
	public String selectAll(@RequestParam int cpage,
							@RequestParam String orderCondition,
							@RequestParam String desc) {
		
		HashMap<String, Object> map = new HashMap();
		map.put("orderCondition", orderCondition);
		map.put("desc", desc);
		
		PageInfo pi = getPageInfo(staffService.selectAllListCount(), cpage, 5, 5);
		ArrayList<Staff> list = staffService.selectAllList(map, pi);
		
		map.put("list", list);
		map.put("pi", pi);

	    return new Gson().toJson(map);	
	}
	
	
	// 사원 검색
	@ResponseBody
	@RequestMapping(value="searchStaff.do", produces="application/json; charset=UTF-8")
	public String selectStaff(@ModelAttribute SearchCondition sc) {
		
		PageInfo pi = getPageInfo(staffService.selectStaffCount(sc), sc.getCpage(), 5, 5);
		ArrayList<Staff> list = staffService.selectStaff(sc, pi);
		
		HashMap<String, Object> map = new HashMap();
		map.put("orderCondition", sc.getOrderCondition());
		map.put("desc", sc.getDesc());
		map.put("list", list);
		map.put("pi", pi);
		
		return new Gson().toJson(map);
	}
	
	
	
	// 수정,삭제 페이지 이동
	@RequestMapping("staffUpdelForm.do")
	public ModelAndView selectStaff(@RequestParam int staff_no, ModelAndView mv) {
		// 사원 정보 조회 후 들고 페이지로 이동
		Staff staff = staffService.selectStaffInfo(staff_no);
		mv.addObject("staff", staff).setViewName("staff_updel_form");		
		return mv;
	}
	
	
	// 사원 정보 수정
	@RequestMapping("updateStaff.do")
	public ModelAndView updateStaff(@ModelAttribute Staff staff, ModelAndView mv) {

		if(staff.getSkill_name() != null) { // 기술이 있을 때
			if(staffService.updateStaff(staff) > 0) {
				// 정보수정 + 기존 기술 삭제 후 업데이트
				mv.addObject("staff", staffService.selectStaffInfo(staff.getStaff_no())).addObject("alertMsg", "수정이 완료되었습니다.");			
			} else {
				mv.addObject("alertMsg", "수정 실패!");	
			}
		} else { // 기술이 없을 때
			if (staffService.updateStaffInfo(staff) > 0) {
				// 정보수정 + 기존 기술 삭제
				mv.addObject("staff", staffService.selectStaffInfo(staff.getStaff_no())).addObject("alertMsg", "수정이 완료되었습니다.");			
			} else {
				mv.addObject("alertMsg", "수정 실패!");	
			}
		} 
	
		mv.setViewName("staff_updel_form");
		return mv;
	}
	
	
	// 사원 정보 삭제
	@RequestMapping("deleteStaff.do")
	public ModelAndView updateStaff(@RequestParam int staff_no, ModelAndView mv) {
		
		if(staffService.deleteStaff(staff_no) > 0) {
			mv.addObject("deleteAlertMsg", "삭제되었습니다.");
		} else {
			mv.addObject("deleteAlertMsg", "삭제 실패!");
		}
		
		mv.setViewName("staff_updel_form");
		return mv;
	}
	
	
	// 기술 목록 조회
	@ResponseBody
	@RequestMapping(value="selectSkill.do", produces="application/json; charset=UTF-8")
	public String selectSkill() {
		ArrayList<String> list = new ArrayList();
		list = staffService.selectSkill();
		return new Gson().toJson(list);
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

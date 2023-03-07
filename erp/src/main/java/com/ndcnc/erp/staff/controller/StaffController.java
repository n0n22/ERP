package com.ndcnc.erp.staff.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ndcnc.erp.staff.model.service.StaffService;
import com.ndcnc.erp.staff.model.vo.Staff;

@Controller
public class StaffController {

	@Autowired
	private StaffService staffService;
	
	
	@RequestMapping("staffInputForm.do")
	public String inputStaffForm() {
		
		return "staff_input_form";
	}
	
	
	@RequestMapping("staffInput.do")
	public String inputStaff(@ModelAttribute Staff newStaff) {
		
		if(staffService.inputStaff(newStaff) > 0) {
			
		} else {
			
		}
		
		
		return "staff_input_form";
	}
	
	
	
	
}

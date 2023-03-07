package com.ndcnc.erp.staff.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ndcnc.erp.staff.model.dao.StaffDao;
import com.ndcnc.erp.staff.model.vo.Staff;

@Service
public class StaffService {

	@Autowired
	private StaffDao staffDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public int inputStaff(Staff newStaff) {
		return staffDao.inputStaff(newStaff, sqlSession);
	}
	
}

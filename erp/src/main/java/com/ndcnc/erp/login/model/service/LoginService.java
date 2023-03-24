package com.ndcnc.erp.login.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ndcnc.erp.login.model.dao.LoginDao;

@Service
public class LoginService {
	
	@Autowired
	private LoginDao loginDao;
	
	
	

}

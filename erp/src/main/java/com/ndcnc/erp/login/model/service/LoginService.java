package com.ndcnc.erp.login.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ndcnc.erp.login.model.dao.LoginDao;
import com.ndcnc.erp.login.model.vo.Member;

@Service
public class LoginService {
	
	@Autowired
	private LoginDao loginDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;


	public int selectMemByEmail(Member mem) {
		return loginDao.selectMemByEmail(mem, sqlSession);
	}
	
	public int insertNaverLogin(Member mem) {
		return loginDao.insertNaverLogin(mem, sqlSession);
	}
	
	public Member selectMemByMemNo(int memNo) {
		return loginDao.selectMemByMemNo(memNo, sqlSession);
	}
	
	public int deleteMember(int memNo) {
		return loginDao.deleteMember(memNo, sqlSession);
	}
	
	

}

package com.ndcnc.erp.login.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.ndcnc.erp.login.model.vo.Member;


@Repository
public class LoginDao {

	public int selectCountByEmail(Member mem, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("loginMapper.selectCountByEmail", mem);
	}

	public int insertNaverLogin(Member mem, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("loginMapper.insertNaverLogin", mem);
	}

	public Member selectMemByEmail(Member mem, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("loginMapper.selectMemByEmail", mem);
	}
	
	public int deleteMember(int memNo, SqlSessionTemplate sqlSession) {
		return sqlSession.delete("loginMapper.deleteMember", memNo);
	}
	
	
}

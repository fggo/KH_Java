package com.kh.spring.demo.model.dao;


import org.mybatis.spring.SqlSessionTemplate;

import com.kh.spring.demo.model.vo.Member;

public interface MemberDao {
  Member selectMemberOne(SqlSessionTemplate sqlSession, Member member);
}

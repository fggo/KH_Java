package com.mybatisdy.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

public class EmpDaoImpl implements EmpDao {

  @Override
  public List<Map> selectSearch1(SqlSession session, Map<String, String> param) {
    //���⼭ case�� ���ʿ� ���� mapper.xml���� <if> <when> ������ ���ǹ� ��
    return session.selectList("emp.selectSearch1", param);
  }
}

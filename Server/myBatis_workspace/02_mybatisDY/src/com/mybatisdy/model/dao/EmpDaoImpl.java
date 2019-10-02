package com.mybatisdy.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

public class EmpDaoImpl implements EmpDao {

  @Override
  public List<Map> selectSearch1(SqlSession session, Map<String, String> param) {
    //���⼭ case�� ���ʿ� ���� mapper.xml���� <if> <when> ������ ���ǹ� ��
    return session.selectList("emp.selectSearch1", param);
  }

  @Override
  public List<Map> selectSearch2(SqlSession session, Map<String, Object> param) {
    return session.selectList("emp.selectSearch2", param);
  }

  @Override
  public List<Map<String,String>> selectEmpList(SqlSession session, int cPage, int numPerPage) {
    // 1.���̹�Ƽ������ ����¡ó���� �ϱ� ���ؼ��� RowBounds��ü�� �̿�
    //RowBounds��ü�� �����ؼ� �Ű������� ������ ���ָ� �ڵ�����
    //RowBounds�� ���� ���� ������ ������ ����¡ ó���� �ϰԵ�.
    //�������� �Ű�����: offset, limit
    //  offset : ��� �ڷḦ(row) ��������(�ǳʶ���) == ���� ��
    //  limit : �� ������ �� �Խù� �� == ������ ��
    RowBounds row = new RowBounds((cPage - 1)*numPerPage, numPerPage);

    return session.selectList("emp.selectEmpList", null, row);
  }

  @Override
  public int selectEmpCount(SqlSession session) {
    return session.selectOne("emp.selectEmpCount");
  }
}

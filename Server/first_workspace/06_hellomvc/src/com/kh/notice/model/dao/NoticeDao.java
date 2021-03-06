package com.kh.notice.model.dao;

import static common.template.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.kh.notice.model.vo.Notice;

public class NoticeDao {
  private Properties prop = new Properties();

  public NoticeDao() {
    String path = NoticeDao.class.getResource("/sql/notice/notice-query.properties").getPath();

    try {
      prop.load(new FileReader(path));
    } catch(IOException e) {
      e.printStackTrace();
    }
  }
  
  public int selectCountNotice(Connection conn) {
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int count=0;
    String sql = prop.getProperty("selectCountNotice");
    try {
      pstmt = conn.prepareStatement(sql);
      rs = pstmt.executeQuery();
      if(rs.next()) {
        count = rs.getInt(1);
      }
    } catch(SQLException e) {
      e.printStackTrace();
    } finally {
      close(rs);
      close(pstmt);
    }

    return count;
  }
  
  public List<Notice> selectNoticeList(Connection conn, int cPage, int numPerPage){
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = prop.getProperty("selectNoticeList");

    List<Notice> list = new ArrayList<Notice>();

    try {
      pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, (cPage-1)*numPerPage +1);
      pstmt.setInt(2, cPage*numPerPage);
      rs = pstmt.executeQuery();

      while(rs.next()) {
        Notice n = new Notice();

        n.setNoticeNo(rs.getInt("notice_no"));
        n.setNoticeTitle(rs.getString("notice_title"));
        n.setNoticeWriter(rs.getString("notice_writer"));
        n.setNoticeContent(rs.getString("notice_content"));
        n.setNoticeDate(rs.getDate("notice_date"));
        n.setFilePath(rs.getString("filepath"));

        list.add(n);
      }
    }catch(SQLException e) {
      e.printStackTrace();
    } finally {
      close(rs);
      close(pstmt);
    }
    return list;
  }
  
  public Notice selectNoticeOne(Connection conn, int no) {
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    Notice n = null;
    String sql = prop.getProperty("selectNoticeOne");
    
    try {
      pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, no);
      rs = pstmt.executeQuery();
      if(rs.next()) {
        n = new Notice();

        n.setNoticeNo(rs.getInt("notice_no"));
        n.setNoticeTitle(rs.getString("notice_title"));
        n.setNoticeWriter(rs.getString("notice_writer"));
        n.setNoticeContent(rs.getString("notice_content"));
        n.setNoticeDate(rs.getDate("notice_date"));
        n.setFilePath(rs.getString("filepath"));
      }
    } catch(SQLException e) {
      e.printStackTrace();
    } finally {
      close(rs);
      close(pstmt);
    }
    
    return n;
  }
  
  public int insertNotice(Connection conn, Notice n) {
    PreparedStatement pstmt = null;
    int result = 0;
    String sql = prop.getProperty("insertNotice");
    try {
      pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, n.getNoticeTitle());
      pstmt.setString(2, n.getNoticeWriter());
      pstmt.setString(3, n.getNoticeContent());
      pstmt.setString(4, n.getFilePath());

      result = pstmt.executeUpdate();
    } catch(SQLException e) {
      e.printStackTrace();
    } finally {
      close(pstmt);
    }
    
    return result;
  }
  public int selectSeqNotice(Connection conn) {
    Statement stmt = null;
    ResultSet rs = null;

    int result = 0;
    String sql = "select seq_notice_no.currval from dual";

    try {
      stmt = conn.createStatement();
      rs = stmt.executeQuery(sql);
      if(rs.next()) {
        result = rs.getInt(1);
      }
    } catch(SQLException e) {
      e.printStackTrace();
    } finally {
      close(rs);
      close(stmt);
    }

    return result;
  }
  
}

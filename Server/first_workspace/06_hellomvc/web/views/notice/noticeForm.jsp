<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp" %>
  <style>
    section#notice-container{width:600px; margin:0 auto; text-align:center;}
    section#notice-container h2{margin:10px 0;}
    table#tbl-notice{width:500px; margin:0 auto; border:1px solid black; border-collapse:collapse; clear:both; }
    table#tbl-notice th {width: 125px; border:1px solid; padding: 5px 0; text-align:center;} 
    table#tbl-notice td {border:1px solid; padding: 5px 0 5px 10px; text-align:left;}
  </style>
  <section id="notice-container">
    <form action="<%=request.getContextPath() %>/notice/noticeFormEnd"
      method="post" enctype="multipart/form-data">
      <!-- enctype="multipart/form-date" 
           : binary 파일을 제대로 받을수 있게함 
             method는 반드시 post로 보내야함 -->
      <table id="tbl-notice">
        <tr>
          <th>제 목</th>
          <td>
            <input type="text" name="title" required>
          </td>
        </tr>
        <tr>
          <th>작성자</th>
          <td>
            <input type="text" name="writer" value="<%=loginMember.getUserId() %>" readonly>
          </td>
        </tr>
        <tr>
          <th>첨부파일</th>
          <td>
            <input type="file" name="up_file">
          </td>
        </tr>
        <tr>
          <th>내 용</th>
          <td>
            <textarea name="content" id="" cols="20" rows="5"></textarea>
          </td>
        </tr>
        <tr>
          <td colspan="2" style="text-align: center;">
            <input type="submit" value="등록하기">
            <input type="reset" value="취소하기">
          </td>
        </tr>
      </table>
    </form>
  </section>
<%@ include file="/views/common/footer.jsp" %>
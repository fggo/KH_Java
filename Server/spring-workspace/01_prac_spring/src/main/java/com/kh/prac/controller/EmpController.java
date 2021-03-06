package com.kh.prac.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.prac.model.service.EmpService;
import com.kh.prac.model.service.EmpServiceImpl;

@Controller
public class EmpController {
  
  private EmpService service = new EmpServiceImpl();

  @RequestMapping("/insertEmp.do")
  public String empInsert() {
    return "insertEmpView";
  }
  
  @RequestMapping("/insertEmpEnd.do")
  public void empInsertEnd(HttpServletRequest request, HttpServletResponse response) {
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String no = request.getParameter("no");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String deptCode = request.getParameter("deptCode");
    String jobCode = request.getParameter("jobCode");
    String salLevel = ""; //S1 ~ S6
    int sal = Integer.parseInt(request.getParameter("sal"));
    switch(sal/1000000) {
      case 1: salLevel = "S1"; break;
      case 2: salLevel = "S2"; break;
      case 3: salLevel = "S3"; break;
      case 4: salLevel = "S4"; break;
      case 5: salLevel = "S5"; break;
      case 6:case 7:case 8:case 9: salLevel = "S6"; break;
    }
    salLevel = (sal >= 10000000)? "S6":salLevel;

    String temp = request.getParameter("bonus");
    double bonus = temp.equals("")? .0: Double.valueOf(request.getParameter("bonus"));
    String mgrId = request.getParameter("mgrId");
    Date hireDate = null;
    Date entDate = null;
    char entYn = 'N';
    
    Map<String, Object> param = new HashMap<String, Object>();
    param.put("id", id);
    param.put("name", name);
    param.put("no", no);
    param.put("email", email);
    param.put("phone", phone);
    param.put("deptCode", deptCode);
    param.put("jobCode", jobCode);
    param.put("salLevel", salLevel);
    param.put("sal", sal);
    param.put("bonus", bonus);
    param.put("mgrId", mgrId);
    param.put("hireDate", hireDate);
    param.put("entDate", entDate);
    param.put("entYn", entYn);

    int result = service.insertEmp(param);

    response.setContentType("text/html;charset=utf-8");

    try {
      response.getWriter().write(result>0? "Successful insert using ajax!" : "insert Failed using ajax.");
    } catch(IOException e) {
      System.out.println(e.getMessage());
    }

  }
  
  @RequestMapping("/searchEmp.do")
  public String empSearch() {
    return "searchEmpView";
  }
  
  @RequestMapping("/searchEmpEnd.do")
  public String empSearchEnd(HttpServletRequest request, HttpServletResponse response) { 
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String no = request.getParameter("no");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String deptCode = request.getParameter("deptCode");
    String jobCode = request.getParameter("jobCode");
    int sal = Integer.parseInt(request.getParameter("sal"));

    String temp = request.getParameter("bonus");
    double bonus = temp.equals("")? .0: Double.valueOf(request.getParameter("bonus"));
    String mgrId = request.getParameter("mgrId");
    Date hireDate = null;
    Date entDate = null;
    char entYn = 'N';
    
    Map<String, Object> param = new HashMap<String, Object>();
    param.put("id", id);
    param.put("name", name);
    param.put("no", no);
    param.put("email", email);
    param.put("phone", phone);
    param.put("deptCode", deptCode);
    param.put("jobCode", jobCode);
    param.put("sal", sal);
    param.put("bonus", bonus);
    param.put("mgrId", mgrId);
    param.put("hireDate", hireDate);
    param.put("entDate", entDate);
    param.put("entYn", entYn);

    List<Map> list = service.searchEmp(param);
    request.setAttribute("list", list);

    response.setContentType("text/html;charset=utf-8");

    return "searchEmpEndView";
    
  }
}

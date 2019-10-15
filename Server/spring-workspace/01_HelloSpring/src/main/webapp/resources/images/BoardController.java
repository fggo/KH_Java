package com.kh.spring.board.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.board.model.service.BoardService;
import com.kh.spring.board.model.vo.Attachment;
import com.kh.spring.common.PageBarFactory;

@Controller
public class BoardController {
	
	private Logger logger=LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	BoardService service;
	
	@RequestMapping("/board/boardList.do")
	public ModelAndView boardList(@RequestParam(value="cPage", 
	required=false, defaultValue="0") int cPage) {
		//반환될 modelandview객체를 생성
		ModelAndView mv=new ModelAndView();
		
		int numPerPage=5;
		List<Map<String,String>> list=service.selectBoardList(cPage,numPerPage);
		int totalCount=service.selectBoardCount();
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalCount, cPage, numPerPage, "/spring/board/boardList.do"));
		mv.addObject("count",totalCount);
		mv.addObject("list",list);
		mv.setViewName("board/boardList");
		
		return mv;
	}
	
	@RequestMapping("/board/boardForm")
	public String boardForm() {
		return "board/boardForm";
	}
	
	
	@RequestMapping("/board/boardFormEnd.do")
	public ModelAndView insertBoard(@RequestParam Map<String,String> param, 
			@RequestParam(value="upFile", required=false) MultipartFile[] upFile
			,HttpServletRequest request){
		logger.debug(upFile[0].getOriginalFilename());
		logger.debug(""+upFile[0].getSize());
		logger.debug(upFile[1].getOriginalFilename());
		logger.debug(""+upFile[1].getSize());
		
		/* 파일업로드 처리하기 */
		//1. 저장경로 지정하기
		String saveDir=request.getSession()
				.getServletContext().getRealPath("/resources/upload/board");
		List<Attachment> attachList=new ArrayList();//여러파일 보관용
		
		File dir=new File(saveDir);
		if(!dir.exists()) logger.debug("생성결과 : "+dir.mkdirs());
		for(MultipartFile f : upFile) {
			if(!f.isEmpty()) {
				//파일명 생성(rename)
				String oriFileName=f.getOriginalFilename();
				String ext=oriFileName.substring(oriFileName.lastIndexOf("."));
				//규칙설정
				SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHMMssSSS");
				int rdv=(int)(Math.random()*1000);
				String reName=sdf.format(System.currentTimeMillis())+"_"+rdv+ext;
				//파일 실제 저장하기
				try {
					f.transferTo(new File(saveDir+"/"+reName));
				}catch (Exception e) {//IlligalStateException|IOException
					e.printStackTrace();
				}
				//DB에 저장할 데이터 보관
				Attachment att=new Attachment();
				att.setOriginalFileName(oriFileName);
				att.setRenamedFileName(reName);
				attachList.add(att);
			}

		}
		int result=service.insertBoard(param,attachList);
		
		String msg="";
		String loc="/board/boardList.do";
		if(result>0) {
			msg="입력성공";
		}else {
			msg="입력실패";
		}
		ModelAndView mv= new ModelAndView();
				
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		
		mv.setViewName("common/msg");
		return mv;
	}
	
}











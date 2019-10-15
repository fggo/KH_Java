package com.kh.spring.board.model.service;

import java.util.List;
import java.util.Map;

import com.kh.spring.board.model.vo.Attachment;

public interface BoardService {

	int selectBoardCount();
	List<Map<String,String>> selectBoardList(int cPage,int numPerpage);
	int insertBoard(Map<String,String> param, List<Attachment> attachList);
	
}

package com.ezen.spring.service;

import java.util.List;

import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.PagingVO;

public interface BoardService {

	int insert(BoardVO bvo);

//	List<BoardVO> getList();

	void readCountUp(int bno);

	BoardVO getDetail(int bno);

	int modify(BoardVO bvo);

	int delete(int bno);

	int getTotal(PagingVO pgvo);

	List<BoardVO> getList(PagingVO pgvo);
	
}

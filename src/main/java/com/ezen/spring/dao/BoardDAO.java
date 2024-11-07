package com.ezen.spring.dao;

import java.util.List;

import com.ezen.spring.domain.BoardVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	List<BoardVO> getList();

	void readCountUp(int bno);

	BoardVO getDetail(int bno);

	int update(BoardVO bvo);

	int delete(int bno);
	
	
	
}

package com.ezen.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	void readCountUp(int bno);

	BoardVO getDetail(int bno);

	int update(BoardVO bvo);

	int delete(int bno);

	int getTotal(PagingVO pgvo);

	List<BoardVO> getList(PagingVO pgvo);

	int cmtQtyUpdate(@Param("bno") long bno, @Param("cnt") int i);
	
	
	
}

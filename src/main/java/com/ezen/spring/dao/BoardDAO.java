package com.ezen.spring.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.PagingVO;

public interface BoardDAO {

	int insert(BoardVO bvo);

	List<BoardVO> getList(PagingVO pgvo);

	BoardVO getDetail(int bno);

	int update(BoardVO bvo);

	int delete(int bno);

	int getTotal(PagingVO pgvo);

	int updateReadCount(int bno);

	long getOneBno();

	int cmtQtyUpdate(@Param("bno") long bno, @Param("cnt") int cnt);

	void hasFileUpdate(@Param("bno") long oneBno, @Param("cnt") int size);

}

package com.ezen.spring.service;

import com.ezen.spring.domain.CommentVO;
import com.ezen.spring.domain.PagingVO;
import com.ezen.spring.handler.PagingHandler;

public interface CommentService {

	int post(CommentVO cvo);

//	List<CommentVO> getList(long bno);

	PagingHandler getList(long bno, PagingVO pgvo);

	int modify(CommentVO cvo);

	int delete(long cno, long bno);

}

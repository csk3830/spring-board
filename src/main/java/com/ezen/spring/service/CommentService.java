package com.ezen.spring.service;

import java.util.List;

import com.ezen.spring.domain.CommentVO;

public interface CommentService {

	int post(CommentVO cvo);

	List<CommentVO> getList(long bno);

}

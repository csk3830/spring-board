package com.ezen.spring.dao;

import java.util.List;

import com.ezen.spring.domain.CommentVO;

public interface CommentDAO {

	int post(CommentVO cvo);

	List<CommentVO> getList(long bno);

}

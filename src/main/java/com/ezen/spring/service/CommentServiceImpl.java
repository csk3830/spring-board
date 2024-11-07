package com.ezen.spring.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ezen.spring.dao.BoardDAO;
import com.ezen.spring.dao.CommentDAO;
import com.ezen.spring.domain.CommentVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Service
public class CommentServiceImpl implements CommentService{
	
	private final CommentDAO cdao;
	private final BoardDAO bdao;
	@Override
	public int post(CommentVO cvo) {
		// TODO Auto-generated method stub
		int isOk = cdao.post(cvo);
		return isOk;
	}
	@Override
	public List<CommentVO> getList(long bno) {
		// TODO Auto-generated method stub
		return cdao.getList(bno);
	}
	
}

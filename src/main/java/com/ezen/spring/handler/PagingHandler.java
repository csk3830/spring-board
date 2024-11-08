package com.ezen.spring.handler;

import java.util.List;

import com.ezen.spring.domain.CommentVO;
import com.ezen.spring.domain.PagingVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingHandler {
	
	private int qty;	// 한 페이지에 나오는 페이지네이션 버튼의 개수
	private int startPage; // 한 페이지에 나오는 페이지네이션 버튼 시작 번호 1, 11, 21,,,
	private int endPage; // 한 페이지에 나오는 페이지네이션 버튼 끝 번호 : 10, 20, 30,,,
	private boolean prev;
	private boolean next;
	
	private int totalCount; // 전체 페이지 수 >> DB에서 조회해 와야 하는 값(매개변수로 받아오기)
	private PagingVO pgvo; // 현재 페이지 번호 : pagingVO
	
	private int realEndPage; // 전체 페이지 중 가장 끝 페이지
	
	private List<CommentVO> cmtList;
	
	// 생성자에서 모든 값들을 계산하여 설정.
	public PagingHandler(int totalCount, PagingVO pgvo) {
		this.qty = 10;
		this.pgvo = pgvo;
		this.totalCount = totalCount;
		
		// 현재 페이지번호를 10으로 나눈 후 올림. 10을 곱하여 endPage를 계산
		this.endPage = (int)Math.ceil(pgvo.getPageNo() / (double)qty) * qty;
		this.startPage = endPage - 9;
		
		// 전체 글 수를 10으로 나눈 후 올림
		this.realEndPage = (int)Math.ceil(totalCount / (double)pgvo.getQty()); //=>Paging VO에서 10으로 설정
		
		// 이전, 다음 여부
		this.prev = this.startPage > 1;
		this.next = this.endPage < this.realEndPage;
		
		if(endPage > realEndPage) {
			this.endPage = realEndPage;
		}
	}
	
	// 댓글용 생성자
	public PagingHandler(int totalCount, PagingVO pgvo, List<CommentVO> cmtList) {
		this(totalCount, pgvo);
		this.cmtList = cmtList;
	}
	
}

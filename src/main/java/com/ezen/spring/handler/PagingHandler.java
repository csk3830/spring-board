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
//			list => pagination
//			한페이지에 목록을 다 나타내기 힘들 때 사용
//			- 한 페이지에 10개의 게시물 표현
//			- 전체 게시글의 수에 계산되어 페이지네이션 값들이 결정이 됨.
//
//			DB상에서 => limit 시작번지, 개수
//			1 => limit 0, 10 => 0번지부터 10개 => 0번지부터 9번지까지
//			2 => limit 10, 10 => 10번지부터 10개 => 10번지부터 19번지까지
//			3 => limit 20, 10 => 20번지부터 10개 => 20번지부터 29번지까지
//			....
//			pageNo => 페이지네이션 번호
//			getPageStart => 시작번지 
//			qty => 개수
//			이전, 다음의 노출여부 	boolean
	
	private int qty; 	// 한 페이지에 나오는 페이지네이션 개수 : 10개
	private int startPage; // 한 페이지에 나오는 페이지네이션 시작번호 : 1		11	21 ... 181
	private int endPage; // 한 페이지에 나오는 페이지네이션 끝번호 : 10	20	30 ... 181
	private boolean prev;
	private boolean next;
	
	private int totalCount; // 전체 페이지 수 : DB에서 조회해 와야 하는 값.(매개변수로 받아오기)
	private PagingVO pgvo; // 현재 페이지 번호 : pagingVO pageNO 사용(매개변수로 받아오기)
	
	private int realEndPage; // 진짜 마지막 페이지 끝 번호
	
	private List<CommentVO> cmtList;
	
	// 생성자에서 모든 값들이 계산되어 설정되어야 함.
	public PagingHandler(int totalCount, PagingVO pgvo) {
		this.qty = 10;
		this.pgvo = pgvo;
		this.totalCount = totalCount;

		// 1~10 / 11~20 / 21~30 ....
		// pageNo => 1 2 3 .. 10 => 1~10
		// pageNo => 11 12 13 ... 20 => 11~20
		// 1 2 3 ... 10 => 10	endPAge는 변함없이 10
		// 11 12 13 ... 20 => 20
		
		// 1 / 10개 => 0.1 결과를 올림(ceil) => 1 * 10 => 10
		// 11 / 10 => 1.1 결과를 올림 => 2 * 10 => 20
		// 정수 / 정수 => 정수		형변환을 해서 소수점을 유지
		this.endPage = (int)Math.ceil(pgvo.getPageNo() / (double)qty) * qty;
		this.startPage = endPage - (qty-1);
		
		// 실제 마지막 페이지
		// 전체 글수 / 한페이지에 표시되는 게시글 수 (올림)
		// 11	/	10	=> 2페이지 	1.1(올림) => 2
		this.realEndPage = (int)Math.ceil(totalCount / (double)pgvo.getQty());
		
		// 이전, 다음 여부
		this.prev = this.startPage > 1;		// 1	11	21	31
		this.next = this.endPage < this.realEndPage;
		
		if(endPage > realEndPage) {
			this.endPage = realEndPage;
		}
		
	}
	
	//댓글용 생성자
	public PagingHandler(int totalCount, PagingVO pgvo, List<CommentVO>cmtList) {
		this(totalCount, pgvo);
		this.cmtList = cmtList;
	}

}

package com.ezen.spring.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class PagingVO {
	private int pageNo; //페이지네이션 번호
	private int qty; // 한 페이지에 표시되는 페이지 수
	
	public PagingVO() {
		this.pageNo = 1;
		this.qty = 10;
	}
	
	// DB에서 사용될 시작번지 구하기
	// select * from board limit 번지, 개수
	// 1page 0, => 2page 10 => 3 page 20
	public int getPageStart() {
		return (this.pageNo - 1) * this.qty;
	}
	
	

	
	
	
}

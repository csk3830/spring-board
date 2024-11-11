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
	
	//search 변수 포함
	private String type;
	private String keyword;
	
	public PagingVO() {
		this.pageNo = 1;
		this.qty = 10;
	}
	
	public PagingVO(int pageNo, int qty) {
		this.pageNo = pageNo;
		this.qty = qty;
	}
	
	// DB에서 사용될 시작번지 구하기
	// select * from board limit 번지, 개수
	// 1page 0, => 2page 10 => 3 page 20
	public int getPageStart() {
		return (this.pageNo - 1) * this.qty;
	}
	
	//type의 복합 타입을 각각 검색하기 위해 배열로 생성
	//type == twc  [t, w, c]
	public String[] getTypeToArray() {
		return this.type == null ? new String[] {} : this.type.split("");
	}
	
}

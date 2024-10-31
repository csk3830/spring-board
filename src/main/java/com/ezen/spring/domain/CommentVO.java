package com.ezen.spring.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class CommentVO {
//			create table comment(
//			cno bigint auto_increment,
//			bno bigint not null ,
//			writer varchar(500) not null, 
//			content text, 
//			reg_date datetime default now(),
//			primary key(cno));
	
	private long cno;
	private long bno;
	private String writer;
	private String content;
	private String regDate;
	
	
}

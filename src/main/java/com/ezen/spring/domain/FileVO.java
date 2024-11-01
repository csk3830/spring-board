package com.ezen.spring.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FileVO {
	
//	uuid varchar(256) not null,
//	save_dir varchar(256) not null,
//	file_name varchar(256) not null,
//	file_type tinyint(1) default 0,
//	bno bigint,
//	file_size  bigint,
//	reg_date datetime default now(),
//	primary key(uuid)
	
	private String uuid;
	private String saveDir;
	private String fileName;
	private int fileType;
	private long bno;
	private long fileSize;
	private String regDate;
	
	
	
}

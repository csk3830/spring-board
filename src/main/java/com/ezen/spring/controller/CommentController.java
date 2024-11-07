package com.ezen.spring.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ezen.spring.domain.CommentVO;
import com.ezen.spring.service.CommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@RequestMapping("/comment/*")
@RestController
public class CommentController {

	private final CommentService csv;
	
	@PostMapping("/post")
	public ResponseEntity<String> post(@RequestBody CommentVO cvo){
		log.info(">>>> post cvo > {}", cvo);
		int isOk = csv.post(cvo);
		return isOk > 0 ?
				new ResponseEntity<String>("1", HttpStatus.OK) :
				new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<CommentVO>> list(@PathVariable("bno") long bno){
		List<CommentVO> list = csv.getList(bno);
		return new ResponseEntity<List<CommentVO>>(list, HttpStatus.OK);
	}
	
	
}

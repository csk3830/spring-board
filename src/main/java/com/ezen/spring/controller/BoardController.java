package com.ezen.spring.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/board/*")  // /board/하고 나오는 모든 값들은 여기에서 받겠다.
@Controller
public class BoardController {
	/* 생성자 주입시 객체는 final로 생성 */

	private final BoardService bsv;
	
	//return void => 온 경로 그대로 리턴		/board/register => /board/register.jsp   
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/insert")
	public String insert(BoardVO bvo) {
		log.info(">>> insert bvo > {}", bvo);
		int isOk = bsv.insert(bvo);
		//서비스야 bvo 줄테니까, 잘 넣고 나한테 1을 다오.
		log.info(">>>> insert > {}", isOk>0? "OK":"Fail");
		//	/WEB-INF/views/.jsp	 X
		//  컨트롤러의 mapping 위치로 연결할 때 redirect:board/list
		return "redirect:/";
	}
	
	@GetMapping("/list")
	public String list(Model m) {
		//request.setAttribute()
		//Model 객체가 해당 일을 대신해줌.
		List<BoardVO> list = bsv.getList();
		m.addAttribute("list", list);
		return "/board/list";
	}
	

}

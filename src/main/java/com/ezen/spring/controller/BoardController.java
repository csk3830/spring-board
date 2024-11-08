package com.ezen.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.PagingVO;
import com.ezen.spring.handler.PagingHandler;
import com.ezen.spring.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/board/*")
@Controller
public class BoardController {

	private final BoardService bsv;
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/insert")
	public String insert(BoardVO bvo) {
		log.info(">>> insert bvo > {}", bvo);
		int isOk = bsv.insert(bvo);
		log.info(">>> board insert > {}", isOk>0? "OK":"Fail");
		
		return "redirect:/"; 
	}
	
	@GetMapping("/list")
	public String list(Model m, PagingVO pgvo) {		
		//request.setAttrbute()  
		//Model 객체가 해당 일을 대신해 줌.
//		PagingVO pgvo = new PagingVO();
		List<BoardVO> list = bsv.getList(pgvo);
		// totalCount를 구해서 PagingHadler에 매개변수로 전달
		int totalCount = bsv.getTotal(pgvo);
		PagingHandler ph = new PagingHandler(totalCount, pgvo);
		log.info(">>> totalCount > {}", totalCount);
		m.addAttribute("list", list);
		m.addAttribute("ph", ph);
		return "/board/list";
	}
	
	@GetMapping({"/detail", "/modify"})
	public void detail(int bno, Model m, HttpServletRequest request) {
		String path = request.getServletPath();
		log.info(">>>>>>>>>>>>> path > {}", path);
		
		if(path.equals("/board/detail")) {
			bsv.readCountUp(bno);
		}
		
		BoardVO bvo = bsv.getDetail(bno);
		m.addAttribute("bvo", bvo);
	}
	
	@PostMapping("/update")
	public String update(BoardVO bvo) {
		
		int isOk = bsv.modify(bvo);
		log.info(">>>> update > {}", isOk > 0 ? "OK":"Fail");
		
		return "redirect:/board/detail?bno="+bvo.getBno();
	}
	
	@GetMapping("/delete")
	public String delete(int bno) {
		int isOk = bsv.delete(bno);
		log.info(">>>> delete > {}", isOk > 0 ? "OK" : "Fail");
		return "redirect:/board/list";
	}
	
}

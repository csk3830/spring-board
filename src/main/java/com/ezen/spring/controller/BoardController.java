package com.ezen.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ezen.spring.domain.BoardDTO;
import com.ezen.spring.domain.BoardVO;
import com.ezen.spring.domain.FileVO;
import com.ezen.spring.domain.PagingVO;
import com.ezen.spring.handler.FileHandler;
import com.ezen.spring.handler.PagingHandler;
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
	private final FileHandler fh; 
	
	//return void => 온 경로 그대로 리턴		/board/register => /board/register.jsp   
	@GetMapping("/register")
	public void register() {}
	
	//첨부파일 => multipartFile / 여러개... multipartFile[]
	@PostMapping("/insert")
	public String insert(BoardVO bvo, MultipartFile[] files) {
		log.info(">>> insert bvo > {}", bvo);
		List<FileVO> flist = null;
		
		if(files[0].getSize() > 0) {
			//파일의 내용이 있다면
			flist = fh.uploadFiles(files);
			log.info(">>>>> first > {}", flist);
		}
		
		//files 정보를 이용하여 => List<FileVO> 변환을 하는 핸들러
		//fileHandler => return List<FileVO> + 파일 저장
		
		BoardDTO bdto = new BoardDTO(bvo, flist);	//bvo, flist
		int isok = bsv.insert(bdto);
//		log.info(">>>> insert > {}", )
		//int isOk = bsv.insert(bvo);
		//서비스야 bvo 줄테니까, 잘 넣고 나한테 1을 다오.
		//log.info(">>>> insert > {}", isOk>0? "OK":"Fail");
		//	/WEB-INF/views/.jsp	 x
		//  컨트롤러의 mapping 위치로 연결할 때 redirect:board/list
		return "redirect:/";
	}
	
	// 데이터 보낼 때 Model
	@GetMapping("/list")
	public String list(Model m, PagingVO pgvo) {
		//request.setAttribute()
		//Model 객체가 해당 일을 대신해줌.
//		PagingVO pgvo = new PagingVO();
		List<BoardVO> list = bsv.getList(pgvo);
		// totalCount 구해서 PagingHandler에 매개변수로 전달
		int totalCount = bsv.getTotal(pgvo);
		PagingHandler ph = new PagingHandler(totalCount, pgvo);
		log.info(">>> totalCount > {}", totalCount);
		m.addAttribute("list", list);
		m.addAttribute("ph", ph);	// list도 보내고, ph도 보내고
		return "/board/list";
	}
	
	// list 페이지에서 bno 하나를 전달하여 해당 객체(DB에서)를 detail 페이지로 전송
	// @requestParam("bno") int bno => 전달되는 파라미터가 여러개일 경우 이름을 명시
	// return void : 요청 경로로 응답을 그대로 보냄. 	/board/detail => board/detail.jsp
	// ㄴ 내가 요청하는 이름과 jsp의 이름 및 경로를 맞춰놨기 때문에 가능. 
	@GetMapping({"/detail", "/modify"})
	public void detail(int bno, Model m, HttpServletRequest request) {
		// bno에 해당하는 BoardVO 객체를 DB에서 가져와서 모델로 전달
		String path = request.getServletPath();
		BoardDTO bdto = bsv.getDetail(bno);
		m.addAttribute("bdto", bdto);
//		BoardVO bvo = bsv.getDetail(bno);
//		m.addAttribute("bvo", bvo);
//		return "/board/detail";
	}
	
	@PostMapping("/update")
	public String update(BoardVO bvo) {
		int isOk = bsv.modify(bvo);
		log.info(">>>> update > {}", isOk>0? "OK":"Fail");
		
		//detail.jsp로 이동 X => controller detail mapping으로 이동 => redirect:/
 		return "redirect:/board/detail?bno="+bvo.getBno();
	}
	
	@GetMapping("/delete")
	public String delete(int bno) {
		int isOk = bsv.delete(bno);
		log.info(">>>> delete > {}", isOk>0? "OK":"Fail");
		return "redirect:/board/list";
	}
}

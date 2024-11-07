<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../layout/header.jsp" />
<div class="container-md">
	<h1>detail Page</h1>
	<hr>

<!-- 제목 -->
	<h5 class="pb-3 mb-0 border-bottom border-secondary font-weight-bold">
		${bvo.bno }.${bvo.title }</h5>

<!-- 작성자, 작성일시, 조회수 -->
	<div class="clearfix my-2">
	    <div class="card small d-flex justify-content-end bg-light">
	        <div class="card-body p-2 px-3">
	                <strong>${bvo.writer} 님</strong>
	                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
	                    <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z" />
	                    <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0" />
	                </svg>
	                ${bvo.regDate}
	                ${bvo.readCount } views
	        </div>
	    </div>
	</div>

<!-- 내용 -->
	${bvo.content }
	
	<hr>
	<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-success">수정</button></a>
	<a href="/board/delete?bno=${bvo.bno }"><button type="button" class="btn btn-danger">삭제</button></a>
	<br>
	<hr>
	
<!-- comment line -->
<!-- 댓글 입력 -->
<div class="input-group mb-3">
  <input type="text" id="cmtWriter" class="form-control" placeholder="Add Writer" aria-label="Username" aria-describedby="basic-addon1">
  <input type="text" id="cmtText" class="form-control" placeholder="Add Comment" aria-label="Username" aria-describedby="basic-addon1">
  <button type="button" id="cmtAddBtn" class="btn btn-secondary">댓글 쓰기</button>
</div>

<!-- 댓글 출력 -->
<ul class="list-group list-group-flush" id="cmtListArea">
  <li class="list-group-item">
  	<div class="ms-2 me-auto">
  		<div class="fw-bold">writer</div>
	 Content
  	</div>
	<span class="badge text-bg-primary rounded-pill">regDate</span>
  </li>
</ul>


<script type="text/javascript" src="/resources/js/boardDetailComment.js"></script>
<script type="text/javascript">
	let bnoVal = "${bvo.bno}";
	spreadCommentList(bnoVal);
</script>

</div>
<jsp:include page="../layout/footer.jsp" />


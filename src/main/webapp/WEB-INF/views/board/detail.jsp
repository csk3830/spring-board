<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<jsp:include page="../layout/header.jsp" />
<div class="container-md">
	<h1>detail Page</h1>
	<hr>

<c:set value="${bdto.bvo }" var="bvo"></c:set>
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

<!-- file upload 표시라인 -->
<c:set value="${bdto.flist }" var="flist"></c:set>
<div class="mb-3">
		<ul class="list-group list-group-flush">
			<!-- 파일의 개수만큼 li를 반복하여 파일 표시 타입이 1인경우만 그림을 표시 -->
		  	<c:forEach items="${flist }" var="fvo">
		  		 <li class="list-group-item">
		  		 	<c:choose>
		  		 		<c:when test="${fvo.fileType > 0 }">
		  		 			<div>
		  		 				<img alt="" src="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}">
		  		 			</div>
		  		 		</c:when>
		  		 		<c:otherwise>
		  		 			<!-- 일반파일 : 아이콘 하나 가져와서 다운로드 가능하게 생성 -->
		  		 			<a href="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}" download="${fvo.fileName}">
		  		 				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-file-earmark-arrow-down-fill" viewBox="0 0 16 16">
								  <path d="M9.293 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.707A1 1 0 0 0 13.707 4L10 .293A1 1 0 0 0 9.293 0M9.5 3.5v-2l3 3h-2a1 1 0 0 1-1-1m-1 4v3.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 0 1 .708-.708L7.5 11.293V7.5a.5.5 0 0 1 1 0"/>
								</svg>
		  		 			</a>
		  		 		</c:otherwise>
		  		 	</c:choose>
		  		 	<div class="fw-bold">${fvo.fileName }</div>
		  		 	<span class="badge text-bg-primary rounded-pill">${fvo.regDate } / ${fvo.fileSize }Bytes</span>
		  		 </li>
		  	</c:forEach>
		</ul>
	</div>

<!-- 내용 -->
	${bvo.content }
	
	<hr>
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.uvo.nickName" var="authNick"/>
	<c:if test="${bvo.writer == authNick}">
	<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-success">수정</button></a>
	<a href="/board/delete?bno=${bvo.bno }"><button type="button" class="btn btn-danger">삭제</button></a>
	</c:if>
	</sec:authorize>
	<br>
	<hr>
	
<!-- comment line -->
<!-- 댓글 입력 -->
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.uvo.nickName" var="authNick"/>
	<div class="input-group mb-3">
	<span class="input-group-text" id="cmtWriter">${authNick }</span>
    <input type="text" id="cmtText" class="form-control" placeholder="Add Comment" aria-label="Username" aria-describedby="basic-addon1">
	<button type="button" id="cmtAddBtn" class="btn btn-secondary">댓글 쓰기</button>
	</div>
<c:set value="${authNick }" var="nick"/>
</sec:authorize>

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

<!-- 댓글 더보기 버튼 : 더 표시하고자 하는 댓글이 없으면 사라지게함. -->
	<div>
		<button type="button" id="moreBtn" data-page="1" class="btn btn-dark" style="visibility:hidden">MORE + </button>
	</div>
	
<!-- modal line -->
	<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="cmtWriterMod">${authNick }</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <input type="text" class="form-control" id="cmtTextMod">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" id="cmtModBtn" class="btn btn-primary">changes</button>
	      </div>
	    </div>
	  </div>
	</div>
	
<script type="text/javascript" src="/resources/js/boardDetailComment.js"></script>
<script type="text/javascript">
	let bnoVal = `<c:out value="${bvo.bno}" />`;
	let authNick = `<c:out value="${nick }" />`;
	spreadCommentList(bnoVal);
</script>

</div>
<jsp:include page="../layout/footer.jsp" />


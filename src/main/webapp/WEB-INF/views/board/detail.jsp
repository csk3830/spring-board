<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp" />

<div class="container-md">
	<h1>Board Detail Page...</h1>
	<hr>
<!-- request 객체로 온 값은 ${bdto} -->
<!-- c:set은 값을 저장하는 용도 -->
<c:set value="${bdto.bvo }" var="bvo"></c:set>

	<div class="mb-3">
	  <label for="n" class="form-label">no.</label>
	  <input type="text" class="form-control" id="n" value="${bvo.bno }" readonly>
	</div>
	<div class="mb-3">
	  <label for="t" class="form-label">title</label>
	  <input type="text" class="form-control" id="t" value="${bvo.title }" readonly>
	</div>
	<div class="mb-3">
	  <label for="w" class="form-label">writer</label>
	  <input type="text" class="form-control" id="w" value="${bvo.writer }" readonly>
	  <span class="badge text-bg-info">${bvo.regDate }</span>
	</div>
	<div class="mb-3">
	  <label for="c" class="form-label">content</label>
	  <textarea class="form-control" id="c" rows="3" readonly>${bvo.content }</textarea>
	</div>

	<!-- file upload 표시라인 -->
	<c:set value="${bdto.flist }" var="flist"></c:set>
	<div class="mb-3">
		<ul class="list-group list-group-flush">
			<!-- 파일의 개수만큼 li를 반복하여 파일 표시. 타입이 1인 경우만 그림을 표시 -->
			<c:forEach items="${flist }" var="fvo">
				<li class="list-group-item">
					<c:choose>
						<c:when test="${fvo.fileType ne 0 }">
							<div>
								<img src="/upload/${fvo.saveDir}/${fvo.uuid}_${fvo.fileName}">
							</div>
						</c:when>
						<c:otherwise>
							<!-- 일반파일 : 아이콘 하나 가져와서 다운로드 가능하게 생성 -->
						</c:otherwise>
					</c:choose>
					<div class="fw-bold">${fvo.fileName }</div>
					<span class="badge text-bg-primary rounded-pill">${fvo.regDate } / ${fvo.fileSize }Bytes</span>	  	
				</li>
			</c:forEach>
		</ul>
	</div>

	<a href="/board/modify?bno=${bvo.bno }"><button type="button" class="btn btn-success">modify</button></a>
	<a href="/board/delete?bno=${bvo.bno }"><button type="button" class="btn btn-danger">delete</button></a>
	<br>
	<hr>
	<!-- comment line -->
	<!-- comment post -->
	<div class="input-group mb-3">
	  <span class="input-group-text" id="cmtWriter">tester1@tester.com</span>
	  <input type="text" id="cmtText" class="form-control" placeholder="Add Comment...">
	  <button type="button" id="cmtAddBtn" class="btn btn-secondary">post</button>
	</div>
	
	<!-- comment print -->	
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
		<button type="button" id="moreBtn" data-page="1" class="btn btn-dark" style="visibility: hidden;">MORE + </button>
	</div>
	
	<!-- Modal line -->
	<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="cmtWriterMod">Writer</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <input type="text" id="cmtTextMod" class="form-control">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" id="cmtModBtn" class="btn btn-primary">changes</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script type="text/javascript">
	let bnoVal = `<c:out value="${bvo.bno}" />`;
	console.log(bnoVal);
	</script>
	
	<script type="text/javascript" src="/resources/js/boardDetailComment.js"></script>
	
	<script type="text/javascript">
	spreadCommentList(bnoVal);
	</script>
	

</div>
<jsp:include page="../layout/footer.jsp" />
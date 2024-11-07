<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp" />
<div class="container-md">
<h1>Board Modify Page...</h1>
<hr>
<c:set value="${bvo }" var="bvo"></c:set>
<form action="/board/update" method="post">
	<div class="mb-3">
	  <label for="n" class="form-label">no.</label>
		<input type="hidden" name="bno" value="${bvo.bno }">
	  <input type="text" class="form-control" id="n" value="${bvo.bno }" readonly>
	</div>
	<div class="mb-3">
	  <label for="t" class="form-label">title</label>
	  <input type="text" name="title" class="form-control" id="t" value="${bvo.title }">
	</div>
	<div class="mb-3">
	  <label for="w" class="form-label">writer</label>
	  <input type="text" name="writer" class="form-control" id="w" value="${bvo.writer }">
	  <span class="badge text-bg-info">${bvo.regDate }</span>
	</div>
	<div class="mb-3">
	  <label for="c" class="form-label">content</label>
	  <textarea class="form-control" name="content" id="c" rows="3">${bvo.content }</textarea>
	</div>
	
	<!-- file 추가 -->
	<!-- 첨부파일 입력 라인 추가 -->

	
	<!-- 첨부파일 표시 라인 추가 -->

	
	
	<!-- file upload 표시라인 -->

	
	<button type="submit" id="regBtn" class="btn btn-success">수정</button>
	<a href="/board/list"><button type="button" class="btn btn-info">취소</button></a>
</form>	
<script type="text/javascript" src="/resources/js/boardModify.js"></script>
<script type="text/javascript" src="/resources/js/boardRegister.js"></script>
	
</div>
<jsp:include page="../layout/footer.jsp" />
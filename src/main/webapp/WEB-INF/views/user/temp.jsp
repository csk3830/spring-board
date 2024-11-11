<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp" />
<div class="container-md">
<h1>회원가입</h1>
<hr>
<form action="/user/register" method="post" >
	<div class="mb-3">
	  <label for="e" class="form-label">이메일</label>
	  <input type="text" class="form-control" id="e" name="email" placeholder="email...">
	</div>
	<div class="mb-3">
	  <label for="p" class="form-label">비밀번호</label>
	  <input type="text" class="form-control" id="p" name="pwd" placeholder="PassWord...">
	</div>
	<div class="mb-3">
	  <label for="n" class="form-label">닉네임</label>
	  <input type="text" class="form-control" id="n" name="nickName" placeholder="nickName...">
	</div>
	<button type="submit" class="btn btn-primary">JOIN</button>
</form>

</div>
<jsp:include page="../layout/footer.jsp" />


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/header.jsp" />

<div class="container-md">
	<h1>User List Page...</h1>
	<hr>

	<c:forEach items="${userList }" var="uvo">
	<div class="card mb-3 card-border-dark " style="max-width: 540px;">
	  <div class="row g-0">
	    <div class="col-md-4">
	      <img src="/resources/image/admin.png" class="img-fluid rounded-start" alt="...">
	    </div>
	    <div class="col-md-8">
	      <div class="card-body">
	        <h5 class="card-title">${uvo.nickName }</h5>
	        <p class="card-text">${uvo.email } (${uvo.regDate })</p>
	        <p class="card-text"><small class="text-body-secondary">Last login ${uvo.lastLogin }</small></p>
	        <c:forEach items="${uvo.authList }" var="auths">
	        <span class="badge round-pill text-bg-success">${ auths.auth}</span>
	        </c:forEach>
	      </div>
	    </div>
	  </div>
	</div>

	
	
	</c:forEach>






</div>
<jsp:include page="../layout/footer.jsp" />
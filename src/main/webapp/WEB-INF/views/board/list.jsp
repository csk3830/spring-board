<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp" />
<div class="container-md">
<h1>Board List Page</h1>
<hr>

<table class="table table-hover">
 <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">제목</th>
      <th scope="col">글쓴이</th>
      <th scope="col">날짜</th>
      <th scope="col">조회</th>
    </tr>
  </thead>
  <tbody>
  	<c:forEach items="${list }" var="bvo">
  		<tr>
  			<td>${bvo.bno }</td>
  			<td>
				<a href="/board/detail?bno=${bvo.bno }">${bvo.title }</a>		
  			</td>
  			<td>${bvo.writer }</td>
  			<td>${bvo.regDate }</td>
  			<td>${bvo.readCount }</td>
  		</tr>
  	</c:forEach>
  </tbody>
</table>

<!--pagination line -->



<a href="/board/register"><button type="button" class="btn btn-info">글쓰기</button></a>








</div>
<jsp:include page="../layout/footer.jsp" />


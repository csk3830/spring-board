<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../layout/header.jsp" />
<div class="container-md">
<h1>Board List Page</h1>
<hr>

<!-- search line -->
<div class="container-fluid">
 	<form action="/board/list" method="get" class="d-flex" role="search">
	 	<select class="form-select" name="type" id="inputGroupSelect01">
		    <option ${ph.pgvo.type == null ? 'selected' : '' } >검색 옵션 선택</option>
		    <option value="t" ${ph.pgvo.type eq 't' ? 'selected' : '' }>제목</option>
		    <option value="w" ${ph.pgvo.type eq 'w' ? 'selected' : '' }>글쓴이</option>
		    <option value="c" ${ph.pgvo.type eq 'c' ? 'selected' : '' }>내용</option>
		    <option value="tw" ${ph.pgvo.type eq 'tw' ? 'selected' : '' }>제목+글쓴이</option>
		    <option value="wc" ${ph.pgvo.type eq 'wc' ? 'selected' : '' }>내용+글쓴이</option>
		    <option value="tc" ${ph.pgvo.type eq 'tc' ? 'selected' : '' }>제목+내용</option>
		    <option value="twc" ${ph.pgvo.type eq 'twc' ? 'selected' : '' }>전체</option>
	  	</select>
        <input class="form-control me-2" name="keyword" type="search" placeholder="Search" value="${ph.pgvo.keyword }" aria-label="Search">
        <input type="hidden" name="pageNo" value="1">
        <input type="hidden" name="qty" value="${ph.pgvo.qty }">
       <!--  <button class="btn btn-outline-success" type="submit">Search</button> -->
       <button type="submit" class="btn btn-success position-relative">
		  Search
		  <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
		    ${ph.totalCount }
		    <span class="visually-hidden">unread messages</span>
		  </span>
		</button>
      </form>
      
</div>

<!-- 게시글 목록 테이블 -->
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
	  			<c:if test="${bvo.hasFile > 0 }">
	  				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16">
					  <path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
					</svg>
					${bvo.hasFile }
	  			</c:if>
				<c:if test="${bvo.cmtQty > 0 }">
	  				<span class="fw-bold text-danger">[${bvo.cmtQty }]</span>
				</c:if>
  			</td>
  			<td>${bvo.writer }</td>
  			<td>${bvo.regDate }</td>
  			<td>${bvo.readCount }</td>
  		</tr>
  	</c:forEach>
  </tbody>
</table>

<!--pagination line -->

<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
    <li class="page-item ${ph.prev eq false ? 'disabled' : '' }">
      <a class="page-link" href="/board/list?pageNo=${ph.startPage-1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    
    <c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
    	<li class="page-item ${ph.pgvo.pageNo eq i ? 'active' : '' }"><a class="page-link" href="/board/list?pageNo=${i }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">${i }</a></li>
    </c:forEach>
    
    <li class="page-item ${ph.next eq false ? 'disabled' : '' }">
      <a class="page-link" href="/board/list?pageNo=${ph.endPage+1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>




<div style="display: flex; justify-content: flex-end;">
    <a href="/board/register">
        <button type="button" class="btn btn-info">글쓰기</button>
    </a>
</div>

</div>
<jsp:include page="../layout/footer.jsp" />


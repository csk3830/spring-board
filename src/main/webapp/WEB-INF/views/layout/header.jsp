<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>header.jsp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="icon" href="/resources/image/favicon.png" type="image/x-icon">

    <style>
        /* 네비게이션 바의 높이를 늘리기 */
        .navbar {
            padding-top: 1rem;  /* 네비게이션 바 위쪽 여백 */
            padding-bottom: 1rem; /* 네비게이션 바 아래쪽 여백 */
        }

        /* 로고 위치 고정 및 z-index 추가 */
        .navbar-brand {
            position: absolute; /* 고정 위치 */
            left: 20px; /* 로고의 왼쪽 위치 */
            top: 50%; /* 세로로 가운데 정렬 */
            transform: translateY(-50%); /* 정확한 세로 가운데 정렬 */
            z-index: 10; /* 다른 요소들 위로 올림 */
            height: auto; /* 로고의 높이를 자동으로 설정 */
        }

        /* 메뉴 항목들이 로고 아래로 배치되도록 */
        .navbar-collapse {
            position: relative; /* navbar-collapse는 기본 위치 */
            z-index: 5; /* 로고 아래로 배치 */
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="/"><img src="/resources/image/logo.png" alt="Logo" style="height: 50px;"></a> <!-- 로고 크기 조정 -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse container-md" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/">index</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/board/list">게시판 보기</a>
                    </li>
                    <sec:authorize access="isAnonymous()">
                        <li class="nav-item">
                            <a class="nav-link" href="/user/register">회원가입</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/user/login">로그인</a>
                        </li>        
                    </sec:authorize>
                    
        <sec:authorize access="isAuthenticated()">
        <!-- 인증 객체가 만들어져 있는 상태 -->
        <!-- 인증된 객체 가져오기 => 현재 로그인 정보는 : principal -->
        <sec:authentication property="principal.uvo.email" var="authEmail"/>
        <sec:authentication property="principal.uvo.nickName" var="authNick"/>
        <sec:authentication property="principal.uvo.authList" var="auths"/>
            <li class="nav-item">
                <a class="nav-link" href="/board/register">게시판 글쓰기</a>
            </li>
            <li class="nav-item">
    			<a class="nav-link" href="/user/modify">회원정보수정 ${authNick }(${authEmail })</a>
        	</li>
        	<c:if test="${auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get() }">
        	<li class="nav-item">
          		<a class="nav-link text-danger" href="/user/list">회원리스트(ADMIN)</a>
        	</li>
        	</c:if>
        	<li class="nav-item">
          		<a class="nav-link" href="/user/logout">로그아웃</a>
        	</li>
        </sec:authorize>

                </ul>  
            </div>
        </div>
    </nav>
</body>
</html>

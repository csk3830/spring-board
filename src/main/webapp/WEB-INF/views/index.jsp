<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<jsp:include page="layout/header.jsp" />

<div class="container-md">
	
	<P>  The time on the server is ${serverTime}. </P>

</div>

<script type="text/javascript">
let modify_msg = `<c:out value="${modify_msg }" />`;
console.log(modify_msg);
if(modify_msg == 'ok'){
	alert("회원정보가 수정되었습니다. 다시 로그인 해주세요.");
} 
if(modify_msg == 'fail'){
	alert("회원정보수정에 실패했습니다. 다시 시도해 주세요.")
}

let remove_msg = `<c:out value="${remove_msg }" />`;
console.log(remove_msg);
if (remove_msg == 'ok'){
	alert("회원 탈퇴가 완료되었습니다. 안녕히 가세요.");
} 
if(remove_msg == 'fail'){
	alert("회원 탈퇴에 실패했습니다. 다시 시도해 주세요.")
}
</script>





<jsp:include page="layout/footer.jsp" />

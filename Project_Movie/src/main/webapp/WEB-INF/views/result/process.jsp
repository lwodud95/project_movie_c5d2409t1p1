<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<script>
	alert("${msg}"); 
	<c:choose>
		<c:when test="${empty targetURL and empty closeWindow}">
			history.back();
		</c:when>
		<c:when test="${empty targetURL and not empty closeWindow}">
			window.close();
		</c:when>
		<c:otherwise>
			location.href = "${targetURL}";
		</c:otherwise>
	</c:choose>
</script>







<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminpage/admin_login_main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminpage/admin_login_form.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<style type="text/css">
.login-box {
	padding: 100px;
}
h1 {
	text-align: center;
    font-size: 2em;
    margin-top: 6%;
}
.split-box {
	margin-top: 0;
}
</style>
<body class="left-sidebar is-preload">
<article class="box post">
	<div class="container">
		<main class="content">
			<h1>관리자 로그인</h1>
			<div class="split-box">
				<div class="login-box">
				<h2 class="section-title"></h2>
					<form action="AdminLogin" method="post" id="admin_loginForm">
						<label for="admin_id">아이디</label>
						<input type="text" id="admin_id" name="admin_id">
						<label for="admin_passwd">비밀번호</label>
						<input type="password" id="admin_passwd" name="admin_passwd"/>
						<button type="submit" id="login-btn">로그인</button>
					</form>
				</div>
			</div>
		</main>
	</div>
</article>
</body>
</html>

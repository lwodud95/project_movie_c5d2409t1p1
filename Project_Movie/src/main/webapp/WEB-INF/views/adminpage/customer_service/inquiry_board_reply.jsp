<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html lang="en">
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>관리자페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/customer_service/faq_post.css" />
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<article id="articleForm">
		<h1>1:1문의 답변</h1>
		<form action="AdminInquiryReply" method="post" enctype="multipart/form-data">
			<input type="hidden" name="inquiry_code" value=" ${param.inquiry_code}">
			<input type="hidden" name="pageNum" value=" ${param.pageNum}">
			<input type="hidden" name="inquiry_re_ref" value=" ${inquiry.inquiry_re_ref}">
			<input type="hidden" name="inquiry_re_lev" value=" ${inquiry.inquiry_re_lev}">
			<input type="hidden" name="inquiry_re_seq" value=" ${inquiry.inquiry_re_seq}">
			<section id="basicInfoArea">
				<table>
					<tr>
						<th width="110px">제목 </th>
						<td><input type="text" name ="inquiry_subject" value="RE: ${inquiry.inquiry_subject}" ></td>
						<th width="90px">작성자</th>
						<td><input type="text" value="${sessionScope.admin_sId}" readonly="readonly"></td>
					</tr>
				</table>
			</section>
			<section id="articleContentArea">
				<textarea rows="15" cols="70" name="inquiry_content"></textarea>
			</section>
			<hr>
			<div>
				<input type="submit" value="등록" >
				<input type="reset" value="다시쓰기">
				<input type="button" value="뒤로가기" onclick="location.href='AdminInquiry'">
			</div>
		</form>
	</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
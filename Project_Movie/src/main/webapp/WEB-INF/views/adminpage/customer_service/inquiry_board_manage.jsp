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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/notice_board_manage.css" rel="stylesheet" />
		<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	<article class="box">
		<div id="title">
			<h1>1:1 문의 목록</h1>
		</div>
	    <div class="search-bar" style="text-align: right;">
			<form action="AdminInquiry" method="get">
			    <select id="searchType" name="searchType">
			        <option value="before" <c:if test="${param.searchType eq 'before'}">selected</c:if>>답변 전</option>
			        <option value="after" <c:if test="${param.searchType eq 'after'}">selected</c:if>>답변</option>
			        <option value="finish" <c:if test="${param.searchType eq 'finish'}">selected</c:if>>답변 완료</option>
			    </select>
		    	<input type="submit" value="찾기">
			</form>

	    </div>
		<section id="listForm">
			<table id="inquiryForm" border="1">
				<tr id="tr_top" align="center">
					<td width="25px">번호</td>
					<td width="65px">상태</td>
					<td width="260px">제목</td>
					<td width="100px">등록일</td>
					<td width="80px">작성자</td>
				</tr>
				<c:choose>
					<c:when test="${empty inquiryList}"> 
						<tr><td colspan="4">1:1문의가 존재하지 않습니다. </td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="inquiry" items="${inquiryList}" varStatus="status">
							<tr>
								<td class="inquiry_code">${inquiry.inquiry_code}</td>
								<td>
									<c:if test="${inquiry.response_status eq 0}">
										답변 전
									</c:if>
									<c:if test="${inquiry.response_status eq 1}">
										답변 완료
									</c:if>
									<c:if test="${inquiry.response_status eq 2}">
										답변
									</c:if>
								</td>
								<td class="inquiry_subject">
									<c:if test="${inquiry.inquiry_re_lev > 0 }">
										<c:forEach begin="1" end="${inquiry.inquiry_re_lev}">
											&nbsp;&nbsp;
										</c:forEach>
										↳ &nbsp;
									</c:if>
									${inquiry.inquiry_subject}
								</td>
								<td>
									<fmt:formatDate value="${inquiry.inquriy_date}" pattern="yyyy-MM-dd"/>
								</td>
								<td>
									<c:choose>
										<c:when test="${inquiry.inquiry_writer != null}">
											${inquiry.inquiry_writer}
										</c:when>
										<c:otherwise>
											${sessionScope.admin_sId}
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>					
				</c:choose>
			</table>
		</section>
				<section id="pageList">
			<input type="button" value="&lt" onclick="location.href='AdminInquiry?pageNum=${pageInfo.pageNum - 1}'" 
				 <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
			
			<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				<c:choose>
					<c:when test="${i eq pageInfo.pageNum }">
						<strong>${i}</strong>
					</c:when>
					<c:otherwise>
						<a href="AdminInquiry?pageNum=${i}">${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<input type="button" value="&gt" onclick="location.href='AdminInquiry?pageNum=${pageInfo.pageNum + 1}'" 
				 <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		</section>
	
	<script type="text/javascript">
		$(function() {
			$(".inquiry_subject").on("click", function(event) {
				let inquiry_code = $(event.target).siblings(".inquiry_code").text();
				location.href = "AdminInquiryPost?inquiry_code=" + inquiry_code + "&pageNum=${pageInfo.pageNum}";
			
			});

		});
	</script>
	</article>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>
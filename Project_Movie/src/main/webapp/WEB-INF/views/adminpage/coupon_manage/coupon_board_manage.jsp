<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>쿠폰 관리</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_account_manage.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>쿠폰 내역</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
		</div>	
		<div id="divTopRight">
			<select>
				<option>제목+내용</option>
				<option>제목</option>
				<option>내용</option>
			</select>
			<input type="text" placeholder="검색어를입력하세요"> <input type="button" value="검색" id="searchBtn">
		</div>	
	</div>
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th width="100">쿠폰번호</th>
				<th width="200">쿠폰타입</th>
				<th width="150">쿠폰상세</th>
<!-- 				<th width="150">할인율</th> -->
				<th width="200">등록일자</th>
				<th width="200">만료일자</th>
				<th width="200">쿠폰상태</th>
				<th width="150">보유계정</th>
				<th width="150">이벤트코드</th>
			</tr>
			<c:choose>
				<c:when test="${empty couponVo}">
					<tr>
						<th colspan="9">"작성된 게시글이 없습니다."</th>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="coupon" items="${couponVo}" varStatus="status">
						<tr>
							<td>${coupon.coupon_code}</td>	
							<td>
								<c:choose>
									<c:when test="${coupon.coupon_type eq false}">
										금액할인
									</c:when>
									<c:otherwise>
										할인율
									</c:otherwise>
								</c:choose>
							</td>	
							<td>
								<c:choose>
									<c:when test="${coupon.discount_amount eq '0'}">
										${coupon.discount_rate}% 할인권
									</c:when>
									<c:otherwise>
										${coupon.discount_amount}원 할인권
									</c:otherwise>
								</c:choose>
							</td>	
<!-- 							<td> -->
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${coupon.discount_rate eq '0'}"> --%>
<%-- 									</c:when> --%>
<%-- 									<c:otherwise> --%>
										
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
<!-- 							</td>	 -->
							<td><fmt:formatDate value="${coupon.regis_date}" pattern="yyyy-MM-dd"/> </td>	
							<td><fmt:formatDate value="${coupon.expired_date}" pattern="yyyy-MM-dd"/> </td>	
							<td>
								<c:choose>
									<c:when test="${coupon.coupon_status eq false}">
										미사용
									</c:when>
									<c:otherwise>
										사용완료
									</c:otherwise>
								</c:choose>
							</td>	
							<td>${coupon.member_id}</td>	
							<td>${coupon.event_code}</td>	
						</tr>	
					</c:forEach>
				</c:otherwise>
			</c:choose> 			
			
		</table>
	</div>
	<br>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>
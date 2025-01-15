<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<!--
	Escape Velocity by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book_tickets/book_pay.css">
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/book_tickets_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<!-- 	모달창 -->
		<div class="modal">
			<div class="modal_content">
				<div class="modal_close">x</div>
				<div class="top">
					<h2>결제하기</h2>
				</div>
				<form action="BookPay" name="" method="post">
					<div class="main_container">
						<div class="left_section">
							<h4>예매정보</h4>
			
							<section class="book_info_container">
								<div class="poster">
									<div class="mv_poster"><img src="${schedule.movie_img1}"></div>
								</div>
								<div class="mv_info">
									<div class="mv_title">${schedule.movie_name}</div>
							        <div class="row">
							            <div class="header">일시</div>
							            <div class="data">2024.12.30(월) 23:00</div>
							        </div>
							        <div class="row">
							            <div class="header">상영관</div>
							            <div class="data">
							            	<c:choose>
												<c:when test="${schedule.theater_code eq 'T1'}">
													1관
												</c:when>
												<c:when test="${schedule.theater_code eq 'T2'}">
													2관
												</c:when>
												<c:otherwise>
													3관
												</c:otherwise>
											</c:choose>
							            </div>
							        </div>
							        <div class="row">
							            <div class="header">인원</div>
							            <div class="data">일반 2명, 청소년 1명</div>
							        </div>
									 <div class="row">
							            <div class="header">좌석</div>
							            <div class="data">D5, D6, D7</div>
							        </div>
						        </div>
							</section>
							
							<section class="discount_container">
								<h4>할인/포인트</h4>
								<div class="discount_tab">
									<button type="button" class="coupon_btn">쿠폰</button>
									<button type="button" class="point_btn">포인트</button>
								</div>
								<div class="coupon_container">
									<p>사용할 쿠폰을 선택해주세요</p>
									<div class="coupon">
										쿠폰번호 <input type="text" class="coupon_form">
										<input type="button" value="등록" class="submit_btn">
									</div>
									<div class="coupon_table">
										<table border="1">
											<tr>
												<th>쿠폰명</th>
												<th>유효기간</th>
												<th>사용</th>
											</tr>
											<tr>
							                    <td>이벤트 날짜 30% 할인 쿠폰</td>
							                    <td>2025-02-23</td>
							                    <td><input type="checkbox"></td>
							                </tr>
										</table>
									</div>
								</div>
								<div class="point_container">
									<p>사용할 포인트를 입력해주세요</p>
									<div class="my_point">
										<div class="point01">보유 포인트</div>
										<div class="point02">3000 p</div>
									</div>
									<div class="use_point">
										<span>사용할 포인트</span>
										<div class="form_btn">
											<input type="text" class="point_form">
										</div>
									</div>
								</div>
							</section>
							
							<section class="pay_container">
								<h4>최종 결제수단</h4>
								<div class="pay_type">
									<button type="button" class="pay">신용카드</button>
									<button type="button" class="pay">카카오페이</button>
									<button type="button" class="pay">토스페이</button>
								</div>
							</section>
							
							<div class="right_section">
								<p>결제금액</p>
								<section class="payment_final">
									<div class="div01">
										<div class="tit">금액</div>
										<div class="row">
											<div class="price">28000</div>
											<div class="won">원</div>
										</div>
									</div>
									<div class="minus">-</div>
									<div class="div02">
										<div class="tit">할인적용</div>
										<div class="row">
											<div class="price">9000</div>
											<div class="won">원</div>
										</div>
									</div>
									<div class="div03">
										<div class="tit">총결제금액</div>
										<div class="row">
											<div class="price">19000</div>
											<div class="won">원</div>
										</div>
									</div>
									<div class="payment">
										<button type="button" class="back_btn" onclick="history.back()">이전</button>
										<button type="button" class="payment_btn" onclick="location.href='BookFinish'">결제</button>
									</div>
								</section>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		<script>
			 $(".modal_close").click(function() {
				$(".modal").css("display", "none");
				$(".modal_content").css("display", "none");
			});
			 
			 $(".coupon_btn").click(function() {
				$(".coupon_container").css("display", "block");
				
				if($(".point_container").css("display", "block")) {
					$(".point_container").css("display", "none");
				}
			});

			 $(".point_btn").click(function() {
				$(".point_container").css("display", "block");

				if($(".coupon_container").css("display", "block")) {
					$(".coupon_container").css("display", "none");
				}
			});
		</script>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>
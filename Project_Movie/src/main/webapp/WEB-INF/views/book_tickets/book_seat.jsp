<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book_tickets/book_seat.css">
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
				<div class="choice_seat">
					<h2>인원/좌석 선택</h2>
				</div>
				
				<ul>
					<li>
						<strong>성인</strong>
						<div class="ctrl_box">
							<button class="minus_btn" onclick="minus()">-</button>
							<div class="count">0</div>
							<button class="plus_btn" onclick="plus()">+</button>
						</div>
					</li>
					<li>
						<strong>청소년</strong>
						<div class="ctrl_box">
							<button class="minus_btn" onclick="minus()">-</button>
							<div class="count">0</div>
							<button class="plus_btn" onclick="plus()">+</button>
						</div>
					</li>
					<li>
						<strong>노약자</strong>
						<div class="ctrl_box">
							<button class="minus_btn" onclick="minus()">-</button>
							<div class="count">0</div>
							<button class="plus_btn" onclick="plus()">+</button>
						</div>
					</li>
				</ul>
				<span class="space_line"></span>
				
				
				<div class="seat_container">
					<div class="msg">인원 선택 후 좌석을 선택해주세요</div>
		            <div class="screen">SCREEN</div>
		            <div class="seat_row">
		                <button class="seat">A1</button>
		                <button class="seat">A2</button>
		                <button class="seat">A3</button>
		                <button class="seat">A4</button>
		                <button class="seat">A5</button>
		                <button class="seat">A6</button>
		                <button class="seat">A7</button>
		                <button class="seat">A8</button>
		                <button class="seat">A9</button>
		                <button class="seat">A10</button>
		            </div>
		            <div class="seat_row">
		                <button class="seat">B1</button>
		                <button class="seat">B2</button>
		                <button class="seat">B3</button>
		                <button class="seat">B4</button>
		                <button class="seat">B5</button>
		                <button class="seat">B6</button>
		                <button class="seat">B7</button>
		                <button class="seat">B8</button>
		                <button class="seat">B9</button>
		                <button class="seat">B10</button>
		            </div>
		            <div class="seat_row">
		                <button class="seat">C1</button>
		                <button class="seat">C2</button>
		                <button class="seat">C3</button>
		                <button class="seat">C4</button>
		                <button class="seat">C5</button>
		                <button class="seat">C6</button>
		                <button class="seat">C7</button>
		                <button class="seat">C8</button>
		                <button class="seat">C9</button>
		                <button class="seat">C10</button>
		            </div>
		            <div class="seat_row">
		                <button class="seat">D1</button>
		                <button class="seat">D2</button>
		                <button class="seat">D3</button>
		                <button class="seat">D4</button>
		                <button class="seat">D5</button>
		                <button class="seat">D6</button>
		                <button class="seat">D7</button>
		                <button class="seat">D8</button>
		                <button class="seat">D9</button>
		                <button class="seat">D10</button>
		            </div>
		            <div class="seat_row">
		                <button class="seat">E1</button>
		                <button class="seat">E2</button>
		                <button class="seat">E3</button>
		                <button class="seat">E4</button>
		                <button class="seat">E5</button>
		                <button class="seat">E6</button>
		                <button class="seat">E7</button>
		                <button class="seat">E8</button>
		                <button class="seat">E9</button>
		                <button class="seat">E10</button>
		            </div>
		            <div class="seat_row">
		                <button class="seat">F1</button>
		                <button class="seat">F2</button>
		                <button class="seat">F3</button>
		                <button class="seat">F4</button>
		                <button class="seat">F5</button>
		                <button class="seat">F6</button>
		                <button class="seat">F7</button>
		                <button class="seat">F8</button>
		                <button class="seat">F9</button>
		                <button class="seat">F10</button>
		            </div>
		            <div class="seat_row">
		                <button class="seat">G1</button>
		                <button class="seat">G2</button>
		                <button class="seat">G3</button>
		                <button class="seat">G4</button>
		                <button class="seat">G5</button>
		                <button class="seat">G6</button>
		                <button class="seat">G7</button>
		                <button class="seat">G8</button>
		                <button class="seat">G9</button>
		                <button class="seat">G10</button>
		            </div>
		        </div>
				
				<span class="space_line"></span>

				<div class="mv_info_container">
					<div class="top_info">
						<div class="book_info">예매정보</div>
						<div class="pay_info">결제</div>	
					</div>
					<div class="tnb">
						<div class="bottom_btn">
							<button class="back_btn" onclick="history.back()">이전</button>
						</div>
						<div class="poster">
							<div class="mv_poster">영화포스터</div>
							<div class="mv_title">해피엔드</div>
						</div>
						<!-- 영화관 정보 섹션 -->
						<div class="mv_info">
					        <div class="row">
					            <div class="header">일시</div>
					            <div class="data">2024.12.30(월) 23:00</div>
					        </div>
					        <div class="row">
					            <div class="header">상영관</div>
					            <div class="data">1관</div>
					        </div>
					        <div class="row">
					            <div class="header">인원</div>
					            <div class="data">일반 1명, 청소년 1명</div>
					        </div>
							 <div class="row">
					            <div class="header">좌석</div>
					            <div class="data">D5, D6, D7</div>
					        </div>
						</div>
						
						<!-- 결제 정보 섹션 -->
					   	<div class="ticket_info">
					        <div class="row">
					            <div class="header">성인</div>
					            <div class="data">
					            	<span class="price">10000</span>
					            	<span class="exe"> 원 X</span>
					            	<span class="qty"> 2</span>
					            </div>
					        </div>
					        <div class="row">
					            <div class="header">청소년</div>
					            <div class="data">
					            	<span class="price">8000</span>
					            	<span class="exe"> 원 X</span>
					            	<span class="qty"> 1</span>
				        		</div>
					        </div>
					        <div class="row">
					            <div class="header">총금액</div>
					            <div class="data">
					            	<span class="price">28000</span>
					                <span class="won"> 원</span>
					            </div>
					        </div>
						</div>
					
						<div class="bottom_btn">
							<button class="pay_btn" onclick="location.href='BookPay'">결제</button>
						</div>
					</div>
				</div>
				
				
			</div>
		</div>
		
		<script>
			 $(".modal_close").click(function() {
				$(".modal").css("display", "none");
				$(".modal_content").css("display", "none");
			});
		</script>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book_tickets/book_tickets.css">
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/book_tickets_sidebar.jsp"></jsp:include>

	<article class="box post">
		<h2>예매하기</h2>
	
	
	
		<!-- 	모달창 -->
		<div class="modal">
			<div class="modal_content">
				<div class="modal_close">x</div>
				
				<h2>예매하기</h2>
				<div class="all_section">
			<!-- 		탑(영화/날짜) -->
					<div class="left_section">
						<div class="header_mv">
							<h4>영화</h4>
						</div>
						
			<!-- 		셀렉트박스 -->
						<div class="mv_sel">
							<select>
								<option selected>예매율순</option>
								<option>별점순</option>
								<option>가나다순</option>
							</select>
						</div>
						
				<!-- 		영화목록 -->
						<div class="mv_list_container">
							<div class="mv_list">
								<a href="">
									<span class="mv_age">12</span>
									<span class="mv_title">해피앤드</span>
								</a>
							</div>
							<div class="mv_list">
								<a href="">
									<span class="mv_age">15</span>
									<span class="mv_title">소방관</span>
								</a>
							</div>
							<div class="mv_list">
								<a href="">
									<span class="mv_age">ALL</span>
									<span class="mv_title">모아나</span>
								</a>
							</div>
							<div class="mv_list">
								<a href="">
									<span class="mv_age">12</span>
									<span class="mv_title">해피앤드</span>
								</a>
							</div>
							<div class="mv_list">
								<a href="">
									<span class="mv_age">15</span>
									<span class="mv_title">소방관</span>
								</a>
							</div>
							<div class="mv_list">
								<a href="">
									<span class="mv_age">ALL</span>
									<span class="mv_title">모아나</span>
								</a>
							</div>
							<div class="mv_list">
								<a href="">
									<span class="mv_age">12</span>
									<span class="mv_title">해피앤드</span>
								</a>
							</div>
							<div class="mv_list">
								<a href="">
									<span class="mv_age">15</span>
									<span class="mv_title">소방관</span>
								</a>
							</div>
							<div class="mv_list">
								<a href="">
									<span class="mv_age">ALL</span>
									<span class="mv_title">모아나</span>
								</a>
							</div>
						</div>
					</div>
					
					<section class="mid_section">
						<div class="header_date">
							<h4>날짜</h4>
						</div>
						
						<div class="date_list">
						<%
	
			                // 현재 날짜부터 10일치 생성
			                Calendar calendar = Calendar.getInstance();
			                SimpleDateFormat yearMonthFormat = new SimpleDateFormat("yyyy년 MM월");
			                SimpleDateFormat dayFormat = new SimpleDateFormat("E");
			                SimpleDateFormat dateFormat = new SimpleDateFormat("d");
			                
			             // 오늘 날짜와 비교하기 위해 현재 날짜 정보 저장
			                Calendar today = Calendar.getInstance();
			                String todayYearMonth = yearMonthFormat.format(today.getTime());
			                String todayDate = dateFormat.format(today.getTime());
			
			                String lastYearMonth = ""; // 이전 년/월을 추적
			
			                for (int i = 0; i < 10; i++) {
			                    String yearMonth = yearMonthFormat.format(calendar.getTime());
			                    String day = dayFormat.format(calendar.getTime());
			                    String date = dateFormat.format(calendar.getTime());
			
			                    // 년/월 헤더 출력
			                    if (!yearMonth.equals(lastYearMonth)) {
			                        out.println("<div class='year_month'><strong>" + yearMonth + "</strong></div>");
			                        lastYearMonth = yearMonth;
			                    }
			                    
			                    // 오늘 날짜에 selected 클래스 추가
			                    String selectedClass = "";
			                    if (yearMonth.equals(todayYearMonth) && date.equals(todayDate)) {
			                        selectedClass = "selected";
			                    }
			
			                    // 날짜 항목 출력
			                    // 현재 날짜 셀렉트X
	 		                    // out.println("<div class='date_item' data-date='" + yearMonth + " " + date + "'>");
			                    // 현재 날짜 셀렉트O
			                    out.println("<div class='date_item " + selectedClass + "' data-date='" + yearMonth + " " + date + "'>");
			                    out.println("  <a href='#'>");
			                    out.println("    <span>" + day + "</span>");
			                    out.println("    <strong>" + date + "</strong>");
			                    out.println("  </a>");
			                    out.println("</div>");
			
			                    // 다음 날로 이동
			                    calendar.add(Calendar.DATE, 1);
		                	}
		           		%>
							<!-- 날짜 리스트 렌더링 -->
				            <c:set var="lastYearMonth" value="" />
				            <c:forEach var="date" items="${dateList}">
				                <!-- 년도와 월 헤더: 중복 표시 방지 -->
				                <c:if test="${date.yearMonth != lastYearMonth}">
				                    <div class="year_month">${date.yearMonth}</div>
				                    <c:set var="lastYearMonth" value="${date.yearMonth}" />
				                </c:if>
				                
				                <!-- 날짜 항목 -->
				                <div class="date_item">
				                    <a href="#">
				                        <span>${date.day}</span> <!-- 요일 -->
				                        <strong>${date.date}</strong> <!-- 날짜 -->
				                    </a>
				                </div>
				            </c:forEach>
						</div>
					</section>
						
						<div class="right_section">
							<div class="header_time">
								<h4>시간</h4>
							</div>
							<div class="movie_schedule_info">
								<section class="sec01">
									<!-- 영화 제목과 이용가 표시 -->
								    <div class="movie_container">
								        <div class="mv_age">12</div>
								        <div class="mv_title">해피엔드</div>
								    </div>
								
								    <!-- 시간/좌석 버튼들 -->
								    <div class="time_seat_container">
								        <a class="time_seat_btn">
								        	<span class="mv_time">10:30</span>
								        	<span class="details">
									        	<span class="seat">78/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">13:45</span>
								        	<span class="details">
									        	<span class="seat">63/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								    </div>
								</section>
								<section class="sec01">
									<!-- 영화 제목과 이용가 표시 -->
								    <div class="movie_container">
								        <div class="mv_age">12</div>
								        <div class="mv_title">해피엔드</div>
								    </div>
								
								    <!-- 시간/좌석 버튼들 -->
								    <div class="time_seat_container">
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								    </div>
								</section>
								<section class="sec01">
									<!-- 영화 제목과 이용가 표시 -->
								    <div class="movie_container">
								        <div class="mv_age">12</div>
								        <div class="mv_title">해피엔드</div>
								    </div>
								
								    <!-- 시간/좌석 버튼들 -->
								    <div class="time_seat_container">
								        <a class="time_seat_btn">
								        	<span class="mv_time">10:30</span>
								        	<span class="details">
									        	<span class="seat">78/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">13:45</span>
								        	<span class="details">
									        	<span class="seat">63/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								    </div>
								</section>
								<section class="sec01">
									<!-- 영화 제목과 이용가 표시 -->
								    <div class="movie_container">
								        <div class="mv_age">12</div>
								        <div class="mv_title">해피엔드</div>
								    </div>
								
								    <!-- 시간/좌석 버튼들 -->
								    <div class="time_seat_container">
								        <a class="time_seat_btn">
								        	<span class="mv_time">10:30</span>
								        	<span class="details">
									        	<span class="seat">78/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">13:45</span>
								        	<span class="details">
									        	<span class="seat">63/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								    </div>
								</section>
								<section class="sec01">
									<!-- 영화 제목과 이용가 표시 -->
								    <div class="movie_container">
								        <div class="mv_age">12</div>
								        <div class="mv_title">해피엔드</div>
								    </div>
								
								    <!-- 시간/좌석 버튼들 -->
								    <div class="time_seat_container">
								        <a class="time_seat_btn">
								        	<span class="mv_time">10:30</span>
								        	<span class="details">
									        	<span class="seat">78/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								    </div>
								</section>
								<section class="sec01">
									<!-- 영화 제목과 이용가 표시 -->
								    <div class="movie_container">
								        <div class="mv_age">12</div>
								        <div class="mv_title">해피엔드</div>
								    </div>
								
								    <!-- 시간/좌석 버튼들 -->
								    <div class="time_seat_container">
								        <a class="time_seat_btn">
								        	<span class="mv_time">10:30</span>
								        	<span class="details">
									        	<span class="seat">78/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">13:45</span>
								        	<span class="details">
									        	<span class="seat">63/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								        <a class="time_seat_btn">
								        	<span class="mv_time">17:10</span>
								        	<span class="details">
									        	<span class="seat">80/80</span>
									        	<span class="hall">1관</span>
								        	</span>
								        </a>
								    </div>
								</section>
							</div>
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
						</div>
					
						<div class="bottom_btn">
							<button class="pay_btn" onclick="location.href='BookSeat'">좌석선택</button>
						</div>
					</div>
				</div>
					
				
			</div>
		</div>
	
		<script>
	        // jQuery를 사용하여 날짜 항목을 동적으로 관리
	        $(document).ready(function() {
	            // 날짜 클릭 시 선택 효과
	            $(".date_item a").on("click", function(e) {
	                e.preventDefault();
	                $(".date_item").removeClass("selected");
	                $(this).parent().addClass("selected");
	            });
	            
	        });
	        
	        // 영화 목록 클릭 시 선택 효과
	        $(document).ready(function () {
	            $(".mv_list").on("click", function () {
	                // 다른 항목의 선택 상태 초기화
	                $(".mv_list").removeClass("selected");
	                // 클릭된 항목에 selected 클래스 추가
	                $(this).addClass("selected");
	            });
	        });
	        
	        // 예매하기 버튼 클릭 시 모달창 생성 
			$("[href='BookTickets']").click(function(e) {
				e.preventDefault();
				$(".modal").css("display", "block");
				$(".modal_content").css("display", "block");
			});
			
	        // x 버튼 클릭 시 모달창 닫힘
			$(".modal_close").click(function() {
				$(".modal").css("display", "none");
				$(".modal_content").css("display", "none");
			});
	        
			$(".menu-items[href='BookTickets']").length > 0 ? console.log(".menu-items[href='BookTickets'] exists") : console.log(".menu-items[href='BookTickets'] not found");
	        
		</script>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>
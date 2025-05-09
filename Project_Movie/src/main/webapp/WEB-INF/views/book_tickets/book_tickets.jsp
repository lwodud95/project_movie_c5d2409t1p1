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
	<script src="${pageContext.request.contextPath}/resources/js/book_tickets/book_tickets.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/book_tickets_sidebar.jsp"></jsp:include>

	<article class="box post">
		<h2>예매안내</h2>
		<div id="notice">
			PICKCINE 인터넷 예매방법과 안내사항 안내드립니다.
			<br>
			<br>
			1. 예매하기 클릭<br>
			2. 관람 날짜와 영화 선택<br>
			3. 관람 인원 선택<br>
			4. 관람 좌석 선택<br>
			5. 결제 수단 선택<br>
			6. 결제하기 버튼 누르면 예매 완료<br>
			7. 예매 확인 및 취소<br>
			<br>
			인터넷 예매와 취소는 상영시간 20분 전까지 가능합니다.<br>
			<br>
			일반고객이 휠체어석 예매 시 현장에서 입장하실 수 없습니다.<br>
			단체관람 할인혜택은 전화문의 바랍니다.<br>
			<br>
			감사합니다.<br>
		</div>
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
							
				<!-- 		영화목록 -->
						<div class="mv_list_container">
							<c:forEach var="movie" items="${movieList}" >
								<div class="mv_list">
									<a href="#">
										<span class="mv_age">
											<c:choose>
												<c:when test="${movie.age_limit eq '12세이상관람가'}">
													<img src="${pageContext.request.contextPath}/resources/images/mv_age(12).png">
												</c:when>
												<c:when test="${movie.age_limit eq '15세이상관람가'}">
													<img src="${pageContext.request.contextPath}/resources/images/mv_age(15).png">
												</c:when>
												<c:when test="${movie.age_limit eq '청소년관람불가'}">
													<img src="${pageContext.request.contextPath}/resources/images/mv_age(19).png">
												</c:when>
												<c:otherwise>
													<img src="${pageContext.request.contextPath}/resources/images/mv_age(all).png">
												</c:otherwise>
											</c:choose>
										</span>
										<span class="mv_title">${movie.movie_name}<c:if test="${movie.movie_type eq '시즌'}"> (Season)</c:if></span>
										<input type="text" value="${movie.movie_code}" hidden>
									</a>
								</div>
							</c:forEach>
						</div>
					</div>
					
					<section class="mid_section">
						<div class="header_date">
							<h4>날짜</h4>
						</div>
						
						<div class="date_list">
						<%
						 	Locale locale = new Locale("ko", "KR");
							
							// 현재 날짜부터 10일치 생성
			                Calendar calendar = Calendar.getInstance(locale);
			                SimpleDateFormat yearMonthFormat = new SimpleDateFormat("yyyy년 MM월", locale);
			                SimpleDateFormat dayFormat = new SimpleDateFormat("E", locale);
			                SimpleDateFormat dateFormat = new SimpleDateFormat("dd", locale);
			                
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
	 		                    out.println("<div class='date_item' data-date='" + yearMonth + " " + date + "'>");
			                    // 현재 날짜 셀렉트O
// 			                    out.println("<div class='date_item " + selectedClass + "' data-date='" + yearMonth + " " + date + "'>");
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
								<h4>날짜를 선택해주세요</h4>
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
	        
		</script>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>
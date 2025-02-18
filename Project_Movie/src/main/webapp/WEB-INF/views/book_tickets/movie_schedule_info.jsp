<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/book_tickets/movie_schedule_info.css">
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/book_tickets/movie_schedule_info.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/book_tickets_sidebar.jsp"></jsp:include>
	
	<article class="box post">
	
		<h2>상영시간표</h2>
		
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
//                     out.println("<div class='date_item " + selectedClass + "' data-date='" + yearMonth + " " + date + "'>");
                    out.println("  <a href=''>");
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
	
	
	
	
		<div class="movie_schedule_info">
			<h4>날짜를 선택해주세요</h4>
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
	        
	    </script>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>
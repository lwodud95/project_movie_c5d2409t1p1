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
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/movie_set/movie_schedule_info_detail.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/movie_set/movie_schedule_info_detail.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<section>
		<div id="body_top">
			<div id="title">스케줄 상세</div>
			<div id="btnGroup01">
				<select class="changeScheduleTable">
					<option value="T1" <c:if test="${param.theater_code eq 'T1'}">selected</c:if>>1관</option>
					<option value="T2" <c:if test="${param.theater_code eq 'T2'}">selected</c:if>>2관</option>
					<option value="T3" <c:if test="${param.theater_code eq 'T3'}">selected</c:if>>3관</option>
				</select>
				<input type="date" class="changeScheduleTable" value="${param.select_date}">
				<input type="button" id="toBeforePageBtn" value="이전페이지">
				<input type="button" id="registScheduleBtn" value="스케줄등록">
				<input type="button" id="deleteScheduleBtn" value="스케줄삭제">
			</div>
			<div id="btnGroup02">
				<input type="button" id="ableBtn" value="예매 활성화">
				<input type="button" id="disableBtn"value="예매 비활성화">
			</div>
		</div>
		<div id="body_main">
			<div class="scheduleInfoBoardList">
				<div id="boardHead">
					<div><input type="checkbox" name="schedule_code"></div>
					<div>스케줄 목록</div>
				</div>
				<c:choose>
					<c:when test="${scheduleList.size() eq 0}">
						<div class="scheduleboardNone">스케줄이 존재하지 않습니다</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="schedule" items="${scheduleList}" varStatus="status">
							<div class="scheduleInfoBoard">
								<div class="scheduleCheck"><input type="checkbox" class="scheduleCheck" value="${schedule.schedule_code}"></div>
								<div class="boardContent">
									<img src="${schedule.movie_img1}">
									스케줄코드 ${schedule.schedule_code}<br>
									
									상영관
									<c:choose>
										<c:when test="${schedule.theater_code eq 'T1'}">(1관),</c:when>
										<c:when test="${schedule.theater_code eq 'T2'}">(2관),</c:when>
										<c:otherwise>(3관),</c:otherwise>
									</c:choose>
									
									좌석현황 (${schedule.avail_seat - schedule.disabledSeatCount} / ${schedule.avail_seat})<br>
									<b>&lt;${schedule.movie_name}&gt;</b> 러닝타임 (${schedule.running_time}분)<br>
									<fmt:parseDate var="parsedStartTime" value="${schedule.start_time}"	pattern="yyyy-MM-dd HH:mm" type="both" />
									<fmt:parseDate var="parsedEndTime" value="${schedule.end_time}"	pattern="yyyy-MM-dd HH:mm" type="both" />
									<fmt:formatDate value="${parsedStartTime}" pattern="yyyy/MM/dd HH:mm"/> ~ <fmt:formatDate value="${parsedEndTime}" pattern="HH:mm"/>
									[
										<c:choose>
											<c:when test="${schedule.isPassed != null && schedule.isPassed}"><b>종료된 스케줄</b></c:when>
											<c:when test="${schedule.isPassed != null && !schedule.isPassed}"><b style = "color: green;">상영중</b></c:when>
											<c:when test="${schedule.isPassed == null && schedule.booking_avail}"><b style = "color: blue;">예매 활성화</b></c:when>
											<c:otherwise><b  style = "color: red;">예매 비활성화</b></c:otherwise>
										</c:choose>
									]
								</div>
							</div>
							<c:if test="${status.count != scheduleList.size()}">
								<div class="creaningTime">
									청소 및 다음 상영 준비시간(30분)
								</div>	
							</c:if>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
	
<!-- 	스케줄 등록 모달 -->
	<div id="schedule_regist_modal" class="modal">
		<div class="modal_content">
			<form action="ScheduleRegistForm" method="POST">
				<h2>스케줄 등록</h2>
				<hr>
				   <label>영화선택</label>
				<select name="selected_movie">
					<option value="" selected="selected">선택</option>
					<optgroup label="현재상영작"></optgroup>
					<optgroup label="상영예정작"></optgroup>
				</select>
				<br>
			    <label>영화코드</label>
			    <input type="text" name="movie_code" readonly="readonly"><br>
			    <label>영화명</label>
			    <input type="text" name="movie_name" readonly="readonly"><br>
			    <label>러닝타임</label>
			    <input type="text" name="running_time" readonly="readonly"><br>
			    <label>상영관</label>
			    <select disabled="disabled">
					<option value="T1" <c:if test="${param.theater_code eq 'T1'}">selected</c:if>>1관</option>
					<option value="T2" <c:if test="${param.theater_code eq 'T2'}">selected</c:if>>2관</option>
					<option value="T3" <c:if test="${param.theater_code eq 'T3'}">selected</c:if>>3관</option>
				</select>
				<input type="hidden" name="theater_code" required>	
			    <br>
			    <label>상영날짜</label>
			    <input type="date" name="select_date" value="${param.select_date}" required readonly><br>
			    <label>상영시작시간</label>
			    <input type="time" name="s_time" min="09:00" max="22:30" required><br>
			    <input type="hidden" name="str_start_time">
			    <label>상영종료시간</label>
			    <input type="time" name="e_time" readonly="readonly"><br>
			    <input type="hidden" name="str_end_time">
			    <label>청소 및 준비(분)</label>
			    <input type="number" value="30" readonly="readonly"><br>
			    <label>상영시간대</label>
			    <input type="text" name="showtime_type" readonly><br>
			    <label>예매가능여부</label>
			    <input type="hidden" name="str_next_schedule">
			    <select name="booking_avail">
			    	<option value="0">예매불가</option>
			    	<option value="1">예매가능</option>
			    </select>
			    <br>
			    <span id="isRegistPossible">
			    </span>
			    <div class="form_btnGroup">
			    	<input type="submit" value="등록">
			    	<input type="reset" value="초기화">
			    	<input type="button" class="close_modal" value="닫기">
			    </div>
			    <div>
			    </div>
			</form>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>
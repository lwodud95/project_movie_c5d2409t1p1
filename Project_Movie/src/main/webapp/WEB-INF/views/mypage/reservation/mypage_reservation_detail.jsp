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
	<title>마이페이지</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/mypage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/mypage/reservation/mypage_reservation_detail.css" rel="stylesheet" />
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/mypage/reservation_detail.js"></script>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
 <article class="box post">
 	<div id="title">
		<h1>예매내역</h1>
 	</div>
		<!-- 로그인 한 회원 이름 +n건입니다. - 예매한 갯수로 연결 -->
		<h6>정유나님 관람가능한 예매내역이 0건 입니다.</h6>
      <section id="listForm">
         <table>
            <tr id="tr_top">
	           	<td width="5%"><input type="radio" name="reservationRadio" disabled="disabled"></td>
	           	<td width="7%">순서</td>
				<td width="12%">예매번호</td>
				<td width="20%">영화명</td>
				<td width="11%">관람인원</td>
				<td width="11%">관람좌석</td>
				<td width="9%">상영관</td>
				<td width="15%">예매일</td>
				<td width="10%">금액</td>
            </tr>
               
            <c:choose>
               <c:when test="${empty reservationDetail}"> 
                  <tr><td colspan="9">게시물이 존재하지 않습니다</td></tr>
               </c:when>
               <c:otherwise>
                  <c:forEach var="reservationDetail" items="${reservationDetail}" varStatus="status">
                     <tr>
                    	<td><input type="radio" name="reservationRadio"></td>
                        <td>${reservationDetail.r_code}</td>
                        <td>${reservationDetail.r_num}</td>
                        <td>${reservationDetail.r_moviename}</td>
                        <td>${reservationDetail.r_people}</td>
                        <td>${reservationDetail.r_seat}</td>
                        <td>${reservationDetail.r_theater}</td>
                        <td>
                           <fmt:formatDate value="${reservationDetail.r_date}" pattern="yy-MM-dd"/>
                        </td>
                        <td>${reservationDetail.r_price}</td>
                     </tr>
                  </c:forEach>
               </c:otherwise>               
            </c:choose>
         </table>
      </section>
      
	<div id="underButton" style="text-align: right;">
<!-- 	상세정보 클릭 시 상세정보 창 띄우기  -->
      <input type="button" value="상세정보" id="detail">
<!--       예매취소 클릭 시 취소하시겠습니까? 알림창 -->
      <input type="button" value="예매취소" id="cancel">
<!-- 확인 시 예매가 취소되었습니다. -->
	</div>
         <section id="pageList">
         <input type="button" value="&lt" 
            onclick="location.href='ReservationDetail?pageNum=${pageInfo.pageNum - 1}'" 
             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
         
         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
            <c:choose>
               <c:when test="${i eq pageInfo.pageNum }">
                  <strong>${i}</strong>
               
               </c:when>
               <c:otherwise>
                  <a href="ReservationDetail?pageNum=${i}">${i}</a>
               </c:otherwise>
            </c:choose>
         </c:forEach>
         
         
         <input type="button" value="&gt" 
            onclick="location.href='ReservationDetail?pageNum=${pageInfo.pageNum + 1}'" 
             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
      </section>
	</article>
	<div id="reservation_detail_modal" class="modal">
		<div class="reservation_detail">
		    <h2>상세 정보</h2>
		    <hr>
	        <label>예매번호</label><input type="text" name="r_num" readonly><br>
	        <label>영화명</label><input type="text" name="r_moviename" readonly><br>
	        <label>상영관</label><input type="text" name="r_theater" readonly><br>
	        <label>좌석</label><input type="text" name="r_seat" readonly><br>
	        <label>관람인원</label><input type="text" name="r_people" readonly><br>
	        <label>관람일</label><input type="datetime-local" name="r_date" readonly><br>
	        <label>가격</label><input type="text" name="r_price" readonly><br>
	        <hr>
			<h3>취소환불규정안내</h3>
			<div id= "content">
				취소 마감시간은 상영 시작 시간 30분 전입니다.<br>
				관람일 전일 오후 5시 이후(일요일은 오전 11시) <br>
				또는 관람일 당일 예매하신 건에 대해서는 예매 후 <br>
				취소∙변경∙환불이 불가합니다.<br>
				토요일이 공휴일인 경우 토요일 오전 11시 <br>
				기준으로 적용됩니다.<br>
			</div>
	        <div class="btnGroup">
	        	<button type="button" class="close_modal">닫기</button>
	        </div>
		</div>
	</div>
	

	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
</body>
</html>
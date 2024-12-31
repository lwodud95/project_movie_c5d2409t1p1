<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
<head>
	<title>Insert title here</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/reservation/mypage_reservation_detail.css"/>
</head>
<body>
 <article class="box post">
		<h1>예매내역</h1>
		<h6>정유나님 관람가능한 예매내역이 1건 입니다.</h6>
      <section id="listForm">
         <table>
            <tr id="tr_top">
               <td>순서</td>
               <td>예매번호</td>
               <td>영화명</td>
               <td>관람인원</td>
               <td>관람좌석</td>
               <td>상영관</td>
               <td width="150px">예매일</td>
               <td>금액</td>
            </tr>
               
            <c:choose>
               <c:when test="${empty boardList}"> 
                  <tr><td colspan="8">게시물이 존재하지 않습니다</td></tr>
               </c:when>
               <c:otherwise>
                  <c:forEach var="board" items="${boardList}" varStatus="status">
                     <tr>
                        <td class="board_num">${board.board_num}</td>
                        <td class="board_subject">${board.board_subject}</td>
                        <td>${board.board_name}</td>
                        <td>
                           <fmt:formatDate value="${board.board_date}" pattern="yy-MM-dd - yy-MM-dd"/>
                        </td>
                        <td>${board.board_readcount}</td>
                     </tr>
                  </c:forEach>
               </c:otherwise>               
            </c:choose>
         </table>
      </section>
<!--       오른쪽 정렬 -->
	<div id="underButton" >
<!-- 	상세정보 클릭 시 상세정보 창 띄우기  -->
      <button>상세정보</button>
<!--       예매취소 클릭 시 취소하시겠습니까? 알림창 -->
<!-- 확인 시 예매가 취소되었습니다. -->
      <button>예매취소</button>
	</div>
            <section id="pageList">
         <input type="button" value="&lt" 
            onclick="location.href='BoardList?pageNum=${pageInfo.pageNum - 1}'" 
             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
         
         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
            <c:choose>
               <c:when test="${i eq pageInfo.pageNum }">
                  <strong>${i}</strong>
               
               </c:when>
               <c:otherwise>
                  <a href="BoardList?pageNum=${i}">${i}</a>
               </c:otherwise>
            </c:choose>
         </c:forEach>
         
         
         <input type="button" value="&gt" 
            onclick="location.href='BoardList?pageNum=${pageInfo.pageNum + 1}'" 
             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
      </section>
	</article>


	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>
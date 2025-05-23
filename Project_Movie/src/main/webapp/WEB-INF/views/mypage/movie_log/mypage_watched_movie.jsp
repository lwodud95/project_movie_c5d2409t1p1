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
	<link href="${pageContext.request.contextPath}/resources/css/mypage/movie_log/mypage_watched_movie.css" rel="stylesheet"/>
	<!-- jQuery를 먼저 추가 -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- 그 후 Font Awesome 아이콘 스크립트 추가 -->
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/mypage/watched_movie.js"></script>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/mypage_sidebar.jsp"></jsp:include>
	<article class="box post">
		<div id="title">
			<h1>내가 본 영화</h1>
		</div>
			<div id="selectBox">
				<form action="WatchedMovie" method="get" id="watchedForm">
					<c:if test="${param.searchYear eq '2025'}">selected</c:if>
					<select id="searchYear">
						<option value="2025" <c:if test="${param.searchYear eq '2025'}">selected</c:if>>2025</option>
						<option value="2024" <c:if test="${param.searchYear eq '2024'}">selected</c:if>>2024</option>
						<option value="2023" <c:if test="${param.searchYear eq '2023'}">selected</c:if>>2023</option>
						<option value="2022" <c:if test="${param.searchYear eq '2022'}">selected</c:if>>2022</option>
						<option value="2021" <c:if test="${param.searchYear eq '2021'}">selected</c:if>>2021</option>
					</select>
					<input type="submit" value="조회">
						* 영화 조회는 <b>최근 5년 내역만</b> 조회가 가능합니다
				</form>
			</div>
			<div style="text-align: right;">
				<c:if test="${not empty watchedMovie}"><input type="button" value="리뷰 등록" id="reviewRegister" ></c:if>
			</div>
	      <section id="listForm">
	         <table id="movieListTable">
	            <tr id="tr_top">
	               <td width="5%"><input type="radio" name ="watchedMovie" disabled="disabled"></td>
	               <td width="35%">영화명</td>
	               <td width="25%">관람 일시</td>
	               <td width="25%">리뷰 등록 여부</td>
	            </tr>
	           
	            <c:choose>
	               <c:when test="${empty watchedMovie}"> 
	                  <tr><td colspan="5">상영한 영화가 존재하지 않습니다</td></tr>
	               </c:when>
	               <c:otherwise>
	                  <c:forEach var="watchedMovie" items="${watchedMovie}" varStatus="status">
	                     <tr>
	                      	<td><input type="radio" name="movieList" value="${watchedMovie.movie_code}" class="get_movie_code"></td>
	                        <td>${watchedMovie.movie_name}</td>
	                        <td>
	                        	<fmt:formatDate value="${watchedMovie.start_time}" pattern="yyyy-MM-dd"/>
                        	</td>
	                        <td>
	                        	<c:choose>
	                        		<c:when test="${watchedMovie.isRegist == 0}">리뷰 등록 전</c:when>
	                        		<c:otherwise>리뷰 등록 완료</c:otherwise>
	                        	</c:choose>
	                        </td>
	                     </tr>
	                  </c:forEach>
	               </c:otherwise>               
	            </c:choose>
	         </table>
	      </section>
          <section id="pageList">
	         <input type="button" value="&lt" 
	            onclick="location.href='WatchedMovie?pageNum=${pageInfo.pageNum - 1}'" 
	             <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
	         
	         <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
	            <c:choose>
	               <c:when test="${i eq pageInfo.pageNum }">
	                  <strong>${i}</strong>
	               
	               </c:when>
	               <c:otherwise>
	                  <a href="WatchedMovie?pageNum=${i}">${i}</a>
	               </c:otherwise>
	            </c:choose>
	         </c:forEach>
	         <input type="button" value="&gt" 
	            onclick="location.href='WatchedMovie?pageNum=${pageInfo.pageNum + 1}'" 
	             <c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	      </section>
		</article>
		<div id="watched_movie_review_modal" class="modal">
			<div class="watched_movie_review">
				    <h2>리뷰 등록</h2>
				    <hr>
				    <div>
				        <label id="review_content">영화명<input type="text" name="movie_name" readonly></label><br>
				        <label id="review_content">한줄리뷰</label>
				        <br>
				        <textarea cols="40" rows="3" name="review">
				        
				        </textarea>
				        <br> 
				        <label id="review_recommend">추천</label><input type="radio" name="review_recommend" value="0">
				        <label id="review_recommend">비추천</label><input type="radio" name="review_recommend" value="1"><br>
				    </div>
			        <hr>
			        <div class="btnGroup">
			        	<button type="button" class="submit_modal">등록</button>
			        	<button type="button" class="cancel_modal">취소</button>
			        </div>
			</div>
		</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
</body>
</html>
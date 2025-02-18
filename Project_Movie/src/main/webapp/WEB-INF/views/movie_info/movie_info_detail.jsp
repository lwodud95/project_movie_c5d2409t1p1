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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movie_info/movie_info_detail.css" />
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/inc/page/movie_info_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		<div id="movie_info_detail">
			<div id="page_top">
				${movie.movie_status}
			</div>
			<div>
				<div id="movie_poster">
					<img src="${movie.movie_img1}"><br>
					<c:if test="${movie.movie_status eq '현재상영작'}">
						<input type="button" value="예매하기" onclick="location.href='BookTickets'">
					</c:if>
				</div>
				<div id="movie_info">
					<b>${movie.movie_name}</b>
					<p id="p01">
						★(${movie.movie_rating}) <br>
						${movie.release_date} | ${movie.running_time} | ${movie.age_limit}
					</p>
					<p id="p02">
					    감독 : ${movie.movie_director}<br>
						출연 : ${movie.movie_actor}<br>
						장르 : ${movie.movie_genre}<br>
						<c:if test="${!movie.movie_status.equals('지난상영작')}">
							예매가격 : ${generalPrice}원
						</c:if>
					</p>
					줄거리
					<div id="movie_summary">
						${movie.movie_synopsis}
					</div>
				</div>
			</div>
			<div id="movie_trailer">
				메인예고편
				<div>
					<iframe id="video" width="850" height="500" src="${movie.movie_trailer}"></iframe>
				</div>
			</div>
			<div id="movie_stillcut">
				Still Cut
				<div>
					<img src="${movie.movie_img1}">
					<div class="stillcut">
						<img src="${movie.movie_img2}">
						<img src="${movie.movie_img3}"><br>
						<img src="${movie.movie_img4}">
						<img src="${movie.movie_img5}">
					</div>
				</div>
			</div>
			<div id="movie_review">
				<div id="review_title">관람평</div>
				<div>
					<table>
						<tr>
							<th style="width:230px;">ID</th>
							<th style="width:500px;">한줄평</th>
							<th style="width:145px;">추천/비추천</th>
						</tr>
					</table>
					<div id="content_table">
						<table>
							<c:choose>
								<c:when test="${empty reviewList}">
									<tr><td colspan="3">등록된 관람평이 없습니다.</td></tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="review" items="${reviewList}">
										<tr>
											<td style="width:230px;">${review.review_writer}</td>
											<td style="width:500px;">${review.review_content}</td>
											<td style="width:145px;">
												<c:choose>
													<c:when test="${review.review_recommend eq 0}">추천</c:when>
													<c:otherwise>비추천</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>
					</div>
				</div>
			</div>
		</div>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	
</body>
</html>
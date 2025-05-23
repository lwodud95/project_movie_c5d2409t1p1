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
	<title>Movie</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_assets/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>    
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</head>
<body class="homepage is-preload">

	<jsp:include page="/WEB-INF/views/inc/main_top.jsp"></jsp:include>

		<section id="intro" class="wrapper style1">
			<div class="title">Currently Movies</div>
				<div id="leftBtn">&lt;</div>
				<div id="rightBtn">&gt;</div>
			<div class="container">
				<p class="style2">
				</p>
			</div>
		</section>
	
		<section id="highlights" class="wrapper style3">
			<div class="container">
				<div class="row aln-center">
					<div class="col-4 col-12-medium">
						<section class="highlight">
							<h3><a href="NoticeList">&lt;공지사항&gt;</a></h3>
							<div class="board">
								<ul>
									<c:forEach var="notice" items="${noticeList}">
										<li><a href="NoticePost?notice_code=${notice.notice_code}">${notice.notice_subject}</a></li>
									</c:forEach>
								</ul>
							</div>
						</section>
					</div>
					<div class="col-4 col-12-medium">
						<section class="highlight">
							<h3><a href="FaqList">&lt;FAQ&gt;</a></h3>
							<div class="board">
								<ul>
									<c:forEach var="faq" items="${faqList}">
										<li><a href="FaqPost?faq_code=${faq.faq_code}">${faq.faq_subject}</a></li>
									</c:forEach>
								</ul>
							</div>
						</section>
					</div>
					<div class="col-4 col-12-medium">
						<section class="highlight">
							<h3><a href="EventList">&lt;이벤트&gt;</a></h3>
							<div class="board">
								<ul>
									<c:forEach var="event" items="${eventList}">
										<li><a href="EventPost?event_code=${event.event_code}">${event.event_subject}</a></li>
									</c:forEach>
								</ul>
							</div>
						</section>
					</div>
				</div>
			</div>
		</section>
	<jsp:include page="/WEB-INF/views/inc/main_bottom.jsp"></jsp:include>
	
</body>
</html>
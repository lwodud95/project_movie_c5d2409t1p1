<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="page-wrapper">    
	<section id="header" class="wrapper">
		<!-- Top Nav -->
		<div class="navbar"> 
			<div class="navbar-right"> 
				<a href="${pageContext.request.contextPath}">홈</a> 
				<a href="">로그인</a> 
				<a href="">로그아웃</a> 
				<a href="">회원가입</a> 
				<a href="#" onclick="openMypage()">마이페이지</a> 
				<a href="#" onclick="openAdminpage()">관리자페이지</a>
			</div>
		</div>

		<!-- Logo -->
			<div id="logo">
				<h1><a href="${pageContext.request.contextPath}">Escape Velocity</a></h1>
				<p>A free responsive site template by HTML5 UP</p>
			</div>

			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li>
						<a href="#">영화관안내</a>
						<ul>
							<li><a href="">영화관안내</a></li>
							<li><a href="">좌석배치도</a></li>
							<li><a href="">오시는길</a></li>
						</ul>
					</li>
					<li>
						<a href="SeasonMovieInfo">영화안내</a>
						<ul>
							<li><a href="SeasonMovieInfo">Season Movie</a></li>
							<li><a href="CurrentlyMovieInfo">현재상영작</a></li>
							<li><a href="UpcomingMovieInfo">상영예정작</a></li>
							<li><a href="PastMovieInfo">지난상영작</a></li>
						</ul>
					</li>
					<li>
						<a href="#">예매하기</a>
						<ul>
							<li><a href="#">상영시간표</a></li>
							<li><a href="#">예매하기</a></li>
							<li><a href="#">예매확인/취소</a></li>
						</ul>
					</li>
					<li>
						<a href="MoivePick">영화PICK</a>
						<ul>
							<li><a href="MoivePick">영화투표하기</a></li>
							<li><a href="MoivePickStatus">PICK 현황</a></li>
							<li><a href="MoivePickResult">PICK 결과보기</a></li>
						</ul>
					</li>
					<li>
						<a href="#">이벤트</a>
						<ul>
							<li><a href="#">이벤트목록</a></li>
							<li><a href="#">당첨자발표</a></li>
						</ul>
					</li>
					<li>
						<a href="#">고객센터</a>
						<ul>
							<li><a href="#">공지사항</a></li>
							<li><a href="#">자주하는문의</a></li>
						</ul>
					</li>
				</ul>
			</nav>
	</section>
	
	
<script>
    function openMypage() {
        window.open("MypageMain", "myPage", "width=1300,height=800, top=150, left=300, resizable=no");
    }
    
    function openAdminpage() {
        window.open("AdminpageMain", "Adminpage", "width=1300,height=800, top=150, left=300, resizable=no");
    }
</script>
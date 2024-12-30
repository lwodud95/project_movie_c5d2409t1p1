<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
	    <a class="navbar-brand ps-3" href="myPage.jsp">마이페이지</a>
	    <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
</nav>
<div id="layoutSidenav">
    <div id="layoutSidenav_nav">				
		<nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        	<div class="sb-sidenav-menu">
            	<div class="nav">
<!--                     결제내역 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapsePaymentHistory" aria-expanded="false" aria-controls="collapsePaymentHistory">
					    결제내역
				    	<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapsePaymentHistory" aria-labelledby="headingPaymentHistory" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPaymentHistory">
					        <a class="nav-link" href="">
					            예매내역
					        </a>
					        <a class="nav-link" href="">
					            취소내역
					        </a>
					    </nav>
					</div>
					
<!-- 					무비로그 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseMovieLog" aria-expanded="false" aria-controls="collapseMovieLog">
					    무비로그
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseMovieLog" aria-labelledby="headingMovieLog" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionMovieLog">
					        <a class="nav-link" href="">
					            내가본영화
					        </a>
					        <a class="nav-link" href="">
					            관람평
					        </a>
					    </nav>
					</div>
					
<!-- 					쿠폰 탭 -->
					<a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseCoupons" aria-expanded="false" aria-controls="collapseCoupons">
					    쿠폰
					    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
					</a>
					<div class="collapse" id="collapseCoupons" aria-labelledby="headingCoupons" data-bs-parent="#sidenavAccordion">
					    <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionCoupons">
					        <a class="nav-link" href="">
					            쿠폰등록
					        </a>
					        <a class="nav-link" href="">
					            쿠폰내역
					        </a>
					    </nav>
					</div>
					
<!-- 					포인트 탭 -->
					<a class="nav-link" href="">
					    포인트
					</a>
					
<!-- 					1:1문의 탭 -->
					<a class="nav-link" href="">
					    1:1문의
					</a>
					
<!-- 					회원정보관리 탭 -->
					<a class="nav-link" href="">
					    회원정보관리
					</a>
		
		
				</div>
			</div>
            <div class="sb-sidenav-footer">
            	<div class="small">Logged in as:</div>
                	Start Bootstrap
                </div>
		</nav>
	</div>
    <div id="layoutSidenav_content">
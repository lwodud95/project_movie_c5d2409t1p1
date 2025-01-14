<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>회원목록</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

<style type="text/css">
th, td {
	text-align: left !important;}
	
/* .tdForNumber { */
/* 	text-align: right !important;}	 */
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>회원 정보 조회</h3>
	<div id="divTop">
		<div id="divTopLeft">
			<input type="button" value="전체조회" id="listSearch">
			<input type="button" value="ID 조회" id="idSearch">
		</div>
		<div id="divTopRight"> <!--  우측 상단 검색란 -->
			<form action="MemberList" method="get">
				<input type="hidden" name="pageNum" value="${param.pageNum}">	
				<select name="searchKeyword">
					<option value="searchId">ID</option>
					<option value="searchEmail">이메일</option>
					<option value="searchPhone">연락처</option>
				</select>
				<input type="text" placeholder="검색어를입력하세요" name="searchContent">
				<input type="submit" value="검색" id="searchBtn">
<%-- 				<input type="hidden" value="${param.pageNum}" name="pageNum"> --%>
			</form>	
		</div>	
	</div>
	<div id="tableDiv">
		<table id="mainTable" border="1">
			<tr align="center" id="tr01">
				<th>가입일</th>
				<th>아이디</th>
				<th>이름</th>
				<th>생년월일</th>
				<th>이메일</th>
				<th>연락처</th>
				<th>성별</th>
				<th>관심장르</th>
				<th>문자<br>수신</th>
				<th>메일<br>수신</th>
				<th>정보<br>공개</th>
				<th>메일<br>인증</th>
				<th>번호<br>인증</th>
				<th>회원<br>유형</th>
				<th>포인트</th>
				<th>쿠폰</th>
				<th>상태</th>
			</tr>
			<c:choose>
				<c:when test="${empty voList}">
					<tr>
						<th colspan="17">등록된 회원이 없습니다</th>
					</tr>
				</c:when>
			<c:otherwise>
				<c:forEach var="member" items="${voList}" varStatus="status">
					<tr>
						<td><fmt:formatDate value="${member.regis_date}" pattern="yyyy-MM-dd"/></td>
						<td>${member.member_id}</td>
<%-- 						<th>${member.member_passwd}</th> --%>
						<td>${member.member_name}</td>
						<td><fmt:formatDate value="${member.birth_date}" pattern="yyMMdd"/></td>
						<td>${member.email}</td>
						<td>${member.phone}</td>
						<td>
							<c:if test="${member.gender eq 'M'}">
								남
							</c:if>
							<c:if test="${member.gender eq 'F'}">
								여
							</c:if>
						</td>
						<td>${member.gerne}</td>
						<td>
							<c:if test="${member.text_receive eq false}">
								거부
							</c:if>
							<c:if test="${member.text_receive eq true}">
								동의
							</c:if>
						</td>
						<td>
							<c:if test="${member.email_receive eq false}">
								거부
							</c:if>
							<c:if test="${member.email_receive eq true}">
								동의
							</c:if>
						</td>
						<td>
							<c:if test="${member.info_open eq false}">
								거부
							</c:if>						
							<c:if test="${member.info_open eq true}">
								동의
							</c:if>						
						</td>
						<td>
							<c:if test="${member.email_auth_status eq false}">
								미완
							</c:if>						
							<c:if test="${member.email_auth_status eq true}">
								완료
							</c:if>						
						</td>
						<td>
							<c:if test="${member.phone_auth_status eq false}">
								미완
							</c:if>						
							<c:if test="${member.phone_auth_status eq true}">
								완료
							</c:if>						
						</td>
						<td>
							<c:if test="${member.member_type eq '1'}">
								일반
							</c:if>
							<c:if test="${member.member_type eq '2'}">
								VIP
							</c:if>
						</td>
						<td class="tdForNumber">
							<fmt:formatNumber value="${member.remain_point}" type="number" />
						</td>
						<td class="tdForNumber">
							<fmt:formatNumber value="${member.coupon_num}" type="number" />
						</td>
						<td>
							<c:if test="${member.member_status eq '1'}">
								정상
							</c:if>						
							<c:if test="${member.member_status eq '2'}">
								정지
							</c:if>						
							<c:if test="${member.member_status eq '3'}">
								탈퇴
							</c:if>						
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
			</c:choose>
		</table>
	</div>
	<br>
	<div id="divBottom" class="view">
		<input type="button" value="처음으로" onclick="location.href='MemberList?pageNum=1'" <c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>> 
		<input type="button" value="이전" 
			onclick="location.href='MemberList?pageNum=${pageInfo.pageNum - 1}'" 
			<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
		<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			<c:choose>
				<c:when test="${i eq pagInfo.pageNum}">
					<strong>${i}</strong>
				</c:when>
				<c:otherwise>
					<a href="MemberList?pageNum=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<input type="button" value="다음" onclick="location.href='MemberList?pageNum=${pageInfo.pageNum + 1}'"
		<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
		<input type="button" value="마지막으로" onclick="location.href='MemberList?pageNum=${pageInfo.maxPage}'"
		<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
	</div>
	<hr>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
	<script type="text/javascript">
	$(function(){
		$("#listSearch").on("click", function(){
			alert("전체 목록을 출력했습니다.");
		});
		
		$("#idSearch").on("click", function(){
			window.open(                
				'AdminPageIdSearch', // 팝업 창에 로드할 파일
	            'ID 조회',    // 팝업 창 이름
	            'width=300,height=150,scrollbars=no,resizable=no');
		});	
	});
	</script>
</body>
</html>
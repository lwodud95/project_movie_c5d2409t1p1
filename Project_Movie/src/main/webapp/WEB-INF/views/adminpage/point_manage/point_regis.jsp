<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>포인트 지급</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>

	<form action="GivePoint" method="post" id="givePointForm" novalidate>
		<div id="tableDiv" class="view" style="overflow-x: auto;">
		<h3>포인트 지급</h3>
			<fieldset>
				<table class="mainTable"> 
					<tr class="tr01" id="tr02">
						<th>포인트 금액</th>
					</tr>
					<tr>
						<td>
							<input type="text" maxlength="5" name="point_amount" id="point_amount" value="0" placeholder="금액 입력" >
							<span>1~99,999 사이 입력</span>
						</td>
					</tr>
				</table>			
			</fieldset>
			<div id="couponSet">
				<input type="submit" value="지급하기">
				<input type="button" value="돌아가기" id="cancel">
			</div>
			<h3>포인트 지급 대상자</h3>
			<fieldset> <!--  지급 대상자 출력 항목 -->
				<table id="mainTable" class="mainTable">
					<tr align="center" id="tr01" class="tr01">
<!-- 						<th><input type="checkbox" id="selectAll"></th> -->
<!-- 						<th>이벤트번호</th> -->
						<th width="150">순서</th>
						<th>아이디</th>
					</tr>
					<c:choose>
						<c:when test="${empty member_id}">
							<tr>
								<th colspan="3">"선택된 대상자가 없습니다"</th>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="id" items="${member_id}" varStatus="status">
								<tr>
									<td>
										${status.count}
									</td>
									<td>
										<input type="hidden" name="event_code" value="${event_code}">
										<input type="hidden" name="member_id" value="${id}">
										${id}
									</td>
								</tr>	
							</c:forEach>
						</c:otherwise>
					</c:choose> 
				</table>
			</fieldset>
		</div>
	</form>
	<br>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	// 포인트 지금 폼 제출 시 검증
	$("#givePointForm").on("submit", function(e){
		let value = $("#point_amount").val().trim();
		let regex = /^[1-9][0-9]{0,4}$/;
		
		e.preventDefault();
		if($("#point_amount").val().trim() === "" || parseInt($("#point_amount").val().trim(), 10) <= 0) {
			 alert("포인트 금액(1~99999)을 입력해주세요.");
			 $("#point_amount").focus();
			 return;
		}
		
		if(!regex.test(value)) {
			 alert("포인트 금액(1~99999)을 숫자로만 입력해주세요.");
			 $("#point_amount").focus();
			 return;
		}
		this.submit();
	});
})
</script>
</body>
</html>
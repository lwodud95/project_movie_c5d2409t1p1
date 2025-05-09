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
	<title>쿠폰 지급</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>

	<form action="GiveCoupon" method="post" id="giveCouponForm">
		<div id="tableDiv" class="view" style="overflow-x: auto;">
		<h3>쿠폰 지급</h3>
			<fieldset> <!--  할인쿠폰 / 금액쿠폰 선택 영역  -->
				<table class="mainTable"> 
					<tr class="tr01" id="tr02">
						<th>만료일</th>
						<th>쿠폰타입</th>
						<th id="thForDiscount"></th>
					</tr>
					<tr>
						<td>
							<input type="date" name="expired_date" id="expired_date" required>
						</td>
						<td> <!--  할인율/금액할인 선택 -->
							<select id="coupon_type" name="coupon_type" required>
								<option>선택</option>
								<option>금액할인</option>
								<option >할인율</option>
							</select>
						</td>
						<td> <!-- 할인율 혹은 할인금액 입력!! -->
							<select id="discount_rate" name="discount_rate" class="discount_rate" hidden>
								<option value="0" selected>선택</option>
								<option>10</option>
								<option>20</option>
								<option>30</option>
								<option>40</option>
								<option>50</option>
								<option>60</option>
								<option>70</option>
								<option>80</option>
								<option>90</option>
								<option>100</option>
							</select>
							<input type="text" maxlength="5" id="discount_amount" name="discount_amount" value="0" placeholder="금액 입력" class="discount_amount" hidden>
						</td>
					</tr>
				</table>			
			</fieldset>
			<div id="couponSet">
				<input type="submit" value="지급하기">
				<input type="button" value="돌아가기" id="cancel">
			</div>
			<h3>당첨자</h3>
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
	let time = new Date();
	time.setHours(time.getHours() + 9); // UTC+9 적용
	let today = time.toISOString().split('T')[0];
// 	let today2 = time.toLocaleString();
	console.log("today : " + today);
// 	console.log("today2 : " + today2);
	$("#expired_date").attr("min", today);

	// 쿠폰 지급 폼 제출 시 검증
	$("#giveCouponForm").on("submit", function(e){
		  e.preventDefault();
		// 날짜 미입력 검증
		if($("#expired_date").val() === "") {
			 alert("날짜를 입력해주세요.");
			 $("#expired_date").focus();
			 return;
		}
		
		// 쿠폰 타입 선택 검증
		if($("#coupon_type").val() === "선택") {
			 alert("쿠폰  타입을 선택해주세요.");
			 $("#coupon_type").focus();
			 return;
		}
		
		// 금액할인 선택 시 입력 여부 및 입력 값이 0인지 검증
		if($("#coupon_type").val() === "금액할인") {
			let value = $("#discount_amount").val().trim();
			let regex = /^[1-9][0-9]{0,4}$/;
			
			$("#discount_rate").val("0"); // 금액할인 선택 시 할인율 값은 0으로 설정하여 값이 중복으로 넘어가지 못하게 설정
			if($("#discount_amount").val().trim() === "" || $("#discount_amount").val().trim() <= "0") {
				 alert("할인금액(1~99,999)을 입력해주세요.");
				 $("#discount_amount").focus();
				 return;
			}
			if(!regex.test(value)) {
				alert("할인금액(1~99,999)을 숫자로만 입력해주세요.");
				$("#discount_amount").focus();
				return;
			}
		// 할인율 선택 시 할인비율 선택 검증
		} else if($("#coupon_type").val() === "할인율") {
			$("#discount_amount").val("0"); // 금액할인 선택 시 할인율 값은 0으로 설정하여 값이 중복으로 넘어가지 못하게 설정
			if($("#discount_rate").val() === "0") {
				 alert("할인율을 선택해주세요.");
				 $("#discount_rate").focus();
				 return;
			}
		}
		this.submit();	
 	});
});
</script>
</body>
</html>
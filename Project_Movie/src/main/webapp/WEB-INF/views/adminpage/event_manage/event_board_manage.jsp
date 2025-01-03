<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<title>이벤트관리</title>
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_styles.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/adminpage_account_manage.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/adminpage/event.css" rel="stylesheet" />
	<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/account_manage.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/resources/js/adminpage/event.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_sidebar.jsp"></jsp:include>
	
	<h3>이벤트 관리</h3>
	<div id="divTop" class="view">
		<div id="divTopLeft">
			<input type="button" value="전체선택" id="selectAll">
			<input type="button" value="등록하기" id="board_regis">
<!-- 			<input type="button" value="수정하기" id="board_modify"> -->
<!-- 			<input type="button" value="삭제하기" id="delete"> -->
			<input type="button" id="eventStart" value="이벤트 시작">
			<input type="button" id="eventEnd" value="이벤트 종료">
			<input type="button" id="chooseEventWinner" value="이벤트 당첨자 추첨">
		</div>	
		<div id="divTopRight">
			<select>
				<option>제목+내용</option>
				<option>제목</option>
				<option>내용</option>
			</select>
			<input type="text" placeholder="검색어를입력하세요"> <input type="button" value="검색" id="searchBtn">
		</div>	
	</div>
	<div id="tableDiv" class="view" style="overflow-x: auto;">
		<table id="mainTable">
			<tr align="center" id="tr01">
				<th width="50">선택</th>
<!-- 				<th width="70">번호</th> -->
				<th width="50">번호</th>
				<th width="350">제목</th>
				<th width="150">등록일자</th>
				<th width="150">시작일자</th>
				<th width="150">종료일자</th>
				<th width="150">등록계정</th>
				<th width="150">상태</th>
			</tr>
			<c:choose>
				<c:when test="${empty eventVo}">
					<tr>
						<th colspan="8">"작성된 게시글이 없습니다."</th>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="eventBoard" items="${eventVo}" varStatus="status">
						<tr>
							<td><input type="checkbox" class="eventSetCheckbox" value="${eventBoard.event_code}"></td>
<%-- 							<td>${status.count}</td> --%>
							<td>${eventBoard.event_code}</td>	
							<td><a href="updateEventBoard?event_code=${eventBoard.event_code}">${eventBoard.event_subject}</a></td>	
							<td>${eventBoard.regis_date}</td>	
							<td>${eventBoard.event_start_date}</td>	
							<td>${eventBoard.event_end_date}</td>	
							<td>${eventBoard.event_writer}</td>	
							<td>
								<c:if test="${eventBoard.event_status == 0}">
										미진행
								</c:if>
								<c:if test="${eventBoard.event_status == 1}">
										진행중
								</c:if>
								<c:if test="${eventBoard.event_status == 2}">
										종료
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
		<a href="#">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
		<a href="#">4</a>
		<a href="#">5</a>
	</div>
	<jsp:include page="/WEB-INF/views/inc/adminpage_mypage/adminpage_mypage_bottom.jsp"></jsp:include>
	
	<script type="text/javascript">
// 		$("#chooseEventWinner").on("click", function(){
// 			let eventSetCheckbox = $(".eventSetCheckbox:checked"); 
// 			let setWinner = [];

// 			if(eventSetCheckbox.length > 0) {
// 				eventSetCheckbox.each(function(){
// 					setWinner.push($(this).val());
// 					console.log(setWinner);
// 				});
// 			}
// 			if(confirm("당첨자 추첨을 완료하시겠습니까?")) {
// 				location.href="ChooseEventWinner?event_code=" + setWinner.join(",");
// 			}
// 			else {
// 				alert("당첨자를 선택하세요");
// 			}
// 		});
	</script>
</body>
</html>
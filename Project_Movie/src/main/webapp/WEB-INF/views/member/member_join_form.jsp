<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%-- 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/member_join_form.css" /> --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/member_join_form.css" />
</head>
<body class="left-sidebar is-preload">

	<jsp:include page="/WEB-INF/views/inc/page/page_top.jsp"></jsp:include>
	
	<jsp:include page="/WEB-INF/views/inc/page/member_sidebar.jsp"></jsp:include>
	
	<article class="box post">
		 <div class="container">
    <h1>회원가입</h1>
    <hr class="section-line"> <!-- 실선 추가 -->

    <!-- 실선 밑 여백 추가 -->
    <div class="spacer"></div> 

    <!-- 회원가입 폼 -->
<!--        <form id="registerForm" action="http://localhost:8081/project_movie/" method="post"> -->
   <form id="registerForm" action="http://localhost:8081/project_movie/" method="get">
      <!-- 아이디 입력 -->
      <table class="form-table">
        <!-- 아이디 입력 -->
		<tr>
		  <th>아이디 *</th> <!-- 필수 입력 항목 -->
		  <td>
		    <input type="text" id="username" name="username" placeholder="영문자,숫자,_ 5자리이상" required>
		    <button type="button">확인</button>
		  </td>
		</tr>
        <tr>
          <th>비밀번호 *</th>
          <td><input type="password" id="password" name="password" placeholder="영문자,숫자,특수문자(!@#$%) 8글자이상" required></td>
        </tr>
        <tr>
          <th>비밀번호 확인 *</th>
          <td><input type="password" id="confirm-password" name="confirm-password" placeholder="비밀번호 확인 입력" required></td>
        </tr>
      </table>

      <!-- 이름, 생년월일, 이메일, 전화번호, 성별 -->
      <table class="form-table">
        <tr>
          <th>이름 *</th>
          <td><input type="text" id="name" name="name" placeholder="이름 입력" required></td>
        </tr>
        <tr>
          <th>생년월일 *</th>
          <td><input type="date" id="birthdate" name="birthdate" required></td>
        </tr>
        <tr>
          <th>이메일 *</th>
          <td>
            <input type="email" id="email" name="email" placeholder="이메일 입력" required>
            <button type="button">발송</button>
            <input type="text" id="email-code" name="email-code" placeholder="인증번호 입력">
            <button type="button">확인</button>
          </td>
        </tr>
        
              <!-- 전화번호 -->
      <tr>
        <th>전화번호 *</th>
        <td>
          <input type="text" id="phone" name="phone" placeholder="숫자 입력" required>
          <button type="button">발송</button>
          <input type="text" id="phone-code" name="phone-code" placeholder="인증번호 입력">
          <button type="button">확인</button>
        </td>
      </tr>
      
      <!-- 성별 -->
	<tr>
	  <th>성별</th>
	  <td>
	    <div class="gender-options">
	      <label><input type="radio" id="gender-m" name="gender" value="M"> 남성</label>
	      <label><input type="radio" id="gender-f" name="gender" value="F"> 여성</label>
	      <label><input type="radio" id="gender-none" name="gender" value="N"> 선택안함</label>
	   </div>
    </td>
	</tr>
      </table>
      
      <!-- 관심장르 및 수신 여부 -->
      <table class="form-table">
        <!-- 관심장르 -->
        <tr>
          <th>관심장르</th>
          <td>
            <input type="text" id="genre" name="genre" placeholder="관심 장르 입력">
          </td>
        </tr>
        
        <!-- 문자 수신 여부 -->
        <tr>
          <th>문자 수신 여부 (선택)</th>
          <td>
            <label><input type="checkbox" id="sms-receive" name="sms-receive"> 휴대폰 문자를 받겠습니다</label>
          </td>
        </tr>
      
        <!-- 이메일 수신 여부 -->
        <tr>
          <th>이메일 수신 여부 (선택)</th>
          <td>
            <label><input type="checkbox" id="email-receive" name="email-receive">정보메일을 받겠습니다</label>
          </td>
        </tr>
      
        <!-- 정보 공개 여부 -->
        <tr>
          <th>정보 공개 여부 (선택)</th>
          <td>
            <label><input type="checkbox" id="info-open" name="info-open"> 다른분들이 나의 정보를 볼수있게 합니다.</label>
          </td>
        </tr>
      
        <!-- 자동 등록 방지 -->
	 <tr>
	  <th>자동 등록 방지 *</th>
	  <td>
	    <img src="${pageContext.request.contextPath}/resources/images/captcha.png" alt="captcha">
	    <input type="text" id="captcha" name="captcha" placeholder="입력" required>
	  </td>
	</tr>
      </table>

      <!-- 제출 버튼 -->
<!--       <div class="button-group"> -->
<!--         <button type="submit">회원가입</button> -->
<!--         <button type="reset" class="cancel-btn">취소</button> -->
<!--       </div> -->
      <div class="button-group">
	    <button type="submit" class="btn submit-btn">* 회원가입 *</button>
	    <button type="button" id="cancel-btn" class="btn cancel-btn">취소</button>
	 </div>
    </form>
  </div>
	
	
<%-- 		<jsp:include page="/WEB-INF/views/member/member_join_form_test.jsp"></jsp:include> --%>
	</article>

	<jsp:include page="/WEB-INF/views/inc/page/page_bottom.jsp"></jsp:include>
	<script src="${pageContext.request.contextPath}/resources/js/member/member_join_form.js"></script>
</body>
</html>

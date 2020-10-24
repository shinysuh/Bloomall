<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<title>로그인</title>
<script type="text/javascript" src="/js/member/join.js"></script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
		<%@include file="/WEB-INF/views/include/main_header.jsp" %>

		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/views/include/left_sidebar.jsp" %>
		
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					JOIN US
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/"><i class="fa fa-dashboard"></i>Home</a>
					</li>
					<li>Join</li>
				</ol>
			</section>
			
			
		<!-- Carousel -->
		<div class="container">
		    <div class="row">
		      	<div class="col-lg">
				<%@include file="/WEB-INF/views/include/crousel.jsp" %>
				</div>
			</div>
		</div>
		
		
			<!-- Main content -->
			<section class="content container-fluid">
				
				<div class="container" style="width: 70%; min-width: 900px; background-color: white; font-size: 14px;" >
					<form id="joinFrm" action="/member/join" method="post">
						<div class="container" style="width: 800px; padding: 10% 5%;">
							<h4>회원가입</h4>
							* 아래 항목을 작성해 주세요.<br><br><br>
							<div class="form-group" style="width:100%;">
								<label for="mem_id">* 아이디</label><br>
								<input type="text" class="form-control" id="mem_id" name="mem_id" placeholder="아이디를 입력해 주세요"
									style="max-width:540px; width:calc(100% - 100px); margin-right: 5px; display: inline-block;">
								<button type="button" id="btnConfirmId" class="btn btn-default">중복확인</button>
								<p id="id_availability" style="color: red;"></p>
							</div>
							<div class="form-group">
								<label for="mem_pw">* 비밀번호</label>
								<input type="password" class="form-control" id="mem_pw" name="mem_pw"
									placeholder="비밀번호를 입력해 주세요" style="max-width: 630px;">
							</div>
							<div class="form-group">
								<label for="mem_pw_chk">* 비밀번호 확인</label>
								<input type="password" class="form-control" id="mem_pw_chk"
									placeholder="비밀번호를 다시 한 번 입력해 주세요" style="max-width: 630px;" >
							</div>
							<div class="form-group">
								<label for="mem_name">* 이름</label>
								<input type="text" class="form-control" id="mem_name" name="mem_name"
									placeholder="이름을 입력해 주세요" style="max-width: 630px;">
							</div>
							<div class="form-group">
								<label for="mem_nick">* 닉네임</label>
								<input type="text" class="form-control" id="mem_nick" name="mem_nick"
									placeholder="사용할 닉네임을 입력해 주세요" style="max-width: 630px;">
							</div>
							<div class="form-group">
								<label for="mem_email">* 이메일 주소</label><br>
								<input type="email" class="form-control" id="mem_email" name="mem_email"
									placeholder="이메일 주소를 입력해 주세요" style="max-width: 526px; width:calc(100% - 115px);
									 margin-right: 5px; display: inline-block;">
								<button type="button" id="btnRequestCode" class="btn btn-default" >인증코드요청</button>
								<p id="authcode_status" style="color: red;"></p>
							</div>
							<!-- 이메일 인증 요청을 하고 , 성공적으로 진행이 되면, 아래 div태그가 보여진다. -->
							<div id="email_authcode" class="form-group" style="display: none;">
								<label for="mem_authcode">* 이메일 인증코드</label><br> 
								<input type="text" class="form-control" id="mem_authcode" placeholder="이메일 인증코드를 입력해 주세요" 
									style="max-width: 570px; width:calc(100% - 70px); margin-right: 5px; display: inline-block;" />
								<button id="btnConfirmCode" class="btn btn-default" type="button" >인증하기</button>
							</div>
							<div class="form-group">
								<label for="mem_tel">* 휴대폰 번호</label>
								<input type="tel" class="form-control" id="mem_tel" name="mem_tel"
									placeholder="휴대폰 번호를 입력해 주세요" style="max-width: 630px;">
							</div>
							<div class="form-group">
								<label for="mem_zip">* 주소</label><br>
								<input type="text" id="sample2_postcode" name="mem_zip" class="form-control" 
									style="max-width: 510px; width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호" readonly>
								<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기"><br>
								<input type="text" id="sample2_address" name="mem_addr" class="form-control" placeholder="주소" style="max-width: 630px; margin:3px 0px;" readonly>
								<input type="text" id="sample2_detailAddress" name="mem_addr_d" class="form-control" placeholder="상세주소" style="max-width: 630px;">
								<input type="hidden" id="sample2_extraAddress" class="form-control" 
									placeholder="참고항목">
								
							</div>
							<div class="form-group">
								<label>* 수신 동의</label><br /> 
								이벤트 등 프로모션 메일 알림 수신에 동의합니다.
								<label><input type="radio" name="mem_email_accp" value="Y" style="margin-left: 20px;" checked="checked"> 예</label>
	      						<label><input type="radio" name="mem_email_accp" value="N" style="margin-left: 20px;"> 아니오</label>
							</div>
						</div>
						<div class="form-group text-center">
							<button type="button" id="btnRegister" class="btn btn-primary">
								회원가입 <i class="fa fa-check spaceLeft"></i>
							</button>
							<button type="button" id="btnCancel" class="btn btn-warning">
								가입취소 <i class="fa fa-times spaceLeft"></i>
							</button>
						</div>
						<br><br><br><br>
					</form>
				</div>


				<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
				<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
				<!-- 우편번호 API 자바스크립트 -->
				<%@include file="/WEB-INF/views/include/zipcode.jsp" %>


			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="/WEB-INF/views/include/footer.jsp" %>

		<!-- Control Sidebar -->
		<%@include file="/WEB-INF/views/include/control_sidebar.jsp" %>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

</body>
</html>
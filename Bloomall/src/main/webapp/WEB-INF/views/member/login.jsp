<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<title>로그인</title>
<script>
if ('${msg}' == "LOGIN_FAIL") {
    alert("로그인에 실패했습니다. \n아이디와 비밀번호를 다시 확인해 주세요.");
}
</script>
<script type="text/javascript" src="/js/member/login.js"></script>
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
					LOGIN <small>회원 로그인</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/"><i class="fa fa-dashboard"></i>Home</a>
					</li>
					<li>Login</li>
				</ol>
			</section>
		
			<!-- Main content -->
			<section class="content container-fluid">
				<div class="container" style="width: 450px; height:420px; background-color: white; margin-top:30px;">
					<form id="loginForm" class="form-signin" action="/member/loginOk" method="post" style="padding:50px 30px;">
						<h2 class="form-signin-heading">Sign in</h2>
						<br><br>
						<input type="text" id="mem_id" name="mem_id" class="form-control" style="margin-bottom: 15px"
							placeholder="User Name" required autofocus> 
						<input type="password" id="mem_pw" name="mem_pw" class="form-control"
							placeholder="Password" required>
						<br><br>
						<button type="button" id="btnLogin" class="btn btn-lg btn-primary btn-block">
							로그인
						</button>
					</form>
				</div>
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
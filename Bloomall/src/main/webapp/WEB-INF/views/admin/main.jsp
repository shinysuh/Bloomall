<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<!-- header -->
<%@include file="/WEB-INF/views/include/header.jsp" %>
<!-- REQUIRED JS SCRIPTS -->
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>

<script>
	if("${msg}" == "ADMIN_LOGIN_SUCCESS"){
		alert("로그인 되었습니다.");		
	}else if("${msg}" == "ADMIN_LOGOUT_SUCCESS"){
		alert("로그아웃 되었습니다");		
		
	}else if("${msg}" == "ADMIN_LOGIN_FAIL"){
		alert("관리자 로그인이 거부되었습니다. \n로그인 정보를 다시 확인하세요.");		
		
	}
</script>
<script type="text/javascript" src="/js/admin/login.js"></script>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
		<%@include file="/WEB-INF/views/include/main_header_ad.jsp" %>

		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/views/include/left_sidebar_ad.jsp" %>
		

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Admin Home
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/"><i class="fa fa-dashboard"></i> Admin Home</a>
					</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<!--| Your Page Content Here |-->
				<%-- 로그인 안된 상태 --%>
				<c:if test="${sessionScope.admin == null }">
					<h5	>쇼핑몰 관리를 위해 로그인 해주세요</h5><br>
					<div class="container" style="width: 450px; height:420px; background-color: white; margin-top:30px;">
					<form id="AdminLoginForm" class="form-signin" action="/admin/login" method="post" style="padding:50px 30px;">
						<h2 class="form-signin-heading">Sign in</h2>
						<br><br>
						<input type="text" id="ad_id" name="ad_id" class="form-control" style="margin-bottom: 15px"
							placeholder="Admin Name" required autofocus> 
						<input type="password" id="ad_pw" name="ad_pw" class="form-control"
							placeholder="Password" required>
						<br><br>
						<button type="button" id="btnLogin" class="btn btn-lg btn-primary btn-block">
							로그인
						</button>
					</form>
				</div>
					
				</c:if>		
				<%-- 로그인 한 상태 --%>
				<c:if test="${sessionScope.admin != null }">
					<div style="margin-top:80px;">
						<h3>관리자 페이지</h3><br>
						<h5><a href="/admin/menu">관리자 메뉴로 이동</a></h5>
					</div>
				</c:if>		

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
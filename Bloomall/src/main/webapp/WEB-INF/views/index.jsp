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
	if("${msg}" == "MEM_REGISTER_SUCCESS"){
		alert("회원가입 되었습니다. \n로그인 해주세요");
		
	}else if("${msg}" == "LOGIN_SUCCESS"){
		alert("로그인 되었습니다.");		
		
	}else if("${msg}" == "LOGOUT_SUCCESS"){
		alert("로그아웃 되었습니다");		
		
	}else if("${msg}" == "MODIFY_INFO_SUCCESS"){
		alert("회원정보가 수정되었습니다.");		
		
	}else if("${msg}" == "PW_UPDATE_SUCCESS"){
		alert("비밀번호가 변경되었습니다.");		
		
	}else if("${msg}" == "DELETE_MEMBER_SUCCESS"){
		alert("회원탈퇴 되었습니다.");		
	}
</script>


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
					Home
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/"><i class="fa fa-dashboard"></i> Home</a>
					</li>
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
				<!--| Your Page Content Here |-->
				<%-- 로그인 안된 상태 --%>
				<c:if test="${sessionScope.user == null }">
					<h4>쇼핑몰 이용을 위해 로그인 해주세요</h4><br>
					<h5><a href="/member/login">로그인 페이지로 이동</a></h5>
				</c:if>		
				<%-- 로그인 한 상태 --%>
				<c:if test="${sessionScope.user != null }">
					<div style="margin-top:80px;">
						<h4>환영합니다!</h4><br>
						<h5>원하는 메뉴를 클릭해주세요</h5>
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
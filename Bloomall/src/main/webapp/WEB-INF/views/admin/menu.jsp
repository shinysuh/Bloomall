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
					Admin Menu
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/"><i class="fa fa-dashboard"></i> Admin Menu</a>
					</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<div style="margin-top:80px;">
					<h4>관리자 페이지</h4><br>
					<h5>관리할 메뉴를 클릭해주세요</h5>
					
					<br><br><br>
					<h5> 카테고리 관리 / 상품관리 / 주문관리 / 공지사항 / 게시판 관리  </h5>
					
					
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
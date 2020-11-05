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
<head>
<style type="text/css">
.item{
	width:300px;
	height: 100px;
	border: 1px solid rgb(221, 220, 220);
	border-collapse: collapse;
	margin: 2%;
	display:inline-block;
	text-align:center;
	background-color:white;

}
a:link, a:visited {
	color:rgb(83, 83, 83);
}
a:hover {
	color:black;
	font-weight:bold;
}
a:active {
	color: rgb(100, 161, 202);
	font-weight: bold;
}
</style>
</head>
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
					Admin Menu <small>관리자 메뉴</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/admin/menu"><i class="fa fa-dashboard"></i> Admin Menu</a>
					</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<section class="content container-fluid">
				<%-- 로그인 안된 상태 --%>
				<div style="margin-top:80px;">
				<c:if test="${sessionScope.admin == null }">
					<h4>쇼핑몰 이용을 위해 로그인 해주세요</h4><br>
					<h5><a href="/admin/main">로그인 페이지로 이동</a></h5>
				</c:if>		
				<%-- 로그인 한 상태 --%>
				<c:if test="${sessionScope.admin != null }">
				<div class="row">
					<h4>관리할 메뉴를 선택하세요.</h4><br>
				<div class="col-md-9" style="width:70%; min-width:300px; padding: 50px 180px;" class="container text-center">
					<div class="col-sm-1"></div>
					<ul class="col-sm-11 items" style="list-style:none;">
						<a href="/admin/product/list"><li class="item"><br><br>상품관리</li></a><br>
						<a href="/admin/order/orderList"><li class="item"><br><br>주문관리</li></a>
						<br>
						<a href="#"><li class="item"><br><br>회원관리</li></a><br>
						<a href="#"><li class="item"><br><br>게시판 관리</li></a>
					</ul>
				</div>
				</div>
				</c:if>		
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
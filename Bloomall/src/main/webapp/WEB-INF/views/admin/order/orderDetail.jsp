<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<script type="text/javascript" src="/js/admin/login.js"></script>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="/WEB-INF/views/include/main_header_ad.jsp" %>
		<%@include file="/WEB-INF/views/include/left_sidebar_ad.jsp" %>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Order Management <small>주문관리</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/admin/menu"><i class="fa fa-dashboard"></i> Admin</a>
					</li>
					<li>
						Order
					</li>
					<li>
						Management
					</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				
				주문번호(주문상품) / 주문자 / 수령자 / 결제(수단) / 금액 / [처리상태(주문접수(1) / 배송준비중(2) / 배송중(3) / 배송완료(4))]





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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="/WEB-INF/views/include/main_header.jsp" %>
		<%@include file="/WEB-INF/views/include/left_sidebar.jsp" %>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Order <small>주문완료</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> Order</a>
					</li>
					<li>
						Order Complete
					</li>
					
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
				<div class="box" style="border: none; padding:200px 50px; text-align: center;">
					<div class="box-body"  >
						<h3>주문번호 <b>${ord_idx}</b>의 주문이 완료되었습니다.</h3><br>
						<div id="orderHistory" style="text-align:center;">
							<a href="/order/orderDetail?ord_idx=${ord_idx}"><button type="button" class="btn btn-default" id="orderAll">주문내역 확인하기</button></a>
							<a href="/cart/list"><button type="button" class="btn btn-default" id="goToCart">장바구니 가기</button></a>
							<a href="/product/list?ctgr_cd=all"><button type="button" id="goToListAll" class="btn btn-default">쇼핑 계속하기</button></a>
						</div>
					</div>
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
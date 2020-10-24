<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<script type="text/javascript" src="/js/member/updatePW.js"></script>
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
					비밀번호 변경
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i>마이페이지</a>
					</li>
					<li>비밀번호 변경</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
				<div style="background-color: white; width:40%; padding: 5% 5%;">
					<form id="updatePwFrm" method="post" action="/member/updatePW">
						<div class="form-group">
							<input type= "hidden" name="mem_id" value="${sessionScope.user.mem_id}" />
							
							<input type="password" class="form-control" id="mem_pw" class="form-control"
								placeholder="현재 비밀번호" autofocus style="max-width: 400px;">
							
							<input type="password" class="form-control" id="mem_pw_updated" name="mem_pw" class="form-control"
								placeholder="새 비밀번호" style="max-width: 400px; margin: 7px 0px;">
							
							<input type="password" class="form-control" id="mem_pw_chk" class="form-control"
								placeholder="새 비밀번호 재입력" style="max-width: 400px;">
						</div>
						<div class="form-group">
							<input type="button" id="btnOK" class="btn btn-primary" value="확인">
						</div>
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
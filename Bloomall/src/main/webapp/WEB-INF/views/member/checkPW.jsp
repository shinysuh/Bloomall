<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<script>

if('${msg}' == "NOT_CORRECT_PASSWORD"){
	alert('비밀번호를 다시 확인해주세요.');
}

$(function(){
	var form = $("#checkPWFrm");
	
	$("#btnOK").click(function(){
		if($("#mem_pw").val() == null || $("#mem_pw").val() == ""){
			alert("비밀번호를 입력하세요.");
		}else{		
			form.submit();
		}
	});
	
	
});
</script>
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
					비밀번호 확인
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i>마이페이지</a>
					</li>
					<li>비밀번호 확인</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
				<div style="background-color: white; width:40%; padding: 5% 5%;">
					<form id="checkPWFrm" method="post" action="/member/checkPW">
						<div class="form-group">
							<!-- /* url에 따라 [회원정보수정-modify]/[비밀번호변경-updatePW]/[회원탈퇴-delete] 페이지로 각각 넘어가는 기능 */ -->
							<input type="hidden" name="url" value="${url}" />
							<input type="password" class="form-control" id="mem_pw" name="mem_pw" class="form-control"
								placeholder="비밀번호를 입력해주세요" autofocus style="max-width: 400px;">
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
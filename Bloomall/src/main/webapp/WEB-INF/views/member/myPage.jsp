<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>

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
					My Page <small>마이페이지</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/member/myPage"><i class="fa fa-dashboard"></i> 마이페이지</a>
					</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<%-- 로그인 안된 상태 --%>
				<c:if test="${sessionScope.user == null }">
					<h4>쇼핑몰 이용을 위해 로그인 해주세요</h4><br>
					<h5><a href="/member/login">로그인 페이지로 이동</a></h5>
				</c:if>		
				<%-- 로그인 한 상태 --%>
				<c:if test="${sessionScope.user != null }">
					<ul>
						<li><a href="/member/checkPW?url=modify">회원정보 수정</a></li>
						<li><a href="/member/checkPW?url=updatePW">비밀번호 변경</a></li>
						<li><a href="/member/checkPW?url=delete">회원 탈퇴</a></li>
					</ul>
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
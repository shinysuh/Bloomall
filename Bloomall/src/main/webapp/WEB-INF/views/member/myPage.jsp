<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
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
				<div class="row">
				<div class="col-md-10" style="width:80%; min-width:300px; background-color:white; padding: 50px 180px;" class="container text-center">
					<div class="col-sm-12 member_info">
						<table style="text-align:left;">
							<tr>
								<td style="font-size:16px;">${vo.mem_name }님의 회원등급은 <b>[Member]</b>입니다.</td>
							</tr>					
							<tr>
								<td>가용 포인트 : ${vo.mem_point }</td>
							</tr>					
						</table>
					</div>
					<br><br><br><br>
					<div class="col-sm-1"></div>
					<ul class="col-sm-11 items" style="list-style:none;">
						<a href="/order/orderHistory"><li class="item"><br><br>주문내역</li></a>
						<a href="/member/checkPW?url=modify"><li class="item"><br><br>회원정보 수정</li></a>
						<br>
						<a href="/member/checkPW?url=updatePW"><li class="item"><br><br>비밀번호 변경</li></a>
						<a href="/member/checkPW?url=delete"><li class="item"><br><br>회원 탈퇴</li></a>
					</ul>
				</div>
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
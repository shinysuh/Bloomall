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
					Order Stat <small>주문통계</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/admin/menu"><i class="fa fa-dashboard"></i> Admin</a>
					</li>
					<li>
						Order
					</li>
					<li>
						Stat
					</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<div class="col-sm-10">	
				<div class="box" style="border: none;">
					<div class="box-body">
						<div style="color:green;"><b>&#9660; 매출통계</b> <small>월별 주문,입금,배송을 조회합니다.</small></div>
						<!-- 기간설정 -->
						<div class="col-sm-12">
							<table class="table table-striped text-center" id="table_2">
								<tr>
									<td class="col-sm-2" style="font-weight:bold;">기간설정</td>
									<td>
										<jsp:useBean id="selectDate" class="java.util.Date" />
										<fmt:formatDate value="${selectDate}" pattern="yyyy-MM-dd" var="selectDateStr"/>
										<fmt:parseNumber value="${selectDateStr.toString().substring(0,4)}" type="NUMBER" var="thisYear" />
										<select class="form-control" id="year" name="year" style="width: 170px; display: inline-block; float:left;">
											<c:forEach begin="2018" end="${thisYear}" var="i">
												<option value="${i}">${i}</option>
											</c:forEach>
										</select>
										<select class="form-control" id="month" name="month" style="width: 170px; display: inline-block; float:left;">
											<c:forEach begin="1" end="12" var="i">
												<option value="${i}">${i}</option>
											</c:forEach>
										</select>
										<button type="button" id="btnSearch" class="btn btn-default" style="float:left;margin-left:5px;">검색</button>
									</td>
								</tr>
							</table>
						</div>
						
						<!-- 주문통계 테이블 -->
						<table class="table table-striped text-center">
							<tr>
								<th>일별통계</th>
								<th>주문건수</th>
								<th>주문금액</th>
								<th>결제건수</th>
								<th>결제금액</th>
								<th>배송건수</th>
								<th>배송중/배송완료</th>
								<th>매입금액</th>
								<th>순매출액</th>
							</tr>


						  <c:forEach items="" var="" varStatus="" >
						  
						  	  <tr>
								<td></td>
								<td class="col-md-1"></td>
								<td class="col-md-1"></td>
								<td class="col-md-2"></td>
								<td class="col-md-1"></td>
								<td class="col-md-1"></td>
								<td class="col-md-1"></td>
								<td class="col-md-1"></td>
								<td class="col-md-2"></td>
							</tr>
						  </c:forEach>
						</table>
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
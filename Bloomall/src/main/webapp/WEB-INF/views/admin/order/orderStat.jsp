<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<script type="text/javascript" src="/js/admin/login.js"></script>
<script type="text/javascript">
$(function(){
	// 날짜 검색 버튼
	$("#btnSearch").click(function(){
		
		/*
		var year = $("#year").val();
		var month = $("#month").val();
		
		var ord_date = new Date(year + "/" + month);
		
		$.ajax({
			type	: "post",
			url		: "/admin/order/statByDate",
			dataType: "Date",
			date	: {ord_date:ord_date},
			success	: function(data){
				alert(ord_date);
				self.location="/admin/order/orderStat";
			}
		});
		*/
		
	});
	
});
</script>
</head>
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
						<div style="color:green;"><b>&#9660; 매출통계</b> &nbsp; <small>월별 주문,입금,배송을 조회합니다.</small></div>
						<!-- 기간설정 -->
						<div class="col-sm-12">
							<table class="table table-striped text-center" id="dateTable">
								<tr>
									<td class="col-sm-1" style="font-weight:bold;">기간설정</td>
									<td style="float:left;">
										<jsp:useBean id="selectDate" class="java.util.Date" />
										<fmt:formatDate value="${selectDate}" pattern="yyyy-MM-dd" var="selectDateStr"/>
										<fmt:parseNumber value="${selectDateStr.toString().substring(0,4)}" type="NUMBER" var="thisYear" />
										<select class="form-control" id="year" name="year" style="width: 110px; display: inline-block; float:left; margin-right:3px;">
											<c:forEach begin="2019" end="${thisYear}" var="i">
												<fmt:parseNumber value="${stat[0].order_date.substring(0,4)}" type="NUMBER" var="selectedYear" />
												<option value="${i}" <c:out value="${i == selectedYear ? 'selected' : '' }" />>${i}</option>
											</c:forEach>
										</select>
										<select class="form-control" id="month" name="month" style="width: 70px; display: inline-block; float:left;">
											<c:forEach begin="1" end="12" var="i">
												<fmt:parseNumber value="${stat[0].order_date.substring(5,7)}" type="NUMBER" var="selectedMonth" />
												<option value="${i}" <c:out value="${i == selectedMonth ? 'selected' : '' }" />>${i}</option>
											</c:forEach>
										</select>
										<button type="button" id="btnSearch" class="btn btn-default" style="float:left;margin-left:5px;">검색</button>
									</td>
								</tr>
							</table>
						</div>
						
						<!-- 주문통계 테이블 -->
						<table class="table table-striped text-center" id="stat">
							<tr>
								<th>일별통계</th>
								<th>주문건수</th>
								<th>주문금액</th>
								<th>결제건수</th>
								<th>결제금액</th>
								<th>발송건수</th>
								<th>배송건수</th>
								<th>매입금액</th>
								<th>순매출액</th>
							</tr>
						  
						  <c:if test="${empty stat }">
								<tr>
									<td rowspan="9">
										해당 날짜의 주문 건이 존재하지 않습니다.
									</td>		  
						  		</tr>
						  </c:if>
						  
						  <c:forEach items="${stat }" var="stat" varStatus="i" >
						  	<c:set var="total_count" value="${total_count + stat.order_count }" />
						  	<c:set var="total_sales" value="${total_sales + stat.total_sales }" />
						  	<c:set var="total_shipped" value="${total_shipped + stat.shipped }" />
						  	<c:set var="total_delivered" value="${total_delivered + stat.delivered }" />
						  	  <tr>
								<td class="col-md-2">${stat.order_date }</td>
								<td class="col-md-1">${stat.order_count }</td>
								<td class="col-md-2" style="font-weight:bold;color:brown;"><fmt:formatNumber value="${stat.total_sales }" pattern="###,###,###,###" />원 </td>
								<td class="col-md-1">0</td>
								<td class="col-md-1">0</td>
								<td class="col-md-1">${stat.shipped }</td>
								<td class="col-md-1">${stat.delivered }</td>
								<td class="col-md-1">0</td>
								<td class="col-md-2" style="font-weight:bold;">0</td>
							</tr>

						  </c:forEach>
							  <tr>
							  	<td>합계</td>
							  	<td>${total_count }</td>
							  	<td class="col-md-2" style="font-weight:bold;color:red;"><fmt:formatNumber value="${total_sales }" pattern="###,###,###,###" />원 </td>
							  	<td>0</td>
							  	<td>0</td>
							  	<td>${total_shipped }</td>
							  	<td>${total_delivered }</td>
							  	<td>0</td>
							  	<td style="font-weight:bold;">0</td>
							  </tr>
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
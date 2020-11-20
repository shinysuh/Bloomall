<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- 예시 차트 -->
<script type="text/javascript">

	// 1차 카테고리 파이차트
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(draw_prime_chart);
	
	function draw_prime_chart(){
		
		var data = google.visualization.arrayToDataTable(${str_p});
		
		var chart = new google.visualization.PieChart(document.getElementById('prime_chart_m'));
		
		chart.draw(data);
	}
	
	// 2차 카테고리 파이차트 
     google.charts.setOnLoadCallback(draw_second_chart);
     
     function draw_second_chart() {
    	 var data = google.visualization.arrayToDataTable(${str_s});
     
    	 var chart = new google.visualization.PieChart(document.getElementById('second_chart_m'));
    	 
    	 chart.draw(data);
     }
     
     // 월별 매출 꺾은선 그래프
     google.charts.setOnLoadCallback(draw_monthly_chart);
     
     function draw_monthly_chart(){
    	 var data = google.visualization.arrayToDataTable(${str_m});
    	 
    	 var chart = new google.visualization.LineChart(document.getElementById('monthly_sales'));
    	 
    	 chart.draw(data);
     }
     
  
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
					Order Chart <small>월별통계차트</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/admin/menu"><i class="fa fa-dashboard"></i> Admin</a>
					</li>
					<li>
						Order
					</li>
					<li>
						Chart
					</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<div class="col-sm-10">	
				<div class="box" style="border: none;">
					<div class="box-body">
					<div class="col-sm-12">
						<form action="/admin/chart/updateChartDate" method="post">
						<table class="table table-striped text-center" id="dateTable">
							<tr>
								<td class="col-sm-1" style="font-weight:bold;padding-top:15px;">기간설정</td>
								<td style="float:left;">
									<jsp:useBean id="selectDate" class="java.util.Date" />
									<!-- 현재 연도 뽑아오기 - 현재 연도까지 dropdown에 표시해야 하므로 정보 필요 -->
									<fmt:formatDate value="${selectDate}" pattern="yyyy-MM-dd" var="selectDateStr"/>
									<fmt:parseNumber value="${selectDateStr.toString().substring(0,4)}" type="NUMBER" var="thisYear" />
									<!-- 선택 창 -->
									<select class="form-control" id="year" name="year" style="width: 110px; display: inline-block; float:left; margin-right:3px;">
										<c:forEach begin="2018" end="${thisYear}" var="i">
											<!--  옵션 조건의 year와 month는 컨트롤러 모델로 넘어온 값 -->
										 	<option value="${i}" <c:out value="${i == year ? 'selected' : '' }" />>${i}</option>
										</c:forEach>
									</select>
									<select class="form-control" id="month" name="month" style="width: 70px; display: inline-block; float:left;">
										<c:forEach begin="1" end="12" var="i">
											<option value="${i}" <c:out value="${i == month ? 'selected' : '' }" />>${i}</option>
										</c:forEach>
									</select>
									<button type="submit" id="btnSearch" class="btn btn-default" style="float:left;margin-left:5px;">검색</button>
								</td>
								<td>
									<a href="/admin/order/orderStat" style="float:right;font-weight:bold;margin: 8px 20px;font-size:16px;color:red;">
										월별 매출 통계표 보러가기 >>
									</a>
								</td>
							</tr>
						</table>
						</form>
					</div>
					<br>
						<div class="col-xs-6">
							<div style="color:green;"><b>&#9660; 1차 카테고리별 매출통계</div>
							<!-- 파이차트 -->
							<div id="prime_chart_m" style="width:600px;height:333px;"></div>
						</div>
						<div class="col-xs-6">
							<div style="color:green;"><b>&#9660; 2차 카테고리별 매출통계</div>
							<!-- 파이차트 -->
							<div id="second_chart_m" style="width:600px;height:333px;"></div>
						</div>
						<div class="col-xs-12">
							<div style="color:green;"><b>&#9660; 월별 매출통계</div>
							<!-- 꺾은선 그래프 -->
     						<div id="monthly_sales" style="width:100%;height:500px;"></div>
						</div>
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
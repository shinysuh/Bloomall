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
		
		//var options = {title: '1차 카테고리별 매출 현황'}
		
		var chart = new google.visualization.PieChart(document.getElementById('prime_chart'));
		
		chart.draw(data);
	}
	
	// 2차 카테고리 파이차트 
     google.charts.setOnLoadCallback(draw_second_chart);
     
     function draw_second_chart() {
    	 var data = google.visualization.arrayToDataTable(${str_s});
     
    	 var chart = new google.visualization.PieChart(document.getElementById('second_chart'));
    	 
    	 chart.draw(data);
     }
     
     // 연도별 바 차트(히스토그램)
     google.charts.setOnLoadCallback(draw_yearly_chart);
     
     function draw_yearly_chart(){
    	 var data = google.visualization.arrayToDataTable(${str_y});
    	 
    	 var chart = new google.visualization.ColumnChart(document.getElementById('yearly_sales'));
    	 
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
					Order Chart <small>전체통계차트</small>
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
						<table class="table table-striped text-center" id="dateTable">
							<tr>
								<td style="float:right;font-weight:bold;margin: 8px 20px;font-size:16px;text-align:right;">
									<a href="/admin/chart/monthlyOrder" style="color:blue;">
										월별 차트 보러가기 >>
									</a><br>
									<a href="/admin/order/orderStat" style="color:red;">
										월별 매출 통계표 보러가기 >>
									</a>
								</td>
							</tr>
						</table>
					</div>
					<br>
						<div class="col-xs-6">
							<div style="color:green;"><b>&#9660; 1차 카테고리별 매출통계</b></div>
							<!-- 파이차트 -->
							<div id="prime_chart" style="width:600px;height:333px;"></div>
							
							
							<!-- 예시 차트 
							<div id="piechart" style="width: 900px; height: 500px;"></div>
							-->
							
						</div>
						<div class="col-xs-6">
							<div style="color:green;"><b>&#9660; 2차 카테고리별 매출통계</b></div>
							<!-- 파이차트 -->
							<div id="second_chart" style="width:600px;height:333px;"></div>
							
							
						</div>

						<div class="col-xs-12">
							<div style="color:green;"><b>&#9660; 연도별 매출통계</b></div>
							<!-- 컬럼차트(vertical bar) -->
     						<div id="yearly_sales" style="width:100%;height:500px;"></div>
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
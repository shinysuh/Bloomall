<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
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
					Order History <small>주문내역</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> Order</a>
					</li>
					<li>
						Order History
					</li>
				</ol>
			</section>
		
										
			<!-- Main content -->
			<section class="content container-fluid">
				<div class="col-lg-10">
				<div class="row">
					<!-- left column -->
					<div class="box" style="border: none;">
						<div class="box-body">
							<table class="table table-striped text-center">
								<%-- 주문내역이 존재하지 않는 경우 --%>
								<c:if test="${empty orderHistory}">
									<tr>
										<td colspan="10"> 
											<p style="padding:50px 0px; text-align: center;">주문내역이 없습니다.</p>
										</td>
									<tr>
								</c:if>
								
								<%-- 주문내역이 존재하는 경우, 리스트 출력 --%>
								<c:forEach items="${orderHistory}" var="orderHistory" varStatus="i">
									<c:set var="idx" value="${orderHistory.ord_idx}"></c:set>
									<c:if test="${i.index == 0 || orderHistory.ord_idx != idx })">
									<tr style="font-size:12px;">
										<th>주문번호</th>
										<th>주문일자</th>
										<th>주문자</th>
										<th>수령자</th>
										<th>상품명</th>
										<th>수량</th>
									</tr>
									</c:if>
									<tr>
										<td class="col-md-1">
											<input id="ord_idx" name="ord_idx" value="${orderHistory.ord_idx }" />
											<a href="/order/orderDetail?ord_idx${orderHistory.ord_idx}">${orderHistory.ord_idx }</a>
										</td>
										<td class="col-md-2">
											<span><fmt:formatDate value="${orderHistory.ord_date }" pattern="yyyy/MM/dd  HH:mm"/></span>
										</td>
										<td class="col-md-1">${orderHistory.mem_id }</td>
										<td class="col-md-1">${orderHistory.ord_recp_name }</td>
										
										
										<td class="col-md-2">
											<p>${orderHistory[i.index].prd_title}</p>
										</td>
									
										<td>${orderHistory[i.index].ord_amount }</td>
									</tr>
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									
									</tr>
								</c:forEach>
							</table>
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
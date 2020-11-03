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

								<c:forEach items="${orderHistory}" var="orderHistory" varStatus="status">
								<c:if test="${status.index == 0 || orderHistory.ord_idx != idx}">
									<tr style="background-color: rgb(229, 217, 236);">
										<td class="col-sm-3" style="padding-top:15px;">
											주문번호 : ${orderHistory.ord_idx} / 주문날짜: <fmt:formatDate value="${orderHistory.ord_date }" pattern="yyyy/MM/dd HH:mm"/> 
										</td>
										<td class="col-sm-1"></td>
										<td class="col-sm-1"></td>
										<td class="col-sm-2" style="text-align:right;">
											<a href="/order/orderDetail?ord_idx=${orderHistory.ord_idx}">
												<button class="btn btn-primary" style="float:right;height:5%;font-size:12px;">주문상세보기</button>
											</a>
										</td>
									</tr>
									<tr>
										<td class="col-sm-3">주문자: ${user.mem_name } / 수령자: ${orderHistory.ord_recp_name }</td>
										<td class="col-sm-1"></td>
										<td class="col-sm-1"></td>
										<td class="col-sm-2" style="text-align:right;font-weight:bold;font-size:15px;">
											총 주문금액: <fmt:formatNumber value="${orderHistory.ord_tot_price}" pattern="###,###,###"/>원
										</td>
									</tr>
									<tr>
										<td>상품명</td>
										<td>가격</td>
										<td>주문수량</td>
										<td style="font-weight:bold;">합계</td>
									</tr>
								</c:if>
									<tr>
										<td>${orderHistory.prd_title}</td>
										<td><fmt:formatNumber value="${orderHistory.prd_price}" pattern="###,###,###"/>원</td>
										<td>${orderHistory.ord_amount}</td>
										<td style="font-weight:bold;"><fmt:formatNumber value="${orderHistory.prd_price * orderHistory.ord_amount}" pattern="###,###,###"/>원</td>
									</tr>
								<c:set var="idx" value="${orderHistory.ord_idx}"></c:set>
								</c:forEach>
							</table>
						</div>
						
						<%-- 페이징 --%>
						<div class="paging">
							<div class="text-center">
								<ul class="pagination">
										<%-- [이전] 표시 --%>
										<c:if test="${pageMaker.prev }">
											<li>
												<a href="/order/orderHistory${pageMaker.makeQuery(pageMaker.startPage - 1)}">[이전]</a>
											</li>
										</c:if>
										<%-- 페이지 번호 표시 --%>
										<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx" >
											<li <c:out value="${pageMaker.cri.page == idx?'class=active':'' }" />>
												<a 
												 href="/order/orderHistory${pageMaker.makeQuery(idx) }">${idx }</a>
											</li>
										</c:forEach>
									
										<%-- [다음] 표시 --%>
										<c:if test="${pageMaker.next }">
											<li>
												<a href="/order/orderHistory${pageMaker.makeQuery(pageMaker.endPage + 1)}">[다음]</a>
											</li>
										</c:if>
									</ul>
							</div>
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
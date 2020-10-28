<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<%@include file="/WEB-INF/views/include/listCSS.jsp" %>

<script type="text/javascript">
$(function(){
	
	// 수량 변경

	
	
	// 상품 삭제
	
	
	// checkAll 버튼 기능 - 항상 checked(모든 체크박스 checked)
	
	
	// 체크 상품 삭제
	
		
	
	// 선택 구매
	
	
	
	// 상품 구매
	
	
	
	
	
});



</script>

</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<%@include file="/WEB-INF/views/include/main_header.jsp" %>
		<%@include file="/WEB-INF/views/include/left_sidebar.jsp" %>
		
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<section class="content-header">
			<!-- 검색목록 리스트 헤더 -->
					<h1>
						Cart <small>장바구니</small>
					</h1>
					<ol class="breadcrumb">
						<li>
							<a href="#"><i class="fa fa-dashboard"></i> Main</a>
						</li>
						<li>Cart</li>
					</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">

				<div class="row">
					<!-- left column -->
					<div class="box" style="border: none;">
						<form method="post" action="/order/buyFromCart">
						<div class="btn-container" style="display: inline-block; float: right; margin:20px 10px 5px 5px;">
							<button type="submit" id="btn_buy_check"  class="btn btn-primary" >선택 상품 구매</button>
							<button id="btn_delete_check"  class="btn btn-default" >선택 상품 삭제</button>
						</div>
						<div class="box-body">
							<table class="table table-striped text-center">
								<tr style="font-size:12px;">
									<th><input type="checkbox" id="checkAll" checked="checked"/></th>
									<th><!-- 상품이미지 --></th>
									<th>상품명</th>
									<th>정가</th>
									<th>BLOOMALL 판매가</th>
									<th>수량</th>
									<th>합계</th>
									<th>주문</th>
								</tr>
								
								<%-- 상품이 존재하지 않는 경우 --%>
								<c:if test="${empty cartList}">
									<tr>
										<td colspan="10"> 
											<p style="padding:50px 0px; text-align: center;">카트에 담긴 상품이 없습니다.</p>
										</td>
									<tr>
								</c:if>
								
								<%-- 상품이 존재하는 경우,  리스트 출력 --%>
								<c:set var="i" value="${fn:length(cartList)}" ></c:set> <!-- cartList : 컬렉션 형태 -->
								<c:forEach items="${cartList}" var="cartList">
									<tr>
										<td class="col-md-1">
											<!-- 체크박스에 장바구니 코드값을 value로 숨겨둠 -->
											<input type="checkbox" name="check" class="check" value="${cartList.cart_idx}" checked="checked" >
											<input type="hidden" id="prd_idx_${cartList.cart_idx}" name="prd_idx" value="${cartList.prd_idx}" >
											<input type="hidden" name="cart_amount" value="${cartList.cart_amount}" >
											<input type="hidden" name="cart_idx" value="${cartList.cart_idx}" >
										</td>
										<td class="col-md-1">
											<a href="/product/detail?prd_idx=${cartList.prd_idx}&ctgr_cd=${ctgr_cd}">
												<img src="/product/fileDisplay?fileName=${cartList.prd_img }" alt="${cartList.prd_title}">
											</a>
										</td>
										<td class="col-md-2">
											<a href="/product/detail?prd_idx=${cartList.prd_idx}&ctgr_cd=${ctgr_cd}"
												style="color: black;"> ${cartList.prd_title} </a>
										</td>
										<td class="col-md-1">
											<p>${cartList.prd_price}</p>
											<input type="hidden" name="price_${cartList.cart_idx}" value="${cartList.prd_price}" /></td>
										<td class="col-md-2">
											<p>${cartList.prd_dc_price}</p>
											<input type="hidden" name="dc_price_${cartList.cart_idx}" value="${cartList.prd_dc_price}" /></td>
										<td class="col-md-2">
											<input type="number" name="cart_amount_${cartList.cart_idx}"
												style="width:50px; height:30px; padding-left:5px; margin-bottom:3px;text-align:right;" value="${cartList.cart_amount}" /> <br>
											<!-- 수량변경 키에 장바구니 코드를 value로 숨겨 놓음 -->
											<button type="button" name="btnUpdate" class="btn btn-default" value="${cartList.cart_idx}" style="width:50px;" >변경</button>    
										</td>
										<td class="col-md-1">${cartList.prd_dc_price * cartList.cart_amount}</td>
										<td class="col-md-2">
											<button type="button" name="btnOrder" class="btn btn-primary" value="${cartList.cart_idx}">주문하기</button>
											<button type="button" name="btnDelete" class="btn btn-default" value="${cartList.cart_idx}" >삭제</button>    
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						</form>
						
						<div class="box-body" style="margin: 7% 10%; padding-bottom:10%; min-width: 600px;">
							<table class="table table-striped text-center">
								<tr>
									<td class="col-md-1" style="font-weight:bold">총 상품금액</td>
									<td class="col-md-1">예상 적립 포인트</td>
									<td class="col-md-1" style="color:rgb(214, 51, 119);font-weight:bold;">최종 결제 금액</td>
								</tr>
								<tr >
									<td class="col-md-1" style="height:50px; text-align: center;font-weight:bold"><p id="totalPrice">0</p></td>
									<td class="col-md-1" style="height:50px; text-align: center;"><p id="totalPoint">0</p></td>
									<td class="col-md-1" style="height:50px; text-align: center;color:rgb(214, 51, 119);font-weight:bold"><p id="total_dc_price">0</p></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!--/.col (left) -->
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
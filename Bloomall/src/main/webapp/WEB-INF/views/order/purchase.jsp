<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<script type="text/javascript" src="/js/order/purchase.js"></script>
<script type="text/javascript">
$(function(){
	// [총상품금액]/[총할인금액]/[적립예정포인트]/[최종결제금액] 로드 함수
	bringTotals();
	
	// <form>의 action 세팅 => ${type} 값에 따라 form의 action 달라짐. ${type} => 1:단일상품구매 / 2:여러상품구매
	formSetting();
});

function formSetting(){
	
	var form = $("#orderForm");
	// ${type} value 가져오기
	var type = $("#btnOrder").prev().val();
	
	if(type == 1){  // 단일상품 구매
		form.attr("action", "/order/orderOne");
	}else if(type == 2){  // 여러상품 구매
		form.attr("action", "/order/orderChk");
	}
}

</script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
	<%@include file="/WEB-INF/views/include/main_header.jsp" %>
	<%@include file="/WEB-INF/views/include/left_sidebar.jsp" %>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Order <small>주문하기</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> Order</a>
					</li>
				</ol>
			</section>

			<!-- Main content -->
			<%-- 상품상세/상품리스트에서 넘어온 주문 페이지 --%>
			<section class="content container-fluid">
			<div class="row">
				<div class="col-md-10">
				<!-- left column -->
				<div class="box" style="border: none;">			
					<form id="orderForm" method="post"> <%-- <form>의 action은 [단일][복수]로 나눠서 jquery에서 지정 --%>
						<div class="box-body" style="padding:30px 10px 100px 10px;">
							<%-- 주문내역 상단 버튼 --%>
							<div class="col-sm-12">
							<div class="orderList" style="padding: 0px 40px;">
								<div style="width:100%;">
									<span style="display: inline-block; float:left; margin:20px 10px 5px 0px;font-weight:bold;font-size:16px;">[상품확인]</span>
									<div class="btn-container" style="display: inline-block; float: right; margin:20px 10px 5px 5px;">
									</div>
								</div>
								<%-- 주문내역 테이블 --%>
								<table class="table table-striped text-center" id="ordertbl">
									<thead id="thead">
										<tr>
										<%-- 선택삭제 기능 없앰(체크박스 삭제) --%>
											<th><!-- 상품이미지 --></th>
											<th>상품명</th>
											<th>정가</th>
											<th>BLOOMALL 판매가</th>
											<th>수량</th>
											<th style="font-weight:bold;">합계</th>
										</tr>
									
									<%-- 상품리스트 출력 --%>
									<tbody>
									<c:forEach items="${productList}" var="productList" varStatus="i"> <!-- i는 리스트 컬렉션의 인덱스 역할 -->
										<tr id="productList_${productList.prd_idx}" class="productRow">
											<td class="col-md-1">
												<input type="hidden" id="amount_${productList.prd_idx}" name="ord_amount" value="${amountList[i.index]}" />
												<input type="hidden" name="prd_idx" value="${productList.prd_idx}" />
												<input type="hidden" name="ord_price" value="${productList.prd_dc_price}" />
												<a href="/product/detail?prd_idx=${productList.prd_idx}&ctgr_cd=${ctgr_cd}">
													<img src="/product/fileDisplay?fileName=${productList.prd_img }" style="width:100px;">
												</a>
											</td>
											<td class="col-md-2">
												<a href="/product/detail?prd_idx=${productList.prd_idx}&ctgr_cd=${ctgr_cd}"
													style="color: black;"> ${productList.prd_title} </a>
											</td>
											<td class="col-md-1">
												<p><fmt:formatNumber value="${productList.prd_price}" pattern="###,###,###" />원</p>
												<input type="hidden" name="prd_price" value="${productList.prd_price}" />
											<td class="col-md-2">
												<p><fmt:formatNumber value="${productList.prd_dc_price}" pattern="###,###,###" />원
													<br>
												(<fmt:formatNumber value="${100-(productList.prd_dc_price / productList.prd_price * 100)}" pattern="###,###,###" />%
												<span style="color:rgb(209, 4, 199);"> &#8681;</span>) <br>
												<span style="color:#4e789c;font-size:13px;"> P <fmt:formatNumber value="${productList.prd_price *0.03 }" pattern="##,###"/></span>
												</p>
												<input type="hidden" name="prd_dc_price" value="${productList.prd_dc_price}" /> 
											<td class="col-md-1">
												<p>${amountList[i.index]}</p>
												<input type="hidden" name="amount" value="${amountList[i.index]}" /> 
											</td>
											<td class="col-md-1">
												<p style="font-weight:bold;"><fmt:formatNumber value="${productList.prd_dc_price * amountList[i.index]}"  pattern="###,###,###" />원</p>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
								<br><br><br>
							</div>
							<hr><br>
							</div>
							
							<%-- 주문 정보 --%>
							<div class="col-sm-12 orderInfo" style="min-width:300px;" >
								<div class="col-xs-8 userInfo" style="display:inline-block; float:left; width:60%; padding: 0% 5%;">
									<div class="container" style="width:100%;">
										<span style="font-weight:bold;font-size:16px;">[배송 정보]</span>
										<div class="form-group" style="width:100%; margin-top:5px;">
											<input type="hidden" class="form-control" id="mem_id" name="mem_id" value="${user.mem_id}">
										</div>
										<div class="form-group">
											<label for="ord_recp_name">* 이름</label> <input type="text"
												class="form-control" id="ord_recp_name" name="ord_recp_name" value="${user.mem_name}">
										</div>
										<div class="form-group">
											<label for="ord_recp_tel">* 휴대폰 번호</label> <input type="tel"
												class="form-control" id="ord_recp_tel" name="ord_recp_tel" value="${user.mem_tel}">
										</div>
										<div class="form-group">
											<label for="inputAddr">* 주소</label> <br />
											<input type="text" id="sample2_postcode" name="ord_recp_zip" class="form-control" 
												value = "${user.mem_zip}"
												style="width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호" readonly>
											<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기"><br>
											<input type="text" id="sample2_address" name="ord_recp_addr" class="form-control" 
												value = "${user.mem_addr}"
												placeholder="주소" style=" margin:3px 0px;" readonly>
											<input type="text" id="sample2_detailAddress" name="ord_recp_addr_d" class="form-control" 
												value = "${user.mem_addr_d}"
												placeholder="상세주소" >
											<input type="hidden" id="sample2_extraAddress" class="form-control" placeholder="참고항목">
										</div>
									</div>
								</div>
								
								<%-- 결제 방식 선택  및 주문 금액 확인 --%>
								<div class="col-xs-4 orderConfirm" style="display:inline-block; width:30%; margin: 0px 5%;">
									<%-- 결제 방식 --%>
									<div>
										<span style="font-weight:bold;font-size:16px;">[결제 방식]</span><br>
										<div class="payment" style="margin-top:10px;">
											<input type="radio" name="payment" value="card" checked="checked">카드 결제
											<input type="radio" name="payment" value="tcash" style="margin-left:40px;">실시간 계좌이체<br>
											<input type="radio" name="payment" value="phone">휴대폰 결제
											<input type="radio" name="payment" value="cash" style="margin-left:25px;">무통장 입금
										</div>
									</div>
									<br><br><br>
									
									<%-- 주문 금액 --%>
									<div style="min-width:300px;">
										<span style="font-weight:bold;font-size:16px;">[결제 금액]</span>
										<table class="table text-center" style="margin-top:15px;" >
											<tr style="height:30px; text-align: center;">
												<td class="col-xs-2" style="font-weight:bold;">총 상품금액</td>
												<td class="col-xs-2" style="height:30px; text-align: center;font-weight:bold;"><p id="total_price">0</p></td>
											</tr>
											<tr style="height:30px; text-align: center;">
												<td>총 할인금액</td>
												<td><p id="total_discount">0</p></td>
											</tr>
											<tr style="height:10px; text-align: center;">
												<td><span style="margin-top:5px;font-size:11px;color:#539ca8;text-align:center;">적립예정포인트</span></td>
												<td>
													<p id="total_point" style="font-size:11px;color:#539ca8;text-align:center;">0</p>
													<input type="hidden" id="mem_point" name="mem_point" />
												</td>
											</tr>
											<tr style="height:30px; text-align: center;">
												<td>
													<label style="color:rgb(190, 90, 129);font-weight:bold;font-size:16px;text-align:center;">최종 결제 금액</label>
												</td>
												<td class="col-xs-2" style="height:30px; text-align: center;">
													<p id="total_dc_price" style="color:rgb(190, 90, 129);font-weight:bold;font-size:18px;text-align:center;">0</p>
													<input type="hidden" id="ord_tot_price" name="ord_tot_price" value="0"/>
												</td>
											</tr>
											<tr>
												<td class="col-xs-1" colspan="2" >
													<input type="hidden" id="type" name="type" value="${type}" />
													<button id="btnOrder" class="btn btn-flat" type="submit" style="padding: 10px 40px; background-color: grey; color:white;">결제하기</button>     
												</td>
											</tr>
										</table>
								
									</div>
								</div>
							</div>
						</div>
					</form>
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
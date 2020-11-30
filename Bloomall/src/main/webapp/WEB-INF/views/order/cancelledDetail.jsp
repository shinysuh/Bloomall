<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<script type="text/javascript">
$(function(){
	// 취소/반품현황 텍스트화
	getStateText();
});
function getStateText(){
	var ord_state = $(".state"); 
	
	if(ord_state.html() == 7){
		ord_state.html("취소접수");
	}else if(ord_state.html() == 8){
		ord_state.html("반품완료");
	}else if(ord_state.html() == 9){
		ord_state.html("환불처리중");
	}else if(ord_state.html() == 0){
		ord_state.html("환불완료");
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
					Cancel Detail <small>취소/반품 상세</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> Order</a>
					</li>
					<li>
						Cancel Detail
					</li>
				</ol>
			</section>

			<!-- Main content -->
			<%-- 주문내역리스트에서 넘어온 주문 페이지 --%>
			<section class="content container-fluid">
			<div class="row">
				<div class="col-md-10">
				<!-- left column -->
					<div>
						<input type="hidden" name="ord_idx" value="${cancelledBuyer.ord_idx}" />
						<input type="hidden" name="page" value="${cri.page}" /> 
					<input type="hidden" name="perPageNum" value="${cri.perPageNum}" />
					</div>
					<div class="box" style="border: none;">
						<div style="display: inline-block; float: right; margin:8px 6%;">
						<a href="/order/cancelledList${pageMaker.makeQuery(pageMaker.cri.page) }">
							<button type="button" id="btn_toHistoryList" class="btn btn-primary">목록으로</button>	
						</a>
						</div>
						<div class="box-body" style="padding:30px 10px 100px 10px;">
							<%-- 주문내역 상단 버튼 --%>
							<div class="col-sm-12">
							<div class="cancelDetail" style="padding: 0px 40px;">
								<%-- 주문내역 테이블 --%>
								<table class="table  text-center" id="ordertbl">
									<thead id="thead">
										<tr style="background-color: rgb(229, 217, 236);" >
											<td colspan="6" style="text-align:left;">
												<b>취소접수날짜: <fmt:formatDate value="${cancelledBuyer.cancel_date}" pattern="yyyy/MM/dd HH:mm"/>
												(주문번호: ${cancelledBuyer.ord_idx} )</b> / <span>주문날짜: <fmt:formatDate value="${cancelledBuyer.ord_date }" pattern="yyyy/MM/dd"/></span>
											</td>
											<td>받는사람: ${cancelledBuyer.ord_recp_name}</td>
										<tr>
										<tr style="background-color: whitesmoke;">
											<td><!-- 상품이미지--></td>
											<td>상품명</td>
											<td>주문가격</td>
											<td>주문수량</td>	
											<td>합계</td> 
											<td style="font-size:12px;color:#539ca8;">포인트</td>
											<td>취소/반품 현황</td>
										</tr>
									<thead>
									
									<%-- 상품이 존재하는 경우,  리스트 출력 --%>
									<tbody>
									<c:forEach items="${cancelDetail}" var="cancelDetail" varStatus="status">
									<c:set var="totalPrice" value="${totalPrice + cancelDetail.ord_price * cancelDetail.ord_amount}"></c:set>
									<c:set var="totalPoint" value="${totalPoint + cancelDetail.ord_price * 0.03 * cancelDetail.ord_amount}"></c:set>
										<tr id="row">
											<td class="col-md-2">
												<a href="/product/detail?prd_idx=${cancelDetail.prd_idx}">
													<img src="/product/fileDisplay?fileName=${cancelDetail.prd_img}" style="width:100px;">
												</a>
											</td>
											<td class="col-md-2">
												<a href="/product/detail?prd_idx=${cancelDetail.prd_idx}"
													style="color: black;"> ${cancelDetail.prd_title} </a>
											</td>
											<td class="col-md-1">
												<p><fmt:formatNumber value="${cancelDetail.ord_price}" pattern="###,###,###" />원</p>
											</td>
											<td class="col-md-1">
												<p>${cancelDetail.ord_amount}</p>
											</td>
											<td class="col-md-1">
												<p ><fmt:formatNumber value="${cancelDetail.ord_price * cancelDetail.ord_amount}"  pattern="###,###,###" />원</p>
											</td>
											<td class="col-md-1">
												<p style="font-size:12px;color:#539ca8;"><fmt:formatNumber value="${cancelDetail.ord_price * 0.03 * cancelDetail.ord_amount}"  pattern="###,###,###" />원</p>
											</td>
											<td class="state col-md-1">${cancelledBuyer.return_state }</td>
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
										<span>[주문 정보]</span>
										<div class="form-group">
											<label for="ord_recp_name">* 이름</label> <input type="text"
												class="form-control" value="${cancelledBuyer.ord_recp_name}" readonly>
										</div>
										<div class="form-group">
											<label for="ord_recp_tel">* 휴대폰 번호</label> <input type="tel"
												class="form-control" value="${cancelledBuyer.ord_recp_tel}" readonly>
										</div>
										<div class="form-group">
											<label for="inputAddr">* 주소</label> <br />
											<input type="text" id="sample2_postcode" name="ord_recp_zip" class="form-control" 
												value = "${cancelledBuyer.ord_recp_zip}" 
												style="width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호" readonly>
											<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기" disabled="disabled"><br>
											<input type="text" id="sample2_address" name="ord_recp_addr" class="form-control" 
												value = "${cancelledBuyer.ord_recp_addr}" 
												placeholder="주소" style=" margin:3px 0px;" readonly>
											<input type="text" id="sample2_detailAddress" name="ord_recp_addr_d" class="form-control" 
												value = "${cancelledBuyer.ord_recp_addr_d}"
												placeholder="상세주소" readonly >
											<input type="hidden" id="sample2_extraAddress" class="form-control" 
												placeholder="참고항목">
										</div>
									</div>
								</div>
								
								<%-- 주문 금액 확인 --%>
								<div class="col-xs-4 orderConfirm" style="display:inline-block; width:20%; margin: 0px 5%;">
								<br>
									<%-- 주문 금액 --%>
									<div style="min-width: 300px;">
										<span>[결제 금액]</span>
										<table class="table text-center" style="margin-top:15px;" >
											<tr>
												<td class="col-md-1">총 상품금액</td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<fmt:formatNumber value="${totalPrice}" pattern="###,###,###" />원</td>
											</tr>
											<tr>
												<td class="col-md-1">총 할인금액(-)</td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<fmt:formatNumber value="${totalPrice - cancelledBuyer.ord_tot_price}" pattern="###,###,###" />원</td>
											</tr>
											<tr style="font-size:12px;color:#539ca8;">
												<td class="col-md-1">총 적립포인트</td>
												<td class="col-md-1" style="text-align: center;">
													<fmt:formatNumber value="${totalPoint}" pattern="###,###,###" />원</td>
											</tr>
											<tr>
												<td class="col-md-1"><label>최종결제금액</label></td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<label><fmt:formatNumber value="${cancelledBuyer.ord_tot_price}" pattern="###,###,###" />원</label>
												</td>
											</tr>
										</table>
								
									</div>
								</div>
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
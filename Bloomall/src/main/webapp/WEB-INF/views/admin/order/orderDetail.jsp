<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<script type="text/javascript" src="/js/admin/login.js"></script>
<script type="text/javascript">
$(function(){
	// 주문처리상태 텍스트
	getStateText();
	
	// 주문상태 변경 버튼 btnUpdate
	$("#btnUpdate").click(function(){
		var ord_idx = $("input[name='ord_idx']").val();
		var ord_state = $("#update_status").val();
		
		$.ajax({
			type	: 'post',
			url		: '/admin/order/updateState',
			dataType: 'text',
			data	: {ord_idx : ord_idx, ord_state : ord_state},
			success	: function(data){
				alert("주문상태가 변경되었습니다.");
				location.href = "/admin/order/orderDetail${pageMaker.makeSearch(pageMaker.cri.page, stateList)}&ord_idx=" + ord_idx;
			}
		});
	});
	
	// 이 주문 삭제하기 버튼 - deleteOrder
	$("#deleteOrder").click(function(){
		
		var ord_idx = $("input[name='ord_idx']").val();
		
		if(confirm("정말 이 주문건을 삭제하시겠습니까? \n이 작업은 DB정보만 삭제하며, 포인트 회수 및 쿠폰 취소를 위해서는 \n주문취소 작업 후 진행해주시기 바랍니다. \n이 작업은 취소할 수 없으므로 신중하게 결정해주세요.")){

			$.ajax({
				type	: 'post',
				url		: '/admin/order/deleteOrder',
				dataType: 'text',
				data	: {ord_idx : ord_idx},
				success	: function(data){
					
					alert("해당 주문건이 정상적으로 삭제되었습니다.")
					
					location.href = "/admin/order/orderList${pageMaker.makeSearch(pageMaker.cri.page, stateList)}";
				}
			});
		 }
	});
	
	// 목록 버튼
	$(".btnList").click(function(){
		location.href = "/admin/order/orderList${pageMaker.makeSearch(pageMaker.cri.page, stateList)}";
		
	});
	
});

function getStateText(){
	var ord_state = $(".state"); 
	
	if(ord_state.html() == 1){
		ord_state.html("주문접수");
		// 주문접수 상태에서는 수량 수정 가능
		$(".amount").attr("readonly", false);
	}else if(ord_state.html() == 2){
		ord_state.html("배송준비중");
	}else if(ord_state.html() == 3){
		ord_state.html("배송중");
	}else if(ord_state.html() == 4){
		ord_state.html("배송완료");
	}
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
					Order Management <small>주문상세정보</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/admin/menu"><i class="fa fa-dashboard"></i> Admin</a>
					</li>
					<li>
						Order
					</li>
					<li>
						Management
					</li>
					<li>
						Detail
					</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<div class="row">
					<div class="col-md-10">
					<form id="form1" action="/admin/order/updateDetail" method="post">
						<div class="box" style="border: none;">
							<div class="box-body">
								<!-- 페이징 정보 저장 -->
								<div id="pagingInfo">
									<input type="hidden" name="ord_idx" value="${order.ord_idx }" >
									<input type="hidden" name="page" value="${cri.page }" />
									<input type="hidden" name="perPageNum" value="${cri.perPageNum }" />
									<input type="hidden" name="searchType" value="${cri.searchType }" />
									<input type="hidden" name="keyword" value="${cri.keyword }" />
									<input type="hidden" name="state" value="${stateList }" />
								</div>
								<!-- 상품 리스트 테이블 -->
								<div style="font-size:16px;">
									<span>주문번호 : <b style="font-size:20px;">${order.ord_idx }</b></span>
									<span style="float:right;">
									<span><b>주문날짜 : </b><fmt:formatDate value="${order.ord_date}" pattern="yyyy-MM-dd HH:mm"/> </span>
									<span class='divi'>&nbsp;&nbsp;|&nbsp;&nbsp;</span>
									<span><b>수정날짜 : </b><fmt:formatDate value="${order.ord_updatedate}" pattern="yyyy-MM-dd HH:mm"/> </span>
									</span>
									<br><br>
								</div>
								
								
								<!-- =================================================================================== -->
								<div class="col-sm-12">
								<!-- [1번 테이블(상품정보)] -->
								<div style="color:green;font-weight:bold;">&#9660; 주문상품</div>
								<table class="table table-striped text-center" id="table_1">
									<tr>
										<th>선택</th>
										<th>번호</th>
										<th>상품이미지</th>
										<th>상품명</th>
										<th>수량</th>
										<th>상품가격</th>
										<th>판매가격</th>
										<th>소계</th>
										<th>처리상태</th>
									</tr>
									<c:forEach items="${orderDetail }" var="orderDetail" varStatus="i">
									<c:set var="totalPrice" value="${totalPrice + orderDetail.prd_price * orderDetail.ord_amount }" />
									<c:set var="totalDC" value="${totalDC + (orderDetail.prd_price - orderDetail.ord_price) * orderDetail.ord_amount }" />
								  	<tr style="text-align:center;">
								  		<td><input type="checkbox" name="check" class="check" /></td>
								  		<td>
								  			${i.index + 1 }
								  			<input type="hidden" name="prd_idx" value="${orderDetail.prd_idx }"  />
								  		</td>
								  		<td class="col-md-1">
								  			<a href="/product/detail?prd_idx=${orderDetail.prd_idx}">
												<img src="/product/fileDisplay?fileName=${orderDetail.prd_img}" style="height:80px;">
											</a>
										</td>
								  		<td class="col-md-3">${orderDetail.prd_title }</td>
								  		<td class="col-md-1">
								  			<input type="text" name="ord_amount" class="amount" value="${orderDetail.ord_amount }" size="1" readonly/> 
								  		</td>
								  		<td class="col-md-1"><fmt:formatNumber value="${orderDetail.prd_price }" pattern="###,###,###"/>원</td>
								  		<td class="col-md-1"><fmt:formatNumber value="${orderDetail.ord_price }" pattern="###,###,###"/>원</td>
								  		<td class="col-md-2" style="font-weight:bold;">
								  			<fmt:formatNumber value="${orderDetail.ord_price * orderDetail.ord_amount }" pattern="###,###,###"/>원
							  			</td>
								  		<td class="state col-md-2">${order.ord_state }</td>
								  	</tr>
									</c:forEach>
								</table>
								</div>
	 
								<!-- =================================================================================== -->
								<div class="col-sm-12">
								<!-- [2번 테이블(현재 상태)] -->
									<div style="color:green;font-weight:bold;">&#9660; 현재 주문처리상태</div>
									<table class="table table-striped text-center" id="table_2">
										<tr>
											<td class="col-sm-2" style="font-weight:bold;">주문상태</td>
											<td>
												<select class="form-control" id="update_status" name="ord_state" style="width: 170px; display: inline-block; float:left;">
													<option value="1" <c:out value="${order.ord_state == 1 ? 'selected':''}" />>주문접수</option>
													<option value="2" <c:out value="${order.ord_state == 2 ? 'selected':''}" />>배송준비중</option>
													<option value="3" <c:out value="${order.ord_state == 3 ? 'selected':''}" />>배송중</option>
													<option value="4" <c:out value="${order.ord_state == 4 ? 'selected':''}" />>배송완료</option>
												</select>
												<button type="button" id="btnUpdate" class="btn btn-default" style="float:left;margin-left:5px;">변경</button>
												<button type="button" id="deleteOrder" class="btn btn-danger" style="float:right;">이 주문 삭제하기</button>
											</td>
										</tr>
									</table>
								</div>
								
								
								<!-- =================================================================================== -->
								<div class="col-sm-12">
								<!-- [3번 테이블(결제정보)] -->
								<div style="color:green;font-weight:bold;">&#9660; 결제금액 정보</div>
								<table class="table table-striped text-center" id="table_3">
									<tr>
										<td class="col-sm-2" style="font-weight:bold;">주문금액</td>
										<td style="float:left;"><fmt:formatNumber value="${totalPrice }" pattern="###,###,###" />원</td>
									</tr>
									<tr>
										<td style="font-weight:bold;">할인금액</td>
										<td style="float:left;"> - <fmt:formatNumber value="${totalDC }" pattern="###,###,###" />원</td>
									</tr>
									<tr>
										<td style="font-weight:bold;">결제금액</td>
										<td style="float:left;font-weight:bold;color:blue;font-size:18px;"><fmt:formatNumber value="${order.ord_tot_price }" pattern="###,###,###" />원</td>
									</tr>
								</table>
								</div>


								<!-- =================================================================================== -->

								<div class="col-sm-6">
								<!-- [4번 테이블(주문자 정보)] -->
								<div style="color:green;font-weight:bold;">&#9660; 주문자 정보</div>
								<table class="table table-striped text-center" id="table_4">
									<tr>
										<td class="col-sm-3" style="font-weight:bold;">이름/ID</td>
										<td style="float:left;">${member.mem_name } / ${member.mem_id}</td>
									</tr>
									<tr>
										<td style="font-weight:bold;">이메일</td>
										<td style="float:left;">${member.mem_email }</td>
									</tr>
									<tr>
										<td style="font-weight:bold;">연락처</td>
										<td style="float:left;">${member.mem_tel }</td>
									</tr>
									<tr>
										<td style="font-weight:bold;">주문날짜</td>
										<td style="float:left;"><fmt:formatDate value="${order.ord_date }" pattern="yyyy-MM-dd HH:mm"/></td>
									</tr>
								</table>
								</div>
								
								
																<%--
										(수정가능) 항목들은 input으로 => 맨아래 수정버튼으로 수정 제출
										
										[1번 테이블(상품정보)]
										선택 / 번호 / 상품이미지 / 상품명 / 수량(수정가능) / 정가 / 판매가격(수정가능) / 소계(가격*수량) / 처리상태 (readonly)(아래에 수정 dropdown)
										
										
										[2번 테이블(현재 상태)]
										주문상태 -> 변경		//		(버튼) 이 주문 삭제하기
										
										
										[3번 테이블(결제정보)]
										총 주문금액
										총 할인금액
										결제금액 - 쿠폰이나 포인트 사용에 따라 달라질 수 있는 항목  (order.ord_tot_price)
										결제수단 
										
										
										[4번 테이블(주문자 정보)]	 	/		[5번 테이블(수령자 정보)]
										이름/ID							수령자(수정가능)
										이메일							연락처(ord_recp_tel)(수정가능)
										연락처(member.mem_tel)				주소/우편번호(수정가능)
										주문날짜							상세주소(수정가능)
										
												[수정] => post. form태그로 테이블 전체 감싸기 / [목록] class="btnList"
																	
									 --%>
									 

								<!-- =================================================================================== -->
								<div class="col-sm-6">
								<!-- [5번 테이블(수령자 정보)] -->
								<div style="color:green;font-weight:bold;">&#9660; 수령자 정보</div>
								<table class="table table-striped text-center" id="table_5">
									<tr>
										<td class="col-sm-3" style="font-weight:bold;">수령자</td>
										<td style="float:left;"><input type="text" value="${order.ord_recp_name }" name="ord_recp_name" /></td>
									</tr>
									<tr>
										<td style="font-weight:bold;">연락처</td>
										<td style="float:left;"><input type="tel" value="${order.ord_recp_tel }" name="ord_recp_tel" /></td>
									</tr>
									<tr>
										<td style="font-weight:bold;">주소</td>
										<td style="float:left;">
											<input type="text" id="sample2_postcode" name="ord_recp_zip" class="form-control" 
												value = "${order.ord_recp_zip}" 
												style="width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호">
											<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기"><br>
											<input type="text" id="sample2_address" name="ord_recp_addr" class="form-control" 
												value = "${order.ord_recp_addr}" 
												placeholder="주소" style=" margin:3px 0px;">
											<input type="text" id="sample2_detailAddress" name="ord_recp_addr_d" class="form-control" 
												value = "${order.ord_recp_addr_d}"
												placeholder="상세주소">
											<input type="hidden" id="sample2_extraAddress" class="form-control" placeholder="참고항목">
										</td>
									</tr>
								</table>
								</div>
								
								
								<div class="col-sm-12" style="text-align:center;">
									<button type="submit" class="btn btn-primary">수정</button>
									<button type="button" class="btnList btn btn-warning">목록</button>
								</div>

							</div>
						</div>
					</form>	
					</div>
				</div>
				<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
				<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
				<!-- 우편번호 API 자바스크립트 -->
				<%@include file="/WEB-INF/views/include/zipcode.jsp" %>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="/WEB-INF/views/include/footer.jsp"%>

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
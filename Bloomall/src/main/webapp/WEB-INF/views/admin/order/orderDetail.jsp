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
		var ord_idx = "${buyer.ord_idx }";
		var ord_state = $("#update_status").val();
		
		$.ajax({
			type	: 'post',
			url		: '/admin/order/updateState',
			dataType: 'text',
			data	: {ord_idx : ord_idx, ord_state : ord_state},
			success	: function(data){
				alert("주문상태가 변경되었습니다.");
				location.href = "/admin/order/orderDetail${pageMaker.makeSearch(pageMaker.cri.page)}&ord_idx=" + ord_idx;
			}
		});
	});
	
	// 이 주문 삭제하기 버튼 - deleteOrder
	$("#deleteOrder").click(function(){
		 var form = $("#form1");
		 if(confirm("정말 이 주문건을 삭제하시겠습니까? \n이 작업은 DB정보만 삭제하며, 포인트 회수 및 쿠폰 취소를 위해서는 \n주문취소 작업 후 진행해주시기 바랍니다. \n이 작업은 취소할 수 없으므로 신중하게 결정해주세요.")){
			 form.attr("action", "/admin/order/deleteOrder");
			 form.submit();
			 alert("해당 주문건이 정상적으로 삭제되었습니다.");
		 }
	});
	
});

function getStateText(){
	var ord_state = $(".state"); 
	
	if(ord_state.html() == 1){
		ord_state.html("주문접수");
		// 주문접수 상태에서는 수량 수정 가능
		$(".amount").attr("disabled", false);
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
						주문번호(주문상품) / 주문자 / 수령자 / 결제(수단) / 금액 / [처리상태(주문접수(1) / 배송준비중(2) / 배송중(3) / 배송완료(4) / 취소/반품(5)])]
						<div class="box" style="border: none;">
							<div class="box-body">
								<!-- 페이징 정보 저장 -->
								<div id="pagingInfo">
									<input type="hidden" name="page" value="${cri.page }" />
									<input type="hidden" name="perPageNum" value="${cri.perPageNum }" />
									<input type="hidden" name="searchType" value="${cri.searchType }" />
									<input type="hidden" name="keyword" value="${cri.keyword }" />
								</div>
								<!-- 상품 리스트 테이블 -->
								<div style="font-size:16px;">
									<span>주문번호 : <b style="font-size:18px;">${buyer.ord_idx }</b></span>
									<span class='divi'>&nbsp;&nbsp;|&nbsp;&nbsp;</span>
									<span>주문날짜 : <fmt:formatDate value="${buyer.ord_date}" pattern="yyyy-MM-dd HH:mm"/> </span>
									<button type="button" class="btnList btn btn-primary" style="float:right; margin-right:1%">목록으로</button>
									<br>
								</div>
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
								  	<tr style="text-align:center;">
								  		<td><input type="checkbox" name="check" class="check" /></td>
								  		<td>${i.index + 1 }</td>
								  		<td class="col-md-1">
								  			<a href="/product/detail?prd_idx=${orderDetail.prd_idx}">
												<img src="/product/fileDisplay?fileName=${orderDetail.prd_img}" style="height:80px;">
											</a>
										</td>
								  		<td class="col-md-3">${orderDetail.prd_title }</td>
								  		<td class="col-md-1">
								  			<input type="text" name="ord_amount" class="amount" value="${orderDetail.ord_amount }" size="1" disabled/> 
								  		</td>
								  		<td class="col-md-1"><fmt:formatNumber value="${orderDetail.prd_price }" pattern="###,###,###"/>원</td>
								  		<td class="col-md-1"><fmt:formatNumber value="${orderDetail.ord_price }" pattern="###,###,###"/>원</td>
								  		<td class="col-md-2" style="font-weight:bold;">
								  			<fmt:formatNumber value="${orderDetail.ord_price * orderDetail.ord_amount }" pattern="###,###,###"/>원
							  			</td>
								  		<td class="state col-md-2">${buyer.ord_state }</td>
								  	</tr>
									</c:forEach>
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
										결제금액 - 쿠폰이나 포인트 사용에 따라 달라질 수 있는 항목  (buyer.ord_tot_price)
										결제수단 
										
										
										[4번 테이블(주문자 정보)]	 	/		[4번 테이블(수령자 정보)]
										이름/ID							수령자 이름(수정가능)
										이메일							연락처(ord_recp_tel)(수정가능)
										연락처(user.mem_tel)(수정가능)		주소/우편번호(수정가능)
										주문날짜							상세주소(수정가능)
										=> 주문자 정보(session에서 user로 가져오기)
										
										
										
												[수정] => post. form태그로 테이블 전체 감싸기 / [목록] class="btnList"
																	
									 --%>
								<div class="col-sm-12">
								<!-- [2번 테이블(현재 상태)] -->
									<div style="color:green;font-weight:bold;">&#9660; 현재 주문처리상태</div>
									<table class="table table-striped text-center" id="table_2">
										<tr>
											<td class="col-sm-1">주문상태</td>
											<td>
												<select class="form-control" id="update_status" name="ord_state" style="width: 170px; display: inline-block; float:left;">
													<option value="1" <c:out value="${buyer.ord_state == 1 ? 'selected':''}" />>주문접수</option>
													<option value="2" <c:out value="${buyer.ord_state == 2 ? 'selected':''}" />>배송준비중</option>
													<option value="3" <c:out value="${buyer.ord_state == 3 ? 'selected':''}" />>배송중</option>
													<option value="4" <c:out value="${buyer.ord_state == 4 ? 'selected':''}" />>배송완료</option>
												</select>
												<button type="button" id="btnUpdate" class="btn btn-primary" style="float:left;margin-left:5px;">변경</button>
												<button type="button" id="deleteOrder" class="btn btn-danger" style="float:right;">이 주문 삭제하기</button>
											</td>
										</tr>
									</table>
								</div>
								
								
								<!-- [3번 테이블(결제정보)] -->
								<div class="col-sm-12">
								<table class="table table-striped text-center" id="table_3">
									<tr>






									</tr>
								</table>
								</div>





							</div>
						</div>
					</form>	
					</div>
				</div>
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
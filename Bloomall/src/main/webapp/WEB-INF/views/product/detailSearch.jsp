<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<style type="text/css">
.prd_title{
	color:black;
	font-weight:bold;
	font-size: 24px;
}
.prd_info, .rvwCount, .org_price, .point_benefit, .basic_notice{
	color: grey;
	font-size: 14px;
}
.basic_notice{
	line-height: 220%;
}
.stars{
	font-size: 28px;
}
hr{
	border-top: 1px solid rgb(167, 167, 167);
}
#recent_r{
	font-weight:bold;
	font-size:14px;
}
#on_sale{
	font-weight:bold;
	font-size:16px;
}
#btn_addCart, #btn_purchaseNow {
	width:40%;
	height:40px;
	font-weight:bold;
	font-size:16px;
	margin-right:5px;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript" src="/js/product/detail.js"></script>

<%-- 핸들바: 리뷰목록 --%>
<script id="template" type="text/x-handlebars-template">




</script>


<script>
$(function(){
	// 리뷰 핸들바
	// 날짜 형식
	
	
	
	// 파라미터로 받은 후기 평점을 별표로 출력
	
	
	
	
	// 로그인 여부에 따라 사용자 본인의 리뷰 수정/확인 버튼 활성화
	
	
	
	
	
	
	// 상품 목록 버튼 btnGoList => 리스트(카테고리 페이징 정보) 
	$("#btnGoList").click(function(){
		location.href = "/product/list${pageMaker.makeSearch(pageMaker.cri.page)}";
		
	});
	
	// [판매중/품절] 여부에 따른 색 변화
	if("${on_sale}"=="판매중"){ // [판매중]일 경우
		$("#on_sale").css("color","blue");
	}else{		// [품절]일 경우
		$("#on_sale").css("color","red");
		$(".in_stock").hide();
		$(".out_of_stock").show();
	}
});

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
					Product Detail <small>상품 상세</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i>Product</a>
					</li>
					<li class="active">Detail</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<div class="col-lg-9">
				<!-- 상품상세 폼 -->
				<div class="row">
					<!-- upper column -->
					<div class="col-md-12">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">PRODUCT DETAIL</h3>
							</div>
							<!-- /.box-header -->
								<div class="box-body">
								<div class="prd_img&info">
									<div class="col-sm-4">
										<div class="form-group" style="text-align:center;">
											<input type="hidden" name="prd_idx" value="${vo.prd_idx }" />
											<img src="/admin/product/fileDisplay?fileName=${vo.prd_img }" title="${vo.prd_title }" alt="${vo.prd_title }" style="width:80%;" />
										</div>
									</div>
									<div class="col-sm-8">
										<div class="form-group">
											<span class="prd_title">${vo.prd_title}</span>&nbsp;
										</div>
										<div class="form-group prd_info">
											<span class="prd_author">${vo.prd_author} 저</span> 
											<span class='divi'>&nbsp;|&nbsp;</span>
											<span class="prd_author">${vo.prd_company}</span> 
											<span class='divi'>&nbsp;|&nbsp;</span>
											<span class="category">[${prt_name}</span>
											<span class='subArrow'>&nbsp;>&nbsp;</span>
											<span class="category">${ctgr_name}]</span>
										</div>
										
										<hr style="margin-bottom:0px;margin-left:3px;width:97%;text-align:left;">
										
										<div class="col-xs-7 price" style="margin-top: 25px;">
											<div class="form-group">
												<table style="width:70%;margin-bottom:10px;">
													<tr class="org_price">
														<td style="width:50%">정가</td>
														<td>${vo.prd_price}원</td>
													</tr>
													<tr class="dc_price">
														<td style="font-weight:bold; height:60px;">판매가</td>
														<td><span style="font-weight:bold; font-size:32px; color:rgb(255, 130, 113);">${vo.prd_dc_price}</span>원 </td>
													</tr>
													<tr class="point_benefit">
														<td>BLOOM 포인트</td>
														<td><fmt:formatNumber value="${vo.prd_price * 0.03}" pattern="###,###,###" />원&nbsp;(3% 적립)</td>
													</tr>
												</table>
											</div>
											<hr>
											<div class="form-group purchase_info">
												<p id="on_sale"> ${on_sale} </p>
												<div class="in_stock">
													<form method="get" action="/order/purchase" >
														<label for="ord_amount">수량</label><br>
														<input type="number" id="ord_amount" name="ord_amount" value="1" /><br><br>
														<input type="hidden" id="prd_idx" name="prd_idx" value="${vo.prd_idx}" />
														<!-- 장바구니 기능으로 진행. js 파일에서 따로 jQuery 작업 -->
														<button type="button" id="btn_addCart" class="btn btn-primary">장바구니</button>
														<button type="submit" id="btn_purchaseNow" class="btn btn-default">바로구매</button>
													</form>
												</div>
												<%-- [품절] 시 나타나는 문구 begin --%>
												<div class="out_of_stock" style="display:none;">
													<table style="width:100%;">
													<tr class="out_of_stock_notice" style="height:70px;">
														<td style="width:35%">구매 시 참고사항</td>
														<td><p>현재 새 상품은 구매할 수 없습니다. 중고상품을 구매하거나 판매 해보세요.</p></td>
													</tr>
													</table>
												</div>	
												<%-- [품절] 시 나타나는 문구 end --%>
												<hr>
												<div>
													<ul class="basic_notice">
										                <li>해외배송 가능</li>
									                    <li>문화비소득공제 신청가능</li>
										            </ul>
 													
												</div>
													
													
													
													
													
											</div>
										</div>
										<div class="col-xs-5" style="background-color:rgb(216, 216, 216);width:39%;height:415px;">
											<div style="margin-top: 25px;">
												<div class="form-group">
													<div class="stars">
												        <label for="stars-rating-5"><i class="fa fa-star text-primary"></i></label>
											    	    <label for="stars-rating-4"><i class="fa fa-star text-primary"></i></label>
											        	<label for="stars-rating-3"><i class="fa fa-star text-primary"></i></label>
											        	<label for="stars-rating-2"><i class="fa fa-star text-primary"></i></label>
											         	<label for="stars-rating-1"><i class="fa fa-star text-default"></i></label>
											         	<b style="color:black; font-size:22px">9.3 <br></b>
			         				<!-- 해결되면 이 줄 삭제 --><em style="color:red;font-size:14px;font-weight:bold;">(평점 EL 문법으로 표시)</em>
											         	
											         	
													</div>
													<div class="rvwCount">
														판매지수 <span style="color:red;"> (판매count 넣기)</span>
														<span class='divi'>&nbsp;|&nbsp;</span>
														회원리뷰 (<a href="#">${rvwCount}</a>건) <!-- <a>태그 같은페이지 anchor로 아래 리뷰위치로 이동 -->
													</div>
												</div>
											
												<hr>
												
												<div class="form-group recent_rvws">
													<div id="recent_r">최근 회원리뷰</div>
												
												
												
												</div>
											
												<br><br>
												리뷰자리 - 최근 리뷰 3~5? 정도
												<br><br>
												   OR    아이디랑 별점만 5~7개 정도 주루룩 (별 작게)
											</div>
										
										</div>
									</div>
									<!-- class="col-sm-8" end -->
									
											
										
									
								</div>
									
								<div class="col-sm-12 prd_info_detail">
									<div class="form-group prd_detail" style="margin-left:3%;width:95%;">
										<label style="font-weight:bold;margin-left:2%"></label>
										<div contenteditable="false" style="border: 1px solid #d2d2d2; padding: 20px;">
										<div style="font-weight:bold;font-size:16px">책소개</div><br>
											${vo.prd_detail }
										</div>
									</div>
								</div>
									
							</div>


								<!-- /.box-body -->

								<div class="box-footer" style="margin-left:1%;">
									<button id="btnGoList" type="button" class="btn btn-primary">목록	</button>
								</div>
								
								
								
								
								</div>

						</div>
						<!-- /.box -->	
					</div>
					<!--/.col (left) -->
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
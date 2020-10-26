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
.rvwCount, .noStarRvw{
	color: grey;
	font-size: 12px;
}
.prd_info, .org_price, .point_benefit, .basic_notice{
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
#star_score a{
 	font-size:22px;
    text-decoration: none;
    color: lightgray;
}
#star_score a.on{
    color:#4e789c;
}

.popup {
	position: absolute;
}
.back { 
	background-color: gray; 
	opacity:0.5; 
	width: 100%; 
	height: 300%; 
	overflow:hidden;  
	z-index:1101;
}
.front { 
	z-index:1110; 
	opacity:1; 
	border:1px; 
	margin: auto; 
}
.star_title{
	font-size:10px;
	color:grey;
}
.stars_right{
	color:#4e789c;
	line-height:80%;
}
.starUl{
	list-style-type: none;
	margin: 0;
	padding: 0;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript" src="/js/product/detail.js"></script>

<%-- 핸들바: 리뷰리스트 --%>
<script id="rvwTemplate" type="text/x-handlebars-template">
	{{#each .}}
		<li class="rvwList openList" data-rvw_idx={{rvw_idx}}>
			<i class="fa fa-comments bg-blue"></i>
			<div class="timeline-item">
				<span class="time">
					<i class="fa fa-clock-o"></i>{{tidyDate rvw_regdate}}
				</span>
				<h3 class="timeline-header">
					<strong>
						{{checkRating rvw_rating}}
						<p class="rvw_rating" style="display:inline-block;">{{rvw_rating}}</p>
					</strong>
				</h3>
				<div class="timeline-body">
					<span style="color:grey;font-size:12px;">글번호: {{rvw_idx}}</span>
					<p style="float:right;">작성자: {{mem_id}}</p> <br>
					<p id="rvw_content">{{rvw_content}}</p>
				</div>
				<%-- 핸들바 수정 포맷(수정 버튼 클릭시 나타남) --%>
				<div class="editFormat" style="display:none;">
					<label>리뷰를 수정해주세요</label><br>
					<div class="rating">
						<p id="star_score_hb">
							<a href="#">★</a>
							<a href="#">★</a>
							<a href="#">★</a>
							<a href="#">★</a>
						 	<a href="#">★</a>
						</p>
					</div>
					<textarea id="r_content_hb" rows="3" style="width:100%;" placeholder=" 후기를 작성해 주세요.">{{rvw_content}}</textarea><br>
				</div>
				<%-- 수정 포맷 end --%>
				<div class="timeline-footer" style="float:right;">
					<input type="hidden" name="rvw_idx" value="{{rvw_idx}}" />
					<input type="hidden" name="replyer" value="{{mem_id}}" />
					<input type="hidden" name="rvw_content" value="{{rvw_content}}" />
					{{checkReplyer mem_id rvw_idx}}
				</div>
			</div>



		</li>
	{{/each}}
</script>

<%-- 핸들바: 별점 리스트 --%>
<script id="starTemplate" type="text/x-handlebars-template">
	{{#each .}}
		<li class="rvwList" data-rvw_idx={{rvw_idx}}>
			<div class="timeline-item">
				<div class="star_title">
					<span style="float:left;">{{tidyDate rvw_regdate}}</span>
					<span style="float:right;">작성자: {{mem_id}}</span> <br>
				</div>
				<h6 class="stars_right">
					<strong>
						{{checkRating rvw_rating}}
					</strong>
				</h6>
			</div>
		</li>
	{{/each}}
	<br>
</script>

<script>
$(function(){
	
	/* 핸들바 적용, 날짜 형식 tidyDate, 후기평점 별표출력 checkRating 코드 => detail.js파일 */
	
	// 로그인 여부에 따라 사용자 본인의 리뷰 수정/확인 버튼 활성화 checkReplyer
	Handlebars.registerHelper("checkReplyer", function(replyer_id, rvw_idx){
		
		// 수정/삭제 버튼 html
		var button_html = "";
		
		// 리뷰 작성자와 사용자의 아이디가 일치할 경우
		if(replyer_id == "${sessionScope.user.mem_id}"){
			button_html = "<button name='btn_rvwEdit' class='btn_rvwEdit btn btn-primary btn-xs' type='button'>수정</button>"
						+ "<button name='btn_rvwEdit' class='btn_rvwDelete btn btn-danger btn-xs' onclick='deleteRvw("+ rvw_idx +")' type='button' style='margin-left:5px;'>삭제</button>"
		}
		return new Handlebars.SafeString(button_html);
	});
	
	
	// 상품 목록 버튼 btnGoList => 리스트(카테고리 페이징 정보) 
	$("#btnGoList").click(function(){
		// all, 1차, 2차 카테고리 돌아가는 리스트 페이징 다르게 적용
		if("${ctgr_cd}" == "all"){
			// 모든 상품 목록 페이징
			location.href = "/product/list${pageMaker.makeQuery(pageMaker.cri.page)}&ctgr_cd=all";
		}else{
			if("${prime_ctgr_cd}" == null || "${prime_ctgr_cd}" == ""){
				// 2차 카테고리 목록 페이징
				location.href = "/product/list${pageMaker.makeQuery(pageMaker.cri.page)}&ctgr_cd=${vo.ctgr_cd}";
			}else{
				// 1차 카테고리 목록 페이징
				location.href = "/product/list${pageMaker.makeQuery(pageMaker.cri.page)}&prime_ctgr_cd=${prime_ctgr_cd}";
			}
		}
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
								<h3 class="box-title">상품상세</h3>
							</div>
							<!-- /.box-header -->
								<div class="box-body">
									<div class="prd_img&info">
										<div class="col-sm-4">
											<div class="form-group" style="text-align:center;">
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
											<div class="col-xs-5" style="background-color:rgb(216, 216, 216);width:39%;">
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
															회원리뷰 (<a href="#" class="toRvw">${rvwCount}</a>건) <!-- 클릭시 리뷰 앵커 / 펼쳐짐 기능 js-->
														</div>
													</div>
												
													<hr>
													
													<div class="form-group recent_rvws">
														<div id="recent_rvw" style="font-weight:bold;">최근 회원리뷰</div>
														<br>
														<div>
															<ul class="starUl">
																<li id="starRvwList" style="margin-left:0;">
																	<!-- 별점 핸들바 위치 -->
																</li>
																<li class="noStarRvw" style="display:none;margin-left:0;">
																	<div>
																		 <p style="text-align:center;line-height:230%;">
																		 	<br>
																			상품 리뷰가 존재하지 않습니다.<br>
																			첫 번째 리뷰어가 되어주세요:)
																			<br><br><br><br><br><br>
																		</p>
																	</div>
																</li>
															</ul>
														</div>
															<!-- 클릭시 리뷰 앵커 / 펼쳐짐 기능 js-->	
															<a href="#" id="more_rvw" class="toRvw" style="float:right;"><b>리뷰 자세히 보기 >></b></a>
															<br>	
													</div>
												</div>
											</div>
										</div>
										<!-- class="col-sm-8" end -->
									</div>
									<%-- 상품상세 --%>
									<div class="col-sm-12 prd_info_detail">
										<div class="form-group prd_detail" style="margin-left:3%;width:95%;">
											<label style="font-weight:bold;margin-left:2%"></label>
											<div contenteditable="false" style="border: 1px solid #d2d2d2; padding: 20px;">
												<div style="font-weight:bold;font-size:16px">책소개</div><br>
													${vo.prd_detail }
											</div>
										</div>
									</div>
								
								
								
								
								<%--================================================================================================--%>
								
								<%-- 리뷰 --%>
								<div class="col-sm-12 review_area" style="margin-left:3%;width:95%;">
									<br>
									<div class="popup back" style="display:none;"></div>
								    <div id="popup_front" class="popup front" style="display:none;">
								     	<img id="popup_img">
								    </div>
							    	<form role="form" action="editPage" method="post">
										<input type="hidden" name="rv_prd_idx" value="${vo.prd_idx }"> 
										<input type="hidden" name="page" value="${cri.page}"> 
										<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
										<%-- 
										<input type="hidden" name="searchType" value="${cri.searchType}">
										<input type="hidden" name="keyword" value="${cri.keyword}">
										 --%>
									</form>
									
									<div>
										<!-- 상품후기쓰기 부분 -->
										 <div>
											<label for="review">Review</label><br>
											<div class="rating">
												<p id="star_score">
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
												</p>
											</div>
											<textarea id="reviewContent" rows="3" style="width:100%;" placeholder=" 후기를 작성해 주세요."></textarea><br>
										
											<!-- 상품 후기 리스트 -->
										 	<ul class="timeline">
					 							 <!-- timeline time label -->
												<li class="time-label" id="repliesDiv">
													<span class="btn btn-default">
												    	<span>리뷰보기</span> <small id="s_rvwCount"> [ ${rvwCount} ] </small>
												    </span>
												    <button class="btn btn-primary" id="btn_writeRvw" type="button">리뷰작성</button>
												</li>
												<li class="noReview" style="display:none;">
													<i class="fa fa-comments bg-blue"></i>
													<div class="timeline-item" >
														 <h3 class="timeline-header" style="text-align:center;line-height:170%;">
															상품 리뷰가 존재하지 않습니다.<br>
															첫 번째 리뷰어가 되어주세요:)</h3>
													</div>
												</li>
											</ul>
											<!-- 상품 후기 리스트 페이지부분 -->  
											<div class='text-center'>
												<ul id="pagination" class="pagination pagination-sm no-margin "></ul>
										 	</div>
										 </div>
									</div>
								</div>
								<%-- 리뷰 끝 --%>


								<!-- /.box-body -->
								<%-- [목록] 버튼 --%>
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
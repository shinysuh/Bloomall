<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<style type="text/css">
.product_title {
	color: black;
	fonr-weight: bold;
}

td{
	padding: 7px;
}
.dc_price{
	color: black;
	font-size: 20px;
	font-weight: bold;
}
.org_price{
	color: darkgrey;
	font-size: 12px;
}
.point_benefit{
	color: rgb(64, 126, 167);
	font-size: 12px;
}
.dotted_hr{
	border-top: 1px dotted grey;
	margin-left: 0;
	width:90%;
}
.info, .price, .rvwCount, .rating{
	font-size: 12px;
}
.product_img{
	text-align: center;
}
.stars{
	font-size: 16px;
}

</style>
<script type="text/javascript">
$(function(){
	
	// 체크 상품 장바구니
	
	
	
	// 체크 상품 위시리스트
	
	
	
	// 장바구니
	
	
	
	
	// 바로구매
	
	
	
	
	
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
				<!-- "/product/list?ctgr_cd=all" => '모든 상품' 출력 -->
				<c:if test="${ctgr_cd == 'all'}">
					<h1>
						Product List <small>${ctgr_name }</small>
					</h1>
					<ol class="breadcrumb">
						<li>
							<a href="/product/list?ctgr_cd=all"><i class="fa fa-dashboard"></i> Product</a>
						</li>
						<li>All</li>
					</ol>
				</c:if>
				<!-- "/product/list?ctgr_cd=${ctgr_cd}" => ${prt_name } 출력 -->
				<c:if test="${ctgr_cd ne 'all'}">
					<c:if test="${empty prt_name}">
						<h1>
							Product List <small>${ctgr_name }</small>
						</h1>
							<ol class="breadcrumb">
							<li>
								<a href="/product/list?ctgr_cd=${ctgr_cd }"><i class="fa fa-dashboard"></i> Product</a>
							</li>
							<li>${ctgr_name }</li>
						</ol>
					</c:if>
					<c:if test="${!empty prt_name}">
						<h1>
							Product List <small>${prt_name }</small>
						</h1>
							<ol class="breadcrumb">
							<li>
								<a href="/product/list?ctgr_cd=${ctgr_cd }"><i class="fa fa-dashboard"></i> Product</a>
							</li>
							<li>${prt_name }</li>
						</ol>
					</c:if>
				</c:if>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
				<!-- 상품목록 -->
				<div class="col-md-9">
					<div>
					<h5><i class="fa fa-book"></i> ${ctgr_name }</h5>


<%-- 베스트셀러 : 데모소스 리스트 형식 가져와서 한번에 4개씩 보이게? --%>







						<div style="display: inline-block; float: right; margin-right:10%;">
							<button type="button" id="btnDelChk" class="btn btn-default">&#9745;장바구니</button>					
							<button type="button" id="btnRegi" class="btn btn-default">&#9745;바로구매</button>					
						</div>
					<br><hr class="dotted_hr"><br>
					</div>
				
				<!-- 상품 리스트 테이블 시작 -->
					<div class="productList productList_list">
					    <table width="90%">					
					        <colgroup>
							    <col width="95"/>
							    <col/>
							    <col width="82"/>
						    </colgroup>
						    
						    
						    <%-- 검색 조건에 일치하는 상품이 없는 경우 --%>
							<c:if test="${empty productList}">
							<tr>
								<p style="padding:50px 0px; text-align: center;border-collapse: collapse;">등록된 상품이 존재하지 않습니다.</p>
							</tr>
							</c:if>
							
							<%-- 검색 조건에 일치하는 상품이 존재하는 경우 --%>
					        <!-- 상품 목록 시작-->
					        <c:forEach items="${productList}" var="prdList">	    
					        <tr>
					      		<td class="product_img" style="width:13%;height:140%">
					            	<div class="ico_wrap"></div>
					            	<input type="hidden" name="prd_idx" value="${prdList.prd_idx}" />
				            		<%-- 책 이미지 링크 begin --%>
					            	<c:if test="${ctgr_cd == 'all' || !empty prt_name}">
					            		<!-- 모든상품/2차카테고리 -->
						            	<a href="/product/detail${pageMaker.makeQuery(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}&ctgr_cd=${ctgr_cd}">
						                <img src="/product/fileDisplay?fileName=${prdList.prd_img }" alt="${prdList.prd_title}"></a>
					            	</c:if>
									<c:if test="${empty prt_name && ctgr_cd != 'all'}">
										<!-- 1차카테고리 -->
						            	<a href="/product/detail${pageMaker.makeQuery(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}&prime_ctgr_cd=${prime_ctgr_cd}">
						                <img src="/product/fileDisplay?fileName=${prdList.prd_img }" alt="${prdList.prd_title}"></a>
									</c:if>
					            	<%-- 책 이미지 링크 end --%>
								</td>
								<td class="product_info" style="line-height:170%;">
									<div>&nbsp;</div>
									<%-- 책제목 링크 begin --%>
									<c:if test="${ctgr_cd == 'all' || !empty prt_name}">
					            		<!-- 모든상품/2차카테고리 -->
										<a href="/product/detail${pageMaker.makeQuery(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}&ctgr_cd=${ctgr_cd}">
										<strong style="color:black;font-size:17px;">${prdList.prd_title}</strong>
										</a>
					            	</c:if>
									<c:if test="${empty prt_name && ctgr_cd != 'all'}">
										<!-- 1차카테고리 -->
										<a href="/product/detail${pageMaker.makeQuery(pageMaker.cri.page)}&prd_idx=${prdList.prd_idx}&prime_ctgr_cd=${prime_ctgr_cd}">
										<strong style="color:black;font-size:17px;">${prdList.prd_title}</strong>
										</a>
									</c:if>
									<%-- 책제목 링크 end --%>
									<div class="info">
										${prdList.prd_author} 저 <span class='dim_txt002'>|</span>${prdList.prd_company}
									</div>
									<div class="price">
										판매가: <span class="dc_price">${prdList.prd_dc_price}</span>원 
										<br>
										<span class="org_price">정가: ${prdList.prd_price}원 </span> <em class="divi">|</em>
										<span class="point_benefit">포인트 적립: <fmt:formatNumber value="${prdList.prd_price * 0.03}" pattern="###,###,###" /></span>
									</div>
									<div class="rating_info">
										<span class="rvwCount">
											판매지수 <span style="color:red;"> (판매count 넣기)</span><em class="divi">|</em>
											회원리뷰 <a href="#">${rvwCount}</a>건
										</span><br>
										<span class="rating">평점: </span>
										<span class="stars">
									        <label for="stars-rating-5"><i class="fa fa-star text-primary"></i></label>
								    	    <label for="stars-rating-4"><i class="fa fa-star text-primary"></i></label>
								        	<label for="stars-rating-3"><i class="fa fa-star text-primary"></i></label>
								        	<label for="stars-rating-2"><i class="fa fa-star text-primary"></i></label>
								         	<label for="stars-rating-1"><i class="fa fa-star text-default"></i></label>
								         	<b style="color:red;">9.3 (평점 EL 문법으로 표시)</b>
										</span>
									</div>
									<br>
								</td>
								<td class="buttons">
									<input type="hidden" name="idx_${prdList.prd_idx }" value="${prdList.prd_idx }" />
									
									<span class="prd_count_edit">
										<input type="checkbox" class="check" />
										<span class="count">수량</span>
										<input type="text" class="count_input" value="1" name="count_input" style="width:70%;" />
									</span>
									<button type="button" class="btn btn-primary" style="width:100%;">장바구니</button>
									<button type="button" class="btn btn-default" style="width:100%;">바로구매</button>
								</td>
							</tr>     
							</c:forEach>            
						</table>
						<!-- 상품 리스트 테이블 끝 -->
					</div>
					
					<%-- 페이징 --%>
					<div class="paging">
						<div class="text-center">
						
							<c:if test="${ctgr_cd == 'all' || !empty prt_name}">
								<!-- 모든상품/2차카테고리 -->
								<ul class="pagination">
									<!-- [이전] 표시 -->
									<c:if test="${pageMaker.prev }">
										<li>
											<a href="/product/list${pageMaker.makeQuery(pageMaker.cri.page - 1)}&ctgr_cd=${ctgr_cd}">[이전]</a>
										</li>
									</c:if>
									<!-- 페이지 번호 표시 -->
									<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx" >
										<li <c:out value="${pageMaker.cri.page == idx?'class=active':''}" />>
											<a 
											 href="/product/list${pageMaker.makeQuery(idx) }&ctgr_cd=${ctgr_cd}">${idx}</a>
										</li>
									</c:forEach>
								
									<!-- [다음] 표시 -->
									<c:if test="${pageMaker.next }">
										<li>
											<a href="/product/list${pageMaker.makeQuery(pageMaker.cri.page + 1)}&ctgr_cd=${ctgr_cd}">[다음]</a>
										</li>
									</c:if>
								</ul>
							</c:if>
							<c:if test="${empty prt_name && ctgr_cd != 'all'}">
								<!-- 1차 카테고리 -->
								<ul class="pagination">
									<!-- [이전] 표시 -->
									<c:if test="${pageMaker.prev }">
										<li>
											<a href="/product/list${pageMaker.makeQuery(pageMaker.startPage - 1)}&prime_ctgr_cd=${prime_ctgr_cd}">[이전]</a>
										</li>
									</c:if>
									<!-- 페이지 번호 표시 -->
									<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx" >
										<li <c:out value="${pageMaker.cri.page == idx?'class=active':'' }" />>
											<a 
											 href="/product/list${pageMaker.makeQuery(idx) }&prime_ctgr_cd=${prime_ctgr_cd}">${idx }</a>
										</li>
									</c:forEach>
								
									<!-- [다음] 표시 -->
									<c:if test="${pageMaker.next }">
										<li>
											<a href="/product/list${pageMaker.makeQuery(pageMaker.endPage + 1 )}&prime_ctgr_cd=${prime_ctgr_cd}">[다음]</a>
										</li>
									</c:if>
								</ul>
							</c:if>
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
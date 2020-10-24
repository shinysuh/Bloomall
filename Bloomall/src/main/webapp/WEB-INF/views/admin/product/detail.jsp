<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<script>
$(function(){
	// 목록 버튼
	$("#btnGoList").click(function(){
		location.href = "/admin/product/list${pageMaker.makeSearch(pageMaker.cri.page)}";
	});
	
	// 수정 버튼
	$("#btnGoUpdate").click(function(){
		location.href = "/admin/product/update${pageMaker.makeSearch(pageMaker.cri.page)}&prd_idx=${vo.prd_idx}";
	});
	
	// 삭제 버튼
	$("#btnDelete").click(function(){
		if(confirm("'${vo.prd_title}' 상품을 삭제하시겠습니까?")){
			$(".deleteForm").submit();
		}else{}
	});
});
</script>
</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
		<%@include file="/WEB-INF/views/include/main_header_ad.jsp" %>

		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/views/include/left_sidebar_ad.jsp" %>
		

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Admin Page <small>상품 상세</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/admin/product/list"><i class="fa fa-dashboard"></i>상품관리</a>
					</li>
					<li class="active">상품 상세</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<!-- 상품상세 폼 -->
				<div class="row">
					<!-- left column -->
					<div class="col-md-12">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">PRODUCT DETAIL</h3>
							</div>
							<!-- /.box-header -->
								<div class="box-body">
									<div class="form-group">
										<input type="hidden" name="prd_idx" value="${vo.prd_idx }" />
										<label for="primaryCategory" style="width:40%; margin-right:10px;" >1차 카테고리</label>
										<label for="secondaryCategory" style="width:40%;" >2차 카테고리</label> <br>
										<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.ctgr_prt_cd}</span>
										<span class="form-control" style="width:40%; display:inline-block;">${vo.ctgr_cd}</span>
									</div>
									<div class="form-group">
										<label for="prd_title" style="width:40%; margin-right:10px;">책제목</label> 
										<label for="prd_author" style="width:40%;">저자</label> 
										<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.prd_title}</span>
										<span class="form-control" style="width:40%; display:inline-block;">${vo.prd_author}</span>
									</div>
									<div class="form-group">
										<label for="prd_company">출판사</label>
										<span class="form-control" style="width:81%;">${vo.prd_company }</span>
									</div>
									<div class="form-group">
										<label for="prd_price" style="width:40%; margin-right:10px;">가격</label> 
										<label for="prd_dc_price" style="width:40%;">할인 적용 가격</label> 
										<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.prd_price}</span>
										<span class="form-control" style="width:40%; display:inline-block;">${vo.prd_dc_price}</span>
									</div>
									<div class="form-group">
										<label for="prd_detail">상세정보</label>
										<div contenteditable="false" style="border: 1px solid #d2d2d2; padding: 20px;">
											${vo.prd_detail }
										</div>
									</div>
									<div class="form-group">
										<label for="file1">상품 이미지(썸네일)</label>
										<span class="form-control"><c:out value="${vo.prd_img }" /> </span>
										<img src="/admin/product/fileDisplay?fileName=${vo.prd_img }" title="Thumnail Img" alt="Thumnail Image" style="width:80px;" />
									</div>
									<div class="form-group">
										<label for="prd_amount" style="width:40%; margin-right:10px;">재고수량</label> 
										<label for="prd_in_stock" style="width:40%;">구매 가능 여부</label><br>
										<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.prd_amount}</span>
										<span class="form-control" style="width:40%; display:inline-block;">${vo.prd_in_stock}</span>
									</div>
									<div class="form-group">
										<label for="prd_regdate" style="width:40%; margin-right:10px;">상품등록 날짜</label> 
										<label for="prd_updatedate" style="width:40%;">상품수정 날짜</label> <br>
										<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">
											<fmt:formatDate value="${vo.prd_regdate}" pattern="yyyy-MM-dd HH:mm"/></span>
										<span class="form-control" style="width:40%; display: inline-block;">
											<fmt:formatDate value="${vo.prd_updatedate}" pattern="yyyy-MM-dd HH:mm"/></span>
									</div>
								</div>

								<!-- /.box-body -->

								<div class="box-footer">
									<div>
										<hr>
									</div>

									<ul class="mailbox-attachments clearfix uploadedList">
									</ul>
									<form class="deleteForm" method="post" action="/admin/product/delete${pageMaker.makeSearch(pageMaker.cri.page)}">
										<!-- 상품번호/이미지 정보 hidden -->
										<input type="hidden" value="${vo.prd_idx }"  name="prd_idx"/>
										<input type="hidden" value="${vo.prd_title }"  name="prd_title"/>
										<input type="hidden" value="${vo.prd_img }" name="prd_img" />
	
										<button id="btnGoList" type="button" class="btn btn-primary">목록	</button>
										<button id="btnGoUpdate" type="button" class="btn btn-default">수정</button>
										<button id="btnDelete" type="button" class="btn btn-danger">삭제</button>

									</form>
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
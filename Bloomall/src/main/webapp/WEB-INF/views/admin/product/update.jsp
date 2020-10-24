<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<script src="/ckeditor/ckeditor.js"></script>
<!-- 핸들바.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript" src="/js/admin/product/update.js"></script>

<!-- 핸들바 템플릿 -->
<script id="secondaryCtgrHandlebar" type="text/x-handlebars-template">
	<option value="default">선택 2</option>
	{{#each .}}
	<option value="{{ctgr_cd}}">{{ctgr_name}}</option>
	{{/each}}
</script>

<!-- 2차카테고리 / ckEditor -->
<script>
// 2차 카테고리 핸들바 템플릿 적용
function secCtgrList(secCategory, target, templateObj){
	
	var template = Handlebars.compile(templateObj.html());
	var options = template(secCategory);
	
	// 기존 <option>선택2</option> 제거 - 중복/누적 방지
	$("#secCategory option").remove();
	target.append(options);
}

$(function(){
	// 1차 카테고리에 따른 2차 카테고리 핸들바에 디스플레이
	$("#primaryCategory").on("change", function(){
		var primaryCtgr = $(this).val();
		var url = "/admin/product/subCategory/" + primaryCtgr;  // AdProduct컨트롤러 subCategoryList() 매핑 @PathVariable
		
		// REST 방식 전송
		$.getJSON(url, function(data){
			secCtgrList(data, $("#secCategory"), $("#secondaryCtgrHandlebar"));
		});
	});
	
// ckEditor
	var ckeditor_config = {
		resize_enabled	: false,
		enterMode		: CKEDITOR.ENTER_BR,	// Enter 키 입력시,<br>로 인식
		shiftEnterMode	: CKEDITOR.ENTER_P,		// shift+Enter : <p> 생성
		toolbarCanCollapse : true,
		removePlugins	: "elementspath",
		// 파일 업로드 기능 탭 추가
		filebrowserUploadUrl: "admin/product/imageUpload"
	};
	CKEDITOR.replace("prd_detail", ckeditor_config);	// config.js의 설정 사용시, CKEDITOR.replace("desc", ""); 로 사용

// 취소 버튼(btnCancel) => 목록으로 돌아감
	$("#btnCancel").click(function(){
		if(confirm("상품수정을 취소하시겠습니까?")){
			location.href = "/admin/product/list${pageMaker.makeSearch(pageMaker.cri.page)}";
		}else{}
	});



// 이미지 파일 변경 시
	$("#file1").on("change", function(){
		$("#fileName").css("color", "blue");
		$("#fileName").html("파일이 변경되었습니다.");	
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
					Admin Page <small>상품수정</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/admin/product/list"><i class="fa fa-dashboard"></i>상품관리</a>
					</li>
					<li class="active">상품수정</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<!-- 상품수정 폼 -->
				<div class="row">
					<!-- left column -->
					<div class="col-md-12">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">EDIT PRODUCT</h3>
							</div>
							<!-- /.box-header -->

							<form id="updateForm" role="form" action="/admin/product/update" method="post" enctype="multipart/form-data">
								<div class="box-body">
									<div class="form-group">
										<input type="hidden" name="page" value="${cri.page }" />
										<input type="hidden" name="perPageNum" value="${cri.perPageNum }" />
										<input type="hidden" name="searchType" value="${cri.searchType }" />
										<input type="hidden" name="keyword" value="${cri.keyword }" />
									</div>
									<div class="form-group">
										<input type="hidden" name="prd_idx" value="${vo.prd_idx }" />
										<label for="primaryCategory" style="width:30%; margin-right:20px;" >1차 카테고리</label>
										<label for="secCategory" style="width:30%;" >2차 카테고리</label> <br>
										<select class="form-control" id="primaryCategory" name="ctgr_prt_cd" style="width:30%; margin-right:10px; display: inline-block;" >
										  <option value="default">선택 1</option>
										  <c:forEach items="${ctgrList}" var="list">
										  	<option value="${list.ctgr_cd}" <c:out value="${vo.ctgr_prt_cd == list.ctgr_cd?'selected':'' }" />>${list.ctgr_name}</option>
										  </c:forEach>
										</select>
										<select class="form-control" id="secCategory" name="ctgr_cd" style="width: 30%; display: inline-block;">
										 	<option value="default">선택 2</option>
											<c:forEach items="${subCtgrList}" var="subList">
										 		<option value="${subList.ctgr_cd }" <c:out value="${vo.ctgr_cd == subList.ctgr_cd?'selected':'' }" />>${subList.ctgr_name}</option>
										 	</c:forEach>
										</select>
									</div>
									<div class="form-group">
										<label for="prd_title" style="width:40%; margin-right:10px;">제목</label> 
										<label for="prd_author" style="width:40%;">저자</label> 
										<input style="width:40%; margin-right:10px; display: inline-block;"
											type="text" id="prd_title" name="prd_title" class="form-control" 
											placeholder="Enter Product name" value="${vo.prd_title }" />
										<input type="text" id="prd_author" name="prd_author" class="form-control "
											placeholder="Enter Author name" value="${vo.prd_author }" style="width:40%; display: inline-block;" />
									</div>
									<div class="form-group">
										<label for="prd_company">출판사</label>
										<input type="text" id="prd_company" name="prd_company" class="form-control"
											placeholder="Enter company" value="${vo.prd_company }" style="width:81%;">
									</div>
									<div class="form-group">
										<label for="prd_price" style="width:40%; margin-right:10px;">가격</label> 
										<label for="prd_dc_price" style="width:40%;">할인 적용 가격</label> 
										<input style="width:40%; margin-right:10px; display: inline-block;"
											type="text" id="prd_price" name="prd_price" class="form-control" 
											placeholder="Enter price" value="${vo.prd_price }" />
										<input type="text" id="prd_dc_price" name="prd_dc_price" class="form-control "
											placeholder="Enter discounted price" value="${vo.prd_dc_price }" style="width:40%; display: inline-block;" />
									</div>
									<div class="form-group">
										<label for="prd_detail">상세정보</label>
										<textarea class="form-control" id="prd_detail" name="prd_detail" rows="8"
										 placeholder="Enter ...">${vo.prd_detail }</textarea>
									</div>

									<div class="form-group">
										<input type="hidden" name="prd_img" value="${vo.prd_img }" />
										<label for="file1">상품 이미지(썸네일)</label>
										<span id="fileName" style="margin-left:5px; font-size:14px;">현재 저장된 파일명: <c:out value="${orignalFile }" /></span>
										<input type="file" id="file1" name="file1" class="form-control" />
									</div>
									
									<div class="form-group">
										<label for="prd_amount" style="width:30%; margin-right:10px;">재고수량</label> 
										<label for="prd_in_stock" style="width:15%;">구매 가능 여부</label><br> 
										<input style="width:30%; margin-right:10px; display: inline-block;"
											type="text" id="prd_amount" name='prd_amount' class="form-control" 
											placeholder="Enter Amount" value="${vo.prd_amount}"/>
										<select class="form-control" id="prd_in_stock" name="prd_in_stock" style="width: 15%; display: inline-block;">
										  <option <c:out value="${vo.prd_in_stock == 'Y'? 'selected':'' }" />>Y</option>
										  <option <c:out value="${vo.prd_in_stock == 'N'? 'selected':'' }" />>N</option>
										</select>
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

									<button id="btnUpdate" type="button" class="btn btn-primary">
										상품수정<i class="fa fa-check spaceLeft"></i>
									</button>
									<button id="btnCancel" type="button" class="btn btn-danger">
										취소<i class="fa fa-times spaceLeft"></i>
									</button>

								</div>
							</form>


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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<head>
<script type="text/javascript">
	if("${msg}" == "PRODUCT_REGI_SUCCESS"){
		alert("상품등록이 완료되었습니다.");
	}else if("${msg}" == "PRD_UPDATE_SUCCESS"){
		alert("상품수정이 완료되었습니다.");
	}else if("${msg}" == "PRD_DELETE_SUCCESS"){
		alert("상품삭제가 완료되었습니다.");
	}
</script>

<script>
$(function(){

	// 검색 버튼
	$("#btnSearch").click(function(){
		self.location = "list" + "${pageMaker.makeQuery(1)}"
					  + "&searchType=" + $("select option:selected").val()
					  + "&keyword=" + $("#keyword").val();
	});
	
	// 상품등록 btnRegi
	$("#btnRegi").click(function(){
		location.href="/admin/product/register";
	});
	
	// 선택상품 수정 btnUpdateChk
	$("#btnUpdateChk").click(function(){
		// 체크박스 유효성 검사
		if($("input[name='check']:checked").length == 0){
			alert("수량을 변경할 상품을 선택해주세요.")
			return;
		}
		
		var chkArr = [];
		var amtArr =[];
		var inStockArr = [];
		
		var prd_amount = $("#prd_amount").val();
		var prd_in_stock = $("#prd_in_stock:selected").val();
		
		// 선택된 상품의 prd_idx를 가져옴
		$("input[name='check']:checked").each(function(i){
			var prd_idx = $(this).val();
			var prd_amount = $("input[name='amount_" + prd_idx + "']").val();
			var prd_in_stock = $("select[name='stock_" + prd_idx + "']").val();
			
			chkArr.push(prd_idx);
			amtArr.push(prd_amount);
			inStockArr.push(prd_in_stock);
		});
		
		
		$.ajax({
			type	: 'post',
			url		: '/admin/product/updateChked',
			dataType: 'text',
			data	: {
						chkArr : chkArr,
						amtArr : amtArr,
						inStockArr : inStockArr
					  },
			success	: function(data){
				alert("선택 상품의 정보 수정이 완료되었습니다.");
				location.href = "/admin/product/list${pageMaker.makeSearch(pageMaker.cri.page)}";
			}
		});
	});
	
	// 선택상품 삭제 btnDelChk
	$("#btnDelChk").click(function(){
		// 체크박스 유효성 검사
		if($("input[name='check']:checked").length == 0){
			alert("삭제할 상품을 선택해주세요.")
			return;
		}
		
		// 체크된 상품s 삭제
		if(confirm("선택한 상품을 삭제하시겠습니까?")){
			var chkArr = [];
			var imgArr = [];
			
			$("input[name='check']:checked").each(function(i){
				var prd_idx = $(this).val();
				var prd_img = $("input[name='img_" + prd_idx + "']").val();
				
				chkArr.push(prd_idx);
				imgArr.push(prd_img);
			});
			
			$.ajax({
				type	: 'post',
				url		: '/admin/product/deleteChked',
				dataType: 'text',
				data	: {chkArr:chkArr, imgArr:imgArr},
				success	: function(data){
					alert("선택 상품의 삭제가 완료되었습니다.");
					location.href = "/admin/product/list${pageMaker.makeSearch(pageMaker.cri.page)}";
				}
			});
		} else{}
	});

	
	/* 전체 선택 체크박스 chkAll */
		// 전체 박스 체크
	$("#chkAll").click(function(){
		$(".check").prop("checked", this.checked);
	});
	
		// 선택안된 박스 존재시, 전체선택 박스 비우기
	$(".check").click(function(){
		$("#chkAll").prop("checked", false);
	})
	
	
	// 수정 버튼 btnEdit
	$("button[name='btnEdit']").click(function(){
		var prd_idx = $(this).val();
		location.href = "/admin/product/update${pageMaker.makeSearch(pageMaker.cri.page)}&prd_idx=" + prd_idx;
	});
	
	// 삭제 버튼 btnDelete
	$("button[name='btnDelete']").click(function(){
		var prd_idx = $(this).attr('data-role-prd_idx');
		var prd_img = $(this).prev().prev().val();
		
		if(confirm("선택한 상품을 삭제 하시겠습니까?")){
			// 컨트롤러에서 get방식 메소드 필요 - 기존 메소드 get으로 바꿔도 됨
			// <form> 관련없이 진행하려면 위의 두 변수 값과 아래 쿼리가 필요(상품번호와 상품이미지 삭제 정보 포함)
			// location.href = "/admin/product/delete${pageMaker.makeSearch(pageMaker.cri.page)}&prd_idx="+prd_idx+"&prd_img="+prd_img;
			
			// <form>을 사용해서 작업 진행 - post
			$(this).parent().submit();
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
					Admin Page <small>상품목록</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="/admin/product/list"><i class="fa fa-dashboard"></i>상품관리</a>
					</li>
					<li class="active">상품목록</li>
				</ol>
			</section>


			<!-- Main content -->
			<section class="content container-fluid">
				<div class="col-md-12">
					<div style="display: inline-block; float: left; margin-left:15px;">
						<select name="searchType" style="width:150px; height:26px;">
							<option value="null" <c:out value="${cri.searchType == null?'selected':''}" />>
								검색 구분</option>
							<option value="title" <c:out value="${cri.searchType eq 'title'?'selected':''}" />>
								제목</option>
							<option value="author" <c:out value="${cri.searchType eq 'author'?'selected':''}" />>
								저자</option>
							<option value="detail" <c:out value="${cri.searchType eq 'detail'?'selected':''}" />>
								상품내용</option>
							<option value="company" <c:out value="${cri.searchType eq 'company'?'selected':''}" />>
								출판사</option>
							<option value="title_author" <c:out value="${cri.searchType eq 'title_author'?'selected':''}" />>
								제목+저자</option>
							<option value="title_author_company" <c:out value="${cri.searchType eq 'title_author_company'?'selected':''}" />>
								제목+저자+출판사</option>
						</select>				
						<input type="text" name="keyword" id="keyword" value="${cri.keyword }" style="width:180px; padding-left:5px;"  />
						<button type="button" id="btnSearch" class="btn btn-default">검색</button>
					</div>				
					<div style="display: inline-block; float: right; margin-right:15px;">
						<button type="button" id="btnUpdateChk" class="btn btn-default">선택상품수정</button>					
						<button type="button" id="btnDelChk" class="btn btn-default">선택상품삭제</button>					
						<button type="button" id="btnRegi" class="btn btn-primary">상품등록</button>					
					</div>
				</div>
				<br><br>
				
				<div class="box" style="border: none;">
					<div class="box-body">
						<!-- 상품 리스트 테이블 -->
						<table class="table table-striped text-center">
							<tr>
								<th><input type="checkbox" id="chkAll" /></th>
								<th>상품번호</th>
								<th>상품이미지</th>
								<th>제목</th>
								<th>저자</th>
								<th>판매가</th>
								<th>할인가</th>
								<th>출판사</th>
								<th>재고</th>
								<th>판매여부</th>
								<th>수정/삭제</th>
							</tr>
						  <c:if test="${empty productList}">
							<tr>
								<td colspan="10">
									<p style="padding:50px 0px; text-align: center;">등록된 상품이 존재하지 않습니다. 상품을 등록해주세요.</p>
								</td>
							</tr>
						  </c:if>	
						  <c:forEach items="${productList }" var="product">
							<tr>
								<td><input type="checkbox" name="check" class="check" value="${product.prd_idx }" /></td>
								<td class="col-md-1" >${product.prd_idx }</td>
								<td class="col-md-2">
								<a href="/admin/product/detail${pageMaker.makeSearch(pageMaker.cri.page)}&prd_idx=${product.prd_idx }">
									<img src="/admin/product/fileDisplay?fileName=${product.prd_img }" style="width:80px;" />
									<input type="hidden" name="img_${product.prd_idx }" value="${product.prd_img }" />
								</a>
								</td>
								<td class="col-md-2">
									<a href="/admin/product/detail?${pageMaker.makeSearch(pageMaker.cri.page)}&prd_idx=${product.prd_idx}" style="color:black;">
										${product.prd_title }</a>
								</td>
								<td class="col-md-1">${product.prd_author }</td>
								<td class="col-md-1">${product.prd_price }</td>
								<td class="col-md-1">${product.prd_dc_price }</td>
								<td class="col-md-1">${product.prd_company }</td>
								<td>
									<input type="number" name="amount_${product.prd_idx}" value="${product.prd_amount}" style="width:80px; height:34px; padding-left:5px;" />
								</td>
								<td>
									<!-- 사용자 페이지에서 상품 보임/숨김 기능 (판매여부)-->
									<select class="form-control" name="stock_${product.prd_idx }" style="width: 60px; display: inline-block;">
										<option <c:out value="${product.prd_in_stock == 'Y'? 'selected':''}" />>Y</option>
										<option <c:out value="${product.prd_in_stock == 'N'? 'selected':''}" />>N</option>
									</select>									
								</td>
								<td class="col-md-2">
									<form class="deleteForm" method="post" action="/admin/product/delete${pageMaker.makeSearch(pageMaker.cri.page)}">
										<!-- 상품번호/이미지 정보 hidden -->
										<input type="hidden" value="${product.prd_idx }"  name="prd_idx"/>
										<input type="hidden" value="${product.prd_img }" name="prd_img" />
										
										<!-- 수정/삭제 버튼 -->
										<button type="button" value="${product.prd_idx }" name="btnEdit" class="btn btn-default">수정</button>
										<button type="button" name="btnDelete" data-role-prd_idx="${product.prd_idx }" class="btn btn-danger">삭제</button>
									</form>
								</td>
							</tr>
						  </c:forEach>
						</table>
					</div>
					
					<!-- 페이징 기능 -->
					<div class="box-footer">

						<div class="text-center">
							<ul class="pagination">
								<!-- [이전] 표시 -->
								<c:if test="${pageMaker.prev }">
									<li>
										<a href="${pageMaker.makeSearch(pageMaker.cri.page - 1)}">[이전]</a>
									</li>
								</c:if>
								<!-- 페이지 번호 표시 -->
								<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx" >
									<li <c:out value="${pageMaker.cri.page == idx?'class=active':'' }" />>
										<a 
										 href="/admin/product/list${pageMaker.makeSearch(idx) }">${idx }</a>
									</li>
								</c:forEach>
							
								<!-- [다음] 표시 -->
								<c:if test="${pageMaker.next }">
									<li>
										<a href="${pageMaker.makeSearch(pageMaker.cri.page + 1 )}">[다음]</a>
									</li>
								</c:if>
							</ul>
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
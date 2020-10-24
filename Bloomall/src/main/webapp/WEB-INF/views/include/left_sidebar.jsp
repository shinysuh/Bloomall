<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 핸들바 템플릿 - 2차 카테고리 정보 --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="secCtgrHandlebar" type="text/x-handlebars-template">
	{{#each .}}
	<li><a href="/product/list?ctgr_cd={{ctgr_cd}}">
		&nbsp;&nbsp;&nbsp;
		<i class="fa fa-bookmark"></i>
		<span>{{ctgr_name}}</span>
	</a></li>
	{{/each}}
</script>
<script>
// 2차 카테고리 핸들바 템플릿 적용
function secCtgrList(secCategory, target, templateObj){
	
	var template = Handlebars.compile(templateObj.html());
	var options = template(secCategory);
	
	target.append(options);
}

$(function(){
	// 1차 카테고리에 따른 2차 카테고리 핸들바에 디스플레이
	// .one()은 이벤트가 단 한번만 작업되므로 아래의 코드가 처음 한번만 작업될 수 있도록 한다
	// .on()으로 바꾸면 매번 클릭할때마다 작업이 이루어진다(중복 카테고리가 계속 추가됨. 만약 on()을 사용하려면 remove()도 사용 필요. 라인 40)
	$(".primaryCategory").one("click", function(){		
		var primaryCtgr = $(this).val();
		var url = "/product/subCategory/" + primaryCtgr;  // userProduct컨트롤러 subCategoryList() 매핑 @PathVariable
		
		// REST 방식 전송
		$.getJSON(url, function(data){
			secCtgrList(data, $("#primary_"+primaryCtgr), $("#secCtgrHandlebar"));	
		});
	});	
});
</script>


<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar" style="background-color: #464646">

	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<ul class="sidebar-menu" data-widget="tree">
			<!-- 로그인 안한 상태일때  -->
			<c:if test="${sessionScope.user == null }">
				<!-- Sidebar user panel (optional) -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="/dist/img/anonymous_user.png" class="img-circle" alt="User Image">
					</div>
					<div class="pull-left info">
						<p>로그인 해주세요</p>
						<!-- Status -->
						<a href="/member/join"><button style="border:none; padding:2px 8px; background-color: #6e6e6e; color:#B8C7CE">회원가입</button></a>
						<a href="/member/login"><button style="border:none; padding:2px 8px; background-color: #6e6e6e; color:#B8C7CE">로그인</button></a>
					</div>
				</div>
			</c:if>
			
			<!-- 사용자가 로그인 한 상태일때 : 닉네임 출력 -->
			<c:if test="${sessionScope.user != null }">
				<!-- Sidebar user panel (optional) -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="/dist/img/anonymous_user.png" class="img-circle" alt="User Image">
					</div>
					<div class="pull-left info">
						<p><b>${user.mem_nick }</b>님</p>
						<!-- Status -->
						<a href="/member/myPage"><i class="fa fa-home"></i> 마이페이지</a>
					</div>
				</div>
			</c:if>
	
			<%-- 검색  --%>
			<!-- search form -->
			<form action="/product/listSearch" method="get" class="sidebar-form">
				<div class="input-group">
					<input type="hidden" name="searchType" class="form-control" value="t_a_d_c">
					<!-- SearchCriteria 작업 필요 -->
					<input type="text" name="keyword" class="form-control" placeholder="상품 검색"
						<c:if test="${!empty scri}">
							value="<c:out value='${scri.keyword}' />"
						</c:if>	
						style="background-color: #6e6e6e; color:#B8C7CE;">
					<span class="input-group-btn">
						<button type="submit" name="search" id="search-btn" class="btn btn-flat">
							<i class="fa fa-search"></i>
						</button>
					</span>
				</div>
			</form>
			<!-- /.search form -->

			<!-- 카테고리 -->
			<li class="header" style="background-color: #464646; color: #B8C7CE">Category</li>
			<li class="all"><a href="/product/list?ctgr_cd=all"><i class="fa fa-book"></i>ALL</a></li>
			<c:forEach items="${userCategory}" var="ctgr">
				<li class="treeview primaryCategory" value="${ctgr.ctgr_cd }">
					<a href="#">
						<i class="fa fa-book"></i>
						<span>${ctgr.ctgr_name}</span>
						<span class="pull-right-container">
							<i class="fa fa-angle-left pull-right"></i>
						</span>
					</a>
					<ul class="treeview-menu" id="primary_${ctgr.ctgr_cd}">
						<li>
						<a href="/product/list?prime_ctgr_cd=${ctgr.ctgr_cd }">
							&nbsp;&nbsp;&nbsp;
							<i class="fa fa-bookmark"></i>
							<span>ALL</span>
						</a></li>
					<!-- 핸들바 위치 -->					
					</ul>
				</li>
			</c:forEach>
		</ul>
		<!-- /.sidebar-menu -->
		
	</section>
	<!-- /.sidebar -->
</aside>
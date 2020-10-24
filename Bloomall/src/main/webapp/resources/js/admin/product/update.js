$(function() {

    var form = $("#updateForm");

    // 상품수정 버튼(btnUpdate) 클릭
    $("#btnUpdate").click(function() {
        var primaryCategory = $("#primaryCategory");
        var secCategory = $("#secCategory");
        var prd_title = $("#prd_title");
        var prd_author = $("#prd_author");
        var prd_company = $("#prd_company");
        var prd_price = $("#prd_price");
        var prd_dc_price = $("#prd_dc_price");
        var prd_detail = CKEDITOR.instances["prd_detail"];
        var file1 = $("#file1");
        var prd_amount = $("#prd_amount");


        // 유효성 검사
        if (confirm("상품을 수정하시겠습니까?")) {
            if (primaryCategory.val() == null || primaryCategory.val() == "default") {
                alert("1차 카테고리를 선택해주세요.");
                primaryCategory.focus();
                return;
            } else if (prd_title.val() == null || prd_title.val() == "") {
                alert("책 제목을 입력해 주세요.");
                prd_title.focus();
                return;

            } else if (prd_author.val() == null || prd_author.val() == "") {
                alert("저자를 입력해 주세요.");
                prd_author.focus();
                return;

            } else if (prd_company.val() == null || prd_company.val() == "") {
                alert("출판사를 입력해 주세요.");
                prd_company.focus();
                return;

            } else if (prd_price.val() == null || prd_price.val() == "") {
                alert("상품 가격을 입력해 주세요.");
                prd_price.focus();
                return;

            } else if (prd_dc_price.val() == null || prd_dc_price.val() == "") {
                alert("할인 적용 가격을 입력해 주세요.");
                prd_dc_price.focus();
                return;

            } else if (prd_detail.getData() == null || prd_detail.getData() == "") {
                alert("상품 상세정보를 입력해 주세요.");
                prd_detail.focus();
                return;

            } else if (prd_amount.val() == null || prd_amount.val() == "") {
                alert("상품 재고 수량을 입력해 주세요.");
                prd_amount.focus();
                return;
            } else {
                form.submit();
            }

        } else {}
    });

});
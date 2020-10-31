// [총상품금액]/[총할인금액]/[적립예정포인트]/[최종결제금액] 로드 함수
function bringTotals() {

    var total_price = 0;
    var total_discount = 0;
    var total_point = 0;
    var total_dc_price = 0;

    $("input[name='prd_price']").each(function(i) {
        var prd_price = $(this).val();
        var prd_dc_price = $(this).parent().next().find("input[name='prd_dc_price']").val();
        var amount = $(this).parent().next().next().find("input[name='amount']").val();

        total_price += parseInt(prd_price) * amount;
        total_dc_price += parseInt(prd_dc_price) * amount;

        var point = parseInt(prd_price) * 0.03;
        total_point += point * amount;
    });

    total_discount = total_price - total_dc_price;

    $("#total_price").html(numberFormat(total_price) + "원");
    $("#total_discount").html(numberFormat(total_discount) + "원");
    $("#total_point").html(numberFormat(total_point) + "원");
    $("#total_dc_price").html(numberFormat(total_dc_price) + "원");

    $("#ord_tot_price").val(total_dc_price);
    $("#mem_point").val(total_point);

}

/* 숫자 콤마 설정 */
function numberFormat(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
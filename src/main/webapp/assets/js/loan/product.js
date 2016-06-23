$("#slider-range").css('width', '600px').slider({
    range: true,
    min: 1,
    max: 1000000,
    values: [1, 1000000],
    slide: function(event, ui) {
        var val = ui.values[$(ui.handle).index() - 1] + "";

        if (!ui.handle.firstChild) {
            $(ui.handle).append("<div class='tooltip right in' style='display:none;left:15px;top:-8px;'><div class='tooltip-arrow'></div><div class='tooltip-inner'></div></div>");
        }
        $(ui.handle.firstChild).show().children().eq(1).text(val);
    }
}).find('a').on('blur', function() {
    $(this.firstChild).hide();
});


$("#input-size-slider").css('width', '200px').slider({
    value: 1,
    range: "min",
    min: 1,
    max: 6,
    step: 1,
    slide: function(event, ui) {
        var sizing = ['', 'input-mini', 'input-small', 'input-medium', 'input-large', 'input-xlarge', 'input-xxlarge'];
        var val = parseInt(ui.value);
        $('#form-field-4').attr('class', sizing[val]).val('.' + sizing[val]);
    }
});

var selectedProduct = '';
$("#saveProductBtn").click(function() {
    var data = {
        id: selectedProduct,
        name: $("#name").val(),
        repayMethod: $("select[name=repayMethod] option:selected").val(),
        minAmount: $("#minAmount").val(),
        maxAmount: $("#maxAmount").val(),
        maxDuration: $("#maxDuration").val(),
        minDuration: $("#minDuration").val(),
        maxRate: $("#maxRate").val(),
        minRate: $("#minRate").val(),
        minInvestAmount: $("#minInvestAmount").val(),
        maxInvestAmount: $("#maxInvestAmount").val(),
        stepAmount: $("#stepAmount").val(),
        maxTotalAmount: $("#maxTotalAmount").val(),
        maxTimes: $("#maxTimes").val(),
        description: $("#description").val()
    };
    $(this).prop("disabled", true);
    $.post("loan/saveProduct", data, function(res) {
        alert("产品保存成功");
        location.reload();
    });
});
$(".editProductLink").click(function() {
    var id = $(this).data('id');
    selectedProduct = id;
    $.get("loan/getProductById/" + id, function(product) {
        if (product) {
            $("#productList").hide();
            $("#addProductPanel").show();
            $("#name").val(product.name);
            $("select[name=repayMethod] option[value=" + product.repayMethod + "]").prop("selected", true);
            $("#minAmount").val(product.minAmount);
            $("#maxAmount").val(product.maxAmount);
            $("#maxDuration").val(product.maxDuration.totalMonths);
            $("#minDuration").val(product.minDuration.totalMonths);
            $("#maxRate").val(product.maxRate);
            $("#minRate").val(product.minRate);
            $("#minInvestAmount").val(product.investRule.minAmount);
            $("#maxInvestAmount").val(product.investRule.maxAmount);
            $("#stepAmount").val(product.investRule.stepAmount);
            $("#maxTotalAmount").val(product.investRule.maxTotalAmount);
            $("#maxTimes").val(product.investRule.maxTimes);
            $("#description").val(product.description);
        } else {
            alert("产品未找到");
        }
    });
});
$("#addProductBtn").click(function() {
    $("#productList").hide();
    $("#addProductPanel").show();
});
$("#cancelSaveProductBtn").click(function() {
    $("#addProductPanel").hide();
    $("#productList").show();
    selectedProduct = '';
});
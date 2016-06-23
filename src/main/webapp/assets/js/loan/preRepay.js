var $confirmPreRepay = $('#confirmPreRepay');
var $preRepayDetail = $('#preRepayDetail');

$(function() {
    var loanid = null;
    $('.detail-btn').click(function() {
        var uri = $(this).data('uri'), self = $(this);
        self.prop('disabled', true);
        $.get(uri, function(res) {
            self.popover({
                'placement': 'left',
                'html': true,
                'content': '<div class="center-align size-12 detail-popover"><i class="icon-remove-sign"></i><div>剩余期数：<span class="red bold">period期</span></div><div>应还本金：<span class="red bold">￥$principal</span></div><div>应还利息：<span class="red bold">￥$interest</span></div><div>还款利息管理费：<span class="red bold">￥$loanFee</span></div><div>借款管理费：<span class="red bold">￥$manageFee</span></div><div>给投资人违约金：<span class="red bold">￥$feeToInvest</span></div><div>给商户违约金：<span class="red bold">￥$feeToClient</span></div><div>金额总计：<span class="red bold">￥$total</span></div></div>'
                        .replace('period', formatAmount(res.detail.period))
                        .replace('$principal', formatAmount(res.detail.principal, 2))
                        .replace('$interest', formatAmount(res.detail.interest, 2))
                        .replace('$loanFee', formatAmount(res.detail.loanFee, 2))
                        .replace('$manageFee', formatAmount(res.detail.manageFee, 2))
                        .replace('$total', formatAmount(res.total, 2))
                        .replace('$feeToClient', formatAmount(res.penalty.feeToClient, 2))
                        .replace('$feeToInvest', formatAmount(res.penalty.feeToInvest, 2))
            });
            self.popover('show');
            $('.detail-popover i').click(function() {
                self.popover('destroy');
                self.prop('disabled', false);
            });
        }).fail(function() {
            self.prop('disabled', false);
        });
    });
    $('.repay-btn').click(function() {
        loanid = $(this).data('loanid');
        $confirmPreRepay.modal({'backdrop': 'static'});
    });

    var repayDetailUrl = "postLoan/advanceRepayAllDetail", arData = null;

    $('#showPreRepayDetailBtn').click(function() {
        var data = {};
        if ($('#rateForCompany').val() == '' || $('#rateForUser').val() == '') {
            alert('费率不可为空');
            return;
        }
        var r1 = parseFloat($('#rateForCompany').val());
        var r2 = parseFloat($('#rateForUser').val());
        if (r1 + r2 > 100) {
            alert('费率之和不可超过100');
            return;
        } else if (r1 < 0 || r2 < 0) {
            alert('费率不可为负数');
            return;
        }
        data.loanId = loanid;
        data.feeForCompany = r1 / 100;
        data.feeForUser = r2 / 100;
        data.type = $('select[name=advanceRepayType] option:selected').val();
        $.post(repayDetailUrl, data, function(res) {
            if (res) {
                $('#detail_period').html(res.detail.period + "期");
                $('#detail_principal').html(formatAmount(res.detail.principal, 2, '￥'));
                $('#detail_interest').html(formatAmount(res.detail.interest, 2, '￥'));
                $('#detail_outstanding').html(formatAmount(res.detail.outstanding, 2, '￥'));
                $('#detail_loanFee').html(formatAmount(res.detail.loanFee, 2, '￥'));
                $('#detail_manageFee').html(formatAmount(res.detail.manageFee, 2, '￥'));
                $('#detail_feeToClient').html(formatAmount(res.penalty.feeToClient, 2, '￥'));
                $('#detail_feeToInvest').html(formatAmount(res.penalty.feeToInvest, 2, '￥'));
                $('#detail_total').html(formatAmount(res.total, 2, '￥'));
                arData = data;
                $confirmPreRepay.modal('hide');
                $preRepayDetail.modal({'backdrop': 'static'});
            } else {
                alert("数据请求失败");
                $confirmPreRepay.modal('hide');
            }
        }).fail(function() {
            alert("网络出现错误");
            $confirmPreRepay.modal('hide');
        });

    });
    $('#doPreRepayBtn').click(function() {
        var self = $(this);
        self.html('<i class="icon-spin icon-cog"></i> 还款中').prop('disabled', true);
        $('#closeRepayDetailBtn').prop('disabled', true);
        $.post("postLoan/advanceRepayAll", arData, function(res) {
            if (res == 'SUCCESS') {
                $preRepayDetail.modal('hide');
                $('#updateSuccess').modal({'backdrop': 'static'});
            } else if (res == "FAIL") {
                $preRepayDetail.modal('hide');
                $('#updateFailed .errorText').html('提前一次性还款失败！');
                $('#updateFailed').modal({'backdrop': 'static'});
            } else {
                $preRepayDetail.modal('hide');
                $('#updateFailed .errorText').html('余额不足！');
                $('#updateFailed').modal({'backdrop': 'static'});
            }
        }).fail(function() {
            $preRepayDetail.modal('hide');
            $('#updateFailed .errorText').html('网络传输错误');
            $('#updateFailed').modal({'backdrop': 'static'});
        });
    });
    $('#cancelPreRepayBtn').click(function() {
        $confirmPreRepay.modal('hide');
    });
    $('#closeRepayDetailBtn').click(function() {
        $preRepayDetail.modal('hide');
    });
});
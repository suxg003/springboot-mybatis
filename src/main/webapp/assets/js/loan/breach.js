$('.penalty-btn').click(function() {
    var uri = $(this).data('uri'), self = $(this);
    self.prop('disabled', true);
    $.get(uri, function(res) {
        self.popover({
            'placement': 'left',
            'html': true,
            'content': $('#popupTemplate').html()
                    .replace('period', formatAmount(res.detail.period))
                    .replace('$principal', formatAmount(res.detail.principal, 2))
                    .replace('$interest', formatAmount(res.detail.interest, 2))
                    .replace('$loanFee', formatAmount(res.detail.loanFee, 2))
                    .replace('$manageFee', formatAmount(res.detail.manageFee, 2))
                    .replace('$overdue', formatAmount(res.penalty.overdue, 2))
                    .replace('$penalty', formatAmount(res.penalty.penalty, 2))
                    .replace('$total', formatAmount(res.total, 2))
        });
        self.popover('show');
        $('.penalty-popover i').click(function() {
            self.popover('destroy');
            self.prop('disabled', false);
        });
    }).fail(function() {
        self.prop('disabled', false);
    });
});
var disburseUrl, disburseType;
$('.disburseAll-btn').click(function() {
    var loanId = $(this).data("id"), loanTitle = $(this).data("title"), self = $(this), type = self.parent().find('select option:selected').val();
    disburseUrl = $(this).data('uri');
    disburseType = type;
    $.post("postLoan/getDisburseAllDetail", {
        id: loanId,
        type: type
    }, function(detail) {
        $("#disburseLoanTitle").html(loanTitle);
        $("#disburseType").html(self.parent().find('select option:selected').text());
        $("#detail_period").html(detail.period + "期");
        $("#detail_principal").html(formatAmount(detail.principal, 2, "￥"));
        $("#detail_interest").html(formatAmount(detail.interest, 2, "￥"));
        $("#detail_outstanding").html(formatAmount(detail.outstanding, 2, "￥"));
        $("#detail_loanfee").html(formatAmount(detail.loanFee, 2, "￥"));
        $("#detail_managefee").html(formatAmount(detail.manageFee, 2, "￥"));
        $('#confirmDisbursePanel').show();
    });
});
$('.send-message-btn').click(function() {
    var uri = $(this).data('uri'), self = $(this);
    self.prop('disabled', true);
    $.get(uri, function() {
        self.html('<i class="icon-ok"></i> 发送成功');
    }).fail(function() {
        self.html('<i class="icon-remove"></i> 发送失败').prop('disabled', false);
    });
});
$('.repay-btn').click(function() {
    var self = $(this);
    if (confirm("确定还款？")) {
        $('#popMasker').modal('show');
        $.get($(this).data("url"), function(res) {
            $('#popMasker').modal('hide');
            if (res == 'INSUFFICIENT') {
                alert("余额不足");
            } else if (res == 'SUCCESS') {
                alert("还款成功！");
                location.reload();
            } else {
                alert("还款失败");
            }
        }).fail(function() {
            $('#popMasker').modal('hide');
            alert("网络出现错误");
        });
    }
});
$('.disburse-btn').click(function() {
    $('#popMasker').modal('show');
});

$('#doDisburseAllBtn').click(function() {
    var self = $(this);
    self.html('<i class="icon-spin icon-cog"></i> 处理中').prop('disabled', true);
    $.get(disburseUrl + '/' + disburseType, function(res) {
        self.html('确定').prop('disabled', false);
        if (res == 'SUCCESS') {
            alert("垫付成功！");
            location.reload();
        } else if (res == 'INSUFFICIENT') {
            alert("余额不足");
            $('#confirmDisbursePanel').hide();
        } else {
            alert("垫付失败");
            $('#confirmDisbursePanel').hide();
        }
    }).fail(function() {
        self.html('确定').prop('disabled', false);
        alert("网络出现问题");
    });
});
$('#cancelDisburseAllBtn').click(function() {
    $('#confirmDisbursePanel').hide();
});

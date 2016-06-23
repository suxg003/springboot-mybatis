(function () {
    'use strict';
    // 金额检验
    function validateAmount(input) {
        var value = input.val(), decimal = value.indexOf('.'), len = value.length - 1;
        if (value === null || value === '' || isNaN(parseFloat(value))) {
            input.val('');
            return;
        }
        if (parseFloat(value) > 1000000) {
            value = '1000000';
            decimal = -1;
        }
        if (decimal !== -1) {
            if (parseInt(value.split('.')[1]) === 0) {
                input.val(formatAmount(value, 0));
            } else {
                if (len - decimal === 1) {
                    input.val(formatAmount(value, 1));
                } else {
                    input.val(formatAmount(value, 2));
                }
            }
        } else {
            input.val(formatAmount(value, 0));
        }
        input.removeClass("text-error");
    }

//////////////////////////////////////////////////////////////////////////////////////////////////
// 商户充值
//////////////////////////////////////////////////////////////////////////////////////////////////
    var rechargeAmount = $("#rechargeValue");
    rechargeAmount.focus(function () {
        var value = $(this).val();
        $(this).val(value.replace(/\,/g, ""));
    });
    rechargeAmount.blur(function () {
        validateAmount($(this));
    });
// 提交充值表单
    $("form[name=formRecharge]").submit(function (e) {
        if (rechargeAmount.val() === "" || rechargeAmount.val() === "0") {
            rechargeAmount.addClass("text-error");
            e.preventDefault();
            return;
        }
        if (rechargeAmount.val() < 1) {
            alert('充值最小金额为1元！');
            e.preventDefault();
            return;
        }
        $('#rechargePanel').modal({'backdrop': 'static'});
    });

    $('#resetValueIn').click(function () {
        rechargeAmount.val(0);
    });
    $('#rechargePanel button').click(function () {
        location.reload();
    });
    $('#btn_recharge').bind('click', submitRecharge);

//////////////////////////////////////////////////////////////////////////////////////////////////
// 选择银行
//////////////////////////////////////////////////////////////////////////////////////////////////
    var rechargeAmount1 = $("#rechargeValue1");
    rechargeAmount1.focus(function () {
        var value = $(this).val();
        $(this).val(value.replace(/\,/g, ""));
    });
    rechargeAmount1.blur(function () {
        validateAmount($(this));
    });
// 提交充值表单
    $("form[name=formRecharge]").submit(function (e) {

    });

    $('#resetValueIn1').click(function () {
        rechargeAmount1.val(0);
    });
    $('#rechargePanel button').click(function () {
        location.reload();
    });
    $('#btn_recharge1').bind('click', submitRecharge1);
//////////////////////////////////////////////////////////////////////////////////////////////////
// 商户取现
//////////////////////////////////////////////////////////////////////////////////////////////////
    var withdrawAmount = $("#withdrawValue");
    withdrawAmount.focus(function () {
        var value = $(this).val();
        $(this).val(value.replace(/\,/g, ""));
    });
    withdrawAmount.blur(function () {
        validateAmount($(this));
    });
    $('#resetValueOut').click(function () {
        withdrawAmount.val('0');
    });
// 提交取现表单
    $("form[name=formWithdraw]").submit(function (e) {
        if (withdrawAmount.val() === "" || withdrawAmount.val() === "0") {
            withdrawAmount.addClass("text-error");
            e.preventDefault();
            return;
        }
        $('#withdrawPanel').modal({'backdrop': 'static'});
    });
    $('#withdrawPanel button').click(function () {
        location.reload();
    });

    $('#btn_withdraw').bind('click', submitWithdraw);


    /**
     * XHR submit recharge
     *
     * @type {}
     */
    function submitRecharge(){
        var amount = $.trim(rechargeAmount.val());
        var description = $.trim($('#rechargeRemark').val());
        var platformName = $('#platformName option:selected').val();
        if(!amount || amount== '0'){
            rechargeAmount.focus();
            return;
        }

        amount = amount.replace(/,/g, '');

        if(!$.isNumeric(amount)){
            rechargeAmount.val('0');
            rechargeAmount.focus();
            return;
        }


        if(parseFloat(amount) < 0){
            rechargeAmount.focus();
            alert('充值金额不能小于0');
            return;
        }

        if(!description){
            $('#rechargeRemark').focus();
            return;
        }

        if(!confirm('充值金额为 '+ amount +', 确认充值？')) return;
        console.log(platformName);
        $('#btn_recharge').prop('disabled', true);
        $.post('/fund/platformFund/audit', {platformName:platformName,amount:amount, operation:'DEPOSIT', description: description}, function(resp){
            $('#btn_recharge').prop('disabled', false);
            if(!resp) return;
            if(!resp.success) {
                alert(resp.comment);
                return;
            }
            rechargeAmount.val('0');
            $('#rechargeRemark').val('');
            alert('充值成功');
        }, 'json').error(function(){
            $('#btn_recharge').prop('disabled', false);
        });
    }


    function submitRecharge1(){
        var amount = $.trim(rechargeAmount1.val());
        var description = $.trim($('#rechargeRemark1').val());
        var platformName = $('#platformName1 option:selected').val();
        var bankName = $('#bankformName option:selected').val();
        var path = "JD_ENTERPRISE_PAY";
        if(!amount || amount== '0'){
            rechargeAmount1.focus();
            return;
        }

        amount = amount.replace(/,/g, '');

        if(!$.isNumeric(amount)){
            rechargeAmount1.val('0');
            rechargeAmount1.focus();
            return;
        }


        if(parseFloat(amount) < 0){
            rechargeAmount1.focus();
            alert('充值金额不能小于0');
            return;
        }

        //if(!description){
        //    $('#rechargeRemark1').focus();
        //    return;
        //}

        if(!confirm('充值金额为 '+ amount +', 确认充值？')){
            return
        }else {
            window.open("/fund/recharge?amount=" + amount + "&path=" + path + "&platformtype=" + platformName + "&bank_name=" + bankName + "");
            if (rechargeAmount1.val() === "" || rechargeAmount1.val() === "0") {
                rechargeAmount1.addClass("text-error");
                e.preventDefault();
                return;
            }
            if (rechargeAmount1.val() < 1) {
                alert('充值最小金额为1元！');
                e.preventDefault();
                return;
            }
            $('#rechargePanel').modal({'backdrop': 'static'});
        }
        console.log(platformName);
        $('#btn_recharge1').prop('disabled', true);
        //$.post('/fund/recharge', {platformtype:platformName,amount:amount, operation:'DEPOSIT', description: description,path:path,bank_name:bankName}, function(resp){
        //    $('#btn_recharge1').prop('disabled', false);
        //    if(!resp) return;
        //    if(!resp.success) {
        //        alert(resp.comment);
        //        return;
        //    }
        //    rechargeAmount1.val('0');
        //    $('#rechargeRemark1').val('');
        //    alert('充值成功');
        //}, 'json').error(function(){
        //    $('#btn_recharge1').prop('disabled', false);
        //});
    }
    /**
     * XHR submit recharge
     *
     * @type {}
     */
    function submitWithdraw(){
        var amount = $.trim(withdrawAmount.val());
        var description = $.trim($('#withdrawRemark').val());
        var platformName = $('#platformNameOut option:selected').val();
        if(!amount || amount=='0'){
            withdrawAmount.focus();
            return;
        }

        amount = amount.replace(/,/g, '');

        if(!$.isNumeric(amount)){
            withdrawAmount.val('0');
            withdrawAmount.focus();
            return;
        }

        if(parseFloat(amount) < 0){
            withdrawAmount.focus();
            alert('提现金额不能小于0');
            return;
        }

        if(!description){
            $('#withdrawRemark').focus();
            return;
        }

        if(!confirm('提现金额为 '+ amount +', 确认提现？')) return;

        $('#btn_withdraw').prop('disabled', true);
        $.post('/fund/platformFund/audit', {platformName:platformName,amount:amount, operation:'WITHDRAW',description:description}, function(resp){
            $('#btn_withdraw').prop('disabled', false);
            if(!resp) return;
            if(!resp.success) {
                alert(resp.comment);
                return;
            }
            withdrawAmount.val('0');
            $('#withdrawRemark').val('');
            alert('提现成功');
        }, 'json').error(function(){
            $('#btn_withdraw').prop('disabled', false);
        });
    }







})();
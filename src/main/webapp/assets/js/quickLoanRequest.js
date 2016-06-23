/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function editLoan(){
    var hrefStr=location.href;
    if(/loanRequestId/.test(hrefStr)){
        loanType = 'geren';//个人借款
        $('#corporationInfo').hide();
        gotoStep1();
    }
}

editLoan();

var geren = $('#geren'),
    qiye = $('#qiye'),
    licai = $('#licai');
var step0 = $('#registerStep0'),
    step1 = $('#registerStep1'),
    step2 = $('#registerStep2'),
    step3 = $('#registerStep3'),
    step4 = $('#registerStep4');

var loanType = ''; //借款类型
function debug(info) {
    console.log(info);
}

///////////////////////////////////////////////////////////////////////////
// 流程控制方法
///////////////////////////////////////////////////////////////////////////
function gotoStep1() {
    $('.screenCentered').hide();
    $('#registerStep1').slideDown();

}
function goBackStep0() {
    $('.screenCentered').hide();
    $('#registerStep0').slideDown();
}
function gotoStep2() {
    $('.screenCentered').hide();
    $('#registerStep2').slideDown();
}
function goBackStep1() {
    $('.screenCentered').hide();
    $('#registerStep1').slideDown();
}
function goBackStep3() {
    $('.screenCentered').hide();
    $('#registerStep2').slideDown();
}
function gotoStep3() {
    $('.screenCentered').hide();
    $('#registerStep3').slideDown();

}
function gotoStep4() {
    $('.screenCentered').hide();
    $('#registerStep4').css('visibility','visible');
    $('#registerStep4').show();
    //$('#registerStep4').slideDown();
}

///////////////////////////////////////////////////////////////////////////
// 选择贷款类型
///////////////////////////////////////////////////////////////////////////
geren.click(function() {
    loanType = 'geren';//个人借款
    $('#corporationInfo').hide();
    gotoStep1();
});
licai.click(function() {
    loanType = 'licai';//理财产品
    $('#corporationInfo').hide();
    gotoStep1();
});
qiye.click(function() {
    loanType = 'qiye';//企业借款
    //gotoMortgageSetting();
    $('#corporationInfo').show();
    gotoStep1();
});
$('#backToStep0').click(function() {
    goBackStep0();
});

///////////////////////////////////////////////////////////////////////////
// 第一步：填写用户信息
///////////////////////////////////////////////////////////////////////////

var mode = 'new'; //使用新用户或者现有用户
var  regedUserLoginName= $('input[name=regedUserLoginName]'),
    login_name_error = regedUserLoginName.parent().find('.errorText'),
    regedRealName = $('#regedRealName'),
    regedIdNumber = $('#regedIdNumber'),
    corporationName = $('#corporationName'),
    regedMobile = $('#regedMobile'),
    contractBorrowerID = $('input[name=contractBorrowerID]'),
    contractBorrower = $('input[name=contractBorrower]');
uncbiVal=false,
    uncbVal=false;

regedUserLoginName.focus(function() {
    login_name_error.hide();
    regedUserLoginName.removeClass('input-invalid');
});

var mobileValidate = false,
    mobile = $('input[name=mobile]'),
    idNumberValidate = false,
    idNumber = $('input[name=idNumber]'),
    id_error_detail = idNumber.parent().find('.error-detail'),
    id_error = idNumber.parent().find('.errorText'),
    checking = idNumber.parent().find('.checkingIdNumber'),
    nameValidate = false,
    $name = $('input[name=name]');

/**
 * 查找用户
 *
 */
function queryUser() {
    if(regedUserLoginName.val()==''){
        return false;
    }
    $.getJSON('user/queryUser/' + regedUserLoginName.val(), function(res) {
        if (res) {
        	if(res.message==false){
        		$('#regedUserLoginName').next().show();
        	}else{
                console.log(res.user.userName);
                login_name_error.hide();
                regedIdNumber.text(res.user.idNumber);
                regedMobile.text(res.user.mobile);
                regedRealName.text(res.user.userName);
                regedRealName.attr('data-id', res.user.userId);
                if (res.hasAccount == false) {
                    $('#hasAccount').text('未开户');
                    $('#useOldUser').attr('disabled', true);
                } else {
                    $('#hasAccount').text('已开户');
                    $('#useOldUser').attr('disabled', false);
                }
                $("#contractBorrower").val(res.user.userName);
                $("#contractBorrowerID").val(res.user.idNumber);
               /* if(res.allowNoPwdRepay != null) {
                    if (res.allowNoPwdRepay == true) {
                        $('#allowNoPwdRepay').text('已签订');
//                        $('#useOldUser').prop('disabled', false);
                    } else {
                        $('#allowNoPwdRepay').text('未签订');
//                        $('#useOldUser').prop('disabled', true);
                    }
                }*/
                if (loanType == 'qiye') {
                    $.get('user/queryCorporation/' + res.user.id, function(name) {
                        corporationName.text(name);
                    });
                }
        	}
        	
        } else {
            regedRealName.text('未找到');
            regedRealName.data('id', '');
            regedIdNumber.text('未找到');
            regedMobile.text('未找到');
            corporationName.text('未找到');
        }
    });
}
regedUserLoginName.keyup(function (event) {
    if (event.keyCode === 13) {
        queryUser();
    }
});
$('#queryUserBtn').on('click',function() {
    queryUser();
});
/**
 * 验证合同显示借款人
 */
contractBorrower.blur(checkContractBorrower);
function checkContractBorrower(c){
    //uncbiVal=false;
    var cbVal = contractBorrower.val(),
        cbError=contractBorrower.parent().find('.errorText'),
        cbReg=/[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*/;

    if(cbVal == ''){
        cbError.hide();
        //uncbVal=false;
        return '1';
    }else if(!cbReg.test(cbVal)){
        cbError.html('<i class="icon-warning-sign"></i>姓名格式不正确！').show();
        //uncbVal=true;
        return '2';
    }else{
        cbError.hide();
        //uncbVal=false;

        return '3';
    }

}

/**
 * 验证合同显示借款人身份证
 */
contractBorrowerID.blur(checkContractBorrowerID);
function checkContractBorrowerID(c){
    uncbiVal=false;
    //身份证验证
    function checkIdcard(idcard) {
        console.log(idcard);
        var Errors = ["验证通过!",
            "身份证号码位数不对!",
            "身份证号码出生日期超出范围或含有非法字符!",
            "身份证号码校验错误!",
            "身份证地区非法!",
            "身份证输入有误!"];
        var area = {11: "北京",12: "天津",13: "河北",14: "山西",15: "内蒙古",21: "辽宁",22: "吉林",23: "黑龙江",31: "上海",32: "江苏",33: "浙江",34: "安徽",35: "福建",36: "江西",37: "山东",41: "河南",42: "湖北",43: "湖南",44: "广东",45: "广西",46: "海南",50: "重庆",51: "四川",52: "贵州",53: "云南",54: "西藏",61: "陕西",62: "甘肃",63: "青海",64: "宁夏",65: "xingjiang",71: "台湾",81: "香港",82: "澳门",91: "国外"};

        var idcard, Y, JYM;
        var S, M;
        var idcard_array = [];
        idcard_array = idcard.split("");
        //地区检验   
        if (area[parseInt(idcard.substr(0, 2))] == null)
            return false;
        //身份号码位数及格式检验   
        switch (idcard.length) {
            case 15:
                if ((parseInt(idcard.substr(6, 2)) + 1900) % 4 == 0 || ((parseInt(idcard.substr(6, 2)) + 1900) % 100 == 0 && (parseInt(idcard.substr(6, 2)) + 1900) % 4 == 0)) {
                    ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$/; //测试出生日期的合法性   
                } else {
                    ereg = /^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$/; //测试出生日期的合法性   
                }
                if (ereg.test(idcard))
                    return true;
                else
                    return false;
                break;
            case 18:
                //18位身份号码检测   
                //出生日期的合法性检查     
                //闰年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))   
                //平年月日:((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))   
                if (parseInt(idcard.substr(6, 4)) % 4 == 0 || (parseInt(idcard.substr(6, 4)) % 100 == 0 && parseInt(idcard.substr(6, 4)) % 4 == 0)) {
                    ereg = /^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$/; //闰年出生日期的合法性正则表达式   
                } else {
                    ereg = /^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$/; //平年出生日期的合法性正则表达式   
                }
                if (ereg.test(idcard)) { //测试出生日期的合法性   
                    //计算校验位   
                    S = (parseInt(idcard_array[0]) + parseInt(idcard_array[10])) * 7
                    + (parseInt(idcard_array[1]) + parseInt(idcard_array[11])) * 9
                    + (parseInt(idcard_array[2]) + parseInt(idcard_array[12])) * 10
                    + (parseInt(idcard_array[3]) + parseInt(idcard_array[13])) * 5
                    + (parseInt(idcard_array[4]) + parseInt(idcard_array[14])) * 8
                    + (parseInt(idcard_array[5]) + parseInt(idcard_array[15])) * 4
                    + (parseInt(idcard_array[6]) + parseInt(idcard_array[16])) * 2
                    + parseInt(idcard_array[7]) * 1
                    + parseInt(idcard_array[8]) * 6
                    + parseInt(idcard_array[9]) * 3;
                    Y = S % 11;
                    M = "F";
                    JYM = "10X98765432";
                    M = JYM.substr(Y, 1); //判断校验位   
                    if (M == idcard_array[17].toUpperCase())
                    {
                        return true; //检测ID的校验位   
                    } else {
                        return false;
                    }

                }
                else
                    return false;
                break;
            default:
                return false;
                break;
        }
    }

    var cbiVal = contractBorrowerID.val().trim(),
        cbiError = contractBorrowerID.parent().find('.errorText');
    if(cbiVal == ''){
        cbiError.hide();
        //uncbiVal=false;
        return '1';
    }else if(!checkIdcard(cbiVal)){

        cbiError.html('<i class="icon-warning-sign"></i>合同显示借款人身份证输入有误').show();
        //uncbiVal=true;
        //console.log('1uncbiVal_'+uncbiVal)
        return '2';
    }else{
        cbiError.hide();
        //uncbiVal=false;
        return '3';
    }
}
/**
 * 使用现有用户申请借款
 *
 */
$('#useOldUser').on('click',function() {

    if (regedRealName.attr('data-id') === '') {
        login_name_error.show();
        regedUserLoginName.addClass('input-invalid');
        return;
    }

    var cbi = checkContractBorrowerID();
    var cb = checkContractBorrower();


    if((cbi == '1' && cb == '1') || (cbi == '3' && cb == '3')){
        mode = 'old';
        gotoStep2();
        mobile.removeClass('input-invalid');
        mobile.next().hide();
        idNumber.removeClass('input-invalid');
        id_error.hide();
        $name.removeClass('input-invalid');
        $name.next().hide();
        nameValidate = false;

    }else{


    }

});

/**
 * 手机号码检验
 *
 * @type type
 */


function checkMobile(mobile) {
    return /^1\d{10}$/.test(mobile);
}
mobile.focus(function() {
    mobile.removeClass('input-invalid');
    mobile.next().hide();
});
mobile.blur(function() {
    if (!checkMobile(mobile.val())) {
        mobile.addClass('input-invalid');
        mobile.next().show();
        mobileValidate = false;
    } else {
        mobileValidate = true;
    }
});
/**
 * 身份证号码检验
 *
 * @type type
 */


function checkIdNumber(idNumber) {
    return /^[1-9][0-9]{16}[0-9xX]$/.test(idNumber);
}
idNumber.focus(function() {
    idNumber.removeClass('input-invalid');
    id_error.hide();
});
idNumber.blur(function() {
    if (!checkIdNumber(idNumber.val())) { //是否合法
        idNumber.addClass('input-invalid');
        id_error_detail.html('请输入有效身份证号码');
        id_error.show();
        idNumberValidate = false;
    }
    else {
        checking.html(' <i class="icon-spinner icon-spin"></i>').show();
        $.get('user/checkIdNumber/' + idNumber.val(), function(res) { //是否已占用
            checking.hide();
            if (!res.valid) {
                idNumber.addClass('input-invalid');
                id_error_detail.html(res.message);
                id_error.show();
                idNumberValidate = false;
            } else {
                idNumberValidate = true;
            }
        });
    }
});
/**
 * 检测真实姓名
 *
 * @type type
 */
function checkName(name) {
    return /^[\u4e00-\u9fa5]{2,10}$/.test(name);
}
$name.focus(function() {
    $name.removeClass('input-invalid');
    $name.next().hide();
    nameValidate = false;
});
$name.blur(function() {
    if (!checkName($name.val())) {
        $name.addClass('input-invalid');
        $name.next().show();
        nameValidate = false;
    } else {
        nameValidate = true;
    }
});
/**
 * 使用新用户提交申请
 *
 */
$('#useNewUser').click(function() {
    var validated = true;
    if (!mobileValidate) {
        mobile.trigger('blur');
        validated = false;
    }
    if (!idNumberValidate) {
        idNumber.trigger('blur');
        validated = false;
    }
    if (!nameValidate) {
        $name.trigger('blur');
        validated = false;
    }
    if (!validated) {
        return;
    }
    mode = 'new';
    gotoStep2();
    login_name_error.hide();
});


///////////////////////////////////////////////////////////////////////////
// 第三步：填写借款信息
///////////////////////////////////////////////////////////////////////////

var paymentMethodLb = $('.payment-method-lb').attr('data-checked'),
	mortgaged = $('.mortgaged-lb').attr('data-checked');

if(mortgaged==''){
	$('input[value=false]').attr('checked','true');
}else{
	$('input[value='+mortgaged+']').attr('checked','true');
}

if(paymentMethodLb==''){
	$('input[value=MonthlyInterest]').attr('checked','true');
}else{
	$('input[value='+paymentMethodLb+']').attr('checked','true');
}
$('select[name=mortgageType]').hide();
if ($('input[name=mortgaged]:checked').val() === 'true') {
    $('select[name=mortgageType]').show();
} else {
    $('select[name=mortgageType]').hide();
}
$('input[name=mortgaged]').change(function() {
    if ($('input[name=mortgaged]:checked').val() === 'true') {
        $('select[name=mortgageType]').show();
    } else {
        $('select[name=mortgageType]').hide();
    }
});

$('#optionsRadios1').change(function() {
	if ($('#optionsRadios1').is(':checked')) {
	    $('#dyxx').css('display','none');
	    //$('#dyxx').find('textarea').removeAttr("required");
    }
});
$('#optionsRadios2').change(function() {
	if ($('#optionsRadios2').is(':checked')) {
	    $('#dyxx').css('display','block');
	    //$('#dyxx').find('textarea').attr("required","required");
	}
});

var loanTitle = $('input[name=title]'),
    amount = $('input[name=amount]'),
    minAmount = $('input[name=minAmount]'),
    minInvestAmountError = minAmount.parent().parent().find('.errorText'),
    maxAmount = $('input[name=maxAmount]'),
    maxInvestAmountError = maxAmount.parent().parent().find('.errorText'),
    stepAmount = $('input[name=stepAmount]'),
    stepAmountError = stepAmount.parent().parent().find('.errorText'),
    years = $('input[name=years]'),
    months = $('input[name=months]'),
    days = $('input[name=days]'),
    durationError = years.parent().parent().find('.errorText'),
    durationErrorText = years.parent().parent().find('.error-detail'),
    annualRate = $('input[name=annualRate]'),
    annualRateError = $('input[name=annualRate]').parent().parent().find('.errorText'),
    danbaoRate = $('input[name=danbaoRate]'),
    danbaoRateError = $('input[name=danbaoRate]').parent().parent().find('.errorText'),
    serviceRate = $('input[name=serviceRate]'),
    serviceRateError = $('input[name=serviceRate]').parent().parent().find('.errorText'),
    min_amount = parseInt(amount.data('min')),
    max_amount = parseInt(amount.data('max'));

loanTitle.focus(function() {
    loanTitle.removeClass('input-invalid');
    loanTitle.next().hide();
});

/**
 * 检验贷款金额
 *
 * @param {type} amount
 * @returns {Boolean}
 */
function checkAmount(amount) {
    if (!/^\d*$/.test(amount)) { //是否数字
        return false;
    }
    var value = parseInt(amount);
    if (value !== parseFloat(amount)) { //是否整数
        return false;
    }
    if (value < min_amount || value > max_amount || value % 1 !== 0) { //金额大小超过限制
        return false;
    }
    return true;
}
amount.focus(function() {
    amount.removeClass('input-invalid');
    amount.parent().parent().find('.errorText').hide();
});

/**
 * 检验贷款期限
 *
 * @returns {undefined}
 */
function setDurationInvalid(valid) {
    if (!valid) {
        years.addClass('input-invalid');
        months.addClass('input-invalid');
        days.addClass('input-invalid');
    } else {
        years.removeClass('input-invalid');
        months.removeClass('input-invalid');
        days.removeClass('input-invalid');
        durationError.hide();
    }
}
/////////////////////////////////////////////
var MAX_DUE_DAY = 30,      // 贷款天数最大值
    MAX_DUE_MONTH = 11,    // 贷款月数最大值
    MAX_DUE_YEAR = 4;      // 贷款年份最大值
/////////////////////////////////////////////    
function checkDuration() {
    if (years.val() === '' && months.val() === '' && days.val() === '') { //全部为空
        setDurationInvalid(false);
        durationErrorText.html('请输入贷款期限');
        durationError.css('display', 'inline-block');
        return false;
    }
    var year = parseInt(years.val());
    var month = parseInt(months.val());
    var day = parseInt(days.val());
    if (year === 0 && month === 0 && day === 0) { //全部为0
        setDurationInvalid(false);
        durationErrorText.html('请输入贷款期限');
        durationError.css('display', 'inline-block');
        return false;
    }
    if (day < 0 || day > MAX_DUE_DAY || isNaN(day)) {
        if (month < 0 || month > MAX_DUE_MONTH || isNaN(month)) {
            if (year < 0 || year > MAX_DUE_YEAR || isNaN(year)) {
                setDurationInvalid(false);
                durationErrorText.html('贷款期限输入有误');
                durationError.css('display', 'inline-block');
                return false;
            }
        }
    }
    return true;
}
years.focus(function() {
    setDurationInvalid(true);
});
years.blur(function() {
    var year = parseInt(years.val());
    if (isNaN(year) || year <= 0) {
        years.val('');
        if (months.val() === '') {
            months.prop('disabled', false);
            days.val('').prop('disabled', false);
        }
    } else {
        if (year >= MAX_DUE_YEAR) {
            years.val(MAX_DUE_YEAR);
            months.val('').prop('disabled', true);
        } else {
            years.val(year);
            months.prop('disabled', false);
        }
        //days.val('').prop('disabled', true);
    }
});
months.focus(function() {
    setDurationInvalid(true);
});
months.blur(function() {
    var month = parseInt(months.val());
    if (isNaN(month) || month <= 0) {
        months.val('');
        if (years.val() === '') {
            days.val('').prop('disabled', false);
        }
    } else {
        if (month > MAX_DUE_MONTH) {
            months.val(MAX_DUE_MONTH);
        } else {
            months.val(month);
        }
        //days.val('').prop('disabled', true);
    }
});
days.focus(function() {
    setDurationInvalid(true);
});
days.blur(function() {
    var day = parseInt(days.val());
    if (isNaN(day) || day <= 0) {
        days.val('');
        years.prop('disabled', false);
        months.prop('disabled', false);
        $('input[name=paymentMethod]').prop('disabled', false);
    } else {
        if (day > MAX_DUE_DAY) {
            days.val(MAX_DUE_DAY);
        } else {
            days.val(day);
        }
        //years.val('').prop('disabled', true);
        //months.val('').prop('disabled', true);
        $('input[name=paymentMethod]').prop('disabled', true);
        $('input[value=BulletRepayment]').prop('disabled', false).prop('checked', true);
    }
});
$('#resetDurationBtn').click(function() {
    years.val('').prop('disabled', false);
    months.val('').prop('disabled', false);
    days.val('').prop('disabled', false);
    $('input[name=paymentMethod]').prop('disabled', false);
});
/**
 * 检测年利率
 *
 * @returns {Boolean}
 */
/////////////////////////////////////////////
var MIN_ANNUAL_RATE = 0.0,    // 年利率最小值
    MAX_ANNUAL_RATE = 24.0;   // 年利率最大值
/////////////////////////////////////////////    
function checkAnnualRate() {
    var result = true;
    if (annualRate.val() === '') { //为空
        result = false;
    }
    var rate = parseFloat(annualRate.val());
    if (rate === 0) { //为0
        result = false;
    }
    if (rate < MIN_ANNUAL_RATE || rate > MAX_ANNUAL_RATE) {
        result = false;
    }
    if (!result) {
        annualRate.addClass('input-invalid');
        annualRateError.css('display', 'inline-block');
    }
    return result;
}
annualRate.focus(function() {
    annualRate.removeClass('input-invalid');
    annualRateError.hide();
});
/**
 * 检测担保费率
 */
/////////////////////////////////////////////
var MIN_DANBAO_RATE = 0.0,    // 担保费率最小值
    MAX_DANBAO_RATE = 20.0;   // 担保费率最大值
/////////////////////////////////////////////    
function checkDanbaoRate() {
    var result = true;
    if (danbaoRate.val() === '') { //为空
        result = false;
    }
    var rate = parseFloat(danbaoRate.val());

    if (rate < MIN_DANBAO_RATE || rate > MAX_DANBAO_RATE) {
        result = false;
    }
    if (!result) {
        danbaoRate.addClass('input-invalid');
        danbaoRateError.css('display', 'inline-block');
    }
    return result;
}
danbaoRate.focus(function() {
    danbaoRate.removeClass('input-invalid');
    danbaoRateError.hide();
});
/**
 * 检测服务费率
 */
/////////////////////////////////////////////
var MIN_SERVICE_RATE = 0.0,    // 担保费率最小值
    MAX_SERVICE_RATE = 20.0;   // 担保费率最大值
/////////////////////////////////////////////    
function checkServiceRate() {
    var result = true;
    if (serviceRate.val() === '') { //为空
        result = false;
    }
    var rate = parseFloat(serviceRate.val());

    if (rate < MIN_SERVICE_RATE || rate > MAX_SERVICE_RATE) {
        result = false;
    }
    if (!result) {
        serviceRate.addClass('input-invalid');
        serviceRateError.css('display', 'inline-block');
    }
    return result;
}
serviceRate.focus(function() {
    serviceRate.removeClass('input-invalid');
    serviceRateError.hide();
});

function checkInvestAmount() {
   var  maxAmout=100000000;
    var result = true;
    if (minAmount.val() === '') {
        minAmount.addClass('input-invalid');
        minInvestAmountError.css('display', 'inline-block');
        result = false;
    } else {
        var v1 = parseInt(minAmount.val());
        if (isNaN(v1) || v1 <= 0) {
            minAmount.addClass('input-invalid');
            minInvestAmountError.css('display', 'inline-block');
            result = false;
        }
        minAmount.val(v1);
    }
    if(minAmount.val()>maxAmout){
        minAmount.addClass('input-invalid');
        result = false;
    }
    if(amount.val()>maxAmout){
        amount.addClass('input-invalid');
        result = false;
    }
    if(maxAmount.val()>maxAmout){
        maxAmount.addClass('input-invalid');
        result = false;
    }
    if(maxAmount.val()>maxAmout){
        maxAmount.addClass('input-invalid');
        result = false;
    }
    if(stepAmount.val()>maxAmout){
        stepAmount.addClass('input-invalid');
        result = false;
    }
    if (maxAmount.val() === '') {
        maxAmount.addClass('input-invalid');
        maxInvestAmountError.css('display', 'inline-block');
        result = false;
    } else {
        var v2 = parseInt(maxAmount.val());
        if (isNaN(v2) || v2 <= 0) {
            maxAmount.addClass('input-invalid');
            maxInvestAmountError.css('display', 'inline-block');
            result = false;
        }
        maxAmount.val(v2);
    }
    if (stepAmount.val() === '') {
        stepAmount.addClass('input-invalid');
        stepAmountError.css('display', 'inline-block');
        result = false;
    } else {
        var v3 = parseInt(stepAmount.val());
        if (isNaN(v3) || v3 <= 0) {
            stepAmount.addClass('input-invalid');
            stepAmountError.css('display', 'inline-block');
            result = false;
        }
        stepAmount.val(v3);
    }
    return result;
}
minAmount.focus(function() {
    minAmount.removeClass('input-invalid');
    minInvestAmountError.hide();
});
maxAmount.focus(function() {
    maxAmount.removeClass('input-invalid');
    maxInvestAmountError.hide();
});
stepAmount.focus(function() {
    stepAmount.removeClass('input-invalid');
    stepAmountError.hide();
});

$('#gotoStep3').click(function() {
    var loanValidated = true;
    if (loanTitle.val() === '') {
        loanTitle.addClass('input-invalid');
        loanTitle.parent().find('.errorText').css('display', 'inline-block');
        loanValidated = false;
    }
    if (loanTitle.val().length < 4) { //长度小于4
    	 loanTitle.addClass('input-invalid');
         loanTitle.parent().find('.errorText').css('display', 'inline-block');
    	loanValidated = false;
    }
    if (!checkAmount(amount.val())) {
        amount.addClass('input-invalid');
        amount.parent().parent().find('.errorText').css('display', 'inline-block');
        loanValidated = false;
    }
    if (!checkInvestAmount()) {
        loanValidated = false;
    }
    if (!checkDuration()) {
        loanValidated = false;
    }
    if (!checkAnnualRate()) {
        loanValidated = false;
    }
    if (!checkDanbaoRate()) {
        loanValidated = false;
    }
    if (!checkServiceRate()) {
        loanValidated = false;
    }
    if($('input:radio[name=paymentMethod]').val()==''){
        $('input[name=paymentMethod]').addClass('input-invalid');
        //amount.parent().parent().find('.errorText').css('display', 'inline-block');
        loanValidated = false;
    }
    if (!loanValidated) {
        return;
    }
    
    if($('input:radio[name=mortgaged]:checked').val() == 'false'){
    	$('#dyxx').hide();
    }else{
    	$('#dyxx').show();
    }
    
    gotoStep3();
});
$('#backToStep1').click(function() {
    goBackStep1();
});
$('#backToStep3').click(function() {
    goBackStep3();
});


///////////////////////////////////////////////////////////////////////////
// 第四步：填写相关说明、提交表单
///////////////////////////////////////////////////////////////////////////

var $description = $('#description'),
    $guaranteeInfo = $('#guaranteeInfo'),
    $mortgageInfo = $('#mortgageInfo'),
    $riskInfo = $('#riskInfo');


function checkDescription() {

    if ($description.val() == '') { //为空
        $description.addClass('input-invalid');
        $description.next().css('display', 'inline-block');
        return false;
    }else{
        $description.removeClass('input-invalid');
        $description.next().css('display', 'none');
    }


    if ($guaranteeInfo.val() == '') { //为空
        $guaranteeInfo.addClass('input-invalid');
        $guaranteeInfo.next().css('display', 'inline-block');
        return false;
    }else{
        $description.removeClass('input-invalid');
        $description.next().css('display', 'none');
    }

    if($('#dyxx').css('display')=='none'){
    	 $description.removeClass('input-invalid');
         $description.next().css('display', 'none');
    }else{
        if ($mortgageInfo.val() == '') { //为空
            $mortgageInfo.addClass('input-invalid');
            $mortgageInfo.next().css('display', 'inline-block');
            return false;
        }else{
            $description.removeClass('input-invalid');
            $description.next().css('display', 'none');
        }    	
    }
    


    if ($riskInfo.val() == '') { //为空
        $riskInfo.addClass('input-invalid');
        $riskInfo.next().css('display', 'inline-block');
        return false;
    }else{
        $description.removeClass('input-invalid');
        $description.next().css('display', 'none');
    }
    return true;
}


///////////////////////////////////////////////////////////////////////////
// 第五步：填写相关说明、提交表单
///////////////////////////////////////////////////////////////////////////
/**
 * 检测贷款说明
 * @param subType 1 立即发布; 0 保存；
 * @returns {Boolean}
 */
function submitForm(subType,ispub){

    var infoValidated = true;
    if (!checkDescription()) {
        infoValidated = false;
    }
    //console.log(false);
    if (!infoValidated) {
        return;
    }
    data = {};
    if(subType==1)
        data.subType=1;
    else
        data.subType=0;

    
    data.loanType = loanType;

    if (mode === 'new') {
        data.newUser = true;
        data.loginName = $('input[name=regedUserLoginName]').val();
        data.username = $('#regedRealName').html();
        data.idNumber = $('#regedIdNumber').html();
        data.userId = '';
    } else {
        data.newUser = false;
        data.userId = $('#regedRealName').attr('data-id');
        data.loginName = '';
        data.username = '';
        data.mobile = '';
        data.idNumber = '';
    }
    data.uniqueCode = $('input[name=uniqueCode]').val();
    data.requestTitle = $('input[name=title]').val();
    data.purpose = $('#usage option:selected').val();
    data.guaranteeType = $('#guaranteeType option:selected').val();
    data.amount = $('input[name=amount]').val();
    data.maxAmount = maxAmount.val();
    data.minAmount = minAmount.val();
    data.stepAmount = stepAmount.val();
    data.years = $('input[name=years]').val();
    data.months = $('input[name=months]').val();
    data.days = $('input[name=days]').val();

    data.rate = $('input[name=annualRate]').val();
   

    data.mortgaged = $('input[name=mortgaged]:checked').val();
    data.requestMethod = $('input[name=paymentMethod]:checked').val();
    data.requestDes = $('#description').val();
    data.guaranteeInfo = $('#guaranteeInfo').val();
    data.mortgageInfo = $('#mortgageInfo').val();
    data.riskInfo = $('#riskInfo').val();
    data.corporation = $('#corporation').val();
    data.claimId = $('#claimId').val();
    data.loanName = $('input[name=contractBorrower]').val();
    data.idNumber = $('input[name=contractBorrowerID]').val();
    data.requestType = $('#loanRequestType option:selected').val();
    data.rateAdd = $('input[name=addAnnualRate]').val();
    data.outTimes=$('#outtimes').val();

    var templateId = $('select[name=template] option:selected').val();
    data.templateId=templateId;
    data.loanGuaranteeFee= $('#loanGuaranteeFee').val() / 100;
        data.loanRiskFee=$('#loanRiskFee').val() / 100;
        data.loanServiceFee= $('#loanServiceFee').val() / 100;
        data.loanManageFee= $('#loanManageFee').val() / 100;
        data.loanInterestFee= $('#loanInterestFee').val() / 100;
        data.investInterestFee= $('#investInterestFee').val() / 100;
        data.publishNow = $('input[name=publishNow]:checked').length;

        var loanRequestId = $('#requestIdCheck').val();
        data.requestId=loanRequestId;
    data.requestDes = data.requestDes.replace('\n','<br/>');
    data.guaranteeInfo = data.guaranteeInfo.replace('\n','<br/>');
    data.mortgageInfo = data.mortgageInfo.replace('\n','<br/>');
    data.riskInfo = data.riskInfo.replace('\n','<br/>');
    
    console.log(data);
    // 提交表单
    var self = $(this);
    self.html('<i class="icon-cog icon-spin"></i> 提交申请').prop('disabled', true);
    $.post('/loan/openLoan/quickLoanRequest', data, function(res) {
        var res= jQuery.parseJSON(res);
        self.html('提交申请').prop('disabled', false);
        console.log(res);
        if (res.result) {
            alert('借款申请成功！');
            if(ispub){
            	$('#registerStep4').attr('data-requestid',res.obj.requestId);
                gotoStep4();
                return false;
            }
           /* if(data.subType==1){
            	location.href = '/loan/loanList/0';
            }else{
            	location.href = '/loan/loanList/1';
            }*/
            location.href = '/loan/loanList/1';
        } else {
            alert(res.message);

        }
    }).fail(function() {
        self.html('提交申请').prop('disabled', false);
        alert('请求失败：请检查输入信息');
    });
}


$('#backToStep2').click(function() {
    goBackStep2();
});



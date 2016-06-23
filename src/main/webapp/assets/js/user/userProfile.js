$('#recent-tab li').click(function () {
    $('#user-information-box .widget-header h4').hide();
    $('#' + $(this).attr('tab-toggle')).show();
});


/**
 * 审核相关代码
 */

//var documents = $("#json-documents").data("json");
////console.log(documents);
//var certificates = $("#json-certificates").data("json");
//var weights = $("#json-weights").data("json");
var documents = JSON.parse($("#json-documents").html());
//console.log(documents);
var certificates = JSON.parse($("#json-certificates").html());
var weights = JSON.parse($("#json-weights").html());
//certificates and weights format is error, fix it here
for (var n in certificates) {
    certificates[n] = eval("(" + certificates[n] + ")");
}
for (var n in weights) {
    weights[n] = parseInt(weights[n]);
}
function setCertificate(type) {
    //$('input.pingfen-input').val(certificates[type].score);
    //$('#' + type + 'auditInfo').val(certificates[type].auditInfo);
    var status = certificates[type].status === 'CHECKED' ? true : false;
    if (status) {
        $('#' + type + '_TAB input[name=shenhe-radio]:first').prop('checked', true);
        $("#auditInfo").hide();
    } else {
        $('#' + type + '_TAB input[name=shenhe-radio]:last').prop('checked', true);
        $("#auditInfo").show();
    }
}
// 认证项Tab点击时更新审核状态Radio
$('#certifications li').click(function () {
    var type = $(this).data('type');
    setCertificate(type);
});
$('a[href=#certifications]').click(function () {
    $('#certifications li').first().trigger('click');
});

// 显示/隐藏审核拒绝理由输入框
$('input.certificateStatusRadio').click(function () {
    var type = $(this).data('type');
    if ($(this).val() == 'false') {
        $('#' + type + '_auditInfo').show();
    } else {
        $('#' + type + '_auditInfo').hide();
    }
});
// 计算审核总评分
//function getTotalScore() {
//    var sum = 0, totalWeights = 0;
//    for (var type in weights) {
//        sum += parseFloat(weights[type]) * parseFloat(certificates[type].score);
//        totalWeights += parseFloat(weights[type]);
//    }
//    var total = (sum / totalWeights).toFixed(1);
//    return isNaN(total) ? 0 : total;
//}
for (var i = 0; i < CertificateTypes.length; i++) {
    // 认证项
    var type = CertificateTypes[i];
    var w = weights[type];
    $('#' + type + '_typeWeight').html(parseFloat(w) * 100);
    $('#' + type + '_auditInfo').val(certificates[type].auditInfo);
    $('#' + type + '_pingfen_input').val(certificates[type].score);

    // 图片容器
    var $colorboxUl = $('<ul class="ace-thumbnails"></ul>');
    // 个人页面不显示贷款相关认证
    if (type != "LOANPURPOSE" && type != "GUARANTEE") {
        // 显示认证项评分
        $('#' + type + '_TAB input[name=scoreInput]').val(certificates[type].score);
        // 审核状态
        var status;
        if (certificates[type].status === 'CHECKED') {
            status = '<i class="icon-ok-sign green"></i>';
            $('#' + type + '_auditInfo').hide();
            $('input[name=' + type + '_shenhe-radio][value=true]').prop("checked", true);
        } else {
            status = '<i class="icon-remove-sign red"></i>';
            $('#' + type + '_auditInfo').show();
            $('input[name=' + type + '_shenhe-radio][value=false]').prop("checked", true);
        }
        // 添加审核状态图标到tab
        $('a[href=#' + type + '_TAB]').prepend(status);
        // 添加认证图片
        var images = documents[type].images;
        for (var j = 0; j < images.length; j++) {
            var img = images[j];
            var cbLiTemplate = $('#cbLiTemplate').html()
                .replace('$link', img['uri'])
                .replace('$src', img['uri'])
                .replace('$uploader', img['uploader'])
                .replace('$date', (new Date(img['submitTime'])).Format('yyyy-MM-dd'))
                .replace('$name', img['name'].split('.')[0]);
            $colorboxUl.append($(cbLiTemplate));
        }
        if (images.length == 0) {
            $('#' + type + '_TAB .cbcontainer').html('暂无图片');
        } else {
            $('#' + type + '_TAB .cbcontainer').append($colorboxUl);
        }
        // 添加认证文档
        var files = documents[type]['files'];
        $.each(files, function (k, v) {
            var link = v.uploader !== '用户本人' ? 'employee/profile/' + v.uploaderId : 'user/' + uid;
            var file = $('#docTemplate').html().replace('$name', v.name)
                .replace('$downloadLink', v.uri)
                .replace('$uri', v.uri)
                .replace('$link', link)
                .replace('$uploader', v.uploader)
                .replace('$submitTime', new Date(v.submitTime)
                    .Format("yyyy-MM-dd hh:mm"));
            if (v.uri.indexOf('.pdf') === -1)
                file = file.replace('$icon', 'file_doc');
            else
                file = file.replace('$icon', 'file_pdf');
            $(file).appendTo('#' + type + '_TAB .doccontainer');
        });
        if (files.length == 0) {
            $('#' + type + '_TAB .doccontainer').html('暂无图片');
        }

    }
}
//$('.totalScore').text(getTotalScore());
var colorbox_params = {
    reposition: true,
    scalePhotos: true,
    scrolling: false,
    previous: '<i class="icon-arrow-left"></i>',
    next: '<i class="icon-arrow-right"></i>',
    close: '&times;',
    current: '{current} of {total}',
    maxWidth: '100%',
    maxHeight: '100%',
    photo: true,
    onOpen: function () {
        document.body.style.overflow = 'hidden';
    },
    onClosed: function () {
        document.body.style.overflow = 'auto';
    },
    onComplete: function () {
        $.colorbox.resize();
    }
};
$('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
//$("#cboxLoadingGraphic").append("<i class='icon-spinner orange'></i>");//let's add a custom loading icon


function getTotalScore() {
    var totalScore = 0;
    for (var t in weights) {
        //var cert = eval("("+certificates[t]+")");
        var w = weights[t], s = certificates[t].score;
        totalScore += w * s;
    }
    return parseInt(totalScore);
}

console.log(getTotalScore());

$("#totalScoreDiv").html(getTotalScore());

$('.updateCertificateBtn').click(function () {
    var type = $(this).data('type');
    var score = $('#' + type + '_pingfen_input').val();
    var shenhe = $('input[name=' + type + '_shenhe-radio]:checked').val();
    var url = "/loan/updateCertificate";
    var self = $(this);
    //计算总分
    var totalScore = getTotalScore();

    $(this).html('正在保存').prop('disabled', true);
    $.post(url, {
        'userId': CC.user.id,
        'score': score,
        'shenhe': shenhe,
        'totalScore': totalScore,
        'auditInfo': $("#" + type + "_auditInfo").val(),
        'type': type
    }, function (res) {
        self.html('保存修改').prop('disabled', false);
        if (!res) {
            alert('保存失败');
        } else {
            alert('保存成功！');
            $("#totalScoreDiv").html(totalScore);
            certificates[type].score = score;
            certificates[type].status = shenhe === 'true' ? 'CHECKED' : 'DENIED';
            var status;
            if (certificates[type].status === 'CHECKED') {
                status = '<i class="icon-ok-sign green"></i>';
            } else {
                status = '<i class="icon-remove-sign red"></i>';
            }
            $('a[href=#' + type + '_TAB]').find('i').remove();
            $('a[href=#' + type + '_TAB]').prepend(status);
            $('.totalScore').text(getTotalScore());
        }
    });
});

//
//$('#rechargePanel').slimScroll({height: '200px',
//    alwaysVisible: true
//});
/**
 * Init values
 */
if (male) {
    $('#maleRadios1').prop('checked', true);
} else {
    $('#maleRadios2').prop('checked', true);
}
if (children) {
    $('#childrenRadios1').prop('checked', true);
} else {
    $('#childrenRadios2').prop('checked', true);
}
moment.lang('zh-cn', {
    months: "一月_二月_三月_四月_五月_六月_七月_八月_九月_十月_十一月_十二月".split("_"),
    monthsShort: "1月_2月_3月_4月_5月_6月_7月_8月_9月_10月_11月_12月".split("_")
});

// Init inline editable elements.
//$.fn.editable.defaults.mode = 'inline';
$.fn.editable.defaults.emptytext = '未知';
$.fn.editableform.loading = "<div class='editableform-loading'><i class='light-blue icon-2x icon-spinner icon-spin'></i></div>";
$.fn.editableform.buttons = '<button type="submit" class="btn btn-info editable-submit"><i class="icon-ok icon-white"></i></button>' +
    '<button type="button" class="btn editable-cancel"><i class="icon-remove"></i></button>';

$('.editable').editable({});

var birthDate = new Date($('#dateOfBirth').data('value'));

$('#dateOfBirth').data('value', birthDate.Format('yyyy-MM-dd'));
$('#dateOfBirth').editable({
    combodate: {
        minYear: 1948,
        maxYear: 1997
    }
});

$('#educationLevel').editable({
    type: 'select',
    source: EducationLevel
});
$('#maritalStatus').editable({
    type: 'select',
    source: MaritalStatus
});
$('#careerStatus').editable({
    type: 'select',
    source: CareerStatus
});
$('#companyType').editable({
    type: 'select',
    source: CompanyType
});
$('#companyIndustry').editable({
    type: 'select',
    source: CompanyIndustry
});
$('#companySize').editable({
    type: 'select',
    source: CompanySize
});
$('#yearOfService').editable({
    type: 'select',
    source: YearOfService
});
$('#salary').editable({
    type: 'select',
    source: MonthlySalary
});
$('#ethnic').editable({
    type: 'select',
    source: EthnicGroup
});

// 手机号码输入验证
$('.phone_number').editable({
    validate: function (value) {
        if (value === '') {
            return '请输入手机号码';
        }
        if (!/^1\d{10}$/.test(value)) {
            return '手机号码格式不正确';
        }
    }
});

// 入学年份输入验证
$('#enrollmentYear').editable({
    validate: function (value) {
        if (value === '') {
            return '请输入4位入学年份';
        }
        if (!/^[12]\d{3}$/.test(value)) {
            return '入学年份格式不正确';
        }
    }
});

// 公司电话输入验证
$('#companyPhone').editable({
    validate: function (value) {
        if (value === '') {
            return '请输入电话号码';
        }
        if (!/\d{7,11}$/.test(value)) {
            return '电话号码格式不正确';
        }
    }
});

// 车辆、房产数输入验证
$('#houseNumber, #carNumber').editable({
    validate: function (value) {
        var str = $(this).attr('id') === 'houseNumber' ? '房产数目' : '车辆数目';
        if (parseInt(value) < 0) {
            return str + '必须为正数';
        }
    }
});


var yf = $('.yellow_fadeout');
yf.text('保存成功！').css('margin-left', -yf.width() / 2 + 'px');

/**
 * Update Personal info
 */
$('#updatePersonalInfo').click(function () {
    $('.load_masker').show();
    var params = {},
        date = $('#dateOfBirth').editable('getValue')['dateOfBirth'].split('-');
    date = (new Date()).setFullYear(parseInt(date[0]), parseInt(date[1]) - 1, parseInt(date[2]));

    params.male = $('input[name="male"]').prop('checked');
    params.dateOfBirth = $('#dateOfBirth').editable('getValue')['dateOfBirth'];
    params.maritalStatus = $.trim($('#maritalStatus').text());
    params.ethnic = $.trim($('#ethnic').text());
    params.children = $('input[name="children"]').prop('checked');

    params.educationLevel = $('#educationLevel').editable('getValue')['educationLevel'];
    params.enrollmentYear = $.trim($('#enrollmentYear').text());
    params.school = $.trim($('#school').text());

    params.nativeProvince = $.trim($('#nativeProvince').text());
    params.nativeCity = $.trim($('#nativeCity').text());
    params.hukouProvince = $.trim($('#hukouProvince').text());
    params.hukouCity = $.trim($('#hukouCity').text());
    params.currentAddress = $.trim($('#currentAddress').text());
    params.userId = $('#user').data('id');
    params.currentPhone = $.trim($('#currentPhone').text());

    params.avatar = "";
    setEmptyValue(params);

    $.post("user/updatePersonalInfo", params, function () {
        $('.load_masker').hide();
        yf.show().fadeOut(1500);
    });
});
$('#updateENPersonalInfo').click(function () {
    $('.load_masker').show();
    var params = {};
    params.userId = $('#e_userId').val();
    params.enAddress = $('#e_enAddress').val();
    params.enPhone = $('#e_enPhone').val();
    params.enNature = $('#e_enNature').val();
    params.enterprise = true;
    setEmptyValue(params);

    $.post("/user/update", params, function () {
        $('.load_masker').hide();
        yf.show().fadeOut(1500);
    });
});

/**
 * Update Finance info
 */

if (hasHouse) {
    $('#houseRadios1').prop('checked', true);
    $('.houseNumber').show();
    $('.houseLoan').show();
}
if (hasHouseLoan) {
    $('#houseLoanRadios1').prop('checked', true);
}
if (hasCar) {
    $('#carRadios1').prop('checked', true);
    $('.carNumber').show();
    $('.carLoan').show();
}
if (hasCarLoan) {
    $('#carLoanRadios1').prop('checked', true);
}
$('#updateFinanceInfo').click(function () {
    $('.load_masker').show();
    var params = {};
    params.house = $('input[name="house"]').prop('checked');
    params.houseNumber = $.trim($('#houseNumber').text());
    params.houseLoan = $('input[name="houseLoan"]').prop('checked');
    params.car = $('input[name="car"]').prop('checked');
    params.carNumber = $.trim($('#carNumber').text());
    params.carLoan = $('input[name="carLoan"]').prop('checked');
    setEmptyValue(params);

    $.post("user/updateFinanceInfo/" + $('#user').data('id'), params, function () {
        $('.load_masker').hide();
        yf.show().fadeOut(1500);
    });
});

$('#houseRadios1').change(function () {
    $('.houseNumber').show();
    $('.houseLoan').show();
});
$('#houseRadios2').change(function () {
    $('.houseNumber').hide();
    $('.houseLoan').hide();
});
$('#carRadios1').change(function () {
    $('.carNumber').show();
    $('.carLoan').show();
});
$('#carRadios2').change(function () {
    $('.carNumber').hide();
    $('.carLoan').hide();
});

/**
 * Update Career info          */
$('#updateCareerInfo').click(function () {
    $('.load_masker').show();
    var params = {};
    params.careerStatus = $.trim($('#careerStatus').text());
    params.companyName = $.trim($('#companyName').text());
    params.companyType = $.trim($('#companyType').text());
    params.companyIndustry = $.trim($('#companyIndustry').text());
    params.companySize = $.trim($('#companySize').text());
    params.companyPhone = $.trim($('#companyPhone').text());
    params.companyAddres = $.trim($('#companyAddres').text());
    params.province = $.trim($('#province').text());
    params.userId = $('#user').data('id');
    params.city = $.trim($('#city').text());
    params.position = $.trim($('#position').text());
    params.salary = $.trim($('#salary').text());
    params.yearOfService = $.trim($('#yearOfService').text());
    params.workMail = $.trim($('#workMail').text());
    setEmptyValue(params);
    $.post("user/updateCareerInfo", params, function () {
        $('.load_masker').hide();
        yf.show().fadeOut(1500);
    });
});

/**
 * Update Contact info
 */
$('#updateContactInfo').click(function () {
    $('.load_masker').show();
    var params = {};
    params.emergency_name = $.trim($('#emergency_name').text());
    params.emergency_relation = $.trim($('#emergency_relation').text());
    params.emergency_mobile = $.trim($('#emergency_mobile').text());
    params.colleague_name = $.trim($('#colleague_name').text());
    params.colleague_relation = $.trim($('#colleague_relation').text());
    params.colleague_mobile = $.trim($('#colleague_mobile').text());
    params.other_name = $.trim($('#other_name').text());
    params.other_relation = $.trim($('#other_relation').text());
    params.other_mobile = $.trim($('#other_mobile').text());
    params.userId = $('#user').data('id');
    setEmptyValue(params);

    $.post("user/updateContactInfo", params, function () {
        $('.load_masker').hide();
        yf.show().fadeOut(1500);
    });
});
function setEmptyValue(params) {
    $.each(params, function (k, v) {
        if (v === '未知') {
            params[k] = '';
        }
    });
}

var tagAliasMap = {}, uid = $('#user').data('id'), branchList = {};

$('#updateUserTagBtn').click(function () {
    var tags = $('#tagsInput').val(), tagValues = [];
    // 生成标签列表
    for (var i in tags) {
        var v = (tags[i] in tagAliasMap)
            ? (tagAliasMap[tags[i]].realm + ':' + tagAliasMap[tags[i]].name)
            : ('STRING:' + tags[i] + ':' + tags[i]);
        tagValues.push(v);
    }
    $.post('user/updateUserTags', {
        'uid': uid,
        'tags': tagValues.join(',')
    }, function () {
        alert('标签更新成功！');
    }).fail(function () {
        alert('更新失败！');
    });
});

// 身份证认证 for arjr
$("#accept-ID").click(function () {
    var $this = $(this);
    if (typeof CC.user == "undefined") {
        alert("参数有误，请刷新页面重试");
        return;
    }
    var text = $this.html();
    $this.text("正在验证…");
    $.post("user/authenticateIdNumber", {
        uid: CC.user.id,
        name: CC.user.name,
        idNumber: CC.user.idNumber
    }, function (res) {
        if (res === "success") {
            alert("认证成功");
            window.location.reload();
        } else {
            $this.html(text);
            alert("认证失败");
        }
    });
});

$('#updateReferralBtn').click(function () {
    var type = $('input[name=refType]:checked').val(), ref = '';
    if (type === 'employee') {
        ref = $('#empReferralSelect option:selected').val();
    } else if (type === 'user') {
        ref = $('#usrReferralSelect option:selected').val();
    } else {
        ref = $('#otherRef').val();
    }
    $.post("user/updateReferral", {
        'uid': CC.user.id,
        'type': type,
        'rid': ref
    }, function (res) {
        if (res) {
            alert('推荐人修改成功！');
        } else {
            alert('推荐人修改失败');
        }
    }).fail(function () {
        alert('推荐人修改失败：网络错误');
    });
});


$('input[name=refType]').change(function () {
    var type = $('input[name=refType]:checked').val();
    if (type === 'employee') {
        $('#empReferralSelect').show();
        $('#usrReferralSelect').hide();
        $('#otherRef').hide();
    } else if (type === 'user') {
        $('#empReferralSelect').hide();
        $('#usrReferralSelect').show();
        $('#otherRef').hide();
    } else {
        $('#empReferralSelect').hide();
        $('#usrReferralSelect').hide();
        $('#otherRef').show();
    }
});

//登录信息


var loginTable = null,
    logsource = $("#login_fund-type option:selected").val();
function initloginTable(data) {
    if (loginTable != null) {
        loginTable.fnDestroy();
    }
    loginTable = $('#loginHistoryTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "iDisplayLength": 10,
        "bSort": false,
        data:data,
        "aoColumns": [
            {"mData": "loginTime", "sDefaultContent": ""},
            {"mData": "source", "sDefaultContent": ""},
        ],
        "aoColumnDefs": [{
            "aTargets": [0], //时间
            "mRender": function (data, type, row) {
                return (new Date(data)).Format("yyyy-MM-dd hh:mm:ss");
            }
        }, {
            "aTargets": [1], //登录渠道
            "mRender": function (data, type, row) {
                if(data == "WEB"){
                    return "公共网络";
                }else if(data == "BACK"){
                    return "系统后台";
                }else if(data == "MSTATION"){
                    return "M站";
                }else if(data == "MOBILE"){
                    return "移动端";
                }

            }
        }],
        "dom": '<>rt<"oBottom"lp>',
        "oLanguage": {
            "sLengthMenu": "_MENU_",
            "sSearch": "",
            "sInfo": "显示第 _START_ - _END_ 条记录，共 _TOTAL_ 条",
            "sInfoEmpty": "没有符合条件的记录",
            "sZeroRecords": "没有符合条件的记录",
            "oPaginate": {
                "sFirst": "首页",
                "sPrevious": "前一页",
                "sNext": "后一页",
                "sLast": "尾页"
            }
        }
    });
    loginTable.fnSort([[5, 'asc']]);//按时间排序
    $("#loginHistoryTable_filter label").css({"visibility": "hidden"});
}

var year, month, day, hour, min, sec;
var today = new Date();
year = today.getYear();
month = today.getMonth();
day = today.getDate();
var lastYearToday = new Date(year + 1900 - 1, month, day, 0, 0, 0);
//
//
var loginstartDate = $('#loginStartDate');
var loginendDate = $('#loginEndDate');
//

$.ajax({
    url: '/user/queryloginRecords',
    type: "GET",
    data: {
        startDate: lastYearToday.getTime(),
        endDate: today.getTime(),
        userId: CC.user.id,
        loginSource: logsource,
        iDisplayStart: 0,
        iDisplayLength: 10
    },
    dataType: 'JSON',
    success: function (res) {
        initloginTable(res.aaData);
    }

});



$("#searchLoginBtn").click(function () {
    var self = $(this);
    self.prop('disabled', true);
    var sd = loginstartDate.val().split("-");
    year = sd[0];
    month = parseInt(sd[1]);
    day = parseInt(sd[2]);
    var new_date_s = (new Date(year, month - 1, day, 0, 0, 0));

    var ed = loginendDate.val().split("-");
    year = ed[0];
    month = parseInt(ed[1]);
    day = parseInt(ed[2]);
    var new_date_e = (new Date(year, month - 1, day, 23, 59, 59));

    var data = {
        startDate: new_date_s.getTime(),
        endDate: new_date_e.getTime(),
        userId: CC.user.id,
        loginSource: $('#login_fund-type option:selected').val(),
        iDisplayStart: 0,
        iDisplayLength: 10
    };
    $.ajax({
        url: '/user/queryloginRecords',
        type: "GET",
        data:data,
        dataType: 'JSON',
        success: function (res) {
            self.prop('disabled', false);
            initloginTable(res.aaData);
        }
    }).fail(function () {
        self.prop('disabled', false);
        alert('查询失败：网络错误');
    });
});

var dater = {
    format: 'YYYY-MM-DD',
    opens: 'left',
    ranges: {
        '今天': [moment(), moment()],
        '昨天': [moment().subtract('days', 1), moment().subtract('days', 1)],
        '过去一周': [moment().subtract('days', 6), moment()],
        '过去30天': [moment().subtract('days', 29), moment()],
        '本月': [moment().startOf('month'), moment().endOf('month')],
        '上个月': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
    },
    startDate: lastYearToday.Format('yyyy-MM-dd'),
    endDate: moment(),
    locale: {
        applyLabel: '确定',
        clearLabel: "取消",
        cancelLabel: "取消",
        fromLabel: '开始时间',
        toLabel: '结束时间',
        weekLabel: '周',
        customRangeLabel: '选择范围',
        daysOfWeek: "日_一_二_三_四_五_六".split("_"),
        monthNames: "一月_二月_三月_四月_五月_六月_七月_八月_九月_十月_十一月_十二月".split("_"),
        firstDay: 0
    }
};
$('#login_reservation').daterangepicker(dater, function(start, end){
    loginstartDate.val(start.format("YYYY-MM-DD"));
    loginendDate.val(end.format("YYYY-MM-DD"));
}).prev().on(ace.click_event, function () {
    $(this).next().focus();
});
$('#dateRangePicker1').val(lastYearToday.Format('yyyy-MM-dd') + ' - ' + today.Format('yyyy-MM-dd'));
loginstartDate.val(lastYearToday.Format('yyyy-MM-dd'));
loginendDate.val(today.Format('yyyy-MM-dd'));

//资金管理
var fundStatus = {
    'INITIALIZED': '<span class="badge badge-grey">' + FundRecordStatus['INITIALIZED'] + '</span>',
    'PROCESSING': '<span class="badge badge-warning">' + FundRecordStatus['PROCESSING'] + '</span>',
    'AUDITING': '<span class="badge badge-purple">' + FundRecordStatus['AUDITING'] + '</span>',
    'SUCCESSFUL': '<span class="badge badge-success">' + FundRecordStatus['SUCCESSFUL'] + '</span>',
    'FAILED': '<span class="badge badge-danger">' + FundRecordStatus['FAILED'] + '</span>',
    'REJECTED': '<span class="badge badge-inverse">' + FundRecordStatus['REJECTED'] + '</span>',
    'CANCELED': '<span class="badge badge-light">' + FundRecordStatus['CANCELED'] + '</span>'
};
var oTable = null;
function initTable(data) {
    if (oTable != null) {
        oTable.fnDestroy();
    }
    oTable = $('#fundHistoryTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": false,
        "iDisplayLength": 10,
        "bDestroy": true,
        "retrieve": false,
        "bSearchable": false,
        data: data,
        "aoColumns": [
            {"mData": "amount"},
            {"mData": "orderId"},
            {"mData": "operationType"},
            {"mData": "operationStatus"},
            {"mData": "tradeStatus"},
            {"mData": "recordTime"},
            {"mData": "description"}
        ],
        "aoColumnDefs": [{
            "aTargets": [0], //金额
            "mRender": function (data, type, row) {
                if (row['operationType'] in ['DEPOSIT', 'REWARD_REGISTER', 'INVEST_REPAY', 'REWARD_INVEST', 'REWARD_DEPOSIT']) {
                    return '<span class=green>' + data + '</span>';
                } else if (row['operation'] === 'WITHDRAW') {
                    return '<span class=red>' + data + '</span>';
                } else
                    return data;
            }
        }, {
            "aTargets": [2], //资金类型
            "mRender": function (data, type, row) {
                return OperationType[data];
            }
        }, {
            "aTargets": [3], //操作
            "mRender": function (data, type, row) {
                return FundRecordOperation[data];
            }
        }, {
            "aTargets": [4], //状态
            "mRender": function (data, type, row) {
                return fundStatus[data];
            }
        }, {
            "aTargets": [5], //时间
            "mRender": function (data, type, row) {
                return (new Date(data)).Format("yyyy-MM-dd hh:mm:ss");
            }
        }, {
            "aTargets": [6], //时间
            "mRender": function (data, type, row) {
                if (typeof(data) !== "undefined") {
                    return data;
                } else {
                    return "";
                }
            }
        }],
        "dom": '<>rt<"oBottom"lp>',
        "oLanguage": {
            "sLengthMenu": "_MENU_",
            "sSearch": "",
            "sInfo": "显示第 _START_ - _END_ 条记录，共 _TOTAL_ 条",
            "sInfoEmpty": "没有符合条件的记录",
            "sZeroRecords": "没有符合条件的记录",
            "oPaginate": {
                "sFirst": "首页",
                "sPrevious": "前一页",
                "sNext": "后一页",
                "sLast": "尾页"
            }
        }
    });
    oTable.fnSort([[5, 'asc']]);//按时间排序
}

var $startDate = $('#fundStartDate');
var $endDate = $('#fundEndDate');

$.post("/user/funds", {
    userId: CC.user.id,
    type: 'ALL',
    status: 'SUCCESSFUL',
    allOperation: false,
    startDate: new Date('1990-12-12').getTime(),
    endDate: today.getTime()
}, function (res) {
    var d = $.parseJSON(res);
    initTable(d.aaData);
});


$('#searchClientFundBtn').click(function () {
    var self = $(this);
    var $rateDate = $('#login_reservation').val();
    self.prop('disabled', true);
    var sd = $rateDate.split(" - ");
    
    var data = {
        userId: CC.user.id,
        type: $('select[name=type] option:selected').val(),
        status: $('#fundRecordStatus option:selected').val(),
        allOperation: $('input[name=showAllOperations]').prop('checked'),
        startDate: new Date(sd[0]).getTime(),
        endDate:  new Date(sd[1]).getTime()
    };
    $.post("/user/funds", data, function (res) {
        self.prop('disabled', false);
        var d = $.parseJSON(res);
        initTable(d.aaData);
    }).fail(function () {
        self.prop('disabled', false);
        alert('查询失败：网络错误');
    });
});


$('#reservation').daterangepicker(dater,function(start, end){
    $startDate.val(start.format("YYYY-MM-DD"));
    $endDate.val(end.format("YYYY-MM-DD"));
}).prev().on(ace.click_event, function () {
    $(this).next().focus();
});
$('#dateRangePicker').val(lastYearToday.Format('yyyy-MM-dd') + ' - ' + today.Format('yyyy-MM-dd'));
$startDate.val(lastYearToday.Format('yyyy-MM-dd'));
$endDate.val(today.Format('yyyy-MM-dd'));

$("#resetPasswordBtn").click(function () {
    var url = $(this).data("url");
    if (confirm("确定重置密码？")) {
        $.get(url, function (res) {
            if (res == true) {
                alert("密码已重置！新的随机密码将通过短信发送给用户");
            } else {
                alert("密码重置失败");
            }
        });
    }
});

function register() {
    $('.ticket-detail-btn').click(function () {
        var uri = $(this).data('uri'), self = $(this);
        self.prop('disabled', true);
        $.get(uri, function (res) {
            self.popover({
                'placement': 'left',
                'html': true,
                'content': $('#popupTicketDetail').html()
                    .replace('$title', res.ticket.title)
                    .replace('$type', TicketType[res.ticket.type])
                    .replace('$category', TicketCategory[res.ticket.category])
                    .replace('$callNumber', res.ticket.callNumber)
                    .replace('$userLoginName', res.userLoginName)
                    .replace('$employeeName', res.employeeName)
                    .replace('$content', res.ticket.content)
                    .replace('$status', TicketStatus[res.ticket.status])
                    .replace('$timeCreated', new Date(res.ticket.timeCreated).Format('yyyy-MM-dd'))
            });
            self.popover('show');
            $('.ticket-popover i').click(function () {
                self.popover('destroy');
                self.prop('disabled', false);
            });
        }).fail(function () {
            self.prop('disabled', false);
        });
    });
}

/*********************************************************************
 * 绑定银行卡
 * @param ele 编辑时触发的元素，为了的到empId
 */
function bandBankCard() {

    var template = Handlebars.compile($("#bank-template").html());
    //默认数据
    var context = {bankNum: "", bankNumConfirm: ""};
    var html = '';
    showdailog(context);


    function showdailog(context) {
        html = template(context);
        bootbox.dialog({
            message: html,
            title: "更换银行卡",
            className: "modal-darkorange"
        });
    }

    validateUser();
}

$(document).on("click", "#bankcardBtn", function () {
    var userId = CC.user.id;
    var bankName = $('#bankName').val();
    var bankCard = $('#bankNumConfirm').val();

    $.post("/user/changebankcard",
        {
            'userId': userId,
            'bankName': bankName,
            'bankCard': bankCard
        }, function (data) {
            var res = eval('(' + data + ')');
            if (res.success == '1') {
                alert('换绑成功！');
                location.reload();
            } else {
                alert(res.comment);
            }
        });
});

function validateUser() {
    $("#bankForm").bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            bankCard: {
                validators: {
                    notEmpty: {
                        message: '银行卡号不能为空'
                    },
                    stringLength: {
                        min: 16,
                        message: '银行卡号不能为空不少于16位'
                    },
                    identical: {
                        field: 'bankNumConfirm',
                        message: '两次输入的银行卡号不一致'
                    }
                }
            },
            bankNumConfirm: {
                validators: {
                    notEmpty: {
                        message: '新银行卡号不能为空'
                    },
                    stringLength: {
                        min: 16,
                        message: '新银行卡号不少于16位'
                    },
                    identical: {
                        field: 'bankCard',
                        message: '两次输入的银行卡号不一致'
                    }
                }
            }
        }/*,
         submitHandler : function(form) {
         $.post($form.attr('action'), $form.serialize(), function(data) {
         var res = eval('('+data+')');
         if(res.success=='1'){
         alert('换绑成功！')
         }else{
         alert(res.commet);
         }
         });
         }*/
    });
}
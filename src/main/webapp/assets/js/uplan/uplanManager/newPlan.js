/*
 $.fn.datepicker.dates['cn'] = {
 days : [ "周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日" ],
 daysShort : [ "日", "一", "二", "三", "四", "五", "六", "日" ],
 daysMin : [ "日", "一", "二", "三", "四", "五", "六", "日" ],
 months : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月",
 "十一月", "十二月" ],
 monthsShort : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月",
 "十一月", "十二月" ]
 };*/
//匹配债权

$('#cb_checkall').bind('click', function (e) {
    $(this).closest('table').find('td input[type=checkbox]').prop('checked', $(this).prop('checked'));
	var loanRate = $.trim($('#loanRate').val());
	var loanEndDate = $.trim($('#loanEndDate').val());
	if (loanRate == '' || loanEndDate == '') {
		alert("请按具体还款日期和收益率匹配后，再进行选择操作！");
		$('#cb_checkall').prop('checked', false);
		$('#loanRate').attr("readonly", false);
		$('input[name=loanId]').prop('checked', false);
		return false;
	} else {
		var result = false;
		$("input[name=loanId]:checkbox:checked").each(function(){ 
			$(this).prop('checked', false);
			$(this).click();
		}); 
		
		var n = $("input:checked").length; 
		if (n == 0) {
			$('#loanRate').attr("readonly", false);
		} else {
			$('#loanRate').attr("readonly", "readonly");
		}
	}
});
$('#loanEndDate').datepicker({
   /* 'language': 'cn'*/
}).next();
/*
 * 发布新产品主页面，点击--匹配债权包 按钮，显示匹配模板页面
 */
function showLoginInformation() {
    showTable();
}
/**
 * 查找用户
 *
 */
var userLoginName=$('input[name=userLoginName]'),
    login_name_error = userLoginName.parent().find('.errorText'),
    realUserName = $('#realUserName'),
    realUserIdNumber = $('#realUserIdNumber'),
    showUserName = $('input[name=showUserName]'),
    showUserIdNumber = $('input[name=showUserIdNumber]'),
uncbiVal=false,
    uncbVal = false;
realUserName.focus(function() {
    login_name_error.hide();
    realUserName.removeClass('input-invalid');
});
function queryUser() {
    if(userLoginName.val()==''){
        return false;
    }
    $.getJSON('/uplan/queryUser/' + userLoginName.val(), function(res) {
        if (res) {
            login_name_error.hide();
            realUserIdNumber.text(res.user.idNumber);	// 身份证号
            realUserName.text(res.user.userName);		// 真实姓名
            realUserName.attr('data-id', res.user.id);	// 真实姓名
            $('#userName').val(res.user.userName);
            $('#userIdNumber').val(res.user.idNumber);
        } else {
        	realUserName.text('未找到');
        	realUserName.data('id', '');
        	realUserIdNumber.text('未找到');
        }
    });
}
userLoginName.keyup(function (event) {
    if (event.keyCode === 13) {
        queryUser();
    }
});
$('#queryUserBtn').on('click',function() {
    queryUser();
});

//添加匹配债权
$('#confirmMatch').on('click', function () {
    var creditList1 = [], planId = $('input[name=loanId]:checked'), creditListJSON = {};

    var loanEndDate = $('#loanEndDate').val();
    var loanRate = $('#loanRate').val();
    if (loanEndDate == '' || loanRate == '') {
        alert('收益率和还款日期不能为空');
        return;
    }

    if (planId.length == 0) {
        alert('请选择要匹配的债权');
        return;
    }

    for (var i = 0; i < planId.length; i++) {
        creditList1.push($(planId[i]).val());
    }

    newPlan.defaultData.jqPlanEl.val(creditList1.toString());
    $('#matchCreditWarp').modal('hide');
    $('.modal-backdrop').remove();
    newPlan.renderCreditList();
});
//删除匹配债权
function delMatchCredit(self) {

    var planIdsStr,//得到删除前的id字符串
        currPlanId,//要删除的id字符串
        newPlanIdStr,//删除后剩余的id字符串
        currPlanIdIndex;//当前id字符串在删除前的位置
    var planIdsStr = newPlan.defaultData.jqPlanEl.val();
    var currPlanId = $(self).attr('data-id');
    currPlanIdIndex = planIdsStr.indexOf(currPlanId);
    if (currPlanIdIndex > 0) {
        if (planIdsStr.length > 36)
            newPlanIdStr = planIdsStr.substring(0, currPlanIdIndex - 1) + planIdsStr.substring(currPlanIdIndex + 36);
        else if (planIdsStr.length == 36)
            newPlanIdStr = ''
    } else if (currPlanIdIndex == 0) {
        if (planIdsStr.length > 36)
            newPlanIdStr = planIdsStr.substring(37);
        else if (planIdsStr.length == 36)
            newPlanIdStr = ''
    } else if (currPlanIdIndex == -1) {
        alert('DataTable参数错误');
        return;
    }
    newPlan.defaultData.jqPlanEl.val(newPlanIdStr);
    newPlan.renderCreditList();
}

function checkRate(index, rate, loanEndDate) {
	var loanRate = $.trim($('#loanRate').val());//年利率
	var loanDate = $.trim($('#loanEndDate').val());// 还款日期
	rate = rate/100;
	loanEndDate = new Date(loanEndDate).Format("yyyy-MM-dd");
	if (loanRate == '' || loanDate == '') {
		alert("请按具体还款日期和收益率匹配后，再进行选择操作！");
		$('input[name=loanId]')[index].checked = false;
		return false;
	}
	
	if (rate != loanRate || loanEndDate != loanDate) {
		alert("您选择的借款人年化利率或还款日期与匹配的不符，请重新选择！");
		$('input[name=loanId]')[index].checked = false;
		return false;
	}
	
	var n = $("input:checked").length; 
	if (n > 0) {
		$('#loanRate').attr("readonly","readonly");
	} else {
		$('#loanRate').attr("readonly", false);
	}
	
	return true;
}

/**
 * 后台查询匹配债权包信息
 */
function showTable() {
    var loanEndDate = $('#loanEndDate').val();
    var loanRate = $('#loanRate').val();
    console.log("loanEndDate==" + loanEndDate + ";loanRate==" + loanRate);

    $('#plansTable').dataTable({
        "sDom": "flt<'row '>",
        "bProcessing": true,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        "paging": false,
        "searching": false,
        "aoColumns": [
            {"mData": "loanId", "sDefaultContent" : ""},// 0
            {"mData": "loanerName", "sDefaultContent" : ""},// 0
            {"mData": "loanerCardNo", "sDefaultContent" : ""},//1
            {"mData": "loanEndDate", "sDefaultContent" : ""},//2
            {"mData": "loanerProfessionKey", "sDefaultContent" : ""},//3
            {"mData": "loanerPurposeKey", "sDefaultContent" : ""},//4
            {"mData": "loanTypeKey", "sDefaultContent" : ""},//5
            {"mData": "loanStatusKey", "sDefaultContent" : ""},//6
            {"mData": "loanerAddress", "sDefaultContent" : ""},//7
            {"mData": "loanTimeLimit", "sDefaultContent" : ""},//8
            {"mData": "loanRate", "sDefaultContent" : ""},//9
            {"mData": "amount", "sDefaultContent" : ""},//10
            {"mData": "remainAmount", "sDefaultContent" : ""},//11

        ],
        "aoColumnDefs": [{
            "aTargets": [0],
            "mRender": function (data, type, row) {
                return '<div class="checkbox"><label><input type="checkbox" name="loanId" id="loanId" value="' + data + '"><span class="text">&nbsp;</span></label></div>';
            }
        }, {
            "bSortable": true,
            "aTargets": [3],
             "mRender": function (data, type, row) {
             return new Date(data).Format("yyyy-MM-dd");
             }
        }, {
            "bSortable": false,
            "aTargets": [9],
            "mRender": function (data, type, row) {
                return data + "天";
            }
        }, {
            "bSortable": false,
            "aTargets": [10],
            "mRender": function (data, type, row) {
                return data / 100 + "%";
            }
        }, {
            "aTargets": [11],
            "mRender": function (data, type, row) {
                return '<span class="red bold">￥ ' + formatAmount(data, 0) + '</span>'
            }
        }, {
            "aTargets": [12],
            "mRender": function (data, type, row) {
                return '<span class="red bold">￥ ' + formatAmount(data, 0) + '</span>'
            }
        }],
        fnCreatedRow: function(nRow, aData, iDataIndex) {
        	var loanId = aData.loanId;
        	var loanRate = aData.loanRate;
        	var loanEndDate = aData.loanEndDate;
        	var a = '<div class="checkbox"><label><input type="checkbox" name="loanId" id="loanId" value="' + loanId + '" onclick="checkRate(' + iDataIndex + "," +  loanRate + "," + loanEndDate + ')" ><span class="text">&nbsp;</span></label></div>';
    		$('td:eq(0)', nRow).html(a);
        },
        "fnDrawCallback": function (oSettings) {
            $("#searchRechargeHistory").html('查询');
            $("#searchRechargeHistory").prop('disabled', false);
        },
        "sAjaxSource": "/uplan/queryByEndDateAndRate",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            aoData.push({
                "name": "loanEndDate",
                "value": loanEndDate
            });
            aoData.push({
                "name": "floatRate",
                "value": loanRate
            });

            aoData.push({
                "name": "pageSize",
                "value": 30
            });
        	 
            oSettings.jqXHR = $.ajax({
                "dataType": 'json',
                "type": "GET",
                "url": sSource,
                "data": aoData,
                "success": fnCallback,
                "error": function () {
                    console.log('error');
                }
            });
        },
        "oLanguage": {
            "sLengthMenu": "显示 _MENU_ 条记录",
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
}


/**
 * 匹配债权-匹配按钮点事件（根据查询条件查询信息）
 */
$(document).on("click", "#queryPlan", function() {
    showTable();
});

var minDate;
// 校验金额
function checkAmount (mount) {
	return /^(([1-9]\d*)|0)(\.\d{1,2})?$/.test(mount);
}
// 校验整数
function checkInt(str) {
	return /^\d{1,11}$/.test(str);
}

function accMul(arg1,arg2) {   
	var m=0,s1=arg1.toString(),s2=arg2.toString();   
	try{m+=s1.split(".")[1].length}catch(e){}   
	try{m+=s2.split(".")[1].length}catch(e){}   
	return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m)   
}

function checkNewPlan () {
    var self = this,
    productName = $('input[name=productName]'),
    productMemo = $('textarea[name=productMemo]'),
    amount = $('input[name=amount]'),
    pnVal = $.trim(productName.val()),
    pmVal = $.trim(productMemo.val()),
    aVal = $.trim(amount.val());
	userLoginName = $('#userLoginName');// 登录名
	userLoginNameVal = $.trim(userLoginName.val());
	userName = $.trim($('#userName').val());
	userIdNumber = $.trim($('#userIdNumber').val());
	showUserName = $('#showUserName');// 合同显示借款人
	showUserNameVal = $.trim(showUserName.val());
	showUserIdNumber = $('#showUserIdNumber');// 合同显示借款人身份证
	showUserIdNumberVal = $.trim(showUserIdNumber.val());
	creditListData = $('#creditListData');// 匹配债权包
	creditListDataVal = $.trim(creditListData.val());
	maxAmount = $('#maxAmount');// 最大投资额
	maxAmountVal = $.trim(maxAmount.val());
	rate = $('#rate');// 年利率
	rateVal = $.trim(rate.val());
	repaymentDate = $('#repaymentDate');// 还款时间
	repaymentDateVal = $.trim(repaymentDate.val());
	investEndDate = $('#investEndDate');// 截止投标时间
	investEndDateVal = $.trim(investEndDate.val());
	rateAdd = $('#rateAdd');//候补年利率
	rateAddVal = $.trim(rateAdd.val());
	minAmount = $('#minAmount');// 最小投资额
	minAmountVal = $.trim(minAmount.val());
	increaseNum = $('#increaseNum');// 投资增量
	increaseNumVal = $.trim(increaseNum.val());
	fee = $('#fee');// 费用
	feeVal = $.trim(fee.val());

	$('.errorText').addClass('hide');
	
	// 登录名
	if (userLoginNameVal == '' || userLoginNameVal.length > 30) {
		userLoginName.focus();
		userLoginName.next('.errorText').removeClass('hide');
		return false;
	}		
			
	// 真实姓名
	if (userName == '') {
		userLoginName.focus();
		userLoginName.next('.errorText').removeClass('hide');
		return false;
	}
	
	// 身份证号
	if (userIdNumber == '') {
		userLoginName.focus();
		userLoginName.next('.errorText').removeClass('hide');
		return false;
	}
	
	if (!(showUserNameVal == '' && showUserIdNumberVal == '')) {
		// 合同显示借款人
		if (showUserNameVal == '' || showUserNameVal.length > 20) {
			showUserName.focus();
			showUserName.next('.errorText').removeClass('hide');
			return false;
		}
		
		// 合同显示借款人身份证
		if (showUserIdNumberVal == '' || showUserIdNumberVal.length > 30) {
			showUserIdNumber.focus();
			showUserIdNumber.next('.errorText').removeClass('hide');
			return false;
		}
	}
	
	// 产品名称
	if (!/[\u4e00-\u9fa5]|\w/.test(pnVal) || pnVal.length < 4) {
	    productName.focus();
	    productName.next('.errorText').removeClass('hide');
	    return false;
	}
	
	// 产品介绍
	if (pmVal == '' || pmVal.length > 200) {
	    productMemo.focus();
	    productMemo.next('.errorText').removeClass('hide');
	    return false;
	}
	
	// 匹配债权包
	if (creditListDataVal == '') {
		alert("请添加债权包！");
	    return false;
	}
	
	// 借款金额
	if (aVal == '' || !checkAmount(aVal) || aVal < 1 || aVal > 100000000) {
	    amount.focus();
	    amount.parent().parent().parent().find('.errorText').removeClass('hide');
	    return false;
	}
	
	// 最大投资额度
	if (maxAmountVal == '' || !checkAmount(maxAmountVal)) {
		maxAmount.focus();
		maxAmount.parent().parent().parent().find('.errorText').removeClass('hide');
	    return false;
	}
	
	// 年利率
	if (rateVal == '') {
		rate.focus();
		rate.parent().parent().parent().find('.errorText').removeClass('hide');
	    return false;
	}
	
	// 还款时间
	if (repaymentDateVal == '') {
		repaymentDate.focus();
		repaymentDate.parent().parent().find('.errorText').removeClass('hide');
		return false;
	}
	
	var nowDateStr = new Date();// 当前时间
	nowDateStr = nowDateStr.Format("yyyy-MM-dd"); //获得系统日期的文本值
	var nowDateInfo = nowDateStr.split('-'); 
	var investDateInfo = investEndDateVal.split('-');
	var nowDate = new Date(parseInt(nowDateInfo[0]), parseInt(nowDateInfo[1])-1, parseInt(nowDateInfo[2]), 0, 0, 0); //新建日期对象
	var investDate = new Date(parseInt(investDateInfo[0]), parseInt(investDateInfo[1])-1, parseInt(investDateInfo[2]), 0, 0, 0);

	// 截止投标时间
	if (investEndDateVal == '' || investDate.getTime() < nowDate.getTime()) {
		investEndDate.focus();
		investEndDate.parent().parent().find('.errorText').removeClass('hide');
		return false;
	}
	
	// 候补年利率
	if (rateAddVal == '' || !checkAmount(rateAddVal) || rateAddVal < 0 || rateAddVal > 24) {
		rateAdd.focus();
		rateAdd.parent().parent().find('.errorText').removeClass('hide');
		return false;
	}
	
	// 最小投资额
	if (minAmountVal == '' || !checkAmount(minAmountVal)) {
		minAmount.focus();
		minAmount.parent().parent().find('.errorText').removeClass('hide');
		return false;
	}
	
	// 投资增量
	if (increaseNumVal == '' || !checkInt(increaseNumVal)) {
		increaseNum.focus();
		increaseNum.parent().parent().find('.errorText').removeClass('hide');
		return false;
	}
	
	// 费用
	if (feeVal == '' || !checkInt(feeVal)) {
		fee.focus();
		fee.parent().parent().find('.errorText').removeClass('hide');
		return false;
	}
	
	return true;
}

var newPlan = {
    defaultData: {
        planIds: '',
        jqPlanEl: $('#creditListData')
    },
    init: function () {
        var self = this;

        //默认加载匹配债权包
        self.renderCreditList();

        var productName = $('input[name=productName]'),
                productMemo = $('textarea[name=productMemo]'),
                amount = $('input[name=amount]');

        productName.click(function () {
            productName.next('.errorText').addClass('hide');
        });
        productMemo.click(function () {
            productMemo.next('.errorText').addClass('hide');
        });
        productMemo.click(function () {
            amount.parent('.input-prepend').siblings('.errorText').addClass('hide');
        });

        //立即发布
        $('#addPlanBtn').click(function () {
            var _tval;
        	if (checkNewPlan()) {
                $("#isFresh").find("input[name=fresh]").each(function(i){
                    var _this = $(this);
                    if(_this.is(":checked")){
                        _tval = _this.attr("value");
                    }
                });
                $("input[name=freshPlan]").val(_tval);
        		$("#newPlanForm").attr("action", "/uplan/publishUplan");
            	$("#newPlanForm").attr("method","post");
            //	console.log($("#newPlanForm").serialize());
            	$("#newPlanForm").submit();
        	} else {
        		return false;
        	}
        });
        // 保存新计划
        $('#savePlanBtn').click(function () {
            var _tval;
        	if (checkNewPlan()) {
                $("#isFresh").find("input[name=fresh]").each(function(i){
                    var _this = $(this);
                    if(_this.is(":checked")){
                        _tval = _this.attr("value");
                    }
                });
                $("input[name=freshPlan]").val(_tval);
        	//	console.log($("#newPlanForm").serialize());  
                $("#newPlanForm").attr("action", "/uplan/saveUplan");
                $("#newPlanForm").submit();
        	} else {
        		return false;
        	}
        });
    //    $('.new-plan-form').on('submit', self.checkNewPlan);
    },
    getRepaymentDate: function (repaymentDate) {
        $.get("/uplan/computeDate/" + repaymentDate,
	        function (data) {
	           // $('input[name=investEndDate]').val(data);
	            $('.date-picker').datepicker({
	                'language': 'cn',
	                startDate: new Date(data),
	                endDate: new Date(minDate)
	            });
                $('#investEndDate').val(moment(Number(data)).format("YYYY-MM-DD"));
	        }
        );
    },
    renderCreditList: function () {
        var self = this;
        creditList = self.defaultData.jqPlanEl.val();
        $('#creditInfoList').dataTable({
            "sDom": "flt",
            "bProcessing": true,
            "bServerSide": true,
            "bSort": false,
            "bFilter": true,
            "bPaginate": false,
            "bSortable": false,
            "paging": false,
            "bRetrieve": false,
            "bDestroy": true,
            "retrieve": false,
            "bSearchable": false,
            "aoColumns": [
                {"mData": "loanerName", "sDefaultContent" : ""},// 0
                {"mData": "loanerCardNo", "sDefaultContent" : ""},//1
                {"mData": "loanEndDate", "sDefaultContent" : ""},//2
                {"mData": "loanerProfessionKey", "sDefaultContent" : ""},//3
                {"mData": "loanerPurposeKey", "sDefaultContent" : ""},//4
                {"mData": "loanTypeKey", "sDefaultContent" : ""},//5
                {"mData": "loanStatusKey", "sDefaultContent" : ""},//6
                {"mData": "loanerAddress", "sDefaultContent" : ""},//7
                {"mData": "loanTimeLimit", "sDefaultContent" : ""},//8
                {"mData": "loanRate", "sDefaultContent" : ""},//9
                {"mData": "amount", "sDefaultContent" : ""},//10
                {"mData": "remainAmount", "sDefaultContent" : ""},//11
                {"mData": "loanId", "sDefaultContent" : ""}//12
            ],
            "aoColumnDefs": [{
                "aTargets": [2],
                "mRender": function (data, type, full) {
                    if (!data) {
                        return "";
                    }
                    return new Date(data).Format("yyyy-MM-dd");
                }
            }, {
                "bSortable": false,
                "aTargets": [8],
                "mRender": function (data, type, row) {
                    return data + "天";
                }
            }, {
                "bSortable": false,
                "aTargets": [9],
                "mRender": function (data, type, row) {
                    return data / 100 + "%";
                }
            }, {
                "aTargets": [10],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">￥ ' + formatAmount(data, 0) + '</span>'
                }
            }, {
                "aTargets": [11],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">￥ ' + formatAmount(data, 0) + '</span>'
                }
            }, {
                "aTargets": [12], //uid link
                "mRender": function (data, type, full) {
                    return '<a href="javascript:;" onClick="delMatchCredit(this)" data-id="' + data + '" class="delete-article-link" ><i class="fa fa-trash-o" title="删除"></i></a>';
                }
            }],
            "fnDrawCallback": function (oSettings) {
                $("#searchRechargeHistory").html('查询');
                $("#searchRechargeHistory").prop('disabled', false);
            },
            "sAjaxSource": "/uplan/getLoanDetailsByIds",
            "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
                aoData.push({'name': 'creditList', 'value': self.defaultData.jqPlanEl.val()});
                oSettings.jqXHR = $.ajax({
                    "dataType": 'json',
                    "type": "GET",
                    "url": sSource,
                    "data": aoData,
                    "success": fnCallback,
                    "error": function () {
                        console.log('error');
                    }
                });
            },
            "oLanguage": {
                "sLengthMenu": " _MENU_ ",
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
        // 默认算出 总额、最大投资额、利率
        if ($.trim(creditList) || creditList.length > 0) {
            $.getJSON('/uplan/getAmountAndLoanStartDate', {'creditList': creditList}, function (data) {
                $('#amount').attr('value', data.amount);
                $('#maxAmount').attr('value', data.amount);
                minDate = data.minDate;
            });


            $('#rate').val($('#loanRate').val());
            $('#repaymentDate').val($('#loanEndDate').val());
            self.getRepaymentDate($('#loanEndDate').val());
        }
    }
};

$('.date-picker').datepicker({
    'language': 'cn',
    startDate: new Date(moment),
    endDate: new Date(moment)
});

newPlan.init();
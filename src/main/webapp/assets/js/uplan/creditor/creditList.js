var aceInput;
// 上传本地债权
function uploadCreditorInfo() {
	$('#uploadLocalModal').modal('show');
    aceInput = $('#uploadFileInput').ace_file_input({
        style: 'well',
        btn_choose: '拖动文件到此处或点击上传（支持批量上传）',
        btn_change: null,
        no_icon: 'fa fa-upload',
        droppable: true,
        thumbnail: 'small',
        icon_remove: null,
        whitelist: 'csv|xls|xlsx',
        backlist: 'exe|php',
        preview_error: function (filename, error_code) {
        }
    }).on('change', function () {
        $('#saveFileBtn').prop('disabled', false);
    });
}

$('#saveFileBtn').on('click', function () {
	var files = document.getElementById("uploadFileInput");
    var files = aceInput.data('ace_input_files');
    if (files == undefined) {
        alert('请上传文件！');
        return false;
    }
    var files_length = files.length;
    var count = 0;
    var files_length = files.length;
    var count = 0;
    $.each(files, function (index, file) {
        var formData = new FormData();
        formData.append("file", file);
        //formData.append("imageName", file.name);
        //console.log(formData)
        $.ajax({
            url: '/uplanLoan/importFile',
            data: formData,
            processData: false,
            contentType: false,
            type: 'POST',
            success: function (data) {
                var data = eval('('+data+')');
                
                console.log("result===" + data);
                
                $('.btn-reset').click();
                if (data.success == 0) {
                    bootbox.dialog({
                        message: data.comment,
                        title: "提示信息",
                        className: ""
                    });
                    //showCCAlert(data.comment, false);
                } else {
                    bootbox.dialog({
                        message: '上传成功！',
                        title: "提示信息",
                        className: "",
                    	buttons: {
                    		success: {
                    			label: "确定",
                    			callback: function() {
                    				location.reload();
                    			}
                    	    }
                    	}
                    });
                }
            }
        }).fail(function () {
            $('.btn-reset').click();
            bootbox.dialog({
                message: "导入数据失败，请检查是否符合规范！",
                title: "提示信息",
                className: ""
            });

        });
    });
});

/**
 * 查询债权详情
 */
function queryList() {
	$('#commonDataTable').dataTable({
        "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": true,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bSortable": false,
        "aoColumns": [
            {"mData": "loanId", "sDefaultContent" : ""}, 		//0 序号
            {"mData": "loanerName", "sDefaultContent" : ""},	//1 借款人
            {"mData": "loanerCardNo", "sDefaultContent" : ""},	//2 身份证号
            {"mData": "loanEndDate", "sDefaultContent" : ""}, 	//3 还款日期
            {"mData": "loanerProfessionKey", "sDefaultContent" : ""},	//4 借款人职业
            {"mData": "loanerPurposeKey", "sDefaultContent" : ""},		//5 借款用途
            {"mData": "loanTypeKey", "sDefaultContent" : ""},	//6 借款方式
            {"mData": "loanStatusKey", "sDefaultContent" : ""},	//7 借款状态
            {"mData": "loanerAddress", "sDefaultContent" : ""},	//8 管辖城市
            {"mData": "loanTimeLimit", "sDefaultContent" : ""},	//9 借款期限
            {"mData": "loanRate", "sDefaultContent" : ""},		//10 年化利率
            {"mData": "loanStatus", "sDefaultContent" : ""}		//11 操作
        ],
        "aoColumnDefs": [{
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
            "bSortable": false,
            "aTargets": [11],
            "mRender": function (data, type, full) {

                if (data == "WAITTORELEASE") {
                    return '<div class="hidden-phone visible-desktop btn-group"><a class="btn btn-mini btn-success" href="/uplanLoan/release/' + full.loanId + '"' + ' title="放权" onclick="if(confirm(\'确定放权么？\')==false)return false;">\
                      <i class="fa fa-check"></i>\
                    </a><a class="btn btn-mini btn-danger" href="/uplanLoan/disable/' + full.loanId + '"' + ' title="禁用" onclick="if(confirm(\'确定禁用么？\')==false)return false;"><i class="fa fa-ban"></i>\
                    </a></div>';
                }
                return "---";

            }
        }],
        fnCreatedRow: function(nRow, aData, iDataIndex) {
        	var loanId = aData.loanId;
        	var a = "<a href='javascript:void(0);' onclick='showInfo(\"" + loanId + "\")'>" + (iDataIndex + 1) + "</a>";
    		$('td:eq(0)', nRow).html(a);
        },
        "sAjaxSource": "/uplanLoan/listBySearch",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            for (var i = 0; i < aoData.length; i++) {
                if (aoData[i]['name'] == 'iSortCol_0') {
                    var cols = this.fnSettings().aoColumns;
                    var index = parseInt(aoData[i]['value']);
                    aoData.push({"name": "sColName", "value": cols[index]['mData']});
                    //break;
                }
            }

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
}

Handlebars.registerHelper('formatdata', function(data, options){
	if (data == '') {
		return '';
	}
	return new Date(data).Format("yyyy-MM-dd");
});

/**
 * 新增债权
 */
function addInvertInfo() {
    var source   = $("#addCreditInfo-template").html();
    var template = Handlebars.compile(source);
    //默认数据
    var context = {'loanStartDate':''};
    var html='';
    html    = template(context);
    bootbox.dialog({
        message: html,
        title: "新增债权",
        className: "modal-darkorange"
    });
    $('.date-picker').datepicker({
        'language': 'cn',
        startDate: new Date(moment),
        endDate: new Date(moment)
    });

    console.log('loanRepaymentType==' + $('#loanRepaymentType').innerHTML);
}

/**
 * 点击序号显示债权详情页面（若未放权，可进行信息修改）
 */
function showInfo(id) {
	var source   = $("#addCreditInfo-template").html();
	var template = Handlebars.compile(source);
	
   $.get('/uplanLoan/creditDetails/' + id, function(data) {
	   var d = eval("(" + data + ")");
	   d.loanRate = d.loanRate/100;
        var source   = $("#addCreditInfo-template").html();
        var template = Handlebars.compile(source);
        //默认数据
        var html = template(d);
        
        bootbox.dialog({
            message: html,
            title: "债权详情",
            className: "modal-darkorange"
        });
        jQuery("#loanRepaymentType").append("<option value='INCOME_REINVEST'>收益复投</option>");
        
        $("select[name=loanerProfession]").val(d.loanerProfession);
        $("select[name=loanerPurpose]").val(d.loanerPurpose);
        $("select[name=loanType]").val(d.loanType);
        $("select[name=loanRepaymentType]").val(d.loanRepaymentType);
        
        if (d.loanStatus === "WAITTORELEASE") {// 等待放权时，显示按钮可修改
        	$("#publishLoan,#saveLoan").show();
        } else {// 其他，只能查看信息
        	$("#publishLoan,#saveLoan").hide();
        }
        $('.date-picker').datepicker({
            'language': 'cn',
            startDate: new Date(moment),
            endDate: new Date(moment)
        });
    });
}

/**
 * 立即放权
 */
$(document).on("click", "#publishLoan", function() {
	if (checkForm()) {
	    $('#submitType').val("publish");
	    $("form").submit();
	} else {
		return false;
	}
});

/**
 * 保存
 */
$(document).on("click", "#saveLoan", function() {
	if (checkForm()) {
		$('#submitType').val("waitToRelease");
	    $("form").submit();
	} else {
		return false;
	}
});

queryList();

//校验金额
function checkAmount (mount) {
	return /^(([1-9]\d*)|0)(\.\d{1,2})?$/.test(mount);
}
// 校验整数
function checkInt(str) {
 	return /^\d{1,11}$/.test(str);
}
 
// 表单校验
function checkForm() {
	$('.errorText').addClass('hide');
	
	// 借款人姓名
	var loanerName = $('#loanerName');
	loanerNameVal = $.trim(loanerName.val());
	
	if (loanerNameVal == '') {
		loanerName.focus();
		loanerName.next('.errorText').removeClass('hide');
		return false;
	}
	
	// 身份证号
	var loanerCardNo = $('#loanerCardNo');
	loanerCardNoVal = $.trim(loanerCardNo.val());
	
	if (loanerCardNoVal == '') {
		loanerCardNo.focus();
		loanerCardNo.next('.errorText').removeClass('hide');
		return false;
	}
	
	// 借款金额
	var amount = $('#amount');
	amountVal = $.trim(amount.val());
	
	if (amountVal == '' || !checkAmount(amountVal)) {
		amount.focus();
		amount.next('.errorText').removeClass('hide');
		return false;
	}
	
	// 借款期限
	var loanTimeLimit = $('#loanTimeLimit');
	loanTimeLimitVal = $.trim(loanTimeLimit.val());
	
	if (loanTimeLimitVal == "" || !checkInt(loanTimeLimitVal)) {
		loanTimeLimit.focus();
		loanTimeLimit.parent().parent().find('.errorText').removeClass('hide');
		return false;
	}
	
	// 借款日期
	var loanStartDate = $('#loanStartDate');
	loanStartDateVal = $.trim(loanStartDate.val());
	
	if (loanStartDateVal == '') {
		loanStartDate.focus();
		loanStartDate.parent().find('.errorText').removeClass('hide');
		return false;
	}
	
	// 年利率
	var floatRate = $('#floatRate');
	floatRateVal = $.trim(floatRate.val());
	
	if (floatRateVal == '' || !checkAmount(floatRateVal)) {
		floatRate.focus();
		floatRate.parent().parent().parent().find('.errorText').removeClass('hide');
		return false;
	}
	
	return true;
}
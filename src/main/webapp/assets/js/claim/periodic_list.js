/****** 日历控件 start ******/
$('.investRecordRange').daterangepicker({
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
    startDate: moment(),
    endDate: moment(),
    locale: {
        applyLabel: '确定',
        clearLabel: "取消",
        fromLabel: '开始时间',
        toLabel: '结束时间',
        weekLabel: '周',
        customRangeLabel: '选择范围',
        daysOfWeek: "日_一_二_三_四_五_六".split("_"),
        monthNames: "一月_二月_三月_四月_五月_六月_七月_八月_九月_十月_十一月_十二月".split("_"),
        firstDay: 0
    }
}, function(start, end) {
    $('.investRecordRange').val(start.format("YYYY-MM-DD") + ' - ' + end.format("YYYY-MM-DD"));
}).prev();
/****** 日历控件 end ******/

$('#date-range-picker').val(moment().subtract('days', 29).format("YYYY-MM-DD")+' - '+moment().format("YYYY-MM-DD"));

/**/
showTotalNum('FIXED');

function showTotalNum(ctype){
  /*  $.ajax({
        url: '/claimLoan/claimAssertByType/',
        type: 'GET',
        dataType: 'json',
        data: {type:ctype},
        success:function(data){
            $("#primaryAssert").html(data.claimPara.primaryAssert + "元");
            $("#remainAssert").html(data.claimPara.remainAssert + "元");

            $("#span_primary_15_30").html('<span style="color:#333; font-weight: normal;">15日:</span>' +
                data.claimPara.primaryAssert15 + '元    <span style="color:#333; font-weight: normal;margin-left:20px;">30日:</span>' + data.claimPara.primaryAssert30 + '元');
            $("#span_remain_15_30").html('<span style="color:#333; font-weight: normal;">15日:</span>' +
                data.claimPara.remainAssert15 + '元    <span style="color:#333; font-weight: normal; margin-left:20px;">30日:</span>' + data.claimPara.remainAssert30 +
                '元    <span style="color:#333; font-weight: normal; margin-left:20px;">产品剩余:(-)</span>' + data.claimPara.remainProductAll + '元');
        },
        error:function(error){
            console.log(error);
        }
    });*/
}

/**
 * 编辑新建 债权信息
 * @param ele 编辑时触发的元素，为了的到empId
 */
function showClaimBox(ele,read) {
	
    var source = $("#addClaimBox-template").html();
    var template = Handlebars.compile(source);

    window.Handlebars.registerHelper('select', function( value, options ){
        var $el = $('<select />').html( options.fn(this) );
        $el.find('[value="' + value + '"]').attr({'selected':'selected'});
        return $el.html();
    });

    window.Handlebars.registerHelper ("setChecked", function (value, currentValue) {
        if ( value == currentValue ) {
           return "checked"
        } else {
           return "";
        }
    });

    window.Handlebars.registerHelper ("formatDate", function (value) {
        if(value != "" && value != undefined){
            return new Date(value).Format("yyyy-MM-dd");
        }
    });
      
    //默认数据
    var context = {
        loanId:"",
        loanerName:"",
        loanerCardNo:"",
        loanerAddress:"",
        loanerProfession:"",
        loanerPurpose:"",
        contractId:"",
        loanAmount:"",
        loanType:"",
        loanRepaymentType:"",
        loanRate:"",
        cashDate:"",
        loanTimeLimit:"",
        manageFee:"",
        mediatorLoginName:"",
        loanSource:"",
        flagBanned:""
    };
    var html = '';
    if (ele) {
        //编辑债权信息
        var empId = $(ele).attr("data-empid");
   
        
    } else {
        html = template(context);
        bootbox.dialog({
            message: html,
            title: "新增债权",
            className: "modal-darkorange"
        });
        
        addClaimForm();
    }

    $('.date-picker').datepicker({
        'language': 'cn',
        startDate: new Date(moment),
        endDate: new Date(moment)
    });
}
/*$("#employeeForm").bootstrapValidator();*/
function addClaimForm() {
	
    $("#addClaimForm").bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        submitHandler: function(validator, form, submitButton) { 
        	console.log(form.serialize());
        	
            $.post(form.attr('action'), form.serialize(), function(data) {
                var res = jQuery.parseJSON(data);
                if (res.success) {   
                	$('.close').click();
                	Notify(res.comment, 'top-right', '5000', 'success', 'fa-check', true);
                	curClaimList();

                    showTotalNum('FIXED');
                } else {
                	Notify(res.comment, 'top-right', '5000', 'danger', 'fa-check', true);
                }
            });
        },
        fields: {
            loanerName: {
                validators: {
                    notEmpty: {
                        message: '请输入借款人姓名'
                    },
                    stringLength: {
                        min: 2,
                        max: 30,
                        message: '登录名最少2位字母/数字'
                    }
                }
            },
            loanerCardNo: {
                validators: {
                    notEmpty: {
                        message: '请输入身份证号'
                    },
                    regexp: {
                        regexp: /^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/,
                        message: '身份证号码格式不正确'
                    }
                }
            },
            contractId: {
                validators: {
                    notEmpty: {
                        message: '请输入合同编号'
                    }
                }
            },
            loanAmount: {
                validators: {
                    notEmpty: {
                        message: '请输入借款金额'
                    },
                    regexp: {
                        regexp: /^\d+(\.\d+)?$/,
                        message: '请输入正确的借款金额'
                    }
                }
            },
            loanStartDate: {
                validators: {
                    notEmpty: {
                        message: '请输入选择借款日期'
                    }
                }
            },
            loanTimeLimit: {
                validators: {
                    notEmpty: {
                        message: '请输入借款期数'
                    },
                    regexp: {
                        regexp: /^[0-9]*$/,
                        message: '借款期数必须为整数'
                    }
                }
            },
            cashDate:{
            	notEmpty: {
                    message: '请输入放款日期'
                }
            },
            monthManageRate: {
                validators: {
                    notEmpty: {
                        message: '请输入月管理费率'
                    },
                    regexp: {
                        regexp: /^\d+(\.\d+)?$/,
                        message: '月管理费率必须为数字'
                    }
                }
            }
        }
    });
}




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
            url: '/claimLoan/importFileFixedLoan',
            data: formData,
            processData: false,
            contentType: false,
            type: 'POST',
            success: function (data) {
//                var data = eval('('+data+')');
                
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
                        message: data.comment,
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


/**导出债权列表*/

$("#downclaimlist").on('click',function(){
	var $callStatus=$('#dateFilter'),$dateRange=$('#date-range-picker');
    var searchData=$('#curClaimDataTable_filter input').val();    
    location.replace('/claimLoan/currentLoanListExport/?dateFilter='+$callStatus.val()+'&dateRange='+$dateRange.val()+'&sSearch='+searchData);
});

curClaimList();

$('#searchRechargeHistory').on('click',function(){
    curClaimList();
});
/**
 * 查询债权详情
 */
function curClaimList() {
    var $dateRange = $('input[name=date-range-picker]');
    $('#curClaimDataTable').dataTable({
        "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": true,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        // "ajax": {
        //     url: postUrl,
        //     type: 'post',
        //     data: {
        //         'startTime': beginTime,
        //         'endTime': endTime,
        //         'status':orderStatus,
        //         'type':cerType,
        //         'belongMossUid':orderHandler,
        //         'phone': ownerMobile,
        //     },
        //     error:function(){
        //         FV.tipsWarn("请求错误，请刷新页面重试！");
        //         return;
        //     }
        // },
        "aoColumns": [
            {"mData": "id", "sDefaultContent": ""},             
            {"mData": "id", "sDefaultContent": ""},   //0 全选
            {"mData": "cartype", "sDefaultContent": ""},   //1 合同编号
            {"mData": "carnumber", "sDefaultContent": ""},   //2 借款人姓名
            {"mData": "carpp", "sDefaultContent": ""},   //3 身份证号
            {"mData": "carcjh", "sDefaultContent": ""},   //4 局间人
            {"mData": "persionid", "sDefaultContent": ""},   //5 原始债权价值
            {"mData": "persionname", "sDefaultContent": ""},   //6 可用债权价值
            {"mData": "gctime", "sDefaultContent": ""},   //7 债权状态
            {"mData": "addessid", "sDefaultContent": ""},   //8 借款金额
            {"mData": "phone", "sDefaultContent": ""},   //9 月还本金
            
//           {"mData": null, "sDefaultContent": ""}    //19 操作
        ],
        "aoColumnDefs": [
				        
				         {
                            "bSortable": false,
                            "aTargets": [0],
                            "mRender": function (data, type, full) {
                                return '<div class="checkbox"><label><input type="checkbox" class="check_each" name="recordInfos" data-id="' + full.id + '" /><span class="text">&nbsp;</span></label></div>';
                            }
                        }],
        fnCreatedRow: function(nRow, aData, iDataIndex) {
            var id = aData.loanId,isOpen = aData.flagBanned,loanStatus = aData.loanStatus ,openHtml,handlerHtml = '<a id="detail_btn" data-empid="'+id+'" class="btn btn-danger btn-xs delete" title="查看详情" onclick="showClaimBox(this,true)" style="margin-right:10px"><i class="fa fa-file"></i> 查看详情</a>';

            if(isOpen){
                openHtml = '<a class="btn btn-xs btn-info bg-palegreen" title="启用" onclick="showConfirm(\'确定要启用么？\',\'/claimLoan/fixedRelease?loanId='+id+'\')">\
                      <i class="fa fa-check"></i>启用\
                    </a>';
            }else{
                openHtml = '<a class="btn btn-danger btn-xs" title="禁用" onclick="showConfirm(\'确定要禁用么？\',\'/claimLoan/fixedDisable?loanId='+id+'\')">\
                      <i class="fa fa-ban"></i>禁用\
                    </a>';
            }
            console.log(isOpen);
            if(isOpen == true && loanStatus == "RESERVE"){
                handlerHtml += '<a id="edit_btn" data-empid="'+id+'"  class="btn btn-info btn-xs edit" title="编辑" onclick="showClaimBox(this,false)"><i class="fa fa-edit"></i> 编辑</a>';
            }
       /*     $('td:eq(9)', nRow).html(openHtml);
            $('td:eq(9)', nRow).html(handlerHtml);*/
        },
        "sAjaxSource": "/claimLoan/fixedLoanList",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            aoData.push({
                "name": "dateFilter",
                "value": $("#dateFilter").val()
            });
            aoData.push({
                "name": "dateRange",
                "value": $dateRange.val()
            });
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


/**
 * confirm提示框
 * @param str  confirm提示语句
 * @param strHref  要执行的url
 */
function showConfirm (str,strHref){
    //bootbox.setLocale("zh_CN");
	
    bootbox.confirm(str, function (result) {    	
        if (result) {        	
        	console.log(strHref);
        	$.ajax({
                url: strHref,
                type: 'POST',
                dataType: 'json',
                data: {},
                success:function(data){
                    //var data = eval('('+data+')');
                    console.log(data);
                    
                    if(data.success){
                    	Notify(data.comment, 'top-right', '5000', 'success', 'fa-check', true);
                    }else{
                    	Notify(data.comment, 'top-right', '5000', 'danger', 'fa-check', true);
                    }
                    curClaimList();
                },
                error:function(error){
                    console.log(error);
                }
            });
            
        }
    });
}


$('.check_all').bind('click',function(){
    $('input.check_each').prop('checked', $(this).prop('checked'));
});

$("#open_all").click(function(){
    if(!confirm('确定全部启用?')) return;
    allHandler("open");
});
$("#close_all").click(function(){
    if(!confirm('确定全部禁用?')) return;
    allHandler("close");
});


var isSync = false;

//批量启用 : 单个提交也调用这个，传id
//
function allHandler(type){
    if(isSync) return;

    var idArr = [];

    $('#curClaimDataTable').find('.check_each').each(function (ix) {
        if (!this.checked) return;
        idArr.push($(this).attr('data-id'));
    });

    if(idArr.length==0){
        alert('未选择任何记录');
        return;
    }

    var ids = idArr.join(','),turl;
    isSync = true;
    if(type == "open"){
        turl = '/claimLoan/fixedRelease?loanId='+ids;
    }else{
        turl = '/claimLoan/fixedDisable?loanId='+ids;
    }

}

$('#link_audit_all').bind('click', function(){
    if(!confirm('确定全部审批?')) return;
    batchDeal('SUCCESSFUL');
});
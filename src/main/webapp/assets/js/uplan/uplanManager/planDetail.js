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
    $('.investRecordRange').val(start.format("YYYY-MM-DD")+' - '+ end.format("YYYY-MM-DD"));
}).prev();

/**
 *
 *
 * */
$('#cb_checkall').bind('click', function (e) {
    $(this).closest('table').find('td input[type=checkbox]').prop('checked', $(this).prop('checked'));
});
 /**
 * 查询已经匹配列表
 */
$('#a_creditorMatched').click(function (event) {
    event.preventDefault();
    var planId = $('#loanTitle').attr('data-id');
    var status = 'MATCHED';
    $('#investRecordsMatched_table').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        "paging": true,
        "searching": true,
        "aoColumns": [
            {"mData": "investId", "sDefaultContent" : ""},	//0 序号
            {"mData": "orderId", "sDefaultContent" : ""},	//1 订单号
            {"mData": "investor", "sDefaultContent" : ""},	//2 投标人
            {"mData": "realName", "sDefaultContent" : ""},	//3 真实姓名
            {"mData": "amount", "sDefaultContent" : ""},	//4 金额
            {"mData": "submitTime", "sDefaultContent" : ""},//5 投标时间
            {"mData": "statusKey", "sDefaultContent" : ""},	//6 状态
            {"mData": "investId", "sDefaultContent" : ""},	//7 操作
        ],
        "aoColumnDefs": [
             {
                "aTargets": [4], //
                "mRender": function (data, type, full) {
                    return '<span class="red bold">￥' + formatAmount(data) + '</span>';
                }
            },
            {
                "aTargets": [5], //
                "mRender": function (data, type, row) {
                	return new Date(data).Format('yyyy-MM-dd hh:mm:ss');
                }
            },
            {
                "aTargets": [7], //
                "mRender": function (data, type, row) {
                    return '<a class="btn btn-primary" href="/uplan/investorAndCreditors/' + data + '">查看</a>&nbsp';
                }
            }

        ],
        "fnDrawCallback": function (oSettings) {
//            $("#searchRechargeHistory").html('查询');
//            $("#searchRechargeHistory").prop('disabled', false);
            // 显示序号
            for (var i = 0, iLen = oSettings.aiDisplay.length; i < iLen; i++) {
                $('td:eq(0)', oSettings.aoData[oSettings.aiDisplay[i]].nTr).html(oSettings['_iDisplayStart'] + i + 1);
            }

            $('#investRecordsMatched_table').css('width', '100%');
        },
        "sAjaxSource": "/uplan/queryNoMatchingCredits",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            aoData.push({
                "name": "planId",
                "value": planId
            });
            aoData.push({
                "name": "status",
                "value": status
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
});

/**
 * 债权查看
 * @param data
 */
function showSingleInvestInfo(data) {
    var source   = $("#showSingleInvestInfo-template").html();
    var template = Handlebars.compile(source);

    Handlebars.registerHelper('formatdata', function(data, options){
    	return new Date(data).Format("yyyy-MM-dd");
    });
    
    Handlebars.registerHelper('formatAmount', function(data, options){
    	return '￥ ' + formatAmount(data, 0);
    });
    
    Handlebars.registerHelper('formatRate', function(data, options){
    	return data / 100 + "%";
    });
    
    $.get("/uplan/investLoans/" + data,
        function (data) {
            var context = eval("(" + data + ")");
            var html='';
            console.log(context);
            html = template(context);
            bootbox.dialog({
                message: html,
                title: "投资记录",
                className: "modal-darkorange"
            });
            $('.modal-dialog').css('width','1160px')
        }
    );
}

/**
 * 产品详情-保存未发布--立即发布
 * @param loanId
 */
function publishUplanByLoanId(loanId) {
	// 若截止投标时间比当前日期小，则不能进行立即发布
	if (new Date($('#investEndDate').val()).toLocaleDateString() < new Date().toLocaleDateString()) {
		alert("截止投标时间不能小于当前日期");
		return false;
	}
	
    $.post("/uplan/publishUplanByLoanId", {loanId: loanId}, function (data) {
    	var result = eval("(" + data + ")");
    	alert(result.comment);
        location.reload();
    });
}

function updateUplan(uplanId) {
	$.get("/uplan/update/" + uplanId, function (data) {
		
	}); 
}

/**
 * 投资记录-查询
 */
function queryInvestRecord() {
	$('#investRecordTable').dataTable({
	    "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
	    "bProcessing": false,
	    "bServerSide": false,
	    "bSort": false,
	    "bFilter": false,
	    "bPaginate": false,
	    "bSortable": false,
	    "bDestroy":true,
	    "aoColumns": [
	        {"mData": "investId", "sDefaultContent" : ""},	//0 序号
	        {"mData": "orderId", "sDefaultContent" : ""},	//1 订单号
	        {"mData": "investor", "sDefaultContent" : ""},	//2 投标人
	        {"mData": "realName", "sDefaultContent" : ""},	//3 真实姓名
	        {"mData": "amount", "sDefaultContent" : ""},	//4 投标金额
	        {"mData": "status", "sDefaultContent" : ""},	//5 投标方式
	        {"mData": "submitTime", "sDefaultContent" : ""},//6 投标时间
	        {"mData": "statusKey", "sDefaultContent" : ""},	//7 投标状态
	        {"mData": "countRateDate", "sDefaultContent" : ""},	//8 计息时间
	        {"mData": "investId", "sDefaultContent" : ""}		//9 债权/通知单
	    ],
	    "aoColumnDefs": [
	        {
	            "aTargets": [0], //uid link
	            "mRender": function (data, type, full) {
	            	var divStr = '<div class="checkbox"><label><input type="checkbox" name="investId" value="' + data + '"><span class="text"></span></label></div>';
	                return divStr;
	            }
	        },{
                "aTargets": [4], //
                "mRender": function (data, type, full) {
                    return '<span class="red bold">￥' + formatAmount(data) + '</span>';
                }
            },{
	            "aTargets": [5],
		        "mRender": function (data, type, row) {
	                return "手动投标";
	            }
	        }, {
	            "aTargets": [6],
		        "mRender": function (data, type, row) {
	                return new Date(data).Format("yyyy-MM-dd");
	            }
	        }, {
	            "aTargets": [8],
		        "mRender": function (data, type, row) {
	                return new Date(data).Format("yyyy-MM-dd");
	            }
	        }, {
	            "aTargets": [9],
		        "mRender": function (data, type, row) {
		        	var show_a = "<a class='btn btn-sm btn-palegreen'  href='javascript:void(0);' onclick='showSingleInvestInfo(\""+data+"\")' style='font-size: 10px;' ><i>债权查看</i></a>";
		        	var pdf_a = '<a class="btn btn-sm btn-info" href="/uplan/fileDetailPdf/'+data+'" style="font-size: 10px;"><i>通知单</i></a>';
	                return '<div class="btn-group btn-group-justified" style="width: 230px">'+show_a + pdf_a+'</div>';
	            }
	        }
	    ],
	    "fnDrawCallback": function (oSettings) {
	        $("#searchRechargeHistory").html('查询');
	        $("#searchRechargeHistory").prop('disabled', false);
	    },
	    "sAjaxSource": "/uplan/queryinvestRecordInfo",
	    "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
	        aoData.push({
	            "name": "planId",
	            "value": $('#loanTitle').attr('data-id')
	        });
	        
	        var $dateRangeP = $('#date-range-picker').val();
	        if ($dateRangeP != "") {
	        	aoData.push({
		            "name": "startDate",
		            "value": $dateRangeP.split(' - ')[0]
		        });
	        	aoData.push({
		            "name": "endDate",
		            "value": $dateRangeP.split(' - ')[1]
		        });
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
            "sInfo": "显示第 _START_ - _END_ 条记录，共 _TOTAL_ 条 ",
            "sInfoEmpty": "没有符合条件的记录",
            "sZeroRecords": "没有符合条件的记录",
            "oPaginate": {
                "sFirst": "首页",
				"sPrevious": "前一页",
				"sNext": "后一页",
				"sLast": "尾页"
            }
        }
	    })
}

/**
 * 投资记录
 */
$('#a_investHistory').click(function() {
	queryInvestRecord();
});

/**
 * 投资记录-按范围查询
 */
$('#searchRechargeHistory').click(function() {
	queryInvestRecord();
});

/**
 * 产品详情-投资记录-全部下载
 */
$('#downloadHistoryBtn').click(function() {
	var planId = $('#loanTitle').attr('data-id');
    var $dateRangeP = $('#date-range-picker').val();
    var href = '/uplan/downloadAllOnInvest?startDate='
        + $dateRangeP.split(' - ')[0] + '&endDate='
        + $dateRangeP.split(' - ')[1] + '&planId=' + planId;
    $(this).prop('href', href);
});

/**
 * 产品详情-投资记录-批量下载
 */
$('#downloadHistoryBtn1').click(function() {
    var investIdsStr = '', investIdInput = $('[name=investId]:checked');
    for (var i = 0; i < investIdInput.length; i++) {
        investIdsStr += $(investIdInput[i]).val();
        if (i < investIdInput.length - 1)
            investIdsStr += ',';
    }
    if (investIdsStr == '') {
        alert('请选择要下载的债权文件');
        return false;
    }
    var href = '/uplan/downloadForBatchOnInvest?investIdsStr='
        + investIdsStr;
    $(this).prop('href', href);
});

//弹出层 产品名称修改
$(".bootbox-regular").on('click', function () {		
    bootbox.prompt("产品名称修改", function (result) {
        if (result === null) {
            //Example.show("Prompt dismissed");
        } else {
            //Example.show("Hi <b>"+result+"</b>");
			$.ajax({
				type:'POST',
				url:'/uplan/updateProductName',
				data:{
					id:$('#loanTitle').attr('data-id'),
					productName:result
				},
				dataType:'json',
				success:function(data){
					if($('.bootbox-form .bootbox-input').val()!=''){
						$('.s-title').html(result);
						$('.jksq').html(result);
					}
				}
			})
        }
    });
});

if ($('#opType').val() == 'showInvestHistory') {
	$('#a_investHistory').click();
}
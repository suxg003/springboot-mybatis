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


$('#cbx_all').bind('click', function(){
    $('input[name=recordInfos]').prop('checked', $(this).prop('checked'));
});

/*
 * 查询
 */
function queryInfos() {
	 $('#commonDataTable').dataTable({
	        "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
	        "bProcessing": false,
	        "bServerSide": true,
	        "bSort": false,
	        "bFilter": false,
	        "bSortable": false,
	        "bDestroy":true,
	        "aoColumns": [
	            {"mData": "record_id", "sDefaultContent" : ""}, 	//0 姓名
	            {"mData": "record_time", "sDefaultContent" : ""},	//1 提现时间
	            {"mData": "batch_no", "sDefaultContent" : ""},		//2 批次号
	            {"mData": "amount", "sDefaultContent" : ""}, 		//3 提现金额
	            {"mData": "check_status", "sDefaultContent" : "未审核"},	//4 审核结果
	            {"mData": "repay_result_type", "sDefaultContent" : ""},	//5 提现结果
	            {"mData": "user_name", "sDefaultContent" : ""},		//6 上传人
	            {"mData": "upload_time", "sDefaultContent" : ""},	//7 上传时间
                {"mData": "realUserName", "sDefaultContent" : ""},	//8 姓名
                {"mData": "id_number", "sDefaultContent" : ""},	//9 身份证
                {"mData": "failure_reason", "sDefaultContent" : ""}	//10 备注
	        ],
	        "aoColumnDefs": [{
	            "bSortable": false,
	            "aTargets": [0],
                "mRender": function (data, type, full) {
                	var value = full.record_id + "," + full.batch_no + "," + full.request_serial_no + "," + full.trade_status;
                	if (full.check_status == "已审核") {// 若为已审核，不能勾选
                		return "";
                	} else {
                		return '<div class="checkbox"><label><input type="checkbox" name="recordInfos" data-value="' + value + '" /><span class="text">&nbsp;</span></label></div>';
                	}
                }
	        }, {
	            "bSortable": false,
	            "aTargets": [1],
	            "mRender": function (data, type, full) {
	            	return new Date(data).Format("yyyy-MM-dd");
	            }
	        }, {
	            "bSortable": false,
	            "aTargets": [3],
	            "mRender": function (data, type, full) {
	            	return '<span class="red bold">￥ ' + formatAmount(data, 0) + '</span>';
	            }
	        }, {
	            "bSortable": false,
	            "aTargets": [7],
	            "mRender": function (data, type, full) {
	            	return new Date(data).Format("yyyy-MM-dd");
	            }
	        }],
	        "sAjaxSource": "/withdraw/queryCheckFunds",
	        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
	        	for (var i = 0; i < aoData.length; i++) {
	                if (aoData[i]['name'] == 'iSortCol_0') {
	                    var cols = this.fnSettings().aoColumns;
	                    var index = parseInt(aoData[i]['value']);
	                    aoData.push({"name": "sColName", "value": cols[index]['mData']});
	                }
	            }
	        	var $dateRangeP = $('#date-range-picker').val();
	        	
	        	var resultType = $('#resultType').val();
	        	
	            aoData.push({
	                "name": "startDate",
	                "value": $dateRangeP.split(' - ')[0]
	            });
	            aoData.push({
	                "name": "endDate",
	                "value": $dateRangeP.split(' - ')[1]
	            });
	            aoData.push({
	                "name": "resultType",
	                "value": resultType
	            });
	            aoData.push({
	                "name": "batchNo",
	                "value": $('#batchNo').val()
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
}
queryInfos();

/**
 * 审核通过
 */
$('#btnOk').click(function () {
	var recordInfosList1 = [], 
	recordInfos = $('input[name=recordInfos]:checked');
	
    for (var i = 0; i < recordInfos.length; i++) {
    	recordInfosList1.push($(recordInfos[i]).attr('data-value'));
    }
    
    if (recordInfos.length == 0) {
    	alert("请选择审核通过的数据！");
    	return false;
    }
    
    var dataInfo = {opType:'CHECKED',
    		recordInfos:recordInfosList1};
    $('#btnOk').prop('disabled', true);
    $.get('/withdraw/checkInfo/', dataInfo, function(data) {
    	data = eval("(" + data + ")");
        alert(data.comment);
    	location.reload();
     });
});


/**
 * 审核拒绝
 */
$('#btnCancel').click(function () {
	var recordInfosList1 = [], 
	recordInfos = $('input[name=recordInfos]:checked');
	
    for (var i = 0; i < recordInfos.length; i++) {
    	recordInfosList1.push($(recordInfos[i]).attr('data-value'));
    }
    
    if (recordInfos.length == 0) {
    	alert("请选择审核拒绝的数据！");
    	return false;
    }
//    console.log("recordInfosList1" + recordInfosList1);
	
    var dataInfo = {opType:'AUDITFAILURE',
    		recordInfos:recordInfosList1};

    $('#btnCancel').prop('disabled', true);
    $.post('/withdraw/checkInfo/', dataInfo , function(data) {
    	data = eval("(" + data + ")");
        alert(data.comment);
    	location.reload();
    });
});

/**
 * 按批次号下载
 */
$('#downloadByBatchNo').click(function () {
	if ($('#batchNo').val() == '') {
		alert("请输入批次号!");
		return false;
	}
	
	var href = '/withdraw/downloadCheckResultByBatchNo?batchNo=' + $('#batchNo').val();
    $(this).prop('href', href);
	return true;
});
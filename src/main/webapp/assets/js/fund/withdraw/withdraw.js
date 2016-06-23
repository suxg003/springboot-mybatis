function getList() {
    $('#commonDataTable').dataTable({
        "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": true,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bSortable": false,
        "bDestroy":true,
        "aoColumns": [
            {"mData": "coreBinding.userName", "sDefaultContent" : ""}, 		//0 姓名
            {"mData": "coreBinding.userIdNumber", "sDefaultContent" : ""},	//1 身份证
            {"mData": "recordTime", "sDefaultContent" : ""},//2 申请时间
            {"mData": "amount", "sDefaultContent" : ""}, 	//3 提现金额
            {"mData": "tradeStatusKey", "sDefaultContent" : ""},	//4 状态
            {"mData": "description", "sDefaultContent" : ""}//5 备注
        ],
        "aoColumnDefs": [{
            "bSortable": false,
            "aTargets": [2],
            "mRender": function (data, type, full) {
            	return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
            }
        }, {
            "bSortable": true,
            "aTargets": [3],
            "mRender": function (data, type, full) {
            	return '<span class="red bold">￥ ' + formatAmount(data, 2) + '</span>'
            }
        }],
        "sAjaxSource": "/withdraw/queryWithdrawInfos",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
        	var startDate = $('#startDate').val();
        	var endDate = $('#endDate').val();
        	// 下载时间范围
        	var rangeTimeFlag = $("#rangeTimeFlag").val();
            for (var i = 0; i < aoData.length; i++) {
                if (aoData[i]['name'] == 'iSortCol_0') {
                    var cols = this.fnSettings().aoColumns;
                    var index = parseInt(aoData[i]['value']);
                    aoData.push({"name": "sColName", "value": cols[index]['mData']});
                }
            }
            var $dateRangeP = $('#date-range-picker').val();
            aoData.push({
                "name": "startDate",
                "value":  $dateRangeP.split(' - ')[0]
            });
            aoData.push({
                "name": "endDate",
                "value": $dateRangeP.split(' - ')[1]
            });
            aoData.push({
                "name": "rangeTimeFlag",
                "value": rangeTimeFlag
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
getList();

/**
 * 下载支付使用
 */
var isDown = false;
function downloadInfo() {
	var $dateRangeP=$('#date-range-picker').val();
	var downloadType = "ALL";
	var sarchName = $("input[type='search']").val();
	// 下载时间范围
	var rangeTimeFlag = $("#rangeTimeFlag").val();
	
    if (!isDown) {
    	var href = '/withdraw/download?dateRangePicker=' + $dateRangeP+'&downloadType='+ downloadType+'&sSearch='+ sarchName+'&rangeTimeFlag='+rangeTimeFlag;
    	isDown = true;
    	$('#downloadHistoryBtn').prop('href', href);
    } else {
    	$('#downloadHistoryBtn').prop('href', 'javascript:void(0)');
    }
	return true;
}

/**
 * 下载内部使用
 */
$('#downloadInternal').click(function () {
    var $dateRangeP=$('#date-range-picker').val();
    var href = '/withdraw/downloadInternal';
    $(this).prop('href', href);
    return true;
});


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

//$('.investRecordRange').val($('#startDate').val() + " - " + $('#endDate').val());
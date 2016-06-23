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
	         	{"mData": "recordTime", "sDefaultContent" : ""},	//0 序号
	            {"mData": "recordTime", "sDefaultContent" : ""},	//1 提现时间
	            {"mData": "amount", "sDefaultContent" : ""},	//2 提现金额
	            {"mData": "coreUser.loginName", "sDefaultContent" : ""}, //3 用户名
	            {"mData": "coreBinding.userName", "sDefaultContent" : ""},		//4 姓名
	            {"mData": "coreBinding.userIdNumber", "sDefaultContent" : ""},	//5 身份证号
	            {"mData": "coreUser.userMobile", "sDefaultContent" : ""},//6 手机号码
	            {"mData": "tradeStatusKey", "sDefaultContent" : ""}		//7 提现结果
	        ],
	        "aoColumnDefs": [{
	            "bSortable": false,
	            "aTargets": [1],
	            "mRender": function (data, type, full) {
	            	return new Date(data).Format("yyyy-MM-dd");
	            }
	        }, {
	            "bSortable": false,
	            "aTargets": [2],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">￥ ' + formatAmount(data, 0) + '</span>'
                }
	        }],
	        "sAjaxSource": "/withdraw/queryWithdrawInfoFailed",
	        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
	        	var startDate = $('#startDate').val();
	        	var endDate = $('#endDate').val();
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
	                "value": $dateRangeP.split(' - ')[0]//"2014-1-1"
	            });
	            aoData.push({
	                "name": "endDate",
	                "value": $dateRangeP.split(' - ')[1]//"2015-9-10"
	            });
	            var batchNo = $('#batchNo').val();
	            aoData.push({
	                "name": "batchNo",
	                "value": batchNo//"201505140001"
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
	        fnCreatedRow: function(nRow, aData, iDataIndex) {
	    		$('td:eq(0)', nRow).html(iDataIndex + 1);
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
 * 下载
 */
$('#downloadByBatchNo').click(function(){
	var $dateRangeP = $('#date-range-picker').val();
	var href = "/withdraw/downloadWithdrawInfoFailed?startDate=" + $dateRangeP.split(' - ')[0] 
	+ "&endDate=" + $dateRangeP.split(' - ')[1];
    $(this).prop('href', href);
    return true;	
});
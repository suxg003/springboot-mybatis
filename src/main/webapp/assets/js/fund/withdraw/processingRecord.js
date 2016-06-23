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
 * 提现管理-查询
 * 传入参数：时间范围、搜索
 */
function queryPorcessingRecord() {
    $('#commonDataTable').dataTable({
      "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",	
      "bProcessing": false,
      "bServerSide": true,
      "bSort": true,
      "bFilter": true,
      "bDestroy": true,
      "aoColumns": [
        {"mData": "name"}, //0
        {"mData": "idNumber"}, //1
        {"mData": "recordTime"}, //2
        {"mData": "amount"}, //3
        {"mData": "status"}, //4
        {"mData": "batchNo"}, //5
        {"mData": "downloadTime"}, //6
      ],
      "aoColumnDefs": [{
        "bSortable": false,
        "aTargets":[2],
        "mRender":function(data){
          var date = new Date(data);
          return date.Format('yyyy-MM-dd hh:mm:ss');
        }
      },{
        "bSortable": false,
        "aTargets":[3],
        "mRender":function(data){
          return "￥" + data;
        }
      },{
        "bSortable": false,
        "aTargets":[4],
        "mRender":function(data){
          if(data == 'PROCESSING') {
            return '处理中';
          }
        }
      },{
        "bSortable": false,
        "aTargets":[6],
        "mRender":function(data){
          var date = new Date(data);
          return date.Format('yyyy-MM-dd hh:mm:ss');
        }
      }],
      "fnDrawCallback": function (oSettings) {
        $("#searchRechargeHistory").html('查询');
        $("#searchRechargeHistory").prop('disabled', false);
      },
      "sAjaxSource": "/withdraw/processingRecords",
      "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
    	var $dateRangeP = $('#date-range-picker').val();
        aoData.push({
          "name": "startDate",
          "value": $dateRangeP.split(' - ')[0]
        });
        aoData.push({
          "name": "endDate",
          "value": $dateRangeP.split(' - ')[1]
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

    $('#searchRechargeHistory').click(function () {
      $("#searchRechargeHistory").html('<i class="icon-spin icon-spinner"></i> 查询中');
      $("#searchRechargeHistory").prop('disabled', true);
      oTable.fnPageChange('first');
    });
}

/**
 * 按批次号下载
 */
$("#downloadProcessing").click(function () {
	var batchNo = $("#batchNo").val();
	if (batchNo == '') {
		alert("请输入批次号");
		return false;
	} else {
	    var href = '/withdraw/downloadByBatchNo?batchNo=' + batchNo;
	    $(this).prop('href', href);
		return true;
	}
});

/**
 * 查询按钮-分页查询
 */
$("#queryProcessing").click(function () {
	queryPorcessingRecord();
});

queryPorcessingRecord();
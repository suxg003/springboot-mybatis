//日历
//    $('#date-range-picker').daterangepicker();
$('#date-range-picker').daterangepicker({
    format: 'YYYY-MM-DD'
});
var $dateRange = $('input[name=date-range-picker]');
/** fhj   红包使用记录 列表 start**/
var oTable = $('#commonDataTable').dataTable({
	"sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
    "bProcessing": false,
    "bServerSide": true,
    "iDisplayLength": 10,
    "aoColumns": [
        {"mData": "id"}, //0
        {"mData": "loginName"}, //1
        {"mData": "cardId"}, //2
        {"mData": "amount"}, //3
        {"mData": "recordTime"}, //4
        {"mData": "actionTypeKey"}, //5
//        {"mData": "actionType"}, //6  原始为investId  不懂具体的业务含义
    ],
    "aoColumnDefs": [{
        "bSortable": false,
        "aTargets":[1]
    },{
        "bSortable": false,
        "aTargets":[2],
        "mRender":function(data){
            return "#" + data;
        }
    },{
        "bSortable": false,
        "aTargets":[3]
    },{
        "bSortable": false,
        "aTargets":[4],
        "mRender":function(data){
            var date = new Date(data);
            return date.Format('yyyy-MM-dd hh:mm:ss');
        }
    },{
        "bSortable": false,
        "aTargets":[5]
    }
//    ,{
//        "bSortable": false,
//        "aTargets": [6], //来源
//        "mRender": function (data) {
//        	alert(data);
//            var actionMap = {
//                'INVEST':'投标'
//            };
//            return actionMap[data.toUpperCase()]||'';
//        }
//    }
    ],
    "sAjaxSource": "/user/listAllGiftcardRecord",
    "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
        
        aoData.push({
            "name": "startDate",
            "value": $dateRange.val().split(' - ')[0]
        });
        aoData.push({
            "name": "endDate",
            "value": $dateRange.val().split(' - ')[1]
        });
        aoData.push({
        	"name": "cardId",
        	"value":cardId
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
/** fhj   红包使用记录 列表 end**/

$('#downloadHistoryBtn').click(function () {
	var $dateRangeP=$('#date-range-picker').val();
    var href = '/reward/downGiftCardRecords?startDate=' + $dateRangeP.split(' - ')[0]+'&endDate='+$dateRangeP.split(' - ')[1]+'&sSearch='+$('#commonDataTable_filter input').val();
    $(this).prop('href', href);
});

$('#searchRechargeHistory').click(function () {
    $("#searchRechargeHistory").html('<i class="icon-spin icon-spinner"></i> 查询中');
    $("#searchRechargeHistory").prop('disabled', true);
    oTable.fnPageChange('first');
});

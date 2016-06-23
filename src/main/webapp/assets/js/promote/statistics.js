/**
 * Created by lxl on 15/7/9.
 */
$(function () {

    $('#date-range-picker').daterangepicker({
        format: 'YYYY-MM-DD',
        opens: 'left',
        ranges: {
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
    }, function (start, end) {
        $('input[name=startDate]').val(start.format("YYYY-MM-DD"));
        $('input[name=endDate]').val(end.format("YYYY-MM-DD"));
    }).prev().on(ace.click_event, function () {
        $(this).next().focus();
    });

    var $dateRange = $('input[name=date-range-picker]');
    var oTable = $('#commonDataTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "iDisplayLength": 10,
        "aaSorting":[[1,"desc"]],
        "aoColumns": [
//        {"mData": "loanId"}, //0
            {"mData": "typeKey"}, //0
            {"mData": "registerCount"}, //1
            {"mData": "umpCount"}, //2
            {"mData": "investCount"}, //3
            {"mData": "umpPercentStr"}, //4
            {"mData": "investPercentStr"}, //5
            {"mData": "investAmount"}, //6
            {"mData": "userFundIn"}, //7
            {"mData": "userFundOut"}, //8
        ],
        "aoColumnDefs": [{
            "bSortable": false,
            "aTargets": [0],
            "mRender": function (data, type, row) {
                if(!data){
                    return "";
                }
                return data;
            }
        },{
            "aTargets":[4],
            "mRender":function(data){
                if(data){
                    return data + "%";
                }
                return "--"
            }

        },{
            "aTargets":[5],
            "mRender":function(data){
                if(data){
                    return data + "%";
                }
                return "--"
            }
        },{
            "aTargets":[6],
            "mRender":function(data){
                return "￥" + data;
            }
        },{
            "aTargets":[7],
            "mRender":function(data){
                return "￥" + data;
            }
        },{
            "aTargets":[8],
            "mRender":function(data){
                return "￥" + data;
            }
        }],
        "fnDrawCallback": function (oSettings) {
            $("#searchRechargeHistory").html('查询');
            $("#searchRechargeHistory").prop('disabled', false);
        },
        "sAjaxSource": "/promote/staPromotes",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            for (var i = 0; i < aoData.length; i++) {
                if (aoData[i]['name'] == 'iSortCol_0') {
                    var cols = this.fnSettings().aoColumns;
                    var index = parseInt(aoData[i]['value']);
                    aoData.push({"name": "sColName", "value": cols[index]['mData']});
                    //break;
                }
            }
            aoData.push({
                "name": "startDate",
                "value": $dateRange.val().split(' - ')[0]
            });
            aoData.push({
                "name": "endDate",
                "value": $dateRange.val().split(' - ')[1]
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

});
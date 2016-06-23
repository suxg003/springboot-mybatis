/**
 * Created by lxl on 15/8/27.
 */
var ssSearch;
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
var oTable;
function getList(){
    var th='';
    th+='<tr>\
            <th><i class="icon-tag"></i> 申请人姓名</th>\
            <th><i class="hidden-480"></i>手机号</th>\
            <th class="hidden-480">电子邮箱</th>\
            <th><i class="fa fa-money"></i> 申请借款时间</th>\
            <th class="hidden-480">申请借款金额</th>\
            <th class="">申请借款期限</th>\
            <th class="hidden-480"><i class="fa fa-calendar"></i> 来源</th>\
			<th><i class="fa fa-clock-o"></i> 状态</th>\
			<th><i class="fa fa-clock-o"></i> 操作</th>';
    $('#list_th').html(th);

    oTable = $('#APPLY_LIST').dataTable({
            "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
            "iDisplayLength": 10,
            "bProcessing": true,
            "bServerSide": true,
            "bFilter": true,
            "bPaginate": true,
            "bRetrieve": true,
            "aaSorting":[[7,"asc"]],
            "aoColumns": [
                {"mData": "applyName"},
                {"mData": "mobile"},
                {"mData": "email"},
                {"mData": "applyTime"},
                {"mData": "applyAmount"},
                {"mData": "duration"},
                {"mData": "sourceKey"},
                {"mData": "status"},
                {"mData": "operation"}
            ],
            "aoColumnDefs": [
                {
                    sDefaultContent: '',
                    aTargets: [ '_all' ]
                },
                {
                    "aTargets": [3],
                    "mRender": function (data, type, row) {
                        if(undefined!=data){
                            return (new Date(data)).Format("yyyy-M-d h:m")
                        }else {
                            return '-'
                        }
                    }
                },
                {
                    "aTargets": [4],
                    "mRender": function (data, type, row) {
                        return '￥'+data
                    }
                },
                {
                    "aTargets": [5],
                    "mRender": function (data, type, row) {
                        var str="";
                        if(row.years!=0){
                            str+=row.years+"年";
                        }
                        if(row.months!=0){
                            str+=row.months+"月";
                        }
                        if(row.days!=0){
                            str+=row.days+"天";
                        }
                        return str;
                    }
                },
                {
                    "aTargets": [7],
                    "mRender": function (data, type, row) {
                        if(data){
                            return '<span>已回访</span>'
                        }else {
                            return '<span class="red bold">未回访</span>'
                        }
                    }
                },
                {
                    "aTargets": [8],
                    "mRender": function (data, type, row) {
                        if(row.status){
                            return '<a class="btn btn-sm btn-grey" style="cursor:not-allowed" href="#">设为已回访</a>';
                        }else {
                            return "<a class='btn btn-sm btn-primary' href='#' onclick='updateLoanApplyStatus(&quot;"+row.applyId+"&quot;)'>设为已回访</a>";
                        }
                    }
                }
            ],
            "fnDrawCallback": function (oSettings) {
                $("#searchRechargeHistory").html('查询');
                $("#searchRechargeHistory").prop('disabled', false);
            },
            "sAjaxSource": "/loan/gitLoanApplyList",
            "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
                ssSearch = getSearchVal(aoData);
                //$('#downloadLoan').attr('href','/loan/applyListDownload/'+iData.status+'?search='+getSearchVal(aoData));
                for (var i = 0; i < aoData.length; i++) {
                    if (aoData[i]['name'] == 'iSortCol_0') {
                        var cols = this.fnSettings().aoColumns;
                        var index = parseInt(aoData[i]['value']);
                        aoData.push({"name": "sColName", "value": cols[index]['mData']});
                        //break;
                    }
                }
                aoData.push({
                    "name": "status",
                    "value": $("#returnVisitStatus").val()
                });
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
                        console.log('error'+aoData);
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

function updateLoanApplyStatus(applyId) {
    $.ajax({
        url: '/loan/returnVisited',
        data: {applyId: applyId},
        type: 'POST',
        error: function (request) {
            alert("Connection error");
            location.reload();
        },
        success: function (data) {
            location.reload();
        }
    });
}

$('#searchRechargeHistory').click(function () {
    $("#searchRechargeHistory").html('<i class="icon-spin icon-spinner"></i> 查询中');
    $("#searchRechargeHistory").prop('disabled', true);
    oTable.fnPageChange('first');
});
$('#downList').click(function () {
    var $dateRangeP=$('#date-range-picker').val();
    var href = '/loan/downApplyList?status='+$("#returnVisitStatus").val()+'&startDate=' + $dateRangeP.split(' - ')[0]+'&endDate='+$dateRangeP.split(' - ')[1]+'&sSearch='+ssSearch;
    location.replace(href)
});

function getSearchVal(params) {
    for(var i=0;i<params.length;i++){
        if(params[i].name=="sSearch"){
            return params[i].value;
        }
    }
}
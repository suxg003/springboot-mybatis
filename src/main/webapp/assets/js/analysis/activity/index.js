function Func() {}

Func.prototype.init = function () {
    var self = this;
    self.loadData();

    //日历
    $('#reservation').daterangepicker({
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
    });

    $('#reservation').daterangepicker();

    $('#reservation').val(moment().subtract('days', 29).format("YYYY-MM-DD") + ' - ' + moment().format("YYYY-MM-DD"));


    $("#btn_search").on('click',function(){
        self.loadData();
    });

};

Func.prototype.loadData = function () {
    var $dateRange = $('#reservation');
    var $type = $('#type');

    $('#activityIndex').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        "aoColumns": [
            {"mData": "activityName", "sDefaultContent" : ""},     //0 活动名称
            {"mData": "participantsNum", "sDefaultContent" : "0"},   //1 参与人数
            {"mData": "registerNum", "sDefaultContent" : "0"},  //2 注册人数
            {"mData": "investNum", "sDefaultContent" : "0"},   //3 投资人数
            {"mData": "investNewNum", "sDefaultContent" : "0"},  //4 新用户投资人数
            {"mData": "investNum", "sDefaultContent" : "0"},       //5 投资笔数
            {"mData": "investAmount", "sDefaultContent" : "0"}, //6 投资金额
            {"mData": "investNewAmount", "sDefaultContent" : "0"},    //7 首投金额
            {"mData": null, "sDefaultContent" : ""}     //8 操作
        ],
        "aoColumnDefs": [
            {
                "aTargets": [6],
                "mRender": function (data, type, row) {
                    return formatAmount(data, 0)
                }
            },
            {
                "aTargets": [7],
                "mRender": function (data, type, row) {
                    return formatAmount(data, 0)
                }
            }
        ],
        "sAjaxSource": "/analysis/activity/list",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

            aoData.push({
                "name": "dateRange",
                "value": $dateRange.val()
            });
            aoData.push({
                "name": "type",
                "value": $type.val()
            });

            var downParams = [];
            for (var i = 0; i < aoData.length; i++) {
                if (aoData[i]['name'] == 'sSearch' || aoData[i]['name'] == 'dateRange' || aoData[i]['name'] == 'type') {
                    downParams.push(aoData[i]['name'] + '=' + aoData[i]['value']);
                }
            }

            oSettings.jqXHR = $.ajax({
                "dataType": 'json',
                "type": "GET",
                "url": sSource,
                "data": aoData,
                "success": fnCallback,
                "error": function (data) {
                    alert(data);
                }
            });
        },
        fnCreatedRow: function (nRow, aData, iDataIndex) {
            var activity = aData.activity
                ,handlerHtml = '<a id="detail_btn" class="btn btn-primary btn-sm" href="/analysis/activity/detail/' + activity + '" title="查看报表"  style="margin-right:15px"><i class="fa fa-file"></i> 查看报表</a>'
                + '<a id="detail_btn" class="btn btn-info btn-sm" href="/analysis/activity/lateInvest/' + activity + '" title="后期统计"><i class="fa fa-file"></i> 后期统计</a>';
            $('td:eq(8)', nRow).html(handlerHtml);
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
};

function Func() {}

Func.prototype.init = function () {
    var self = this;

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

    self.loadData();

    $("#btn_search").on('click',function(){
        self.loadData();
    });

};

Func.prototype.loadData = function () {
    var $dateRange = $('#reservation');
    var $source = $('#source').val();

    var $aoColumns, $aoColumnDefs;


    $aoColumns = [
        {"mData": "sourceName", "sDefaultContent" : ""},     //0 渠道名称
        {"mData": "uv", "sDefaultContent" : "0"},   //1 PV
        {"mData": "pv", "sDefaultContent" : "0"},  //2 uv
        {"mData": "activateNum", "sDefaultContent" : "0"},  //3 激活人数
        {"mData": "registerNum", "sDefaultContent" : "0"},   //4 注册人数
        {"mData": "investNum", "sDefaultContent" : "0"},  //5 投资人数
        {"mData": "investAmount", "sDefaultContent" : "0"},       //6 投资金额(元)
        {"mData": "investCurrAmount", "sDefaultContent" : "0"}, //7 活期投资金额(元)
        {"mData": "price", "sDefaultContent" : "0"},    //8 客户单价(元)
        {"mData": "retainedAmount", "sDefaultContent" : "0"},    //9 留存资金
        {"mData": null, "sDefaultContent" : ""}     //10 操作
    ];

    if ('WEB' == $source || 'MSTATION' == $source || 'WECHAT' == $source) {
        $aoColumnDefs = [
            {
                "aTargets": [3],
                "visible": false
            }
        ];

    }

    if ('ANDROID' == $source || 'IOS' == $source) {
        $aoColumnDefs = [
            {
                "aTargets": [1],
                "visible": false
            },
            {
                "aTargets": [2],
                "visible": false
            }
        ];
    }

    $('#sourcesIndex').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        "aoColumns": $aoColumns,
        "aoColumnDefs": $aoColumnDefs,
        "sAjaxSource": "/analysis/sources/list",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

            aoData.push({
                "name": "dateRange",
                "value": $dateRange.val()
            });
            aoData.push({
                "name": "source",
                "value": $source
            });

            var downParams = [];
            for (var i = 0; i < aoData.length; i++) {
                if (aoData[i]['name'] == 'sSearch' || aoData[i]['name'] == 'dateRange' || aoData[i]['name'] == 'source') {
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
            var source = aData.source,
                type = aData.type,
                handlerHtml = '<a id="detail_btn" class="btn btn-primary btn-sm" href="/analysis/sources/detail/' + source + '/' + type + '" title="查看报表"  style="margin-right:15px"><i class="fa fa-file"></i> 查看报表</a>';
            if ('WEB' == $source || 'MSTATION' == $source || 'WECHAT' == $source) {
                $('td:eq(9)', nRow).html(handlerHtml);// 操作
            } else {
                $('td:eq(8)', nRow).html(handlerHtml);// 操作
            }

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

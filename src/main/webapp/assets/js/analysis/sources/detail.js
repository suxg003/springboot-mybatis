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

    $("#btn_search").on('click',function(){
        var $dateRange = $('#reservation').val();

        if (!$dateRange) {
            alert("请选择日期范围!");
            return;
        }

        if ($dateRange) {
            $('#defaultData').css('display', 'none');
            $('#detailData').css('display', '');
        } else {
            $('#defaultData').css('display', '');
            $('#detailData').css('display', 'none');
        }
        self.loadData();
    });

    $("#btn_excel").on('click',function(){
        var $dateRange = $('#reservation').val(),
            $source = $('#source').val(),
            $type = $('#type').val();

        if (!$dateRange) {
            alert("请选择日期范围!");
            return;
        }

        location.replace('/analysis/sources/detailExcel?source='+$source+'&type='+$type+'&dateRange='+$dateRange);
    });


};

Func.prototype.loadData = function () {
    var $dateRange = $('#reservation'),
        $source = $('#source'),
        $type = $('#type'),
        $aoColumnDefs;

    if ('IOS' == $type.val() || 'ANDROID' == $type.val()) {
        $aoColumnDefs = [
            {
                "bSortable": true,
                "aTargets": [0],
                "mRender": function (data, type, row) {
                    return new Date(data).Format("yyyy-MM-dd");
                }
            },
            {
                "aTargets": [1],
                "visible": false
            },
            {
                "aTargets": [2],
                "visible": false
            }
        ];
    } else {
        $aoColumnDefs = [
            {
                "bSortable": true,
                "aTargets": [0],
                "mRender": function (data, type, row) {
                    return new Date(data).Format("yyyy-MM-dd");
                }
            },
            {
                "aTargets": [3],
                "visible": false
            }
        ];
    }


    $('#numTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "bSort": false,
        "bFilter": false,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        "iDisplayLength":5,
        "aLengthMenu":[ [ 5, 20, 50 ], [ "5", "20", "50" ] ],
        "aoColumns": [
            {"mData": "date", "sDefaultContent" : ""},                      //0 时间
            {"mData": "uv", "sDefaultContent" : "0"},                       //1 UV
            {"mData": "pv", "sDefaultContent" : "0"},                       //2 PV
            {"mData": "activateNum", "sDefaultContent" : "0"},                       //2 激活人数
            {"mData": "registerNum", "sDefaultContent" : "0"},             //3 注册人数
            {"mData": "idAuthNum", "sDefaultContent" : "0"},               //4 实名人数
            {"mData": "rechargeNum", "sDefaultContent" : "0"},             //5 充值人数
            {"mData": "investNum", "sDefaultContent" : "0"},               //6 投资人数
            {"mData": "registerConversionRate", "sDefaultContent" : "0"},   //7 注册转化率
            {"mData": "authIdConversionRate", "sDefaultContent" : "0"},     //8 实名转化率
            {"mData": "rechargeConversionRate", "sDefaultContent" : "0"},   //9 充值转化率
            {"mData": "investConversionRate", "sDefaultContent" : "0"}      //10 投资转化率
        ],
        "aoColumnDefs": $aoColumnDefs,
        "sAjaxSource": "/analysis/sources/detailList",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

            aoData.push({
                "name": "dateRange",
                "value": $dateRange.val()
            });
            aoData.push({
                "name": "source",
                "value": $source.val()
            });
            aoData.push({
                "name": "type",
                "value": $type.val()
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


    $('#amountTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "bSort": false,
        "bFilter": false,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        "iDisplayLength":5,
        "aLengthMenu":[ [ 5, 20, 50 ], [ "5", "20", "50" ] ],
        "aoColumns": [
            {"mData": "date", "sDefaultContent" : ""},                  //0 时间
            {"mData": "rechargeAmount", "sDefaultContent" : "0"},       //1 充值总额
            {"mData": "investAmount", "sDefaultContent" : "0"},         //2 投资总额
            {"mData": "investCurrAmount", "sDefaultContent" : "0"},     //3 活期投资总额
            {"mData": "price", "sDefaultContent" : "0"},        //4 客户单价
            {"mData": "retainedAmount", "sDefaultContent" : "0"}   //5 留存资金
        ],
        "aoColumnDefs": [
            {
                "bSortable": true,
                "aTargets": [0],
                "mRender": function (data, type, row) {
                    return new Date(data).Format("yyyy-MM-dd");
                }
            }
        ],
        "sAjaxSource": "/analysis/sources/detailList",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

            aoData.push({
                "name": "dateRange",
                "value": $dateRange.val()
            });
            aoData.push({
                "name": "source",
                "value": $source.val()
            });
            aoData.push({
                "name": "type",
                "value": $type.val()
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

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

    $("#btn_excel").on('click',function(){
        var $dateRange = $('#reservation').val(),
            $activity = $('#activity').val(),
            $userLevel = $('#userLevel').val(),
            $type = $('#type').val();

        if (!$dateRange) {
            alert("请选择日期范围!");
            return;
        }

        location.replace('/analysis/activity/detailExcel?activity='+$activity+'&type='+$type+'&dateRange='+$dateRange+'&userLevel='+$userLevel);
    });
};

Func.prototype.loadData = function () {
    var $dateRange = $('#reservation');
    var $type = $('#type');
    var $userLevel = $('#userLevel');
    var $activity = $('#activity');

    $('#numTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "searching":false,
        "bDestroy": true,
        "iDisplayLength":5,
        "aLengthMenu":[ [ 5, 20, 50 ], [ "5", "20", "50" ] ],
        "aoColumns": [
            {"mData": "date", "sDefaultContent" : "累计"},     //0 时间
            {"mData": "participantsNum", "sDefaultContent" : "0"},   //1 参与人数
            {"mData": "registerNum", "sDefaultContent" : "0"},  //2 注册人数
            {"mData": "idAuthNum", "sDefaultContent" : "0"},   //3 实名人数
            {"mData": "bindCardNum", "sDefaultContent" : "0"},   //3 绑卡人数
            {"mData": "rechargeNum", "sDefaultContent" : "0"},  //4 充值人数
            {"mData": "investNum", "sDefaultContent" : "0"},       //5 投资人数
            {"mData": "investNewNum", "sDefaultContent" : "0"}, //6 首投人数
            {"mData": "registerConversionRate", "sDefaultContent" : "0"},    //7 注册转化率
            {"mData": "authIdConversionRate", "sDefaultContent" : "0"},    //8 实名转化率
            {"mData": "rechargeConversionRate", "sDefaultContent" : "0"},     //9 充值转化率
            {"mData": "investConversionRate", "sDefaultContent" : "0"}     //10 投资转化率
        ],
        "aoColumnDefs": [
            {
                "bSortable": true,
                "aTargets": [0],
                "mRender": function (data, type, row) {
                    console.log("----" + data);
                    if (data) {
                        return new Date(data).Format("yyyy-MM-dd");
                    }
                }
            }
        ],
        "sAjaxSource": "/analysis/activity/detailList",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

            aoData.push({
                "name": "dateRange",
                "value": $dateRange.val()
            });
            aoData.push({
                "name": "type",
                "value": $type.val()
            });
            aoData.push({
                "name": "userLevel",
                "value": $userLevel.val()
            });
            aoData.push({
                "name": "activity",
                "value": $activity.val()
            });

            var downParams = [];
            for (var i = 0; i < aoData.length; i++) {
                if (aoData[i]['name'] == 'sSearch' || aoData[i]['name'] == 'dateRange' || aoData[i]['name'] == 'type' || aoData[i]['name'] == 'userLevel') {
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
        "bFilter": true,
        "bPaginate": true,
        "searching":false,
        "bSortable": false,
        "bDestroy": true,
        "iDisplayLength":5,
        "aLengthMenu":[ [ 5, 20, 50 ], [ "5", "20", "50" ] ],
        "aoColumns": [
            {"mData": "date", "sDefaultContent" : "累计"},     //0 时间
            {"mData": "rechargeAmount", "sDefaultContent" : "0"},   //1 充值总额
            {"mData": "rechargeNewAmount", "sDefaultContent" : "0"},  //2 新用户充值总额
            {"mData": "investAmount", "sDefaultContent" : "0"},   //3 投资总额
            {"mData": "investCurrAmount", "sDefaultContent" : "0"},  //4 活期投资总额
            {"mData": "investNewAmount", "sDefaultContent" : "0"},       //5 新用户投资总额
            {"mData": "investCurrNewAmount", "sDefaultContent" : "0"} //6 新用户活期投资总额
        ],
        "aoColumnDefs": [
            {
                "bSortable": true,
                "aTargets": [0],
                "mRender": function (data, type, row) {
                    if (data) {
                        return new Date(data).Format("yyyy-MM-dd");
                    }
                }
            }
        ],
        "sAjaxSource": "/analysis/activity/detailList",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

            aoData.push({
                "name": "dateRange",
                "value": $dateRange.val()
            });
            aoData.push({
                "name": "type",
                "value": $type.val()
            });
            aoData.push({
                "name": "userLevel",
                "value": $userLevel.val()
            });
            aoData.push({
                "name": "activity",
                "value": $activity.val()
            });

            var downParams = [];
            for (var i = 0; i < aoData.length; i++) {
                if (aoData[i]['name'] == 'sSearch' || aoData[i]['name'] == 'dateRange' || aoData[i]['name'] == 'type' || aoData[i]['name'] == 'userLevel') {
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

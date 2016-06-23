/**
 * Created by dandan on 15/10/20.
 */

function Func(type, status, flagInvestClear) {
    this.type = type;
    this.status = status;
    this.flagInvestClear = flagInvestClear;
    this.init();
}

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

    $('#btn_search').on('click', function () {
        self.loadData.apply(self, []);
    });
};

Func.prototype.loadData = function () {
    var _self = this;
    var $dateRange = $('#reservation');
    var opType = $('#operetionType').val();
    $('#reApRedeemTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        "aoColumns": [
            {"mData": "orderId", "sDefaultContent": ""},//0
            {"mData": "loginName", sDefaultContent: ""},//1
            {"mData": "userName", sDefaultContent: ""},//2
            {"mData": "amount", "sDefaultContent": ""},//3
            {"mData": "principalAmount", "sDefaultContent": ""},//4
            {"mData": "interestAmount", "sDefaultContent": ""},//5
            {"mData": "auditTime", "sDefaultContent": ""},//6
            {"mData": "repayTypeKey", "sDefaultContent": ""},//7
            {"mData": "fee", "sDefaultContent": ""},//8
            {"mData": "receivableAmount", "sDefaultContent": ""},//9
            {"mData": "applyStatusKey", "sDefaultContent": ""},//10
            {"mData": "id", "sDefaultContent": ""}//11

        ],
        "aoColumnDefs": [
            {
                "aTargets": [3],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">' + formatAmount(data, 2) + '元</span>';
                }
            },
            {
                "aTargets": [4],
                "mRender": function (data, type, row) {
                    if (data != null) {
                        return '<span class="red bold">' + formatAmount(data, 2) + '元</span>';
                    } else {
                        return null;
                    }

                }
            },
            {
                "aTargets": [5],
                "mRender": function (data, type, row) {
                    if (data != null) {
                        return '<span class="red bold">' + formatAmount(data, 2) + '元</span>';
                    } else {
                        return null;
                    }

                }
            },
            {
                "aTargets": [6],
                "mRender": function (data, type, row) {
                    return new Date(data).Format("yyyy-MM-dd");
                }
            },
            {
                "aTargets": [8],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">' + formatAmount(data, 2) + '元</span>';
                }
            },
            {
                "aTargets": [9],
                "mRender": function (data, type, row) {
                    if (data != null) {
                        return '<span class="red bold">' + formatAmount(data, 2) + '元</span>';
                    } else {
                        return null;
                    }

                }
            },
            {
                "aTargets": [11],
                "mRender": function (data, type, row) {

                    return '<a href="/claimTemplate/sellBill/'+data+'" target="_blank" class="btn btn-sm btn-palegreen">卖单文件</a>';

                }
            }
        ],
        "sAjaxSource": "/claimRepayApply/queryClaimRepayApplyInfos",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

            aoData.push({
                "name": "dateRange",
                "value": $dateRange.val()
            });
            aoData.push({
                "name": "type",
                "value": _self.type
            });
            aoData.push({
                "name": "status",
                "value": _self.status
            });
            aoData.push({
                "name": "flagInvestClear",
                "value": _self.flagInvestClear
            });
            var downParams = [];
            for (var i = 0; i < aoData.length; i++) {

                if (aoData[i]['name'] == 'sSearch' || aoData[i]['name'] == 'dateRange' || aoData[i]['name'] == 'type' || aoData[i]['name'] == 'status' || aoData[i]['name'] == 'flagInvestClear') {
                    downParams.push(aoData[i]['name'] + '=' + aoData[i]['value']);
                }
            }

            oSettings.jqXHR = $.ajax({
                "dataType": 'json',
                "type": "GET",
                "url": sSource,
                "data": aoData,
                "success": fnCallback,
                "error": function () {

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


function Func(type, status) {
    this.type = type;
    this.status = status;
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

    $('#link_audit_all').bind('click', function () {
        if (!confirm('确定全部审批?')) return;
        batchDeal('SUCCESSFUL');
    });

    /*全选通过*/
    $('#check_all').bind('click', function () {
        $('input.check_each').prop('checked', $(this).prop('checked'));
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
            {"mData": "id", "sDefaultContent": ""},//0
            {"mData": "orderId", "sDefaultContent": ""},//1
            {"mData": "loginName", sDefaultContent: ""},//2
            {"mData": "userName", sDefaultContent: ""},//3
            {"mData": "amount", "sDefaultContent": ""},//4
            {"mData": "principalAmount", "sDefaultContent": ""},//5
            {"mData": "interestAmount", "sDefaultContent": ""},//6
            {"mData": "applyTime", "sDefaultContent": ""},//7
            {"mData": "repayType", "sDefaultContent": ""},//8
            {"mData": "applyStatus", "sDefaultContent" : ""},//9
            {"mData": "id", "sDefaultContent" : ""}//10

        ],
        "aoColumnDefs": [
            {
                "bSortable": false,
                "aTargets": [0],
                "mRender": function (data, type, full) {
                    return '<div class="checkbox" style="margin-top: -10px;"><label><input type="checkbox" class="check_each" name="recordInfos" data-id="' + full.id + '" /><span class="text">&nbsp;</span></label></div>';
                }
            },
            {
                "aTargets": [4],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">' + formatAmount(data, 2) + '元</span>';
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
                    if (data != null) {
                        return '<span class="red bold">' + formatAmount(data, 2) + '元</span>';
                    } else {
                        return null;
                    }

                }
            },
            {
                "aTargets": [7],
                "mRender": function (data, type, row) {
                    return new Date(data).Format("yyyy-MM-dd");
                }
            },
            {
                "aTargets": [8],
                "mRender": function (data, type, row) {
                    if (data == 'MONTHLY_INTEREST') {
                        return '按月付息，到期还本付息';
                    }
                    if (data == 'BULLET_REPAYMENT') {
                        return '一次性还本付息';
                    }
                    if (data == 'DAILY_INTEREST') {
                        return "每日计息，随时还本付息";
                    }
                }
            },
            {
                "aTargets": [9],
                "mRender": function (data, type, row) {
                    return data.key;
                }
            },
            {
                "aTargets": [10],
                "mRender": function (data, type, row) {
                    if ($("#USER_TRANSFER_AUDIT").val() != undefined) {
                        return '<cm:securityTag privilegeString="USER_TRANSFER_AUDIT"><a data-command="SUCCESSFUL" data-id="' + data + '" class="btn btn-sm btn-blue">通过</a>';
                    } else {
                        return '';
                    }

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
            var downParams = [];
            for (var i = 0; i < aoData.length; i++) {

                if (aoData[i]['name'] == 'sSearch' || aoData[i]['name'] == 'dateRange' || aoData[i]['name'] == 'type' || aoData[i]['name'] == 'status') {
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
                	alert(2);
                	alert(data);
                }
            });
        },
        fnCreatedRow: function (nRow, aData, iDataIndex) {
            $('td:eq(1)', nRow).html(iDataIndex + 1);

            $('a[data-command]', nRow).bind('click', function () {
                if (!confirm('确定' + $(this).html() + '?')) return;
                var command = $(this).attr('data-command');
                var id = $(this).attr('data-id');
                batchDeal(command, id);
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

//批量提交 : 单个提交也调用这个，传id
var isSync = false;

function batchDeal(op, id) {

    if (isSync) return;

    var idArr = [];

    if (id) {
        idArr.push(id);
    }
    else {
        $('#reApRedeemTable .check_each').each(function (ix) {
            if (!this.checked) return;
            idArr.push($(this).attr('data-id'));
        });
    }

    if (idArr.length == 0) {
        alert('未选择任何记录');
        return;
    }

    var ids = idArr.join(',');
    isSync = true;

    $.post('/claimRepayApply/bathPassRedemption', {
        'idStr': ids,
        'status': op
    }, function (res) {
        isSync = false;
        if (!res.success) {
            alert(res.comment || '操作失败');
            return;
        }
        window.location = location.href;
    }, 'json').error(function () {
        isSync = false;
    });
}

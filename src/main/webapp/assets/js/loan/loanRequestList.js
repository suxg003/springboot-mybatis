/** 
 * 重载datatables排序算法：根据实际创建时间排序 
 */

$.fn.dataTableExt.oSort['duration-desc'] = function(a, b) {
    var x = parseInt(a.match(/>(\d+)/)[1]);
    var y = parseInt(b.match(/>(\d+)/)[1]);
    return ((x < y || isNaN(y)) ? -1 : ((x > y || isNaN(x)) ? 1 : 0));
};
$.fn.dataTableExt.oSort['duration-asc'] = function(a, b) {
    var x = parseInt(a.match(/>(\d+)/)[1]);
    var y = parseInt(b.match(/>(\d+)/)[1]);
    return ((x < y || isNaN(x)) ? 1 : ((x > y || isNaN(y)) ? -1 : 0));
};
/** 
 * 重载datatables排序算法：根据借款金额排序 
 */
$.fn.dataTableExt.oSort['amount-desc'] = function(a, b) {
    var x = parseFloat(a.replace(/[,￥ ]/g, ''));
    var y = parseFloat(b.replace(/[,￥ ]/g, ''));
    return ((x < y || isNaN(y)) ? -1 : ((x > y || isNaN(x)) ? 1 : 0));
};
$.fn.dataTableExt.oSort['amount-asc'] = function(a, b) {
    var x = parseFloat(a.replace(/[,￥ ]/g, ''));
    var y = parseFloat(b.replace(/[,￥ ]/g, ''));
    return ((x < y || isNaN(x)) ? 1 : ((x > y || isNaN(y)) ? -1 : 0));
};
var fundStatus = {
    'UNASSIGNED': '<span class="badge badge-grey">未处理</span>',
    'ASSIGNED': '<span class="badge badge-warning">处理中</span>',
    'CANCELED': '<span class="badge badge-grey">已取消</span>',
    'PENDING_VISIT': '<span class="badge badge-warning">实地征信</span>',
    'PENDING_RISK': '<span class="badge badge-warning">风控审核</span>',
    'PENDING_APPORVE': '<span class="badge badge-warning">待批准</span>',
    'APPROVED': '<span class="badge badge-success">已批准</span>',
    'REJECTED': '<span class="badge badge-important">已驳回</span>',
    'PUBLISHED': '<span class="badge badge-info">已发放</span>',
    'ARCHIVED': '<span class="badge badge-purple">已存档</span>',
    'DELETED': '<span class="badge badge-invverse">已刪除</span>'
};
var oTable = null;
function initTable(data) {
    if (oTable != null) {
        oTable.fnDestroy();
    }
    oTable = $('#loanList').dataTable({
        "data": data,
        //"aaSorting": [[10, "asc"]],
        "aoColumns": [
            {"mData": "title"},
            {"mData": "serial"},
            {"mData": "corporation"},
            {"mData": "user"},
            {"mData": "purpose"},
            {"mData": "amount"},
            {"mData": "duration"},
            {"mData": "rate"},
            {"mData": "mortgaged"},
            {"mData": "method"},
            {"mData": "status"},
            {"mData": "timeSubmit"}
        ],
        "aoColumnDefs": [{
		"aTargets": [0], //title
		"mRender": function(title, type, row) {
		    return '<a href="loan/request/' + row.id + '" target="_blank">' + title + '</a>';
		}
	    }, {
		"aTargets": [2], //corporation
		"mRender": function(corporation, type, row) {
                    if (corporation != null) {
                        return '<a href="corporation/' + corporation.id + '" target="_blank">' + corporation.name + '</a>';
                    } else {
                        return '无';
                    }
		}
	    }, {
                "aTargets": [3], //user
                "mRender": function(user, type, row) {
                    return '<a href="user/profile/' + user.id + '" target="_blank">' + user.loginName + '</a>';
                }
            }, {
                "aTargets": [4], //purpose
                "mRender": function(purpose, type, row) {
                    return loanPurpose[purpose];
                }
            }, {
                "aTargets": [5], //amount
                "mRender": function(amount, type, row) {
                    return '<span class="red bold">￥' + formatAmount(amount, 0) + '</span>';
                }
            }, {
                "aTargets": [6], //duration
                "mRender": function(duration, type, row) {
                    return duration.totalMonths + '个月';
                }
            }, {
                "aTargets": [7], //rate
                "mRender": function(rate, type, row) {
                    if (rate % 100 == 0) {
                        return rate / 100 + '%';
                    }
                    return (parseFloat(rate) / 100).toFixed(2) + '%';
                }
            }, {
                "aTargets": [8], //抵押
                "mRender": function(mortgaged, type, row) {
                    return mortgaged == true ? "有" : "无";
                }
            }, {
                "aTargets": [9], //method
                "mRender": function(method, type, row) {
                    return repayMethod[method];
                }
            }, {
                "aTargets": [10], //Status
                "mRender": function(status, type, row) {
                    return fundStatus[status];
                }
            }, {
                "aTargets": [11], //Status
                "mRender": function(date, type, row) {
                    return (new Date(date)).Format("yyyy-MM-dd hh:mm");
                }
            }],
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

$(function() {
    var params = {
        startDate: '',
        endDate: '',
        status: 'UNASSIGNED',
    };
    $.post("loan/getLoanRequestList", params, function(requests) {
        initTable(requests);
    });
    $('[data-rel=tooltip]').tooltip();
});

$("#searchLoanRequestBtn").click(function() {
    var params = {
        startDate: '',
        endDate: '',
        status: $('select[name=loanRequestStatusSelect] option:selected').val(),
    };
    $.post("loan/getLoanRequestList", params, function(requests) {
        initTable(requests);
    });
});

//        "aoColumnDefs": [{
//                "aTargets": [4], //amount
//                "sType": 'amount'
//            }, {
//                "aTargets": [5], //Duration
//                "mRender": function(data, type, row) {
//                    return formatDuration(data);
//                }
//            }, {
//                "aTargets": [9], //Status
//                "mRender": function(data, type, row) {
//                    if (data == "未处理") {
//                        return '<span class="badge badge-grey">未处理</span>';
//                    } else if (data == "处理中") {
//                        return '<span class="badge badge-warning">处理中</span>';
//                    } else if (data == "已取消") {
//                        return '<span class="badge badge-grey">已取消</span>';
//                    } else if (data == "风控审核") {
//                        return '<span class="badge badge-info">风控审核</span>';
//                    } else if (data == "实地征信") {
//                        return '<span class="badge badge-info">实地征信</span>';
//                    } else if (data == "待批准") {
//                        return '<span class="badge badge-pink">待批准</span>';
//                    } else if (data == "已批准") {
//                        return '<span class="badge badge-success">已批准</span>';
//                    } else if (data == "已驳回") {
//                        return '<span class="badge badge-inverse">已驳回</span>';
//                    } else if (data == "已发放") {
//                        return '<span class="badge badge-info">已发放</span>';
//                    } else if (data == "已存档") {
//                        return '<span class="badge badge-purple">已存档</span>';
//                    } else if (data == "已删除") {
//                        return '<span class="badge badge-important">已删除</span>';
//                    }
//                }
//            }, {
//                "sType": 'duration',
//                "aTargets": [10], //Post date
//                "mRender": function(data, type, row) {
//                    return timeTillNow(parseInt(data)) + '<span class="hide">' + data + '</span>';
//                }
//            }],
function dynamicTable() {
    $('#loanList').dataTable({
        "bProcessing": true,
        "bServerSide": true,
        //"aaSorting": [[ 10, "asc" ]],
        "aoColumns": [
            {"mData": "title"},
            {"mData": "serial"},
            {"mData": "user"},
            {"mData": "purpose"},
            {"mData": "amount"},
            {"mData": "duration"},
            {"mData": "rate"},
            {"mData": "mortgaged"},
            {"mData": "method"},
            {"mData": "status"},
            {"mData": "timeSubmit"}
        ],
        "aoColumnDefs": [{
                "aTargets": [2], //title
                "mRender": function(user, type, row) {
                    return 'dd';//<a href="user/profile/' + user.id + '" target="_blank">' + user.loginName + '</a>';
                }
            }, {
                "aTargets": [3], //purpose
                "mRender": function(purpose, type, row) {
                    return loanPurpose[purpose];
                }
            }, {
                "aTargets": [4], //amount
                "mRender": function(amount, type, row) {
                    return '<span class="red bold">￥' + formatAmount(amount, 0) + '</span>';
                }
            }, {
                "aTargets": [5], //duration
                "mRender": function(duration, type, row) {
                    return duration.totalMonths + '个月';
                }
            }, {
                "aTargets": [9], //Status
                "mRender": function(data, type, row) {
                    return data;
                    if (data == "未处理") {
                        return '<span class="badge badge-grey">未处理</span>';
                    } else if (data == "处理中") {
                        return '<span class="badge badge-warning">处理中</span>';
                    } else if (data == "已取消") {
                        return '<span class="badge badge-grey">已取消</span>';
                    } else if (data == "风控审核") {
                        return '<span class="badge badge-info">风控审核</span>';
                    } else if (data == "实地征信") {
                        return '<span class="badge badge-info">实地征信</span>';
                    } else if (data == "待批准") {
                        return '<span class="badge badge-pink">待批准</span>';
                    } else if (data == "已批准") {
                        return '<span class="badge badge-success">已批准</span>';
                    } else if (data == "已驳回") {
                        return '<span class="badge badge-inverse">已驳回</span>';
                    } else if (data == "已发放") {
                        return '<span class="badge badge-info">已发放</span>';
                    } else if (data == "已存档") {
                        return '<span class="badge badge-purple">已存档</span>';
                    } else if (data == "已删除") {
                        return '<span class="badge badge-important">已删除</span>';
                    }
                }
            }],
        "sAjaxSource": "loan/getLoanRequestData",
        "oLanguage": {
            "sLengthMenu": "显示 _MENU_ 条记录",
            "sSearch": "搜索:",
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

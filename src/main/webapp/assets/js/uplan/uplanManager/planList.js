function getList(iData) {

    if (iData.status == '') {
        iData.status = '0'
    }
    $('#loanTabs li').eq(iData.status).addClass('active');

    $('#LOANS_LIST').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "aoColumns": [
            {"mData": "productName", "sDefaultContent" : ""},		//0 产品名称
            {"mData": "amount", "sDefaultContent" : ""},			//1 借款金额
            {"mData": "rate", "sDefaultContent" : ""},				//2 预期年化利率
            {"mData": "repaymentTypeKey", "sDefaultContent" : ""},	//3 还款方式
            {"mData": "repaymentDate", "sDefaultContent" : ""},		//4 还款时间
            {"mData": "progress", "sDefaultContent" : ""},			//5 投资进度
            {"mData": "bidNumbers", "sDefaultContent" : ""},		//6 投标数
            {"mData": "bidNumbers", "sDefaultContent" : ""},		//7 下载文件/查看记录
            {"mData": "freshPlan", "sDefaultContent" : ""}			//8 是否新手标
        ],
        "aoColumnDefs": [
            {
                "aTargets": [0], //uid link
                "mRender": function (data, type, full) {
                    return '<a href="/uplan/details/' + full.id + '/showAllInfos">' + data + '</a>';
                }
            }, {
                "aTargets": [1],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">￥ ' + formatAmount(data, 0) + '</span>'
                }
            },
            {
                "aTargets": [2],
                "mRender": function (data, type, full) {
                    return '<span class="red bold">' + parseInt(data + full.rateAdd) / 100 + "%" + '</span>'
                }
            }, 
            {
                "aTargets": [4],
               "mRender": function (data, type, row) {
                   return new Date(data).Format("yyyy-MM-dd");
                }
            }, {
                "aTargets": [5],
                "mRender": function (data, type, row) {
                    if (iData.status == "1") {
                    	return '未开始';
                    } else {
                        var htmlStr = '<div class="progress progress-striped active">' +
                            '<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:'+(parseFloat(data)*100).toFixed(2)+'%">' +
                            '<span>'+(parseFloat(data)*100).toFixed(2)+'%</span><span class="sr-only">40% Complete (success)</span>' +
                            '</div>' +
                            '</div>';
                        return htmlStr;
                    }
                }
            }, {
                "aTargets": [7],
                "mRender": function (data, type, row) {
                	var download =  '<a id="downloadBtn" href="/uplan/downloadForBatchOnPlan/' + row.id + '/" class="btn btn-primary btn-sm" title="文件下载">文件下载</a>';
                	var show =  '<a id="showBtn" href="/uplan/details/' + row.id + '/showInvestHistory" class="btn btn-info btn-sm" title="查看">查看</a>';
                	return '<div class="hidden-phone visible-desktop btn-group">' + download + show + '</div>';
                }
            }, {
                "aTargets": [8],
                "mRender": function (data, type, row) {
                	if (data) {
                		return "新手标";
                	}
                }
            }
        ],
        "fnDrawCallback": function (oSettings) {
            $("#searchRechargeHistory").html('查询');
            $("#searchRechargeHistory").prop('disabled', false);
        },
        "sAjaxSource": "/uplan/queryPlanListByCondition",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            aoData.push({
                "name": "status",
                "value": iData.status
            });
            aoData.push({
                "name": "pageNo",
                "value": iData.pageNo
            });
            aoData.push({
                "name": "pageSize",
                "value": iData.pageSize
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
}

var status = location.search.slice(1);
// 根据优选项目状态查询信息
getList({status: status});

// 选择不同状态时触发
$('#loanTabs li').click(function () {
    var sIndex = $(this).index();
    var href = '/uplan/planList?' + sIndex;
    location.replace(href)
});

// 借款列表下载
$('#downloadLoan').click(function() {
	if (status == '') {
		status = '0';
	}
	var href = '/uplan/downloadUplans/' + status;
    $(this).prop('href', href);
    return true;	
});
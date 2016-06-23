function getList() {
    $('#commonDataTable').dataTable({
        "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": true,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bSortable": false,
        "aoColumns": [
            {"mData": "type", "sDefaultContent" : ""}, 	//0 借款方式
            {"mData": "name", "sDefaultContent" : ""},	//1 借款人姓名
            {"mData": "idnumber", "sDefaultContent" : ""},	//2 借款人身份证号
            {"mData": "status", "sDefaultContent" : ""}, 	//3 还款状态
            {"mData": "startDate", "sDefaultContent" : ""},	//4 起始放款日期
            {"mData": "endDate", "sDefaultContent" : ""},	//5 还款日期
            {"mData": "timeLimit", "sDefaultContent" : ""},	//6 借款天数
            {"mData": "leftTime", "sDefaultContent" : ""},	//7 剩余天数
            {"mData": "amount", "sDefaultContent" : ""},	//8 借款金额
            {"mData": "rate", "sDefaultContent" : ""},		//9 预计年华收益率
            {"mData": "rateAdd", "sDefaultContent" : ""},	//10 补贴利率
            {"mData": "profession", "sDefaultContent" : ""}, //11 借款人职业情况
            {"mData": "purpose", "sDefaultContent" : ""},		//12 借款人借款用途
            {"mData": "remainAmount", "sDefaultContent" : ""},	//13 可用债权价值
            {"mData": "loanedPercent", "sDefaultContent" : ""}, //14 已转出债权百分比
            {"mData": "loanedAmount", "sDefaultContent" : ""},	//15 已出借金额
            {"mData": "productName", "sDefaultContent" : ""}	//16 债权归属
        ],
        "aoColumnDefs": [{
            "bSortable": false,
            "aTargets": [8],
            "mRender": function (data, type, row) {
                return '<span>￥ ' + formatAmount(data, 0) + '</span>'
            }
        }, {
            "bSortable": false,
            "aTargets": [13],
            "mRender": function (data, type, row) {
                return '<span>￥ ' + formatAmount(data, 0) + '</span>'
            }
        }, {
            "bSortable": false,
            "aTargets": [15],
            "mRender": function (data, type, row) {
                return '<span>￥ ' + formatAmount(data, 0) + '</span>'
            }
        }],
        "sAjaxSource": "/uplanLoan/listAvailableBySearch",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            for (var i = 0; i < aoData.length; i++) {
                if (aoData[i]['name'] == 'iSortCol_0') {
                    var cols = this.fnSettings().aoColumns;
                    var index = parseInt(aoData[i]['value']);
                    aoData.push({"name": "sColName", "value": cols[index]['mData']});
                    //break;
                }

                if (aoData[i]['name'] == 'sSearch') {
                    if (aoData[i]['value']) {
                    	$('#downloadLoan').attr('href', '/uplanLoan/download?sSearch=' + aoData[i]['value']);
                    }
                    else {
                        $('#downloadLoan').attr('href', '/uplanLoan/download');
                    }
                }
            }
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
getList();
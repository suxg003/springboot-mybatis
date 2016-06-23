var loanPar;
loanPar = {
    bbt: {
        aoColumns: [
            {"mData": "loaner", "sDefaultContent" : ""},//0
            {"mData": "loanTitle", "sDefaultContent" : ""},//1
            {"mData": "currentPeriod", "sDefaultContent" : ""},//2
            {"mData": "amountInterest", "sDefaultContent" : ""},//3
            {"mData": "loanerAvailableAmount", "sDefaultContent" : ""},//4
            {"mData": "dueDate", "sDefaultContent" : ""},//5
            {"mData": "repayStatus", "sDefaultContent" : ""},//6
            {"mData": "repayStatus", "sDefaultContent" : ""}
        ],
        aoColumnDefs: [{
            //"bSortable": false,
            "aTargets": [0], //loanerId link
            "mRender": function (data, type, row) {
                var loanerId = row.loanerId;
                return '<a href="/user/profile/?userId='+loanerId+'">'+data+'</a>';
            }
        },{
            //"bSortable": false,
            "aTargets": [1], //loanerId link
            "mRender": function (data, type, row) {
                var loanId = row.loanId;
                return '<a href="/loan/0/'+loanId+'">'+data+'</a>';
            }
        }, {
            //"bSortable": false,
            "aTargets": [2], //loanerId link
            "mRender": function (data, type, row) {
                return '第'+data+'期';
            }
        },{
            //"bSortable": false,
            "aTargets": [3], //loanerId link
            "mRender": function (data, type, row) {
                return formatAmount(data+row.amountPrincipal,2);
            }
        },{
            //"bSortable": false,
            "aTargets": [4], //loanerId link
            "mRender": function (data, type, row) {
                return formatAmount(data,2);
            }
        },{
            //"bSortable": false,
            "aTargets": [5], //loanerId link
            "mRender": function (data, type, row) {
                return (new Date(data)).Format("yyyy-MM-dd");
            }
        },{
            //"bSortable": false,
            "aTargets": [6], //loanerId link
            "mRender": function (data, type, row) {
                var dStr = '';
                if(data=='UNDUE'){
                    dStr='已到期';
                }else{
                    dStr=row.repayStatusKey;
                }
                return dStr;
            }
        },{
            //"bSortable": false,
            "aTargets": [7], //loanerId link
            "mRender": function (data, type, row) {
                var dStr = '';
                if(row.repayStatusKey=='未到期'){
                    dStr+='<div style="width:120px;margin-right:0;">';

                    if($('#POSTLOAN_REPAY')){
                        dStr+='<a class="btn btn-sm btn-success repay-btn" onclick="showConfirm(\'确定要还款【'+row.loanTitle+'】么？\'\,\'/postLoan/repay/BBT/'+row.id+'\')">还款</a>';
                    }

                    dStr+= '<span class="mx-tip-fa">\
                            <button class="btn btn-sm btn-yellow detail-btn">\
                            还款明细\
                            </button>\
                            <div class="tip-cell">\
                            <div class="x">\
                            <div class="content">\
                            <p>还款期数：<span class="red">第'+row.currentPeriod+'期</span></p>\
                            <p>应还本金：<span class="red">￥'+row.amountPrincipal+'</span></p>\
                            <p>应还利息：<span class="red">￥'+row.amountInterest+'</span></p>\
                            <p>剩余本金：<span class="red">￥'+row.amountOutStanding+'</span></p>\
                            </div>\
                            <div class="z">◆</div>\
                            <div class="y">◆</div>\
                            </div>\
                            </div>\
                            </span></div>';

                    return dStr;
                }
            }
        }
        ]
    },
    uplan: {
        aoColumns: [
            {"mData": "planerName", "sDefaultContent" : ""},//0
            {"mData": "productName", "sDefaultContent" : ""},//1
            {"mData": "currentPeriod", "sDefaultContent" : ""},//2
            {"mData": "totalPrincipal", "sDefaultContent" : ""},//3
            {"mData": "repaymentDate", "sDefaultContent" : ""},//4
            {"mData": "dueDate", "sDefaultContent" : ""},//5
            {"mData": "repayStatus", "sDefaultContent" : ""},//6
            {"mData": "productName", "sDefaultContent" : ""}
        ],
        aoColumnDefs: [{
            //"bSortable": false,
            "aTargets": [0], //uid link
            "mRender": function (data, type, row) {
                var uid = row.userId;
                return '<a href="/user/profile/?userId='+row.planerId+'">'+data+'</a>';
            }
        }, {
            //"bSortable": false,
            "aTargets": [1],
            "mRender": function (data, type, row) {
                return '<a href="/uplan/details/'+row.planId+'/showAllInfos">'+data+'</a>';
            }
        }, {
            //"bSortable": false,
            "aTargets": [2],
            "mRender": function (data, type, row) {
                return '第'+data+'期';
            }
        }, {
            //"bSortable": false,
            "aTargets": [3],
            "mRender": function (data, type, row) {
                return formatAmount(data+row.totalInterrest,2);
            }
        }, {
            //"bSortable": false,
            "aTargets": [4],
            "mRender": function (data, type, row) {
                return (new Date(data)).Format("yyyy-MM-dd")
            }
        }, {
            //"bSortable": false,
            "aTargets": [5],
            "mRender": function (data, type, row) {
                return '<a class="btn btn-sm btn-success repay-btn" onclick="showConfirm(\'确定要还款【'+row.productName+'】么？\'\,\'/postLoan/repay/UPLAN/'+row.planId+'\')">还款</a>';
            }
        }
        ]
    }
};

function showTodayList(loanType){
    var loanParam,loanTable;
    if(loanType=='BBT'){
        loanParam= loanPar.bbt;
        loanTable = $('#BBT-list');
    }else{
        loanParam= loanPar.uplan;
        loanTable = $('#UPLAN-list');
    }


    var oTable = loanTable.dataTable({
        "sDom": "flt<'row'<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        "paging": true,
        "searching": true,
        "aoColumns":loanParam.aoColumns ,
        "aoColumnDefs":loanParam.aoColumnDefs ,
        "sAjaxSource": "/postLoan/overdue/getData?type="+loanType,
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            for (var i = 0; i < aoData.length; i++) {
                if (aoData[i]['name'] == 'iSortCol_0') {
                    var cols = this.fnSettings().aoColumns;
                    var index = parseInt(aoData[i]['value']);
                    aoData.push({"name": "sColName", "value": cols[index]['mData']});
                }
                if(aoData[i]['name'] == 'sSearch') {
                    if (aoData[i]['value']) {
                        $('#link_download').attr('href', '/user/download?sSearch=' + aoData[i]['value']);
                    }
                    else {
                        $('#link_download').attr('href', '/user/download');
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
                "sPrevious": "上一页",
                "sNext": "下一页"
            }
        },
        "fnDrawCallback": function( oSettings ) {
            /** 还款明细 **/
            $('.detail-btn').on("click",function(){
                $(this).next('.tip-cell').css('display','block');
            });
            $('.detail-btn').on("mouseout",function(){
                $(this).next('.tip-cell').css('display','none');
            });
        }
    });
}



$('.nav-tabs li').on('click',function(){
    if($(this).index()==0){
        showTodayList('BBT');
    }else{
        showTodayList('UPLAN');
    }
});
showTodayList('BBT');

function showConfirm (str,strHref){
    bootbox.confirm(str, function (result) {
        if (result) {
            //return false;
            $.ajax({
                url:strHref,
                type:"GET",
                dataType:"JSON",
                data:{},
                success:function(data) {
                    if (data.success == '1')
                        location.reload();
                    else
                        Notify( data.comment, 'top-right', '5000', 'danger', 'fa-check', true);
                }
            });
        }
    });
}

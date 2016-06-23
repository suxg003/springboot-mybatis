/**
 * Created by lxl on 15/7/9.
 */
$(function () {
    $('#date-range-picker').daterangepicker({
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
        $('input[name=startDate]').val(start.format("YYYY-MM-DD"));
        $('input[name=endDate]').val(end.format("YYYY-MM-DD"));
    }).prev().on(ace.click_event, function () {
        $(this).next().focus();
    });

    var $dateRange = $('input[name=date-range-picker]');

    var oTable = $('#commonDataTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "iDisplayLength": 10,
        "aaSorting":[[6,"desc"]],
        "aoColumns": [
            {"mData": "userId"}, //0
            {"mData": "loginName"}, //1
            {"mData": "name"},//2
            {"mData": "mobile"},//3
            {"mData": "typeKey"}, //4
            {"mData": "subRegsourcetype"},
            {"mData": "registerDate"},//5
            {"mData": "lastLoginTime"},//6
            {"mData": "investAmount"},//7
            {"mData": "firstInvestAmount"},//8
            {"mData": "firstInvestTimeStr"},//9
            {"mData": "investCount"},//10
            {"mData": "countIn"},//11
            {"mData": "amountIn"},//12
            {"mData": "countOut"},//13
            {"mData": "amountOut"},//14
        ],
        "aoColumnDefs": [{
            "bSortable": false,
            "aTargets":[0]
        },{
            "bSortable": false,
            "aTargets":[1],
            "mRender": function (data, type, row) {
                var str = '<a href="/user/profile?userId='+row.userId+'" target="_blank">'+data+'</a>';
                return str;
            }
        },{
            "bSortable": false,
            "aTargets":[2]
        },{
            "bSortable": false,
            "aTargets": [3] //来源
        },{
            "bSortable": false,
            "aTargets": [4], //来源
            "mRender": function (data, type, row) {
                if(undefined==data){
                    return "";
                }else{
                    return data;
                }
            }
        }, {
            "bSortable": true,
            "aTargets": [6],
            "mRender": function (data, type, row) {
                if(!data){
                    return "";
                }
                return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
            }
        },{
            "aTargets":[7],
            "mRender": function (data, type, row) {
                if(!data){
                    return "";
                }
                return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
            }
        },{
            "bSortable": false,
            "aTargets":[5]
        }],
        "fnDrawCallback": function (oSettings) {
            $("#searchRechargeHistory").html('查询');
            $("#searchRechargeHistory").prop('disabled', false);
            // 显示序号
            for (var i = 0, iLen = oSettings.aiDisplay.length; i < iLen; i++) {
                $('td:eq(0)', oSettings.aoData[oSettings.aiDisplay[i]].nTr).html(oSettings['_iDisplayStart'] + i + 1);
            }
        },
        "sAjaxSource": "/promote/getPromoteRegisterUser",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            for (var i = 0; i < aoData.length; i++) {
                if (aoData[i]['name'] == 'iSortCol_0') {
                    var cols = this.fnSettings().aoColumns;
                    var index = parseInt(aoData[i]['value']);
                    aoData.push({"name": "sColName", "value": cols[index]['mData']});
                    //break;
                }
            }
            aoData.push({
                "name": "startDate",
                "value": $dateRange.val().split(' - ')[0]
            });
            aoData.push({
                "name": "endDate",
                "value": $dateRange.val().split(' - ')[1]
            });
            aoData.push({
                "name": "aSearch",
                "value": $('#aAccess').val()
            });
            aoData.push({
                "name": "bSearch",
                "value": $('#bAccess').val()
            });
            aoData.push({
                "name": "cSearch",
                "value": $('#userName').val()
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



    addCondition();


    $("#aAccess").click(function () {
        getAccess();
        return false;
    }).keyup(function () {
        getAccess();
    });
    $("#promoteForm").focus(function () {
        alert(11111);
        $("#promoteUl").css({display:"none"});
    });


    $('#searchRechargeHistory').click(function () {
        $("#searchRechargeHistory").html('<i class="icon-spin icon-spinner"></i> 查询中');
        $("#searchRechargeHistory").prop('disabled', true);
        oTable.fnPageChange('first');
    });
    $('#downloadHistoryBtn').click(function () {
        var $dateRangeP=$('#date-range-picker').val();
        var href = '/promote/register/downloadListAll?startDate=' + $dateRangeP.split(' - ')[0]+'&endDate='+$dateRangeP.split(' - ')[1]+'&sSearch='+$('#commonDataTable_filter input').val();
        $(this).prop('href', href);
    });

});
function addCondition(){
    var aAccess = "<label><input type='text' class='form-control input-sm' id='aAccess' placeholder='请输入主渠道'></label>";
    var bAccess = "<label><input type='text' class='form-control input-sm' id='bAccess' placeholder='请输入子渠道'></label>";
    var userName = "<label><input type='text' class='form-control input-sm' id='userName' placeholder='请输入用户名'></label>";
    var promoteUl = "<form id='promoteForm' style='display: block;position: relative'><ul id='promoteUl'></ul></form>";
    $("#commonDataTable_filter").append(aAccess);
    $("#commonDataTable_filter").append(bAccess);
    $("#commonDataTable_filter").append(userName);
    $("#commonDataTable_filter").append(promoteUl);
    $("#commonDataTable_filter").css({position:"relative"});
    $("#commonDataTable_filter label input").css({"margin-right":"10px"});
    $("#commonDataTable_filter label input[type=search]").css({display:"none"});
    $("#promoteUl").css({
        position:"absolute",
        left:0,
        top:"30px",
        margin:0,
        padding:0,
        width:'175px',
        "list-style":"none",
        "background":"#fff",
        "box-shadow":"0 0 5px 0 #000",
        "z-index":100
    });

    $("#aAccess").blur(function () {
        $("#promoteUl").html("");
        return false;
    });
}

function getAccess(){
    $.ajax({
        type:'POST',
        url:'/promote/registerResourceType',
        data:{"search":$("#aAccess").val()},
        dataType:'json',
        success:function(data){
            var promoteRes,promoteLi = "";
            promoteRes = data.resultList;
            for(var i = 0;i < promoteRes.length;i ++){
                promoteLi += "<li class='promoteLi' style='padding: 5px 8px;cursor:pointer'>" + promoteRes[i] + "</li>";
            }
            $("#promoteUl").html(promoteLi);
            $("#promoteUl").css({display:"block"});
            var resLis = $("#promoteUl li");
            for(var i = 0;i < resLis.length;i ++){
                (function () {
                    resLis[i].onmouseover = function () {
                        $(this).css({background:"#427fed"});
                    };
                    resLis[i].onmouseout = function () {
                        $(this).css({background:"#fff"});
                    };
                    resLis[i].onmousedown = function () {
                        $("#promoteUl").html("");
                        $("#aAccess").val($(this).html());
                        return true;
                    }

                })(i);
            }

        }
    });
}
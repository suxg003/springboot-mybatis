var userLink = '<a href="user/profile/$uid" target="_blank">$loginName</a>';
//日历
$('#date-range-picker').daterangepicker({
    format: 'YYYY-MM-DD'
});
var $dateRange = $('input[name=date-range-picker]');
var users = {};
var oTable = $('#commonDataTable').dataTable({
    "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
    "bProcessing": true,
    "bServerSide": true,
    "bSort": true,
    "bFilter": true,
    "iDisplayLength": 10,
    "aoColumns": [
        {"mData": "id"}, //0
        {"mData": "balance"}, //1
        {"mData": "availableBalance"}, //2
        {"mData": "giftPercent"}, //3
        {"mData": "cardTypeKey"}, //4
        {"mData": "loginName"}, //5
        {"mData": "enabled"}, //6
        {"mData": "startTime"}, //7startTime
        {"mData": "endTime"}, //8
        {"mData": "enabled"}, //9
    ],
    "aoColumnDefs": [{
        "bSortable": false,
        "aTargets":[0],
        "mRender":function(data){
            return '<a href="/user/giftrecord/'+data+'">#' + data + '</a>';
        }
    },{
        "bSortable": false,
        "aTargets":[1]
    },{
        "bSortable": false,
        "aTargets":[2]
    },{
        "bSortable": false,
        "aTargets":[3],
        "mRender":function(data){
            return data+'%';
        }
    },{
        "bSortable": false,
        "aTargets":[4]
    },{
        "bSortable": false,
        "aTargets":[5],
        "mRender":function(data, type, row){
            var str = data.length>0?data:row.loginName;
            return '<a href="/user/profile/?userId='+row.userId+'" target="_blank">'+str+'</a>'
        }
    },{
        "bSortable": false,
        "aTargets":[6],
        "mRender":function(data){
            return data==1?'<span data-field="enable" class="green">可用</span>':'<span data-field="enable" class="red">不可用</span>'
        }
    },{
        "bSortable": false,
        "aTargets": [7], //来源
        "mRender": function (data) {
            var date = new Date(data);
            return date.Format('yyyy-MM-dd hh:mm:ss');
        }
    }, {
        "aTargets": [8], //注册日期
        "mRender": function (data) {
            var date = new Date(data);
            return date.Format('yyyy-MM-dd hh:mm:ss');
        }
    }, {
        "aTargets": [9],
        "mRender": function(data, type, row) {
            var html = '';
            if(data){
                html = '<a class="btn btn-danger" data-action="do-disable" data-confirm="确定要禁用该红包吗？" data-id="'+row['id']+'">禁用</a>';
            }
            else{
                html = '<a class="btn btn-primary" data-action="do-enable" data-confirm="确定要启用该红包吗？" data-id="'+row['id']+'">启用</a>';
            }
            return html;
        }
    }],
    "fnDrawCallback": function (oSettings) {
        $("#searchRechargeHistory").html('查询');
        $("#searchRechargeHistory").prop('disabled', false);
        // 显示序号
//                for (var i = 0, iLen = oSettings.aiDisplay.length; i < iLen; i++) {
//                    $('td:eq(0)', oSettings.aoData[oSettings.aiDisplay[i]].nTr).html(oSettings['_iDisplayStart'] + i + 1);
//                }

        $('#commonDataTable a[data-action]').bind('click', function(e){
            var self = this;
            var action = this.getAttribute('data-action');
            var id = this.getAttribute('data-id');
            var confirmStr = this.getAttribute('data-confirm');
            if(confirmStr && !confirm(confirmStr))
                return;

            function myCallback(data){
                if(!data.success){
                    $.gritter.add({'title':'操作失败','text':data.comment});
                    return;
                }

                //刷新table
                if(action=='do-disable') {
                    self.setAttribute('data-action', 'do-enable');
                    self.setAttribute('data-confirm', '确定要启用该启用包吗？');
                    $(self).removeClass('btn-danger').addClass('btn-primary').html('启用');
                    $(self).closest('tr').find('span[data-field=enable]').removeClass('grenn').addClass('red').html('不可用');
                }else {
                    self.setAttribute('data-action', 'do-disable');
                    self.setAttribute('data-confirm', '确定要禁用该红包吗？');
                    $(self).removeClass('btn-primary').addClass('btn-danger').html('禁用');
                    $(self).closest('tr').find('span[data-field=enable]').removeClass('red').addClass('green').html('可用');
                }
            }

            //do
            switch(action)
            {
                case 'do-enable':
                    $.ajax({
                        "dataType": 'json',
                        "type": "POST",
                        "url": "/user/updateCardEnableStatus",
                        "data": {'id':id, 'enabled':true},
                        "success": myCallback,
                        "error": function () {
                            console.log('error');
                        }
                    });
                    break;
                case 'do-disable':
                    $.ajax({
                        "dataType": 'json',
                        "type": "POST",
                        "url": "/user/updateCardEnableStatus",
                        "data": {'id':id, 'enabled':false},
                        "success": myCallback,
                        "error": function () {
                            console.log('error');
                        }
                    });
                    break;
            }
        });
    },
    "sAjaxSource": "/user/listAllGiftcard",
    "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
        aoData.push({
            "name": "startDate",
            "value": $dateRange.val().split(' - ')[0]
        });
        aoData.push({
            "name": "endDate",
            "value": $dateRange.val().split(' - ')[1]
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

$('#searchRechargeHistory').click(function () {
    $("#searchRechargeHistory").html('<i class="icon-spin icon-spinner"></i> 查询中');
    $("#searchRechargeHistory").prop('disabled', true);
    oTable.fnPageChange('first');
});
$('#downloadHistoryBtn').click(function () {
	var $dateRangeP=$('#date-range-picker').val();
    var href = '/reward/downGiftCards?startDate=' + $dateRangeP.split(' - ')[0]+'&endDate='+$dateRangeP.split(' - ')[1]+'&sSearch='+$('#commonDataTable_filter input').val();
    $(this).prop('href', href);
});

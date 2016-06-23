
var oTable = $('#commonDataTable').dataTable({
    "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
    "bProcessing": true,
    "bServerSide": true,
    "bSort": true,
    "bFilter": true,
    "aoColumns": [
        {"mData": "loginName"}, //0
        {"mData": "userName"}, //1
        {"mData": "userMobile"}, //2
        {"mData": "referralCount"}/*   , //3
        {"mData": "id"}  */
    ],
    "aoColumnDefs": [{
        "aTargets": [0], //uid link
        "mRender": function (data, type, row) {
            var uid = row.userId;
            var ulname = row.loginName;
            return '<a href="/reward/referral/detail/'+ ulname +'/'+ uid +'">' + data + '</a>';
        }
    }],
    "fnDrawCallback": function (oSettings) {            	
        $("#searchRechargeHistory").html('查询');
        $("#searchRechargeHistory").prop('disabled', false);
        // 显示序号
        /* for (var i = 0, iLen = oSettings.aiDisplay.length; i < iLen; i++) {
            $('td:eq(0)', oSettings.aoData[oSettings.aiDisplay[i]].nTr).html(oSettings['_iDisplayStart'] + i + 1);
        } */

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
                        "type": "GET",
                        "url": "/reward/referrals",
                        "data": {'enabled':true},
                        "success": myCallback,
                        "error": function () {
                            console.log('error');
                        }
                    });
                    break;
                case 'do-disable':
                    $.ajax({
                        "dataType": 'json',
                        "type": "GET",
                        "url": "/reward/referrals",
                        "data": {'enabled':false},
                        "success": myCallback,
                        "error": function () {
                            console.log('error');
                        }
                    });
                    break;
            }
        });
    },
    "sAjaxSource": "/reward/referrals",
    "fnServerData": function (sSource, aoData, fnCallback, oSettings) {            	
        /* aoData.push({
            "name": "startDate",
            "value": $dateRange.val().split(' - ')[0]
        });
        aoData.push({
            "name": "endDate",
            "value": $dateRange.val().split(' - ')[1]
        });  */
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
    (function(){
        'use strict';

        $('.approveBtn').click(function () {
            var self = $(this);
            self.prop('disabled', true);
            $('#prosessingPanel').modal('show');
            $.get($(this).data("url"), function (res) {
                self.prop('disabled', false);
                if (res) {
                    alert("批准成功！");
                    location.reload();
                } else {
                    alert("批准失败！");
                }
                $('#prosessingPanel').modal('hide');
            }).fail(function () {
                self.prop('disabled', false);
                alert('批准失败：网络错误');
            });
        });
        $('.rejectBtn').click(function () {
            $('#prosessingPanel').modal('show');
            $.get($(this).data("url"), function (res) {
                if (res) {
                    alert("申请已被驳回！");
                    location.reload();
                } else {
                    alert("申请驳回失败！");
                }
                $('#prosessingPanel').modal('hide');
            });
        });
        $('.cancelBtn').click(function () {
            $('#prosessingPanel').modal('show');
            $.get($(this).data("url"), function () {
                location.reload();
            });
        });
        $('select.forCard').change(function () {
            var card = $(this).children('option:selected').val(), parant = $(this).data('for');
            $(parant + ' .cardType').text(accounts[card].name);
            $(parant + ' .available').data('amount', accounts[card].available);
            $(parant + ' .available').text('￥' + formatAmount(accounts[card].available, 2));
            $(parant + ' .balance').text('￥' + formatAmount(accounts[card].balance, 2));
            $(parant + ' .frozen').text('￥' + formatAmount(accounts[card].frozen, 2));
        });
        //////////////////////////////////////////////////////////////////////////////////////////////////
        // 用户转账
        //////////////////////////////////////////////////////////////////////////////////////////////////
        //$(".chzn-select").chosen();
        var userTransferAmount = $("input[name=userTransferValue]");
        userTransferAmount.focus(function () {
            var value = $(this).val();
            $(this).val(value.replace(/\,/g, ""));
        });
        userTransferAmount.blur(function () {
            //validateAmount($(this));
        });
        $('#resetUserTransferValue').click(function () {
            userTransferAmount.val(0);
        });
        $('#userTransferPanel .btn').click(function () {
            location.reload();
        });

        function changeStatus(uid, data) {
            if (data.success) {
                $('#uid-' + uid + ' .status').html('<i class="icon-ok-sign"></i>'+ data.comment).addClass('green');
            } else {
                $('#uid-' + uid + ' .status').html('<i class="icon-remove-sign"></i> '+ data.comment).addClass('red');
            }
        }
        // 提交用户转账表单
        $("#userTransferBtn").click(function () {
            var loginName = $.trim($('#userSelection').val());
            var loginNameID=loginName.replace(/[^a-zA-Z0-9]/g,'');
            if (loginName == '') {

                //alert('请选择要转入的用户！');
                $('#userSelection').focus();
                return;
            }

            var amount = $.trim(userTransferAmount.val());
            if (!amount || amount == "0") {
                userTransferAmount.focus();
                userTransferAmount.addClass("text-error");
                return;
            }

            var userTransferOutAcct = $('#userTransferOutCard select').children('option:selected').val();
            if (!userTransferOutAcct) {
                alert('请选择转出账户！');
                return;
            }

            var need = parseFloat(userTransferAmount.val()), left = parseFloat($('#userTransferOutCard .available').data('amount'));
            if (need > left) {
                alert('商户余额不足！');
                return;
            }

          /*  $('#userContainer').html('');
            for (var i = 0; i < 1; i++) {
                var temp = $('#userTemplate').html().replace('$user', $('#UID-' + loginNameID).text()).replace('$id', loginNameID);
                $(temp).appendTo($('#userContainer'));
            }
            $('#userTransferPanel #userNum').text(1);
            $('#userTransferPanel').modal({'backdrop': 'static'});*/

            $("#userTransferBtn").prop('disabled', true);
            $.post('/fund/transfer/request', {
                'type': $('#transferType').val(),
                'loginName': loginName,
                'description': $('#descriptioninfo').val(),
                'amount': userTransferAmount.val().replace(/\,/g, "")
            }, function (res) {
                $("#userTransferBtn").prop('disabled', false);
                var resData=res.data;
                console.log("res" + res);
                alert(res.comment);

                $('#userSelection').val('');
                userTransferAmount.val('0');
                $('#descriptioninfo').val('');

                //查询一次
                query();
/*
                console.log("resData" + resData);
                resData=resData.replace(/[^a-zA-Z0-9]/g,'');
                changeStatus(resData, res);*/

            }, 'json').error(function () {
                $("#userTransferBtn").prop('disabled', false);
                console.log(loginName, 'failed');
            });
        });

        //日历
    //    $('#reservation').daterangepicker();

        window.onload=function(){
            var aInput=document.getElementById('Untreated_accounts').getElementsByTagName("input");
            aInput[0].onclick=function(){
                for(var i=1;i<aInput.length;i++){
                    aInput[i].checked=this.checked;
                }
            };

            for(var i=1;i<aInput.length;i++){
                aInput[i].onclick=function(){
                    var n=0;
                    for(var i=1;i<aInput.length;i++){
                        if(aInput[i].checked){
                            n++;
                        }
                    }
                    if(n==aInput.length-1)
                    {
                        aInput[0].checked=true;
                    }
                    else
                    {
                        aInput[0].checked=false;
                    }


                }
            }
            $('#rangeDate').daterangepicker({
                format: 'YYYY-MM-DD',
                opens: 'left',
                ranges: {
                    '今天': [moment(), moment()],
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
            }, function(start, end) {
            //    $('#reservation').val(start.format("YYYY-MM-DD")+' - '+ end.format("YYYY-MM-DD"));
            }).prev();

            $('#rangeDate').val(moment().subtract('days', 29).format("YYYY-MM-DD")+' - '+moment().format("YYYY-MM-DD"));
            
        };

        var isSync = false;

        //批量提交 : 单个提交也调用这个，传id
        function batchDeal(op, id){

            if(isSync) return;

            var idArr = [];

            if(id){
                idArr.push(id);
            }
            else {
                $('#Untreated_accounts .check_each').each(function (ix) {
                    if (!this.checked) return;
                    idArr.push($(this).attr('data-id'));
                });
            }

            if(idArr.length==0){
                alert('未选择任何记录');
                return;
            }

            var ids = idArr.join(',');
            isSync = true;

            $.post('/fund/transfer/auditTransferBatch', {
                'idsStr': ids,
                'status': op
            }, function (res) {
                isSync = false;
                if(!res.success){
                    alert(res.comment||'操作失败');
                    return;
                }
                //changeStatus(resData, res);
                //alert('操作成功');
                //query();
                window.location = location.href;
            },'json').error(function () {
                isSync = false;
            });
        }

        $('#link_audit_all').bind('click', function(){
            if(!confirm('确定全部审批?')) return;
            batchDeal('SUCCESSFUL');
        });

        $('#link_audit_refuse').bind('click', function(){
            if(!confirm('确定全部拒绝?')) return;
            batchDeal('REFUSE');
        });

        $('#link_audit_cancel').bind('click', function(){
            if(!confirm('确定全部取消?')) return;
            batchDeal('CANCELED');
        });
        
        // 查询
        $('#findTranserBtn').bind('click', function() {
        	query();
        });

        $('#check_all').bind('click',function(){
            $('input.check_each').prop('checked', $(this).prop('checked'));
        });

        function query() {
        	$('#Untreated_accounts').dataTable({
                "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "bProcessing": true,
                "bServerSide": true,
                "bSort": false,
                "bFilter": true,
                "bSortable": false,
                "bDestroy":true,
                "aoColumns": [
                    {"mData": "id", "sDefaultContent": ""}, //0
                    {"mData": "id", "sDefaultContent": ""}, //1
                    {"mData": "userLoginName", sDefaultContent: ""},  //2
                    {"mData": "userName", sDefaultContent : ""},  //3
                    {"mData": "amount"},                          //4
                    {"mData": "changeTypeName"},                  //5
                    {"mData": "statusName"},                      //6
                    {"mData": "description"},                     //7
                    {"mData": "recordTime"},                      //8
                    {"mData": "employeeName"},                    //9
                    {"mData": "id"}                          //10
                ],
                "aoColumnDefs": [{
                    "bSortable": false,
                    "aTargets": [0],
                    "mRender": function (data, type, full) {
                        return '<div class="checkbox"><label><input type="checkbox" class="check_each" name="recordInfos" data-id="' + full.id + '" /><span class="text">&nbsp;</span></label></div>';
                    }
                },{
                    "bSortable": false,
                    "aTargets": [8],
                    "mRender": function (data, type, full) {
                    	return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                    }
                }, {
                    "bSortable": false,
                    "aTargets": [10],
                    "mRender": function (data, type, full) {
                    	if($("#USER_TRANSFER_AUDIT").val()!=undefined){
                    		return '<cm:securityTag privilegeString="USER_TRANSFER_AUDIT"><a data-command="SUCCESSFUL" data-id="'+data+'" class="btn btn-sm btn-blue">批准</a>\
                            <a data-command="REFUSE" data-id="'+data+'" class="btn btn-sm btn-danger">拒绝</a>\
                            <a data-command="CANCELED" data-id="'+data+'" class="btn btn-sm btn-default">取消</a></cm:securityTag>';
                    	}else{
                    		return '';
                    	}
                        
                    }
                }],
                "sAjaxSource": "/fund/transfer/requestList",
                "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
                	var rangeDate = $.trim($('#rangeDate').val());
                    for (var i = 0; i < aoData.length; i++) {
                        if (aoData[i]['name'] == 'iSortCol_0') {
                            var cols = this.fnSettings().aoColumns;
                            var index = parseInt(aoData[i]['value']);
                            aoData.push({"name": "sColName", "value": cols[index]['mData']});
                        }
                    }
                    aoData.push({
                        "name": "startDate",
                        "value": rangeDate.split(' - ')[0]
                    });
                    aoData.push({
                        "name": "endDate",
                        "value": rangeDate.split(' - ')[1]
                    });
                    aoData.push({
                    	"name": "type",
                    	"value": ""
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
                    var downParams = [];
                    for (var i = 0; i < aoData.length; i++) {
                        //if (aoData[i]['name'] == 'iSortCol_0') {
                        //    var cols = this.fnSettings().aoColumns;
                        //    var index = parseInt(aoData[i]['value']);
                        //    aoData.push({"name": "sColName", "value": cols[index]['mData']});
                        //    //break;
                        //}

                        if (aoData[i]['name'] == 'sSearch' || aoData[i]['name'] == 'startDate'
                            || aoData[i]['name'] == 'endDate' || aoData[i]['name'] == 'type') {
                            downParams.push(aoData[i]['name'] + '=' + aoData[i]['value']);
                        }
                    }
                    $('#transerReqBtn').attr('href', '/fund/transfer/requestDown?' + downParams.join('&'));

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
                fnCreatedRow: function(nRow, aData, iDataIndex) {
                    $('td:eq(1)', nRow).html(iDataIndex + 1);

                    $('a[data-command]', nRow).bind('click', function(){
                        if(!confirm('确定'+ $(this).html()+'?')) return;
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
        }

        query();
        
    })();
function getList(iData){
	//  status 0 OPENED、1 INITIATED、2 SCHEDULED、3 FINISHED、4 SETTLED、5 FAILED、6 CANCELED、7 CLEARED、8 OVERDUE、
	// 9 BREACH、10 ARCHIVED
	    
		if(iData.status==''){
			iData.status='0'
		}		
		$('#loanTabs li').eq(iData.status).addClass('active');
		$('#downloadLoan').attr('href','/loan/download/'+iData.status);
		var th='';
		th+='<tr>\
            <th><i class="icon-tag"></i> 标题</th>\
            <th><i class="hidden-480"></i> 借款人</th>\
            <th class="hidden-480">借款金额</th>\
            <th><i class="fa fa-money"></i> 借款用途</th>\
            <th class="hidden-480">年化利率</th>\
            <th class="">借款期限</th>\
            <th class="hidden-480"><i class="fa fa-calendar"></i> 还款方式</th>\
			<th><i class="fa fa-clock-o"></i> 抵押品</th>\
			<th><i class="fa fa-clock-o"></i> 开标时间</th>';
			if(iData.status=='0'||iData.status=='1'||iData.status=='4'||iData.status=='5'||iData.status=='7'||iData.status=='8'){
				th+="<th><i class='fa fa-clock-o'></i> 投标进度</th>";
			}
			if(iData.status=='0'||iData.status=='1'||iData.status=='4'||iData.status=='5'||iData.status=='7'||iData.status=='8'){
				th+='<th><i class="fa fa-clock-o"></i> 投标数</th>';
			}
			if(iData.status=='4'||iData.status=='5'){
				th+='<th><i class="fa fa-clock-o"></i>满标时间</th>';
			}
			if(iData.status=='5'||iData.status=='6'||iData.status=='9'||iData.status=='10'){
				th+='<th><i class="fa fa-clock-o"></i>结算时间</th>';
			}
			if(iData.status=='6'||iData.status=='9'||iData.status=='10'){
				th+='<th><i class="fa fa-clock-o"></i>还清时间</th>';
			}
			if(iData.status=='2'||iData.status=='6'||iData.status=='9'||iData.status=='10'){
				th+='<th><i class="fa fa-clock-o"></i> 操作</th>';
			}
		$('#list_th').html(th);
		if(iData.status=='0'||iData.status=='1'||iData.status=='7'||iData.status=='8'){
            var oTable = $('#LOANS_LIST').dataTable({
                "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "iDisplayLength": 10,
                "bProcessing": true,
                "bServerSide": true,
                "bSort": false,
                "bFilter": true,
                "bPaginate": true,
				"bRetrieve": true,
				"aaSorting":[[2,"desc"]],
                "aoColumns": [
                    {"mData": "title"},
                    {"mData": "loanName"},
                    {"mData": "loanAmount"},
                    {"mData": "purpose"},
                    {"mData": "rate"},
                    {"mData": "duration"},
                    {"mData": "repayMethod"},
                    {"mData": "mortgaged"},
                    {"mData": "timeOpen"},
                    {"mData": "process"},
                    {"mData": "investedNumber"}
                ],
                "aoColumnDefs": [
                    {
                        "aTargets": [0], //uid link
                        "mRender": function (data, type, row) {
							if(iData.status!=1){
								return '<a target="_blank" href="/loan/'+ iData.status +'/'+row.loanId+'">' + data + '</a>';
							}else{
								return '<a target="_blank" href="/loan/'+ iData.status +'/'+row.requestId+'">' + data + '</a>';
							}
                        }
                    },
                    {
                        "aTargets": [2], //uid link
                        "mRender": function (data, type, row) {
                            return '<span class="red bold">￥' + formatAmount(data) + '</span>';
                        }
                    },
					{
						"aTargets": [2], //uid link
						"mRender": function (data, type, row) {
							return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
						}
					},
					{
						"aTargets": [8], //uid link
						"mRender": function (data, type, row) {
							if(iData.status!=1&&undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					},
					{
						"aTargets": [9], //uid link
						"mRender": function (data, type, row) {
							if(iData.status!=1){
								return '<div class="progress progress-striped active">\
									<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: '+data+'%">\
									<span style="color:white;text-align:center;"><b>\
										'+data+'%\
									</b></span>\
									</div>\
									</div>';
							}else {
								return '未开始'
							}

						}
					},
					{
						"aTargets": [10], //uid link
						"mRender": function (data, type, row) {
							if(iData.status==1){
								return '0'
							}else{
								return data
							}
						}
					}
                ],
                "fnDrawCallback": function (oSettings) {
                    $("#searchRechargeHistory").html('查询');
                    $("#searchRechargeHistory").prop('disabled', false);
                },
                "sAjaxSource": "/loan/loanStatus/"+iData.status,
                "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
					$('#downloadLoan').attr('href','/loan/download/'+iData.status+'?search='+getSearchVal(aoData));
					aoData.push({
						"name": "status",
						"value": iData.status
					});
                    oSettings.jqXHR = $.ajax({
                        "dataType": 'json',
                        "type": "GET",
                        "url": sSource,
                        "data": aoData,
                        "success": fnCallback,
                        "error": function () {
                            console.log('error'+aoData);
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
		if(iData.status=='2'){
			var oTable = $('#LOANS_LIST').dataTable({
				"sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
				"iDisplayLength": 10,
				"bProcessing": true,
				"bServerSide": true,
				"bSort": false,
				"bFilter": true,
				"bPaginate": true,
				"bRetrieve": true,
				"aaSorting":[[2,"desc"]],
				"aoColumns": [
					{"mData": "title"},
					{"mData": "loanName"},
					{"mData": "loanAmount"},
					{"mData": "purpose"},
					{"mData": "rate"},
					{"mData": "duration"},
					{"mData": "repayMethod"},
					{"mData": "mortgaged"},
					{"mData": "timeOpen"},
					{"mData": "operation"}
				],
				"aoColumnDefs": [
					{
						"aTargets": [0], //uid link
						"mRender": function (data, type, row) {
							return '<a href="/loan/'+ iData.status +'/'+row.loanId+'">' + data + '</a>';
						}
					},
                    {
                        "aTargets": [2], //uid link
                        "mRender": function (data, type, row) {
                            return '<span class="red bold">￥' + formatAmount(data) + '</span>';
                        }
                    },
					{
						"aTargets": [2], //uid link
						"mRender": function (data, type, row) {
							return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
						}
					},
					{
						"aTargets": [8], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					},{
						"aTargets": [9], //uid link
						"mRender": function (data, type, row) {
							return "<button onclick='location.href=&quot;/loan/schedule&quot;'>重新调度</button>";
							//return "<button onclick='javascript:location.href=&quot;/loan/schedule&quot;'>重新调度</button><button onclick='javascript:location.href=&quot;/loan/cancel/"+row.loanId+"&quot;'>取消</button>";
						}
					}
				],
				"fnDrawCallback": function (oSettings) {
					$("#searchRechargeHistory").html('查询');
					$("#searchRechargeHistory").prop('disabled', false);
				},
				"sAjaxSource": "/loan/loanStatus/"+iData.status,
				"fnServerData": function (sSource, aoData, fnCallback, oSettings) {
					$('#downloadLoan').attr('href','/loan/download/'+iData.status+'?search='+getSearchVal(aoData));
					aoData.push({
						"name": "status",
						"value": iData.status
					});
					oSettings.jqXHR = $.ajax({
						"dataType": 'json',
						"type": "GET",
						"url": sSource,
						"data": aoData,
						"success": fnCallback,
						"error": function () {
							console.log('error'+aoData);
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
		if(iData.status=='3'){
			var oTable = $('#LOANS_LIST').dataTable({
				"sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
				"iDisplayLength": 10,
				"bProcessing": true,
				"bServerSide": true,
				"bSort": false,
				"bFilter": true,
				"bPaginate": true,
				"bRetrieve": true,
				"aaSorting":[[2,"desc"]],
				"aoColumns": [
					{"mData": "title"},
					{"mData": "loanName"},
					{"mData": "loanAmount"},
					{"mData": "purpose"},
					{"mData": "rate"},
					{"mData": "duration"},
					{"mData": "repayMethod"},
					{"mData": "mortgaged"},
					{"mData": "timeOpen"}
				],
				"aoColumnDefs": [
					{
						"aTargets": [0], //uid link
						"mRender": function (data, type, row) {
							return '<a target="_blank"  href="/loan/'+ iData.status +'/'+row.loanId+'">' + data + '</a>';
						}
					},
                    {
                        "aTargets": [2], //uid link
                        "mRender": function (data, type, row) {
                            return '<span class="red bold">￥' + formatAmount(data) + '</span>';
                        }
                    },
					{
						"aTargets": [2], //uid link
						"mRender": function (data, type, row) {
							return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
						}
					},
					{
						"aTargets": [8], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					}
				],
				"fnDrawCallback": function (oSettings) {
					$("#searchRechargeHistory").html('查询');
					$("#searchRechargeHistory").prop('disabled', false);
				},
				"sAjaxSource": "/loan/loanStatus/"+iData.status,
				"fnServerData": function (sSource, aoData, fnCallback, oSettings) {
					$('#downloadLoan').attr('href','/loan/download/'+iData.status+'?search='+getSearchVal(aoData));
					aoData.push({
						"name": "status",
						"value": iData.status
					});
					oSettings.jqXHR = $.ajax({
						"dataType": 'json',
						"type": "GET",
						"url": sSource,
						"data": aoData,
						"success": fnCallback,
						"error": function () {
							console.log('error'+aoData);
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
		if(iData.status=='4'){
			var oTable = $('#LOANS_LIST').dataTable({
				"sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
				"iDisplayLength": 10,
				"bProcessing": true,
				"bServerSide": true,
				"bSort": false,
				"bFilter": true,
				"bPaginate": true,
				"bRetrieve": true,
				"aaSorting":[[2,"desc"]],
				"aoColumns": [
					{"mData": "title"},
					{"mData": "loanName"},
					{"mData": "loanAmount"},
					{"mData": "purpose"},
					{"mData": "rate"},
					{"mData": "duration"},
					{"mData": "repayMethod"},
					{"mData": "mortgaged"},
					{"mData": "timeOpen"},
					{"mData": "process"},
					{"mData": "investedNumber"},
					{"mData": "timeFinished"}
				],
				"aoColumnDefs": [
					{
						"aTargets": [0], //uid link
						"mRender": function (data, type, row) {
							return '<a target="_blank" href="/loan/'+ iData.status +'/'+row.loanId+'">' + data + '</a>';
						}
					},
                    {
                        "aTargets": [2], //uid link
                        "mRender": function (data, type, row) {
                            return '<span class="red bold">￥' + formatAmount(data) + '</span>';
                        }
                    },
					{
						"aTargets": [2], //uid link
						"mRender": function (data, type, row) {
							return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
						}
					},
					{
						"aTargets": [8], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					},{
						"aTargets": [9], //uid link
						"mRender": function (data, type, row) {
							return '<div class="progress progress-striped active">\
									<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: '+data+'%">\
									<span style="color:white;text-align:center;"><b>\
										'+data+'%\
									</b></span>\
									</div>\
									</div>';
						}
					},
					{
						"aTargets": [11], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					}
				],
				"fnDrawCallback": function (oSettings) {
					$("#searchRechargeHistory").html('查询');
					$("#searchRechargeHistory").prop('disabled', false);
				},
				"sAjaxSource": "/loan/loanStatus/"+iData.status,
				"fnServerData": function (sSource, aoData, fnCallback, oSettings) {
					$('#downloadLoan').attr('href','/loan/download/'+iData.status+'?search='+getSearchVal(aoData));
					aoData.push({
						"name": "status",
						"value": iData.status
					});
					oSettings.jqXHR = $.ajax({
						"dataType": 'json',
						"type": "GET",
						"url": sSource,
						"data": aoData,
						"success": fnCallback,
						"error": function () {
							console.log('error'+aoData);
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
		if(iData.status=='5'){
			var oTable = $('#LOANS_LIST').dataTable({
				"sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
				"iDisplayLength": 10,
				"bProcessing": true,
				"bServerSide": true,
				"bSort": false,
				"bFilter": true,
				"bPaginate": true,
				"bRetrieve": true,
				"aaSorting":[[2,"desc"]],
				"aoColumns": [
					{"mData": "title"},
					{"mData": "loanName"},
					{"mData": "loanAmount"},
					{"mData": "purpose"},
					{"mData": "rate"},
					{"mData": "duration"},
					{"mData": "repayMethod"},
					{"mData": "mortgaged"},
					{"mData": "timeOpen"},
					{"mData": "process"},
					{"mData": "investedNumber"},
					{"mData": "timeFinished"},
					{"mData": "timeSettled"}
				],
				"aoColumnDefs": [
					{
						"aTargets": [0], //uid link
						"mRender": function (data, type, row) {
							return '<a target="_blank" href="/loan/'+ iData.status +'/'+row.loanId+'">' + data + '</a>';
						}
					},

					{
						"aTargets": [2], //uid link
						"mRender": function (data, type, row) {
							return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
						}
					},
					{
						"aTargets": [8], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					},{
						"aTargets": [9], //uid link
						"mRender": function (data, type, row) {
							return '<div class="progress progress-striped active">\
									<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: '+data+'%">\
									<span style="color:white;text-align:center;"><b>\
										'+data+'%\
									</b></span>\
									</div>\
									</div>';
						}
					},{
						"aTargets": [11], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					},
					{
						"aTargets": [12], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					}
				],
				"fnDrawCallback": function (oSettings) {
					$("#searchRechargeHistory").html('查询');
					$("#searchRechargeHistory").prop('disabled', false);
				},
				"sAjaxSource": "/loan/loanStatus/"+iData.status,
				"fnServerData": function (sSource, aoData, fnCallback, oSettings) {
					$('#downloadLoan').attr('href','/loan/download/'+iData.status+'?search='+getSearchVal(aoData));
					aoData.push({
						"name": "status",
						"value": iData.status
					});
					oSettings.jqXHR = $.ajax({
						"dataType": 'json',
						"type": "GET",
						"url": sSource,
						"data": aoData,
						"success": fnCallback,
						"error": function () {
							console.log('error'+aoData);
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
		if(iData.status=='6'||iData.status=='9'||iData.status=='10'){
			var oTable = $('#LOANS_LIST').dataTable({
				"sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
				"iDisplayLength": 10,
				"bProcessing": true,
				"bServerSide": true,
				"bSort": false,
				"bFilter": true,
				"bPaginate": true,
				"bRetrieve": true,
				"aaSorting":[[2,"desc"]],
				"aoColumns": [
					{"mData": "title"},
					{"mData": "loanName"},
					{"mData": "loanAmount"},
					{"mData": "purpose"},
					{"mData": "rate"},
					{"mData": "duration"},
					{"mData": "repayMethod"},
					{"mData": "mortgaged"},
					{"mData": "timeOpen"},
					{"mData": "timeSettled"},
					{"mData": "timeCleared"},
					{"mData": "operation"}
				],
				"aoColumnDefs": [
					{
						"aTargets": [0], //uid link
						"mRender": function (data, type, row) {
							return '<a target="_blank" href="/loan/'+ iData.status +'/'+row.loanId+'">' + data + '</a>';
						}
					},
                    {
                        "aTargets": [2], //uid link
                        "mRender": function (data, type, row) {
                            return '<span class="red bold">￥' + formatAmount(data) + '</span>';
                        }
                    },
					{
						"aTargets": [2], //uid link
						"mRender": function (data, type, row) {
							return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
						}
					},
					{
						"aTargets": [8], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					},
					{
						"aTargets": [9], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					},
					{
						"aTargets": [10], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					},
					{
						"aTargets": [11], //uid link
						"mRender": function (data, type, row) {
							if($("#LOAN_ARCHIVE").val()!=undefined){
								return '<a class="btn btn-sm btn-primary" href="/loan/archiveLoan/'+row.loanId+'"><i class="fa fa-save"></i>存档</a>';
							}
							return '';
						}
					}
				],
				"fnDrawCallback": function (oSettings) {
					$("#searchRechargeHistory").html('查询');
					$("#searchRechargeHistory").prop('disabled', false);
				},
				"sAjaxSource": "/loan/loanStatus/"+iData.status,
				"fnServerData": function (sSource, aoData, fnCallback, oSettings) {
					$('#downloadLoan').attr('href','/loan/download/'+iData.status+'?search='+getSearchVal(aoData));
					aoData.push({
						"name": "status",
						"value": iData.status
					});
					oSettings.jqXHR = $.ajax({
						"dataType": 'json',
						"type": "GET",
						"url": sSource,
						"data": aoData,
						"success": fnCallback,
						"error": function () {
							console.log('error'+aoData);
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
		if(iData.status=='11'){
			var oTable = $('#LOANS_LIST').dataTable({
				"sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
				"iDisplayLength": 10,
				"bProcessing": true,
				"bServerSide": true,
				"bSort": false,
				"bFilter": true,
				"bRetrieve": true,
				"bPaginate": true,
				"aoColumns": [
					{"mData": "title"},
					{"mData": "loanName"},
					{"mData": "loanAmount"},
					{"mData": "purpose"},
					{"mData": "rate"},
					{"mData": "duration"},
					{"mData": "repayMethod"},
					{"mData": "mortgaged"},
					{"mData": "timeOpen"}
				],
				"aoColumnDefs": [
					{
						"aTargets": [0], //uid link
						"mRender": function (data, type, row) {
							return '<a target="_blank" href="/loan/'+ iData.status +'/'+row.loanId+'">' + data + '</a>';
						}
					},
                    {
                        "aTargets": [2], //uid link
                        "mRender": function (data, type, row) {
                            return '<span class="red bold">￥' + formatAmount(data) + '</span>';
                        }
                    },
					{
						"aTargets": [2], //uid link
						"mRender": function (data, type, row) {
							return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
						}
					},
					{
						"aTargets": [8], //uid link
						"mRender": function (data, type, row) {
							if(undefined!=data){
								return (new Date(data)).Format("yyyy-M-d h:m")
							}else {
								return '-'
							}
						}
					}
				],
				"fnDrawCallback": function (oSettings) {
					$("#searchRechargeHistory").html('查询');
					$("#searchRechargeHistory").prop('disabled', false);
				},
				"sAjaxSource": "/loan/loanStatus/"+iData.status,
				"fnServerData": function (sSource, aoData, fnCallback, oSettings) {
					$('#downloadLoan').attr('href','/loan/download/'+iData.status+'?search='+getSearchVal(aoData));
					aoData.push({
						"name": "status",
						"value": iData.status
					});
					oSettings.jqXHR = $.ajax({
						"dataType": 'json',
						"type": "GET",
						"url": sSource,
						"data": aoData,
						"success": fnCallback,
						"error": function () {
							console.log('error'+aoData);
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
    }
        var status=location.href.substr(location.href.lastIndexOf("/")+1);
        
        $('#loanTabs li').click(function(){
        	var sIndex=$(this).index();
        	var href='/loan/loanList/'+sIndex;
        	location.replace(href)
        });
function archiveLoan(loanId){
	var href='/loan/archiveLoan/'+loanId;
	location.replace(href)
}
getList({status:status});

function getSearchVal(params) {
	for(var i=0;i<params.length;i++){
		if(params[i].name=="sSearch"){
			return params[i].value;
		}
	}
}

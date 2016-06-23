/**
 * Created by dandan on 15/10/20.
 */
(function(){
    'use strict';


    function Func(){

        this.init();

        loadData();
    }

    Func.prototype.init = function(){

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

        $('#reservation').val(moment().subtract('days', 29).format("YYYY-MM-DD")+' - '+moment().format("YYYY-MM-DD"));

        $('#btn_search').on('click',function(){
            loadData();
        });

        $('#back-pro').click(function(){
        	history.go(-1);
        });
    };

    window.showClaimD = function(data, invest) {
    	console.log(invest);
        console.log(data, invest, typeof(invest));

        var source = $("#showClaim-template").html();
        var template = Handlebars.compile(source);

        Handlebars.registerHelper('formatDate', function (dt, options) {
            if(dt != null ){
                return new Date(dt).Format("yyyy-MM-dd");
            }else{
                return null;
            }
        });

        Handlebars.registerHelper('formatAmount', function (dt, options) {
            if(dt != null ){
                return formatAmount(dt, 0) + '元';
            }else{
                return null;
            }
        });

        Handlebars.registerHelper('formatRate', function (dt, options) {
            if(dt != null ){
                return dt + '%';
            }else{
                return null;
            }
        });

        Handlebars.registerHelper('formatBoolean', function (dt, options) {

            if(dt == false){
                return "匹配失败";
            }else{
                return "匹配成功";
            }
        });

        $.get("/claimInvestLoan/listRestLoanByInvest/" + data,
            function (data) {
                var context = eval("(" + data + ")");
                var fill = {xx:invest, mm: context.data};
                var html = '';
                console.log(context);
                html = template(fill);
                bootbox.dialog({
                    message: html,
                    title: "投资记录",
                    className: "modal-darkorange"
                });
                $('.modal-dialog').css('width', '1160px')
            }
        );
    };

    
    
    var investId='';
    var feeRateSure='';
    var date='';
    window.showRedeem = function(data) {
        //var source = $("#showRedeem-template").html();
        var template = Handlebars.compile( $("#showRedeem-template").html());
        var context = {feeRate: "",data:""};
        investId= data;

        $.get("/claimRepayApply/getDaysByInvestId/?investId=" + data,
            function (data) {
	        	var jsonData = eval("(" + data + ")");
	            var html = '';
	            context = {data: jsonData.data};
	            //console.log(jsonData.data);
	            date= jsonData.data;
                html    = template(context);
                bootbox.dialog({
                    message: html,
                    title: "申请赎回",
                    className: "modal-darkorange"
                });
                $('.modal-dialog').css('width', '500px')
            }
        );
    };
    
    window.showRedeem2 = function(data) {
        //var source = $("#showRedeem-template").html();
        var template = Handlebars.compile( $("#showRedeem-template2").html());
        var context = {loginName:"",userName:"",principalAmount:"",interest:"",totalAsset:"",fee:"",receivableAmount:"",feeRate:""};
        var feeRate=$('input[name=feeRate]').val();
        feeRateSure=feeRate;
        //debugger;
        var feeRateInp = $("input[name=feeRate]");
        if (feeRateInp.val() === "" ||feeRateInp.val() === "0") {
            //userTransferAmount.addClass("text-error");  
        	 alert('请正确填写费率！');
        	 return;
        }
        var re = /^(0|[1-9]\d*)(\.\d{1,2})?$/; 
        if (!re.test(feeRateInp.val()))
        {
        	alert('请正确填写费率(最多含两位小数)！');
            return;
    	}
        $('#cel-1').click();
       
        //alert(investId);
        $.get("/claimRepayApply/getStatisticsByInvestId/?investId=" + investId+"&feeRate="+feeRate,
            function (data) {
	        	var jsonData = eval("(" + data + ")");
	            var html = '';
	            var data=jsonData.data;
	            context = {loginName:data.loginName,
	            		userName:data.userName,
	            		principalAmount:data.principalAmount,
	            		interest:data.interest,
	            		totalAsset:data.totalAsset,
	            		fee:data.fee,
	            		receivableAmount:data.receivableAmount,
	            		feeRate:feeRate};
	            //console.log(jsonData.data);
                html    = template(context);
                bootbox.dialog({
                    message: html,
                    title: "申请赎回",
                    className: "modal-darkorange"
                });
                $('.modal-dialog').css('width', '500px')
            }
        
        );
    };

    
   // console.log(feeRateSure);
    window.redTip = function() {
	    $.post('/claimRepayApply/fixed/redemptionByFixed/?investId=' + investId+'&feeRate='+feeRateSure, function(data){
	    	var jsonData=  eval("(" + data + ")");
	    	console.log(jsonData);
	    	
            if(jsonData.success ==1){
                alert(jsonData.comment);
                location.reload();
            }else{
                alert(jsonData.comment);
                location.reload();
            }	    	
	    })	        	   
	};


  
    
    
    function loadData(){
        var $dateRange = $('#reservation');
        var opType = $('#operetionType').val();

        $('#reProRecordsTable').dataTable({
            "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
            "bProcessing": false,
            "bServerSide": true,
            "bSort": false,
            "bFilter": true,
            "bPaginate": true,
            "bSortable": false,
            "bDestroy": true,
            "aoColumns": [
                {"mData": "orderId","sDefaultContent" : ""},//0
                {"mData": "loginName","sDefaultContent" : ""},//1
                {"mData": "userName","sDefaultContent" : ""},//2
                {"mData": "amount","sDefaultContent" : ""},//3
                {"mData": "submitTime","sDefaultContent" : ""},//4
                {"mData": "countRateDate","sDefaultContent" : ""},//5
                {"mData": "fixedRate","sDefaultContent" : ""},//6
                {"mData": "status","sDefaultContent" : ""},//7
                {"mData": "investId","sDefaultContent" : ""}//8

            ],
            "aoColumnDefs": [
                {
                    "aTargets": [3],
                    "mRender": function (data, type, row) {
                        return '<span class="red bold">' + formatAmount(data, 2) + '元</span>';
                    }
                },
                {
                    "aTargets": [4],
                    "mRender": function (data, type, row) {
                        return new Date(data).Format("yyyy-MM-dd");
                    }
                },
                {
                    "aTargets": [5],
                    "mRender": function (data, type, row) {
                        if(data != null){
                            return new Date(data).Format("yyyy-MM-dd");
                        }else{
                            return null;
                        }
                    }
                },
                {
                    "aTargets": [6],
                    "mRender": function (data, type, row) {
                        if(data != null){
                            return data + '%';
                        }else{
                            return null;
                        }

                    }
                },{
                    "aTargets": [7],
                    "mRender": function (data, type, row) {
                        if(data == 'MATCHING') {
                            return '投资中';
                        }
                        if(data == 'CANCEL') {
                            return '取消';
                        }
                        if(data == 'END') {
                            return "赎回";
                        }
                    }
                },
                {
                    "aTargets": [8],
                    "mRender": function (data, type, row) {

                    	 var show_a = '<a class="btn btn-sm btn-palegreen"  href="javascript:void(0);" onclick="showClaimD(\''+data+'\','+JSON.stringify(row).replace(/"/g,"'")+')" style="display:inline-block;width:60px;" ><i>债权查看</i></a>';
                         var pdf_a = '<a class="btn btn-sm btn-info" target="_blank" href="/claimTemplate/noticeBill/'+data+'" style="display:inline-block;width:60px;"><i>通知单</i></a>';
                         var nextMonthpdf_a = '<a class="btn btn-sm btn-info" target="_blank" href="/claimTemplate/nextMonthNoticeBill/'+data+'" style="display:inline-block;width:60px;"><i>持有债权</i></a>';
                         var zjcjbg_a = '<a class="btn btn-sm btn-info" target="_blank" href="/claimTemplate/zjcjbg/'+data+'" style="display:inline-block;width:60px;"><i>资金报告</i></a>';
                         var sh_a =  '<a class="btn btn-sm btn-default"  href="javascript:void(0);" onclick="showRedeem(\''+data+'\')" style="display:inline-block;width:60px;" ><i>申请赎回</i></a>';

                         if(row.productType =='MONTH_WIN' || row.productType =='RECYCLE_INTEREST'){
                        	 if(row.status =='MATCHING'){
                        		 return '<div class="btn-group btn-group-justified" style="width: 300px">'+show_a + pdf_a+nextMonthpdf_a+zjcjbg_a+sh_a+'</div>';
                        	 }else{
                        		 return '<div class="btn-group btn-group-justified" style="width: 240px">'+show_a + pdf_a+nextMonthpdf_a+zjcjbg_a+'</div>';
                        	 }
                        	 
                         }else{
                        	 return '<div class="btn-group btn-group-justified" style="width: 240px">'+show_a + pdf_a+nextMonthpdf_a+zjcjbg_a+'</div>';                       	 
                         } 
                        	                         
                    }
                }
            ],
            "sAjaxSource": "/claimInvest/listByProductId/"+getURLParameter("productId"),
            "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

                aoData.push({
                    "name": "startDate",
                    "value": $dateRange.val().split(' - ')[0]
                });
                aoData.push({
                    "name": "endDate",
                    "value": $dateRange.val().split(' - ')[1]
                });
                aoData.push({
                    "name": "isJoinedProduct",
                    "value": true
                });
                aoData.push({
                    "name": "principalInvestType",
                    "value": 1
                });
                var downParams = [];
                for (var i = 0; i < aoData.length; i++) {

                    if(aoData[i]['name'] == 'sSearch' || aoData[i]['name'] == 'startDate'
                        ||aoData[i]['name'] == 'endDate') {
                        downParams.push(aoData[i]['name']+'='+aoData[i]['value']);
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
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            }
        });

    }


    new Func();

})();


<%--
  Created by IntelliJ IDEA.
  User: lxl
  Date: 15/7/11
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <title>千金所测试平台</title>
  <meta name="description" content="千金所测试平台管理系统" />
  <%@include file="../common/head.jspf" %>
  <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
</head>
<body>
<%@include file="../common/navbar.jspf" %>
<!-- Main Container -->
<div class="main-container container-fluid">

	<!-- Page Container -->
	<div class="page-container">
    	<%@include file="../common/sidebar.jspf" %>
    	<!-- Page Content -->
    	<div class="page-content">
      		<!-- Page Breadcrumb -->
      		<div class="page-breadcrumbs">
        		<ul class="breadcrumb">
					<li>
						<i class="fa fa-home"></i>
					  	<a href="/">首页</a>
					</li>
					<li class="active">活动统计</li>
					<li class="active">数据统计</li>
					<li class="active">产品项目统计</li>
				</ul>
      		</div>
			<!-- /Page Breadcrumb -->
			<!-- Page Header -->
			<div class="page-header position-relative">
				<div class="header-title">
					<h1>产品项目统计</h1>

				</div>
				<!--Header Buttons-->
				<div class="header-buttons">
                    <a class="sidebar-toggler" href="#">
                        <i class="fa fa-arrows-h"></i>
                    </a>
                    <a class="refresh" id="refresh-toggler" href="">
                        <i class="glyphicon glyphicon-refresh"></i>
                    </a>
                    <a class="fullscreen" id="fullscreen-toggler" href="#">
                        <i class="glyphicon glyphicon-fullscreen"></i>
                    </a>
                </div>
				<!--Header Buttons End-->
			</div>
			<!-- /Page Header -->
			<!-- Page Body -->
			<div class="page-body">
				<div class="well">
					<div class="row">
						<div class="col-lg-12 col-sm-12 col-xs-12">
				        	<div class="F-right" style="width:150px;">
					        	<div class="form-group pull-right">
					            	<button class="btn btn-small btn-primary" id="searchRechargeHistory">查询</button>
					            	<a class="btn btn-small btn-danger downloadLink" id="downloadHistoryBtn" href="">下载</a>
					        	</div>
				          	</div>
				          	<div class=" F-right" style="width:350px;">
					        	<div class="form-group pull-right">
					            	<label for="date-range-picker" class="control-label no-padding-right MargT-7 F-left text-right"  style="width:115px;margin-right:5px;">发标日期范围</label>
						            <div class="input-group F-left"  style="width:230px;">
						            	<span class="input-group-addon"><i class="fa fa-calendar"></i></span>					            	
						                <input type="text" name="date-range-picker" id="date-range-picker" class="form-control"/>
						            </div>
								</div>
							</div>						
						</div>	        	

					</div>
					<hr class="MargT-10 MargB-10">
        
					<table id="commonDataTable" class="table table-bordered">
			            <thead>
				            <tr>
								<th>标的名称</th>
								<th>发标金额</th>
								<th>实际募集金额</th>
								<th>标的期限</th>
								<th>标的利率</th>
								<th>发标时间</th>
								<th>满标时间</th>
								<th>结算时间</th>
								<th>发标账户</th>
								<th>借款人</th>
								<th>借款人身份证号</th>
								<th>标的状态</th>
								<th>还款方式</th>
				            </tr>
			            </thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
        	<!-- /Page Body -->
		</div>
    	<!-- /Page Content -->
	</div>
</div>
<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script type="text/javascript" src="/assets/js/bbtTool.js"></script>
<script type="text/javascript" src="/assets/js/moment.min.js"></script>
<script type="text/javascript" src="/assets/js/daterangepicker.min.js"></script>
<script type="text/javascript" src="/assets/js/ace-extra.js"></script>

<script src="/assets/js/datetime/daterangepicker.min.js" type="text/javascript"></script>
<script src="/assets/js/datetime/moment.js" type="text/javascript"></script>

<script>
  var cardId = '${cardId}';
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
      "aoColumns": [
        {"mData": "title"}, //0
        {"mData": "loanAmount"}, //1
        {"mData": "investedAmount"}, //2
        {"mData": "duration"}, //3
        {"mData": "rate"}, //4
        {"mData": "timeOpen"}, //5
        {"mData": "timeFinished"}, //6
        {"mData": "timeSettled"}, //7
        {"mData": "empName"}, //8
        {"mData": "userName"}, //9
        {"mData": "userIdNumber"}, //10
        {"mData": "status"},//11
        {"mData": "repayMethod"},//12
      ],
      "aoColumnDefs": [{
        "bSortable": false,
        "aTargets":[0],
        "mRender":function (data, type, row) {
          return '<a href="/loan/0/'+row.loanId+'">' + data + '</a>';
        }
      },{
        "bSortable": false,
        "aTargets":[1],
        "mRender":function(data){
          return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
        }
      },{
        "bSortable": false,
        "aTargets":[2],
        "mRender":function(data){
          return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
        }
      },{
        "bSortable": false,
        "aTargets":[3]
      },{
        "bSortable": false,
        "aTargets":[4]
      },{
        "bSortable": false,
        "aTargets":[5],
        "mRender":function(data){
          if(undefined!=data){
            return (new Date(data)).Format("yyyy-M-d h:m")
          }else {
            return '-'
          }
        }
      },{
        "bSortable": false,
        "aTargets":[6],
        "mRender":function(data){
          if(undefined!=data){
            return (new Date(data)).Format("yyyy-M-d h:m")
          }else {
            return '-'
          }
        }
      },{
        "bSortable": false,
        "aTargets":[7],
        "mRender":function(data){
          if(undefined!=data){
            return (new Date(data)).Format("yyyy-M-d h:m")
          }else {
            return '-'
          }
        }
      },{
        "bSortable": false,
        "aTargets":[8],
        "mRender":function(data){
          if(undefined!=data){
            return data;
          }else {
            return ''
          }
        }
      },{
        "bSortable": false,
        "aTargets":[9],
        "mRender":function(data){
          if(undefined!=data){
            return data;
          }else {
            return ''
          }
        }
      },{
        "bSortable": false,
        "aTargets":[10],
        "mRender":function(data){
          if(undefined!=data){
            return data;
          }else {
            return ''
          }
        }
      },{
        "bSortable": false,
        "aTargets":[11]
      },{
        "bSortable": false,
        "aTargets":[12]
      }],
      "fnDrawCallback": function (oSettings) {
        $("#searchRechargeHistory").html('查询');
        $("#searchRechargeHistory").prop('disabled', false);
      },
      "sAjaxSource": "/statistics/loanInfos",
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
      var href = '/statistics/downLoanInfos?startDate=' + $dateRangeP.split(' - ')[0]+'&endDate='+$dateRangeP.split(' - ')[1]+'&sSearch='+$('#commonDataTable_filter input').val();
      $(this).prop('href', href);
    });
  });
</script>
</body>
</html>

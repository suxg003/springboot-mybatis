<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>千金所测试平台</title>
    <meta name="description" content="千金所测试平台管理系统" />
    <%@include file="../../common/head.jspf" %>
    <link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
	<link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
    <style type="text/css">
        #list_th th{font-size: 13px;}
    </style>

</head>
<body>
<%@include file="../../common/navbar.jspf" %>
<!-- Main Container -->
<div class="main-container container-fluid">
    <!-- Page Container -->
    <div class="page-container">
        <%@include file="../../common/sidebar.jspf" %>
        <!-- Page Content -->
        <div class="page-content">
            <!-- Page Breadcrumb -->
				<div class="page-breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="fa fa-home"></i> <a href="/">首页</a></li>
						<li class="active">资金管理</li>
						<li class="active">提现管理</li>
						<li class="active">未处理请求</li>
					</ul>
				</div>
				<!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        未处理请求
                    </h1>
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
						<div class="F-right" style="width:470px;">
				        	<div class="form-group pull-right">
				            	<label for="date-range-picker" class=" control-label no-padding-right MargT-7 F-left" style="width:110px; text-align:right;margin-right:5px;">日期范围</label>
					            <div class="input-group F-left " style="width:230px;">
					            	<span class="input-group-addon"><i class="fa fa-calendar"></i></span>			            	
					                <input type="text" name="date-range-picker"
										id="date-range-picker" class="form-control investRecordRange" />
					            </div>
					            <select id="rangeTimeFlag" name="rangeTimeFlag" class="F-left" style="margin-left:20px;">
					            	<option value="all">全部</option>
					            	<option value="before">16点前</option>
					            	<option value="after">16点后</option>
					            </select> 
							</div>
						</div>
										
						<div class="col-lg-5 col-sm-5 col-xs-12 ">
							<cm:securityTag privilegeString="WITHDRAW_UNTREATEDREQUEST">
				            	<a href="javascript:void(0)" onclick="getList()" class="btn btn-small btn-primary"><i class="fa fa-download"></i> 查询</a>
				                <a href="javascript:void(0)" class="btn btn-small btn-primary" id="downloadHistoryBtn" onclick="downloadInfo()"><i class="fa fa-download"></i> 下载(支付使用)</a>
				                <a href="javascript:void(0)" class="btn btn-small btn-primary" id="downloadInternal"><i class="fa fa-download"></i> 下载(内部使用)</a>
			                </cm:securityTag>
			            </div>
		            </div>
	            </div>
	            <input type="hidden" id="startDate" name="startDate" value='${start}'/>
	            <input type="hidden" id="endDate" name="endDate" value='${end}'/>
                <table class="table table-striped table-bordered table-hover dataTable no-footer" id="commonDataTable" aria-describedby="simpledatatable_info">
                	<thead id="list_th">
						<tr>
                            <th>姓名</th>
                            <th>身份证</th>
                            <th>申请时间</th>
                            <th>提现金额</th>
                            <th>状态</th>
                        	<th>备注</th>
                    	</tr>
                	</thead>
                	<tbody >
                	</tbody>
                </table>
                </div>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>
<%@include file="../../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datetime/daterangepicker.min.js" type="text/javascript"></script>
<script src="/assets/js/datetime/moment.js" type="text/javascript"></script>
<script src="/assets/js/datatable/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="/assets/js/datatable/ZeroClipboard.js" type="text/javascript"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js" type="text/javascript"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js" type="text/javascript"></script>
<script src="/assets/js/datatable/datatables-init.js" type="text/javascript"></script>
<script src="/assets/js/handlebars/handlebars.min.js" type="text/javascript"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js" type="text/javascript"></script>
<script src="/assets/js/amountFormat.js" type="text/javascript"></script>
<script src="/assets/js/bbtTool.js" type="text/javascript"></script>
<script src="/assets/js/fund/withdraw/withdraw.js" type="text/javascript"></script>
<script type="text/javascript">
$('#date-range-picker').val('${start} - ${end}');
</script>
</body>
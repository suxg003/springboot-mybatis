<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
						<li class="active">产品管理</li>
						<li class="active">优选计划</li>
						<li class="active">可用债权价值</li>
					</ul>
				</div>
				<!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        可用债权价值
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
	            <div class="table-toolbar">
	                <a href="/uplanLoan/download" class="btn btn-small btn-primary" id="downloadLoan"><i class="fa fa-download"></i> 导出报表</a>
	            </div>
                 <table class="table table-striped table-bordered table-hover dataTable no-footer" id="commonDataTable" aria-describedby="simpledatatable_info">
                     <thead id="list_th">
						<tr>
                             <th>借款方式</th>
                             <th>借款人姓名</th>
                             <th>借款人身份证号</th>
                             <th>还款状态</th>
                             <th>起始放款日期</th>
                             <th>还款日期</th>
                             <th>借款天数</th>
                             <th>剩余天数</th>
                             <th>借款金额</th>
                             <th>预计年华收益率</th>
                             <th>补贴利率</th>
                             <th>借款人职业情况</th>
                             <th>借款人借款用途</th>
                             <th>可用债权价值</th>
                             <th>已转出债权百分比</th>
                             <th>已出借金额</th>
                             <th>债权归属</th>
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
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script src="/assets/js/amountFormat.js"></script>
<script src="/assets/js/uplan/creditor/availableCredit.js" type="text/javascript"></script>

</body>
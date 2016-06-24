<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/18
  Time: 14:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>本日到期欠款 系统测试平台</title>
    <meta name="description" content="系统测试平台管理系统" />
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
                    <li class="active">项目管理</li> 
                    <li class="active">贷后管理</li>
                    <li class="active">本日到期欠款</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        本日到期欠款
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

				<div class="">
				    <div class="tabbable">
				        <ul class="nav nav-tabs" id="myTab">
				            <li class="active">
				                <a data-toggle="tab" href="#zhitou">
				                    	直投项目
				                </a>
				            </li>

				            <li class="tab-red">
				                <a data-toggle="tab" href="#youxuan">
				                  	  优选计划
				                </a>
				            </li>

				        </ul>
                        <cm:securityTag privilegeString="POSTLOAN_REPAY">
                           <div id="POSTLOAN_REPAY"></div>
                        </cm:securityTag>
                        <cm:securityTag privilegeString="POSTLOAN_DISBURSE">
                             <div id="POSTLOAN_DISBURSE">
                        </cm:securityTag>
				        <div class="tab-content">
				            <div id="zhitou" class="tab-pane active">

								<table class="table table-striped table-hover dataTable no-footer" id="BBT-list" aria-describedby="simpledatatable_info">
								    <thead id="list_th">
										<tr>
								            <th>借款人</th>
								            <th>借款标题</th>
								            <th>期数</th>
								            <th>待还本息</th>
								            <th>账户余额</th>
								            <th>到期日</th>
											<th>状态</th>
								            <th>还款时间</th>
								            <th style="width: 100px">操作</th>
								            <th>垫付</th>
								        </tr>
								    </thead>
									<tbody>

									</tbody>
								</table>

				            </div>

				            <div id="youxuan" class="tab-pane">
								<table class="table table-hover dataTable" id="UPLAN-list">
								    <thead id="">
										<tr>
											<th>借款人</th>
								            <th>产品名称</th>
								            <th>待还本息</th>
								            <th>投标数</th>
								            <th>到期日</th>
								            <th>操作</th>
								        </tr>
								    </thead>
									<tbody>


									</tbody>
								</table>

				            </div>

				        </div>
				    </div>
				    <div class="horizontal-space"></div>
				</div>


            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>

</div>
<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/toastr/toastr.js"></script>
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/postLoan/today.js"></script>

</body>
</html>
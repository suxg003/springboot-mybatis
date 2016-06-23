<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>千金所测试平台</title>
    <meta name="description" content="千金所测试平台管理系统" />
    <%@include file="../../common/head.jspf" %>
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
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
                    <li>
                        <i class="fa fa-home"></i>
                        <a href="/">首页</a>
                    </li>
                    <li class="active">产品管理</li>
					<li class="active">优选计划</li>
					<li class="active">优选项目列表</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        优选项目列表
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
                    <ul class="nav nav-pills" id="loanTabs">
                    	<cm:securityTag privilegeString="UPLAN_PLANLIST">
							<c:forEach items="${statusList}" var="status">
		                        <li data-type=${status} style="cursor:pointer">
	                            <a data-toggle="tab">
	                                ${status.key}
	                            </a>
	                        </li>
		                    </c:forEach>
                        	<a href="javascript:void(0)" class="pull-right btn btn-small btn-primary" id="downloadLoan"><i class="fa fa-download"></i> 借款列表下载</a>
                    	</cm:securityTag>
                    </ul>
                    <hr class="wide">
                    <table class="table table-striped table-hover dataTable no-footer" id="LOANS_LIST" aria-describedby="simpledatatable_info">
                        <thead id="list_th" class="bordered-blue">
							<tr>
                                <th><i class="icon-tag"></i>产品名称</th>
                                <th><i class="icon-money"></i>借款金额</th>
                                <th>预期年化利率</th>
                                <th>还款方式</th>
                                <th>还款时间</th>
                                <th>投资进度</th>
                                <th>投标数</th>
                                <th>下载文件/查看记录</th>
                                <th>是否新手标</th>
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
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/amountFormat.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/uplan/uplanManager/planList.js" type="text/javascript"></script>
</body>
</html>

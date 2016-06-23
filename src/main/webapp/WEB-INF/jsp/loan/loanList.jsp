<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/16
  Time: 13:43
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
                    <li class="active">产品管理</li>
                    <li class="active">直投项目</li>
                    <li class="active">直投项目</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        直投项目
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

                        <li data-type="OPENED" style="cursor:pointer">
                            <a data-toggle="tab">
                                募集中
                            </a>
                        </li>

                        <li data-type="UNPUBLISH" style="cursor:pointer">
                            <a data-toggle="tab">
                                保存未发布
                            </a>
                        </li>

                        <li data-type="INITIATED" style="cursor:pointer;display: none">
                            <a data-toggle="tab">
                                初始
                            </a>
                        </li>

                        <li data-type="SCHEDULED" style="cursor:pointer">
                            <a data-toggle="tab">
                                预告
                            </a>
                        </li>

                        <li data-type="FINISHED" style="cursor:pointer">
                            <a data-toggle="tab">
                                已满标
                            </a>
                        </li>

                        <li data-type="SETTLED" style="cursor:pointer">
                            <a data-toggle="tab">
                                已结算
                            </a>
                        </li>

                        <li data-type="CLEARED" style="cursor:pointer">
                            <a data-toggle="tab">
                                已还清
                            </a>
                        </li>

                        <li data-type="FAILED" style="cursor:pointer">
                            <a data-toggle="tab">
                                流标
                            </a>
                        </li>

                        <li data-type="CANCELED" style="cursor:pointer">
                            <a data-toggle="tab">
                                已取消
                            </a>
                        </li>

                        <li data-type="OVERDUE" style="cursor:pointer">
                            <a data-toggle="tab">
                                逾期
                            </a>
                        </li>

                        <li data-type="BREACH" style="cursor:pointer">
                            <a data-toggle="tab">
                                违约
                            </a>
                        </li>

                        <li data-type="ARCHIVED" style="cursor:pointer">
                            <a data-toggle="tab">
                                已存档
                            </a>
                        </li>


                        <cm:securityTag privilegeString="LOAN_DOWNLOAD">
                            <a href="/loan/download/${status}" class="pull-right btn btn-small btn-primary" id="downloadLoan"><i class="fa fa-download"></i> 借款列表下载</a>
                        </cm:securityTag>
                    </ul>
                    <hr class="wide">
					<cm:securityTag privilegeString="LOAN_ARCHIVE">
                     	<input type="hidden" value="LOAN_ARCHIVE" id="LOAN_ARCHIVE">
                     </cm:securityTag>

                    <table class="table table-striped table-bordered table-hover dataTable no-footer" id="LOANS_LIST" aria-describedby="simpledatatable_info">
                        <thead id="list_th">
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
<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script type="text/javascript" src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/loan/loanList.js" type="text/javascript"></script>

</body>
</html>

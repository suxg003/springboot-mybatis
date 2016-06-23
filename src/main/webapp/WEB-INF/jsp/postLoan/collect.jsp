<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh">
    <head>
        <title><fmt:message key="title"/></title>
        <%@include file="../common/head.jspf" %>
        <link rel="stylesheet" href="css/daterangepicker.css" />
    </head>
    <body class="navbar-fixed">
        <%@include file="../common/navbar.jspf" %>

        <div class="container-fluid main-container" id="main-container">
            <%@include file="../common/sidebar.jspf" %>
            <div id="main-content" class="clearfix main-content">

                <div id="breadcrumbs" class="breadcrumbs">
                    <ul class="breadcrumb">
                        <li>
                            <i class="icon-home home-icon"></i> <a href="dashboard">首页</a>
                            <span class="divider">
                                <i class="icon-angle-right"></i>
                            </span>
                        </li>
                        <li>
                            贷后管理
                            <span class="divider">
                                <i class="icon-angle-right"></i>
                            </span>
                        </li>
                        <li class="active">代扣历史记录</li>
                    </ul><!--.breadcrumb-->
                </div><!--#breadcrumbs-->

                <div id="page-content" class="clearfix page-content">

                    <div class="row-fluid">
                        <div class="widget-box transparent span-12">
                            <div class="widget-header widget-header-flat">
                                <h4>
                                    <i class="icon-table"></i> 代扣历史记录
                                </h4>
                                <div action="postLoan/undue" class="pull-right no-margin form-horizontal" method="POST">
                                    <div class="control-group pull-right">
                                        <button class="btn btn-small btn-primary" id="searchHistory">查询</button>
                                    </div>
                                    <div class="control-group pull-right">
                                        <label for="date-range-picker" class="control-label">日期范围</label>
                                        <div class="controls">
                                            <div class="input-prepend">
                                                <span class="add-on">
                                                    <i class="icon-calendar"></i>
                                                </span>
                                                <input type="text" name="dateRangePicker" id="dateRangePicker" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="widget-body">
                                <div class="widget-main no-padding">
                                    <table class="table table-bordered" id="collectTable">
                                        <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>代扣订单号</h>
                                                <th><i class="icon-money"></i> 金额</th>
                                                <th>银行</th>
                                                <th>卡号</th>
                                                <th>开户名</th>
                                                <th>状态</th>
                                                <th><i class="icon-time"></i> 日期</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--#page-content-->
            </div><!--#main-content-->
        </div><!--#main-container-->
        
        <div id="popMasker" class="modal hide fade">
            <div class="modal-header">
                <h3><i class='icon-rocket'></i> <span id="maskerTitle">正在处理请求</span></h3>
            </div>
            <div class="modal-body relative">
                <div class="text-center">
                    <div class="text-center grey">
                        <h1><i class='icon-cog icon-spin'></i> 请稍后....</h1>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="collectConfirm" class="modal hide fade">
            <div class="modal-header">
                <h3><i class='icon-bell'></i> <span id="maskerTitle">代扣确认</span></h3>
            </div>
            <div class="modal-body relative">
                <div class="form-horizontal">
                    <div class="control-group">
                        <label for="" class="control-label">代扣金额（元）：</label>
                        <div class="controls">
                            <input type="text" id="collectAmountInput" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label for="" class="control-label"></label>
                        <div class="controls">
                            <button class="btn btn-small btn-primary" id="doCollectBtn">确定代扣</button>
                            <button class="btn btn-small btn-light" onclick="$('#collectConfirm').modal('hide');">取消</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="../common/foot.jspf" %>

        <!-- jquery dataTables -->
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.highlight-4.js"></script>
        <script type="text/javascript" src="js/daterangepicker.min.js"></script>
        <script type="text/javascript" src="js/moment.min.js"></script>
        <script type="text/javascript" src="js/jquery.gritter.js"></script>
        <script type="text/javascript" src="js/amountFormat.js"></script>
        <script type="text/javascript" src="js/collect.js"></script>
    </body>
</html>

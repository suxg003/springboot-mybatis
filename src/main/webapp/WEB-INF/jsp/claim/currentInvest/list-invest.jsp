<%--
  Created by IntelliJ IDEA.
  User: dandan
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>活期理财-投资列表</title>
    <meta name="description" content="千金所测试平台管理系统"/>
    <%@include file="../../common/head.jspf" %>
    <link href="/assets/css/quickLoanRequest.css" rel="stylesheet"/>
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet"/>
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
                    <li class="active">债权项目</li>
                    <li class="active">活期理财</li>
                    <li class="active">投资列表</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1> 投资列表 </h1>
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
                <div class="col-lg-12 col-sm-12 col-xs-12">

                    <div class="well">

                        <div class="table-toolbar">
                            <div>
                                <div class="row">
                                    <div class="col-md-12 F-right">
                                        <div class="buttons-preview">
                                            <span class="F-left MargT-5  MargR-5">投资时间:</span>

                                            <div class="controls col-lg-3 col-sm-3 col-xs-3"
                                                 style="display:inline-block">
                                                <div class="input-group">
					                            	<span class="input-group-addon">
					                                	<i class="fa fa-calendar"></i>
					                            	</span><input type="text" class="form-control input-sm active"
                                                                  id="reservation">
                                                </div>
                                            </div>
                                            <a id="btn_search" class="btn btn-sm btn-blue">查询</a>

                                        </div>
                                    </div>
                                </div>
                                <div style="clear:both;"></div>
                            </div>
                            <table id="reProRecordsTable" class="table table-hover dataTable no-footer">
                                <thead class="bordered-blue">
                                <tr>
                                    <th>订单号</th>
                                    <th>投资人账户名</th>
                                    <th>投资人姓名</th>
                                    <th>投资金额</th>
                                    <th>投资时间</th>
                                    <th>固定年化利率</th>
                                    <th>计息时间</th>
                                    <th>状态</th>
                                    <th>赎回重投</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>

<script id="showClaim-template" class="modal fade matchCreditModal bs-example-modal-lg  in" tabindex="-1"
        type="text/x-handlebars-template">
    <div id="page-content" class="clearfix">
        <div class="row" style="">
            <div class="col-lg-12 col-sm-12 col-xs-12">
                <div class="widget">

                    <div class="widget-header">
                        <span class="widget-caption blue Font-16">投资匹配情况</span>

                        <div class="widget-buttons">
                            <a href="#" data-toggle="collapse">
                                <!-- <i class="fa fa-minus blue"></i> -->
                            </a>
                        </div>
                    </div>
                    <div class="widget-body Loan-Info" style="display: block; overflow:hidden;line-height:36px;">
                        <div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">投资金额：{{formatAmount xx.amount}}</div>
                        <div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">预期年化利率：{{formatRate xx.fixedRate}}</div>
                        <div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">投资时间：{{formatDate xx.submitTime}}</div>
                        <div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">计息时间：{{formatDate xx.countRateDate}}</div>
                        <div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">匹配状态：{{formatBoolean xx.matchStatus}}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="">
            <div class="col-lg-12 col-sm-12 col-xs-12">
                <div class="widget">
                    <div class="widget-header">
                        <span class="widget-caption blue Font-16">投资债权列表</span>

                        <div class="widget-buttons">
                            <a href="#" data-toggle="collapse">
                            </a>
                        </div>
                    </div>
                    <div class="tab-pane" ng-controller="creditorMatched">
                        <table id="commonDataTable" class="table table-hover dataTable no-footer">
                            <thead>
                            <tr>
                                <th>借款人姓名</th>
                                <th>合同编号</th>
                                <th>债权原始价值</th>
                                <th>转让金额</th>
                                <th>债权剩余价值</th>
                                <th>剩余期数</th>
                                <th>末期还款时间</th>
                            </tr>
                            </thead>
                            <tbody>
                            {{#if mm}}
                            {{#each mm}}
                            <tr>
                                <th>{{this.loanerName}}</th>
                                <th>{{this.contractId}}</th>
                                <th>{{this.loanAmount}}</th>
                                <th>{{this.totalTransferAmount}}</th>
                                <th>{{this.remainAmount}}</th>
                                <th>{{this.remainPeriod}}</th>
                                <th>{{formatDate this.dueDate}}</th>
                            </tr>
                            {{/each}}
                            {{else}}
                            <tr><td colspan="7" style="text-align: center;">暂无数据</td></tr>
                            {{/if}}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</script>


<%@include file="../../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>

<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/datetime/moment.min.js"></script>
<script src="/assets/js/datetime/daterangepicker.min.js"></script>
<script src="/assets/js/select2/select2.js"></script>

<script src="/assets/js/claim/cur-invest-list.js"></script>

</body>
</html>

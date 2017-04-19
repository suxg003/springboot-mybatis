<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/16
  Time: 13:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>系统测试平台</title>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
    <style>
        .label-grey{
            background:#000;
            color:#fff;
        }
        .fc-event{
            width:260px!important;
            height:130px!important;
            overflow:auto;
            padding:5px;
        }
    </style>
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
                    <li class="active">项目发展调度</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        项目发展调度
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

                    <div class="row">
                        <div class="col-lg-9 col-md-9 col-sm-12">
                            <div class="well">
                            <div id="calendar"></div>
                                </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-122 sideInfoPanel">
                            <div class="well">
                                <%--<div class="header bordered-pink">操作</div>--%>
                                <div class="clearfix"></div>
                                <div class="widget-box transparent ">
                                <h6>颜色标识</h6>
                                <div class="widget-main">
                                    <span class="label label-grey"><i class="fa fa-asterisk bigger-110" title="初始"></i> 初&nbsp;&nbsp;&nbsp;&nbsp;始</span>
                                    <span class="label label-success"><i class="fa fa-check bigger-110" title="已满标"></i> 已满标</span>
                                    <span class="label label-inverse"><i class="fa fa-times bigger-110" title="已取消"></i> 已取消</span>
                                    <span class="label label-info"><i class="fa fa-check-circle bigger-110" title="已结算"></i> 已结算</span>
                                    <span class="label label-purple"><i class="fa fa-thumbs-up bigger-110" title="已还清"></i> 已还清</span>
                                    <span class="label label-important"><i class="fa fa-info-circle bigger-110" title="逾期"></i> 逾期</span>
                                    <span class="label label-yellow"><i class="fa fa-clock-o bigger-110" title="已安排"></i> 已安排</span>
                                    <span class="label label-pink"><i class="fa fa-play-circle bigger-110" title="开放投标"></i> 开放投标</span>
                                </div>
                                <div class="space-10"></div>
                                    <hr class="wide">
                                <cm:securityTag privilegeString="LOAN_SCHEDULE">

                                        <h6>待发布借款标</h6>&nbsp;
                                        <small class="bold grey">拖动到日历上</small>

                                    <div class="widget-main">
                                        <div id="external-events">
                                            <c:forEach var="loan" items="${initiated}">
                                                <div class="external-event ui-draggable label-yellow" loanId="${loan.loanId}" data-amount="${loan.loanAmount}" data-timeout="${loan.outTimes}" data-requestid="${loan.rmbLoanRequest.requestId}">
                                                    <i class="icon-angle-left"></i>
                                                    ${loan.loanTitle}
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="space-10"></div>
                                </cm:securityTag>

                                <div class="bg-primary center">
                                    <div class="title-text">当前总可用余额 </div>
                                    <div class="bigger-180 bold">
                                        <fmt:formatNumber type="currency" maxFractionDigits="0" value= "${totalAvailable}"/>
                                    </div>
                                </div>
                                <div class="hide">
                                    <h6>资金流量</h6>
                                    <div class="widget-main amountInfoWidget">
                                        <div class="clearfix center">
                                            <div class="grid2">
                                                <span class="bigger-120 red">￥15,000</span>
                                                <br />
                                                今日总余额
                                            </div>
                                            <div class="grid2">
                                                <span class="bigger-120 red">￥11,000</span>
                                                <br />
                                                今日已发布
                                            </div>
                                        </div>
                                        <div class="hr hr16 dotted"></div>
                                        <div class="widget-box">
                                            <div class="widget-body">
                                                <div class="widget-main">
                                                    <div id="columnChart"></div>
                                                </div>
                                            </div><!--/widget-body-->
                                        </div><!--/widget-box-->
                                    </div>
                                </div>
                            </div>
                            </div>
                        </div>
                </div>
                </div>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>
<%@include file="../common/foot.jspf" %>
<script src="/assets/js/jquery-ui-1.10.4.custom.js"></script>
<script src="/assets/js/fullcalendar/fullcalendar.js"></script>
<script src="/assets/js/amountFormat.js"></script>
<script src="/assets/js/highcharts.js"></script>
<script src="/assets/js/loan/schedule.js"></script>
<script type="text/javascript">
    <c:forEach var="loan" items="${events}">
        // Insert finished loans
    insertEvent('${loan.openTime}', '${loan.loanId}', '${loan.loanTitle}', '${loan.status}', '${loan.loanAmount}', '${loan.rmbLoanRequest.requestId}', '${loan.outTimes}');
    </c:forEach>
</script>
</body>
</html>
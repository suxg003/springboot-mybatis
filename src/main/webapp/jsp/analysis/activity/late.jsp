<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>后期投资统计</title>
    <%@include file="../../common/head.jspf" %>
</head>
<body class="navbar-fixed">
<%@include file="../../common/navbar.jspf" %>
<div class="main-container container-fluid">
    <!-- Page Container start-->
    <div class="page-container">
        <%@include file="../../common/sidebar.jspf" %>
        <!-- Page Content -->
        <div class="page-content">
            <!-- Page Breadcrumb -->
            <div class="page-breadcrumbs">
                <ul class="breadcrumb">
                    <li><i class="fa fa-home"></i> <a href="/">首页</a></li>
                    <li class="active">数据统计平台</li>
                    <li class="active">活动数据统计</li>
                    <li class="active">后期投资统计</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>${info.activityName}后期投资统计</h1>
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

                        <c:choose>
                            <c:when test="${list == null}">
                                <div><h3>[${info.activityName}]活动尚未结束,不能查看后期投资</h3></div>
                            </c:when>
                            <c:otherwise>
                                <div>
                                    <div class="row">
                                        <div class="col-md-12 F-right">
                                            <div class="buttons-preview">
                                                <a id="btn_excel" href="/analysis/activity/lateInvestExcel/${info.activity}" class="btn btn-sm btn-blue">导出Excel</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <table id="activityIndex" class="table table-hover dataTable no-footer">
                                    <thead class="bordered-blue">
                                    <tr>
                                        <th>周期</th>
                                        <th>投资人数</th>
                                        <th>投资金额</th>
                                        <th>转化率</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${list}" var="entry">
                                        <tr>
                                            <th>${entry.comments}</th>
                                            <th>${entry.investNum}</th>
                                            <th>${entry.investAmount}</th>
                                            <th>${entry.conversionRate}</th>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../../common/foot.jspf" %>
</body>
</html>

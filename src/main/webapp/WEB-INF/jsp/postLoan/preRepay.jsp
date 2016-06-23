<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title><fmt:message key="title"/></title>
    <%@include file="../common/head.jspf" %>
    <link rel="stylesheet" href="css/daterangepicker.css"/>
    <link rel="stylesheet" href="css/postLoan.css"/>
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
                <li class="active">提前还款(可能收取违约金)</li>
            </ul>
            <!--.breadcrumb-->
        </div>
        <!--#breadcrumbs-->

        <div id="page-content" class="clearfix page-content">

            <div class="row-fluid">
                <div class="widget-box transparent span-12">
                    <div class="widget-header widget-header-flat">
                        <h4>
                            <i class="icon-bolt"></i> 提前还款(可能收取违约金)
                        </h4>
                    </div>

                    <div class="widget-body">
                        <div class="widget-main no-padding">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>
                                        唯一号
                                    </th>
                                    <th>
                                        <i class="icon-tag"></i>
                                        标题
                                    </th>
                                    <th>
                                        借款人
                                    </th>
                                    <th>
                                        用途
                                    </th>
                                    <th>
                                        <i class="icon-money"></i>
                                        金额
                                    </th>
                                    <th>
                                        还款方式
                                    </th>
                                    <th>
                                        年化利率
                                    </th>
                                    <th>
                                        期限
                                    </th>
                                    <th>
                                        投标数
                                    </th>
                                    <th>
                                        <i class="icon-gear"></i>
                                        操作
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="loan" items="${results}">
                                    <c:if test="${loan.bidNumber > 0}">
                                        <tr>
                                            <td>
                                                    ${loan.loanRequest.serial}
                                            </td>
                                            <td>
                                                <a href="loan/${loan.id}" target="_blank">
                                                        ${loan.title}
                                                </a>
                                            </td>
                                            <td>
                                                <a href="user/profile/${loan.loanRequest.userId}" target="_blank">
                                                        ${appBean.getUser(loan.loanRequest.userId).loginName}
                                                </a>
                                            </td>
                                            <td>
                                                    ${loan.loanRequest.purpose.key}
                                            </td>
                                            <td>
                                                <fmt:formatNumber type="currency" maxFractionDigits="0"
                                                                  value="${loan.amount}"/>
                                            </td>
                                            <td>
                                                    ${loan.method.key}
                                            </td>
                                            <td>
                                                <fmt:formatNumber type="percent" minFractionDigits="1"
                                                                  value="${loan.rate/10000}"/>
                                            </td>
                                            <td>
                                                <cm:durationString duration="${loan.duration}"/>
                                            </td>
                                            <td>
                                                    ${loan.bidNumber}
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--#page-content-->
    </div>
    <!--#main-content-->
</div>
<!--#main-container-->

<!-- user form for create/edit -->
<div id="singleUser" class="modal hide fade"></div>

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

<div id="confirmPreRepay" class="modal hide">
    <div class="modal-header">
        <h3><i class="icon-bell-alt"></i> 提前还款</h3>
    </div>
    <div class="modal-body">
        <div class="row-fluid">
            <div class="form-horizontal">
                <h4><label for="">违约费率（给商家）</label><span class="input-append"><input type="text" id="rateForCompany"
                                                                                     value="0"/><span
                        class="add-on">%</span></span></h4>
                <h4><label for="">违约费率（给用户）</label><span class="input-append"><input type="text" id="rateForUser"
                                                                                     value="0"/><span
                        class="add-on">%</span></span></h4>
                <h4><label for="">还款类型</label>
                    <select name="advanceRepayType">
                        <c:forEach var="type" items="${AdvanceRepayAllType}">
                            <option value="${type}">${type.key}</option>
                        </c:forEach>
                    </select>
                </h4>
                <div class="text-center grey">
                    <button class="btn btn-primary closeModalBtn" style="width: 100px; margin-top: 20px;"
                            id="showPreRepayDetailBtn"><i class="icon-ok"></i> 明细
                    </button>
                    <button class="btn btn-light closeModalBtn" style="width: 100px; margin-top: 20px;"
                            id="cancelPreRepayBtn">取消
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="preRepayDetail" class="modal hide">
    <div class="modal-header">
        <h3><i class="icon-bell-alt"></i> 提前还款明细</h3>
    </div>
    <div class="modal-body">
        <div class="row-fluid">
            <div class="form-horizontal">
                <h4><label for="">还款期数:</label><span class="blue bold" id="detail_period"></span></h4>
                <h4><label for="">本金:</label><span class="red bold" id="detail_principal"></span></h4>
                <h4><label for="">利息:</label><span class="red bold" id="detail_interest"></span></h4>
                <h4><label for="">利息管理费:</label><span class="red bold" id="detail_loanFee"></span></h4>
                <h4><label for="">借款管理费:</label><span class="red bold" id="detail_manageFee"></span></h4>
                <h4><label for="">违约金(给商家):</label><span class="red bold" id="detail_feeToClient"></span></h4>
                <h4><label for="">违约金(给用户):</label><span class="red bold" id="detail_feeToInvest"></span></h4>
                <h4><label for="">总计:</label><span class="red bold" id="detail_total"></span></h4>
                <%--<h4><label for="">剩余本息:</label><span class="red bold" id="detail_outstanding"></span></h4>--%>
                <div class="text-center grey">
                    <button class="btn btn-success closeModalBtn" style="width: 100px; margin-top: 20px;"
                            id="doPreRepayBtn"><i class="icon-ok"></i> 还款
                    </button>
                    <button class="btn btn-light closeModalBtn" style="width: 100px; margin-top: 20px;"
                            id="closeRepayDetailBtn">取消
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="updateSuccess" class="modal hide">
    <div class="modal-header">
        <h3>系统提示</h3>
    </div>
    <div class="modal-body">
        <div class="row-fluid">
            <div class="form-horizontal">
                <div class="text-center grey">
                    <h2><i class="icon-ok green"></i> 提前一次性还款成功！</h2>
                    <button class="btn btn-primary closeModalBtn" style="width: 100px; margin-top: 20px;"
                            onClick="location.reload();">确定
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="updateFailed" class="modal hide">
    <div class="modal-header">
        <h3>系统提示</h3>
    </div>
    <div class="modal-body">
        <div class="row-fluid">
            <div class="form-horizontal">
                <div class="text-center grey">
                    <h2><i class="icon-warning-sign red"></i> <span class="errorText"></span></h2>
                    <button class="btn btn-primary closeModalBtn" style="width: 100px; margin-top: 20px;"
                            onClick="location.reload();">确定
                    </button>
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
<script type="text/javascript" src="js/loan/preRepay.js"></script>
</body>
</html>

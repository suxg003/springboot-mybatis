<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>渠道详细数据</title>
    <%@include file="../../common/head.jspf" %>
    <link href="/assets/css/quickLoanRequest.css" rel="stylesheet"/>
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet"/>
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
                    <li class="active">渠道数据统计</li>
                    <li class="active">渠道详细数据</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>[${typeName}][${sourcesName}]数据统计 </h1>
                </div>
                <input type="hidden" id="type" value="${type}">
                <input type="hidden" id="source" value="${source}">
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

                        <div>
                            <div class="row">
                                <div class="col-md-12 F-right">
                                    <div class="buttons-preview">
                                        <span class="F-left MargT-5  MargR-5">时间范围:</span>
                                        <div class="controls col-lg-3 col-sm-3 col-xs-3"
                                             style="display:inline-block">
                                            <div class="input-group">
					                            	<span class="input-group-addon">
					                                	<i class="fa fa-calendar"></i>
					                            	</span><input type="text" class="form-control input-sm active"
                                                                  id="reservation">
                                            </div>
                                        </div>
                                        <cm:securityTag privilegeString="STATISTICS_SOURCES">
                                            <a id="btn_search" class="btn btn-sm btn-blue">查询</a>
                                            <a id="btn_excel" href="#" class="btn btn-sm btn-blue">导出报表</a>
                                        </cm:securityTag>
                                    </div>
                                </div>
                            </div>
                            <div style="clear:both;"></div>
                        </div>
                        <div id="defaultData">
                            <div class="tab-content">
                                <tr> 用户统计列表</tr>
                                <table class="table table-hover dataTable no-footer">
                                    <thead class="bordered-blue">
                                    <tr>
                                        <th></th>
                                        <c:if test="${type == 'IOS' || type == 'ANDROID'}">
                                            <th>激活人数</th>
                                        </c:if>
                                        <c:if test="${type == 'MSTATION' || type == 'WECHAT' || type == 'WEB'}">
                                            <th>UV</th>
                                            <th>PV</th>
                                        </c:if>
                                        <th>注册人数</th>
                                        <th>实名人数</th>
                                        <th>充值人数</th>
                                        <th>投资人数</th>
                                        <th>注册转化率</th>
                                        <th>实名转化率</th>
                                        <th>充值转化率</th>
                                        <th>投资转化率</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${list}" var="entry">
                                        <tr>
                                            <th><c:out value="${entry.comments}" default="无"></c:out></th>

                                            <c:if test="${type == 'IOS' || type == 'ANDROID'}">
                                                <th><c:out value="${entry.activateNum}" default="0"></c:out></th>
                                            </c:if>
                                            <c:if test="${type == 'MSTATION' || type == 'WECHAT' || type == 'WEB'}">
                                                <th><c:out value="${entry.uv}" default="0"></c:out></th>
                                                <th><c:out value="${entry.pv}" default="0"></c:out></th>
                                            </c:if>

                                            <th><c:out value="${entry.registerNum}" default="0"></c:out></th>
                                            <th><c:out value="${entry.idAuthNum}" default="0"></c:out></th>
                                            <th><c:out value="${entry.rechargeNum}" default="0"></c:out></th>
                                            <th><c:out value="${entry.investNum}" default="0"></c:out></th>
                                            <th><c:out value="${entry.registerConversionRate}" default="0"></c:out></th>
                                            <th><c:out value="${entry.authIdConversionRate}" default="0"></c:out></th>
                                            <th><c:out value="${entry.rechargeConversionRate}" default="0"></c:out></th>
                                            <th><c:out value="${entry.investConversionRate}" default="0"></c:out></th>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="tab-content" style="margin-top: 25px">
                                <tr> 投资统计列表</tr>
                                <table class="table table-hover dataTable no-footer">
                                    <thead class="bordered-blue">
                                    <tr>
                                        <th></th>
                                        <th>充值金额(元)</th>
                                        <th>投资金额(元)</th>
                                        <th>活期投资金额(元)</th>
                                        <th>客户单价(元)</th>
                                        <th>留存资金(元)</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${list}" var="entry">
                                        <tr>
                                            <th><c:out value="${entry.comments}" default="0"></c:out></th>
                                            <th><c:out value="${entry.rechargeAmount}" default="0"></c:out></th>
                                            <th><c:out value="${entry.investAmount}" default="0"></c:out></th>
                                            <th><c:out value="${entry.investCurrAmount}" default="0"></c:out></th>
                                            <th><c:out value="${entry.price}" default="0"></c:out></th>
                                            <th><c:out value="${entry.retainedAmount}" default="0"></c:out></th>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <div id="detailData" style="display: none;">
                            <div class="tab-content">

                                <table id="numTable" class="table table-hover dataTable no-footer">
                                    <thead class="bordered-blue">
                                    <tr>
                                        <th width="10%"></th>
                                        <th>UV</th>
                                        <th>PV</th>
                                        <th>激活人数</th>
                                        <th>注册人数</th>
                                        <th>实名人数</th>
                                        <th>充值人数</th>
                                        <th>投资人数</th>
                                        <th>注册转化率</th>
                                        <th>实名转化率</th>
                                        <th>充值转化率</th>
                                        <th>投资转化率</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="tab-content" style="margin-top: 25px">
                                <table id="amountTable" class="table table-hover dataTable no-footer">
                                    <thead class="bordered-blue">
                                    <tr>
                                        <th></th>
                                        <th>充值金额(元)</th>
                                        <th>投资金额(元)</th>
                                        <th>活期投资金额(元)</th>
                                        <th>客户单价(元)</th>
                                        <th>留存资金(元)</th>
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
            </div>
        </div>
    </div>
</div>

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

<script src="/assets/js/analysis/sources/detail.js"></script>

<script>
    var sourcesDetail = new Func();
    sourcesDetail.init();
</script>

</body>
</html>

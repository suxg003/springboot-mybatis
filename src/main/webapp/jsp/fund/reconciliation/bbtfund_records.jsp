<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/25
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta name="description" content="系统测试平台管理系统"/>
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
                    <li class="active">资金管理</li>
                    <li class="active">平台资金记录</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1> 平台资金记录 </h1>
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

                    <div id="page-content" class="">
                        <div class="row">

                            <div class="col-lg-12">
                                <div class="widget-header bordered-bottom bordered-sky blue">
                                    <i class="fa fa-users widget-caption Font-16 MargR-10"></i>
                                    <span class="widget-caption Font-16">商户账户</span>

                                </div>

                                <div class="widget-body">
                                    <div class="row">
                                        <div class="col-lg-4 col-sm-4 col-xs-12">
                                            <div class="userCard">
                                                <div class="card-header">
                                                    <div class="pull-left blue card-type">
                                                        <i class="fa fa-credit-card blue"></i>

                                                    </div>
                                                    <div class="pull-right blue card-number">
                                                        平台资金
                                                    </div>
                                                </div>
                                                <div class="card-content">
                                                    <div class="card-detail">
                                                        <span class="">账户B可用余额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${accountBAmount}" /></span>
                                                    </div>
                                                    <div class="card-detail">
                                                        <span class="">账户A可用余额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${accountAAmount}" /></span>
                                                    </div>

                                                    <div class="card-detail">
                                                        <span class="">账户C可用余额：</span>
                                                        <c:if test="${accountCAmount!=null}">
                                                        <span class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${accountCAmount}" /></span>
                                                        </c:if>
                                                        <c:if test="${accountCAmount==null}">
                                                            <span class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="0" /></span>
                                                        </c:if>
                                                    </div>

                                                    <div class="card-detail">
                                                        <span class="">总服务费：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${accountFeeAmount}" /></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>



                                        <div class="col-lg-4 col-sm-4 col-xs-12">
                                            <div class="userCard">
                                                <div class="card-header">
                                                    <div class="pull-left blue card-type">
                                                        <i class="fa fa-credit-card blue"></i>

                                                    </div>
                                                    <div class="pull-right blue card-number">
                                                        平台充值与提现
                                                    </div>
                                                </div>
                                                <div class="card-content">
                                                    <div class="card-detail">
                                                        <span class="">账户B充值金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${platBDeposit}" /></span>
                                                    </div>
                                                    <div class="card-detail">
                                                        <span class="">账户B提现金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${platBWithdraw}" /></span>
                                                    </div>
                                                    <div class="card-detail">
                                                        <span class="">账户B转出金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${outBAmount}" /></span>
                                                    </div>
                                                    <div class="card-detail">
                                                        <span class="">账户A充值金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${platADeposit}" /></span>
                                                    </div>
                                                    <div class="card-detail">
                                                        <span class="">账户A提现金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${platAWithdraw}" /></span>
                                                    </div>
                                                    <div class="card-detail">
                                                        <span class="">账户A转出金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${outAAmount}" /></span>
                                                    </div>
                                                    <div class="card-detail">
                                                        <c:if test="${platCDeposit!=null}">
                                                        <span class="">账户C充值金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${platCDeposit}" /></span>
                                                        </c:if>
                                                        <c:if test="${platCDeposit==null}">
                                                            <span class="">账户C充值金额：</span><span
                                                                class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="0" /></span>
                                                        </c:if>
                                                    </div>
                                                    <div class="card-detail">
                                                        <span class="">账户C提现金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${platCWithdraw}" /></span>
                                                    </div>
                                                    <div class="card-detail">
                                                        <span class="">账户C转出金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${outCAmount}" /></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 col-sm-4 col-xs-12">
                                            <div class="userCard">
                                                <div class="card-header">
                                                    <div class="pull-left blue card-type">
                                                        <i class="fa fa-credit-card blue"></i>

                                                    </div>
                                                    <div class="pull-right blue card-number">
                                                        用户充值与提现
                                                    </div>
                                                </div>
                                                <div class="card-content">
                                                    <div class="card-detail">
                                                        <span class="">用户充值金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${userDeposit}" /></span>
                                                    </div>
                                                    <div class="card-detail">
                                                        <span class="">用户提现金额：</span><span
                                                            class="red bold"><fmt:formatNumber type="currency" pattern="#,###.##" value="${userWithdraw}" /></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="row MargT-20">
                            <div class="col-lg-12 col-sm-12 col-xs-12">
                                <div class="widget-header bordered-bottom bordered-sky blue">
                                    <i class="fa fa-list-alt widget-caption Font-16 MargR-10"></i>
                                    <span class="widget-caption Font-16">平台资金记录</span>

                                </div>
                                <div class="widget-body">
                                    <div class="widget-main no-padding">
                                        <div>
                                            <div class="row">
                                                <div class="col-md-12 F-right">
                                                    <div class="buttons-preview">
                                                        <span class="F-left MargT-5  MargR-5">资金类型:</span>
                                                        <select name="operationType" id="operetionType"
                                                                class="F-left MargR-10" style="padding: 4px 12px;">
                                                            <option value="">全部</option>
                                                            <c:forEach items="${changeTypes}" var="item">
                                                                <option value="${item}">${item.key}</option>
                                                            </c:forEach>
                                                        </select>
                                                        <span class="F-left MargT-5">日期范围：</span>

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
                                                        <a id="link_down" class="btn btn-sm btn-palegreen">下载</a>


                                                    </div>
                                                </div>
                                            </div>
                                            <div style="clear:both;"></div>
                                        </div>
                                        <table id="bbtFundRecordsTable" class="table table-hover dataTable no-footer">
                                            <thead>
                                            <tr>
                                                <th>订单号</th>
                                                <th>用户名</th>
                                                <th>用户姓名</th>
                                                <th>类型</th>
                                                <th>订单金额</th>
                                                <th>可用余额</th>
                                                <th>状态</th>
                                                <th>备注</th>
                                                <th>日期</th>
                                                <th>平台账户</th>
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
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>

<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/datetime/moment.min.js"></script>
<script src="/assets/js/datetime/daterangepicker.min.js"></script>
<script src="/assets/js/select2/select2.js"></script>
<script src="/assets/js/fund/reconciliation/bbtFundRecords.js"></script>


<script type="text/javascript">
    //日历
    $('#reservation').daterangepicker();

</script>

</body>
</html>
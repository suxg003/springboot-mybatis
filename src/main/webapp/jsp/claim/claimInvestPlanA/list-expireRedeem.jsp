<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>到期赎回列表</title>
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
                    <li class="active">债权项目</li>
                    <li class="active">定期计划A</li>
                    <li class="active">到期赎回列表</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>到期赎回列表 </h1>
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

                        <div>
                            <div class="row">
                                <div class="col-md-12 F-right">
                                    <div class="buttons-preview">
                                        <span class="F-left MargT-5  MargR-5">到期时间:</span>

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
                                        <cm:securityTag privilegeString="USER_TRANSFER_AUDIT">
                                            <input type="hidden" value="USER_TRANSFER_AUDIT" id="USER_TRANSFER_AUDIT">

                                            <span id="link_audit_all" class="F-right btn btn-sm btn-blue"
                                                  style="margin-top: 4px;">批量通过</span>

                                        </cm:securityTag>
                                    </div>
                                </div>
                            </div>
                            <div style="clear:both;"></div>
                        </div>
                        <table id="reApRedeemTable" class="table table-hover dataTable no-footer">
                            <thead class="bordered-blue">
                            <tr>
                                <th>
                                    <label class="MargB-0">
                                        <input type="checkbox" id="check_all">
                                        <span class="text bold">全选</span>
                                    </label>
                                </th>
                                <th>订单号</th>
                                <th>投资人账户名</th>
                                <th>投资人姓名</th>
                                <th>到期赎回金额</th>
                                <th>本金</th>
                                <th>利息</th>
                                <th>到期时间</th>
                                <th>赎回方式</th>
                                <th>状态</th>
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

<script src="/assets/js/claim/expireRedeem-list.js"></script>

<script>
    var pARedeem = new Func("FIXED_DEPOSIT_1", "AUDITING");
    pARedeem.init();
</script>

</body>
</html>

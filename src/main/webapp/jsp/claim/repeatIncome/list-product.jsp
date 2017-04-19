
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
    <title>复利计划-产品列表</title>
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
                    <li class="active">债权项目</li>
                    <li class="active">复利计划</li>
                    <li class="active">产品列表</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1> 产品列表 </h1>
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
                                            <span class="F-left MargT-5  MargR-5">时间类型:</span>
                                            <select name="operationType" id="operetionType"
                                                    class="F-left MargR-10 select-size">
                                                <option value="">请选择</option>
                                                <option value="PUBLISH">发布时间</option>
                                                <option value="FULL">满标时间</option>
                                            </select>

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
                                    <th>产品名称</th>
                                    <th>当前发布金额</th>
                                    <th>当前剩余金额</th>
                                    <th>发布时间</th>
                                    <th>满标时间</th>
                                    <th>状态</th>
                                    <th>年化利率</th>
                                    <th>可提前赎回</th>
                                    <th>提前赎回费率</th>
                                    <th>赎回方式</th>
                                    <th>产品类型</th>
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

<script src="/assets/js/claim/product-list.js"></script>

<script>
    var reClaim = new Func("RECYCLE_INTEREST","reInvest");
    reClaim.init();
</script>

</body>
</html>

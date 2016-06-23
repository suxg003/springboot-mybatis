<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/10/19
  Time: 13:47
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>发布新计划</title>
    <%@include file="../common/head.jspf" %>
    <link rel="stylesheet" href="/assets/css/uplan/newPlan.css"/>
    <link rel="stylesheet" href="/assets/css/dataTables.bootstrap.css"/>

</head>
<body class="navbar-fixed">
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
                    <li class="active">债权项目</li>
                    <li class="active">发布产品</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        发布新产品
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
                <form class="form-horizontal new-plan-form" name="new-plan-form" id="newProductForm" action="/claimProduct/publishProduct" method="POST">
                    <div class="widget-box transparent">
                        <div class="wizard" style="padding-bottom:40px">
                            <div class="form-group">&nbsp;</div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">可用债权价值：</label>
                                <div class="col-lg-4">
                                    <span id="span_claim_remain_amount" style="color:red;"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">选择产品：</label>
                                <div class="col-lg-4"><select id="productType" name="productType">
                                        <option value="MONTH_WIN">月盈计划</option>
                                        <option value="RECYCLE_INTEREST">复利计划</option>
                                        <option value="FIXED_DEPOSIT_1">定期计划A</option>
                                        <option value="FIXED_DEPOSIT_3">定期计划B</option>
                                        <option value="FIXED_DEPOSIT_6">定期计划C</option>
                                        <option value="FIXED_DEPOSIT_9">定期计划D</option>
                                        <option value="CURRENT_DEPOSIT">活期理财</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">产品名称：</label>
                                <div class="col-lg-4">
                                    <div class="input-group">
                                        <input type="text" id="productName" name="productName" value="" class="form-control" placeholder="输入产品名称">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">发布金额：</label>
                                <div class="col-lg-4">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-yen"></i></span>
                                        <input type="text" id="amount" name="amount" value="" class="form-control" placeholder="输入发布金额">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">起投金额：</label>
                                <div class="col-lg-4">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-yen"></i></span>
                                        <input type="text" id="minAmount" name="minAmount" value="" class="form-control" placeholder="输入起投金额">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">最大投资金额：</label>
                                <div class="col-lg-4">
                                    <div class="input-group">
                                        <span class="input-group-addon"><i class="fa fa-yen"></i></span>
                                        <input type="text" id="maxAmount" name="maxAmount" value="" class="form-control" placeholder="输入最大投资金额">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">投资增量：</label>
                                <div class="col-lg-4">
                                    <input type="text" id="increaseNum" name="increaseNum" class="form-control pull-left" placeholder="输入投资增量"
                                    data-bv-notempty="true"
                                    data-bv-notempty-message="" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label"><span id="span_ratetype_text">固定</span>年化利率(%)：</label>
                                <div class="col-lg-4">
                                    <div class="input-group ">
                                        <input type="text" id="fixedRate" name="fixedRate" class="form-control">
                                        <div class="fixedRateWarp">
	                                    	
	                                    </div>
                                    </div>                                    
                                </div>
                            </div>
                            <div id="div_group_closurePeriod" class="form-group">
                                <label class="col-lg-3 control-label">投资期限(月)：</label>
                                <div class="col-lg-4">
                                    <div class="input-group">
                                        <input type="text" id="closurePeriod" name="closurePeriod" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">计息时间：</label>
                                <div class="col-lg-4">
                                    <select id="countRateType" name="countRateType">
                                        <option value="">请选择</option>
                                        <option value="T_0">投资当日</option>
                                        <option value="T_1">投资次工作日</option>
                                        <option value="T_2">投资后第二个工作日</option>
                                    </select>
                                </div>
                            </div>
                            <div id="div_group_repayType" class="form-group">
                                <label class="col-lg-3 control-label">还款方式：</label>
                                <div class="col-lg-4">
                                    <select class="sel_linkage">
                                        <option value="MONTHLY_INTEREST">按月付息，到期还本付息</option>
                                        <option value="BULLET_REPAYMENT">一次性还本付息</option>
                                    </select>
                                    <input type="hidden" id="planRepaymentType" name="planRepaymentType" value="MONTHLY_INTEREST">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">是否可提前赎回：</label>
                                <div class="col-lg-4">
                                    <select class="sel_linkage">
                                        <option value="1">是</option>
                                        <option value="0" selected="selected">否</option>
                                    </select>
                                    <input type="hidden" id="flagCanbreak" name="flagCanbreak" value="0">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">赎回方式：</label>
                                <div class="col-lg-4">
                                    <select class="sel_linkage">
                                        <option value="MANUAL_EXPIRE">手动</option>
                                        <option value="AUTO_EXPIRE" selected="selected">自动</option>
                                    </select>
                                    <input type="hidden" id="expireOutType" name="expireOutType" value="AUTO_EXPIRE">
                                </div>
                            </div>
                            <div class="form-group" id="breakRateBox">
                                <label class="col-lg-3 control-label">提前赎回费率(%)：</label>
                                <div class="col-lg-4">
                                    <div class="input-group">
                                        <input type="text" id="breakRate" name="breakRate" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" id="flagRedpack-group">
                                <label class="control-label col-lg-3" for="flagRedpack"><em>*</em>是否可使用红包：</label>
                                <div class="controls col-lg-4">
                                    <label class="radio-inline">
                                      <input type="radio" value="1" style="position:relative;left:0;height:auto;opacity:1" name="flagRedpack" checked="checked"> 是
                                    </label>
                                    <label class="radio-inline">
                                      <input type="radio" value="0" style="position:relative;left:0;height:auto;opacity:1" name="flagRedpack"> 否
                                    </label>
                                </div>
                            </div>
                            <div class="form-group" id="newFlag-group">
                                <label class="control-label col-lg-3"><em>*</em>是否支持新手标：</label>
                                <div class="controls col-lg-4">
                                    <label class="radio-inline">
                                        <input type="radio" value="1" style="position:relative;left:0;height:auto;opacity:1" name="flagFresh"> 是
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" value="0" style="position:relative;left:0;height:auto;opacity:1" name="flagFresh" checked="checked"> 否
                                    </label>
                                </div>
                            </div>
                            <div class="form-group" id="bigFlag-group">
                                <label class="control-label col-lg-3"><em>*</em>是否支持大额标：</label>
                                <div class="controls col-lg-4">
                                    <label class="radio-inline">
                                        <input type="radio" value="1" style="position:relative;left:0;height:auto;opacity:1" name="flagBig"> 是
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" value="0" style="position:relative;left:0;height:auto;opacity:1" name="flagBig" checked="checked"> 否
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-4"></label>
                                <div class="controls col-lg-6">
                                    <button type="submit" class="btn btn-primary">确定发布</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>


<%@include file="../common/foot.jspf" %>
<!-- jquery dataTables -->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/customerBootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/claim/newproduct.js" type="text/javascript"></script>
</body>
</html>
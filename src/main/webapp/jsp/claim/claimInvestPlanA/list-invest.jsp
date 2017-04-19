<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<title>投资列表</title>
<%@include file="../../common/head.jspf"%>
<link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
<link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
</head>
<body class="navbar-fixed">
	<%@include file="../../common/navbar.jspf"%>
	<div class="main-container container-fluid">
		<!-- Page Container start-->
		<div class="page-container">
			<%@include file="../../common/sidebar.jspf"%>
			<!-- Page Content -->
			<div class="page-content">
				<!-- Page Breadcrumb -->
				<div class="page-breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="fa fa-home"></i> <a href="/">首页</a></li>
						<li class="active">债权项目</li>
						<li class="active"><a href="/claimProduct/claimInvestPlanA/proList">定期计划A</a></li>
						<li class="active">投资列表</li>
					</ul>
				</div>
				<!-- /Page Breadcrumb -->
	            <!-- Page Header -->
	            <div class="page-header position-relative">
	                <div class="header-title">
	                    <h1>投资列表 </h1>
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
		                <div class="col-lg-12 col-sm-12 col-xs-12" style="margin-bottom:30px;">
		                    <div class="widget-header bordered-bottom bordered-blue blue">
		                        <span class="widget-caption Font-16">产品详情</span>
		                    </div>
		
		                    <div class="widget-body">
		                        <div class="row detail-invest">
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
		                            	产品名称：${product.productName}
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										当期发布金额：<span class="red bold"><fmt:formatNumber type="number" pattern="#,###.##" value="${product.amount}"/>元</span>
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										当期剩余金额：<span class="red bold"><fmt:formatNumber type="number" pattern="#,###.##" value="${product.remainAmount}"/>元</span>
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										发布时间：<fmt:formatDate pattern="yyyy-MM-dd" value="${product.submitTime}"/>
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										满标时间：<fmt:formatDate pattern="yyyy-MM-dd" value="${product.investEndDate}"/>
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										年化收益：
										<c:choose>
			                              	<c:when test="${product.fixedRate != null}">
			                              		<fmt:formatNumber type="number" maxFractionDigits="2" value="${product.fixedRate}" />%
			                              	</c:when>
			                            	<c:otherwise></c:otherwise>
		                            	</c:choose>										
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										计息时间：${product.countRateType.key}
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										还款方式：${product.planRepaymentType.key}
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										封闭期：${product.closurePeriod}个月
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										是否可提前赎回：
		                                <c:choose>
		                                    <c:when test="${product.flagCanbreak == true}">是</c:when>
		                                    <c:otherwise>否</c:otherwise>
		                                </c:choose>
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										赎回方式：${product.expireOutType.key}
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										起投金额：<span class="red bold"><fmt:formatNumber type="number" pattern="#,###.##" value="${product.minAmount}"/>元</span>
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										最高限额：<span class="red bold"><fmt:formatNumber type="number" pattern="#,###.##" value="${product.maxAmount}"/>元</span>
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										投资增量：<span class="red bold"><fmt:formatNumber type="number" pattern="#,###.##" value="${product.increaseNum}"/>元</span>
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										提前赎回费率：
										<c:choose>
			                              	<c:when test="${product.breakRate != null}">
			                              		<fmt:formatNumber type="number" maxFractionDigits="2" value="${product.breakRate}" />%
			                              	</c:when>
			                            	<c:otherwise></c:otherwise>
		                            	</c:choose>										
										
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
		                            	 是否使用红包：<c:choose>
		                                    <c:when test="${product.flagRedpack == false}"><span >否</span></c:when>
		                                    <c:when test="${product.flagRedpack == true}"><span>是</span></c:when>
		                                </c:choose>
		                            </div>
		                            <div class="col-lg-3 col-sm-3 col-xs-12 margin-bottom-10">
										 状态：
		                                <c:choose>
		                                    <c:when test="${product.status == 'FINISHED'}"><span class="red">已结束</span></c:when>
		                                    <c:when test="${product.status == 'CLOSED'}"><span class="green">已满标</span></c:when>
		                                    <c:otherwise><span class="red">未满标</span></c:otherwise>
		                                </c:choose>
		                            </div>
		                        </div>
		                        <div class="row text-center margin-top-10">
		                            <a href="javascript:;" class="btn btn-sm btn-blue" id="back-pro">返回产品列表</a>
		                        </div>
		                    </div>
		                </div>
		                
						<div class="col-lg-12 col-sm-12 col-xs-12">
						    <div class="widget-header bordered-bottom bordered-blue blue">
						        <span class="widget-caption Font-16">投资记录</span>
						
						    </div>
						
						    <div class="widget-body">
								<div class="table-toolbar">
									<div id="investRecordHistory"
										style="padding-bottom: 15px; height: 30px;">
										<div class="control-group  pull-left">
											<label for="date-range-picker" class="control-label pull-left"
												style="width: 100px; line-height: 30px;">投资日期范围</label>
		
                                            <div class="controls col-lg-3 col-sm-3 col-xs-3"
                                                 style="width: 230px; ">
                                                <div class="input-group">
					                            	<span class="input-group-addon"><i class="fa fa-calendar"></i>
					                            	</span><input type="text" class="form-control input-sm active" id="reservation">
                                                </div>
                                            </div>
										</div>
										<div class="control-group pull-left">
											<button id="btn_search" class="btn btn-sm btn-blue">查询</button>
											
										</div>
										
										
									</div>
									<div class="row">&nbsp;</div>
									<div class="scrollWrapper">
										<table class="table table-striped table-hover dataTable no-footer" id="reProRecordsTable" aria-describedby="simpledatatable_info">
											<thead id="list_tb" class="bordered-blue">
												<tr>
													<th>订单号</th>
													<th>投资人账户名</th>
													<th>投资人姓名</th>
													<th>投资金额</th>
													<th>投资时间</th>
													<th>计息时间</th>
													<th>年化利率</th>
													<th>状态</th>
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
						
					</div>
				</div>
			</div>
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

<%@include file="../../common/foot.jspf"%>
<!--Page Related Scripts-->

<script src="/assets/js/datetime/daterangepicker.min.js"></script>
<script src="/assets/js/datetime/moment.js"></script>
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/amountFormat.js"></script>
<script src="/assets/js/bbtTool.js"></script>

<script src="/assets/js/claim/invest-list.js" type="text/javascript"></script>

</body>
</html>

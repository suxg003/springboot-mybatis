<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/18
  Time: 14:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
       <title>逾期欠款列表</title>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
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
                    <li class="active">项目管理</li> 
                    <li class="active">贷后管理</li>
                    <li class="active">逾期欠款列表</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h4>
                 逾期欠款列表
                    </h4>
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
				<div class="">
				    <div class="tabbable">
						<ul class="nav nav-tabs" id="myTab">
				            <li class="active">
				                <a data-toggle="tab" href="#zhitou">
				                    	直投项目
				                </a>
				            </li>
				           <%-- <li class="">
				                <a data-toggle="tab" href="#youxuan">
				                    	优选计划
				                </a>
				            </li>--%>
				
				        </ul>
				
				        <div class="tab-content">
				            <div id="zhitou" class="tab-pane active">
				            <%--<form action="/postLoan/overdue" class="pull-right no-margin form-horizontal" method="POST">
									<div class="col-lg-12 col-sm-12 col-xs-12">
										<div class="control-group pull-right text-right" style="width:200px;">
											<button class="btn btn-small btn-primary" id="searchHistory">查询</button>
											<a class="btn btn-small btn-danger downloadLink"
											   id="downloadHistory"
											   href="">下载
											</a>
										</div>
										<div class="form-group pull-right" style="width:350px;">
											<label for="date-range-picker" class="col-sm-4 control-label no-padding-right ">日期范围&nbsp;&nbsp;&nbsp;</label>
											<div class="input-group F-left col-md-8">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>			            	
												<input type="text" name="date-range-picker"
													id="date-range-picker" class="form-control investRecordRange" />
											</div>
										</div>
									</div>
								   
								</form>
                                <div class="clearfix"></div>
                                <hr class="wide">--%>
								<table class="table table-striped table-hover dataTable no-footer" id="BBT-list" aria-describedby="simpledatatable_info">
								    <thead id="list_th">
										<tr>
											<th>借款人</th>
											<th>借款标题</th>
											<th>期数</th>
											<th>待还本息</th>
											<th>账户余额</th>
											<th>到期日</th>
											<th>状态</th>
											<th>操作</th>
										</tr>
										</thead>
										<tbody>
										<c:forEach var="repay" items="${it}">
											<tr>
												<td>
													<a href="/user/profile/?userId=${repay.loanerId}">
														${repay.loaner}
													</a>
												</td>
												<td>
													<a href="/loan/0/${repay.loanId}">
														${repay.loanTitle}
													</a>
												</td>
												
												<td>
													第${repay.currentPeriod}期
												</td>
												<td>
													<fmt:formatNumber type="currency" value="${repay.amountInterest+repay.amountPrincipal}"/>
												</td>
												<td>
													<fmt:formatNumber type="currency" value="${repay.loanerAvailableAmount}"/>
												</td>
											
												<td>
													<fmt:formatDate value="${repay.dueDate}" pattern="yyyy-MM-dd hh:mm:ss"/>
												</td>
												<td>
													<c:choose>
														<c:when test="${repay.repayStatus == 'UNDUE'}">
															逾期
														</c:when>
														<c:otherwise>
															${repay.repayStatus.key}
														</c:otherwise>
													</c:choose>
												</td>
												<td>
														<%--<button class="btn btn-sm btn-success repay-btn"--%>
														<%--data-url="postLoan/repay/BBT/${repay.id}">--%>
														<%--还款--%>
														<%--</button>--%>
													<span class="mx-tip-fa">
														<button class="btn btn-sm btn-yellow detail-btn">
															还款明细
														</button>
														<div class="tip-cell">
															<div class="x">
																<div class="content">
																	<p>还款期数：<span class="red">第${repay.currentPeriod}期</span></p>
																	<p>应还本金：<span class="red">￥${repay.amountPrincipal}</span></p>
																	<p>应还利息：<span class="red">￥${repay.amountInterest}</span></p>
																	<p>剩余本金：<span class="red">￥${repay.amountOutStanding}</span></p>
																</div>
																<div class="z">◆</div>
																<div class="y">◆</div>
															</div>
														</div>
													</span>		
												</td>
											</tr>
										</c:forEach>
										</tbody>
								</table>				               

				            </div>
				            <div id="youxuan" class="tab-pane">
				            <%--<form action="/postLoan/overdue" class="pull-right no-margin form-horizontal" method="POST">
									<div class="col-lg-12 col-sm-12 col-xs-12">
										<div class="control-group pull-right text-right" style="width:200px;">
											<button class="btn btn-small btn-primary" id="searchHistory">查询</button>
											<a class="btn btn-small btn-danger downloadLink"
											   id="downloadHistory"
											   href="">下载
											</a>
										</div>
										<div class="form-group pull-right" style="width:350px;">
											<label for="date-range-picker" class="col-sm-4 control-label no-padding-right ">日期范围&nbsp;&nbsp;&nbsp;</label>
											<div class="input-group F-left col-md-8">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>			            	
												<input type="text" name="date-range-picker"
													id="date-range-picker" class="form-control investRecordRange" />
											</div>
										</div>
									</div>
								   
								</form>
                                <div class="clearfix"></div>
                                <hr class="wide">--%>
								<table class="table table-striped table-hover dataTable no-footer" id="UPLAN-list" aria-describedby="simpledatatable_info">
								    <thead id="list_th">
										<tr>
											<th>借款人</th>
											<th>借款标题</th>
											<th>期数</th>
											<th>待还本息</th>
											<th>账户余额</th>
											<th>到期日</th>
											<th>状态</th>
											<th>操作</th>
										</tr>
									</thead>
								</table>				               
				            
				            </div>
				
				        </div>
				    </div>
				    <div class="horizontal-space"></div>
				
				</div>

            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>

<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/datetime/daterangepicker.min.js" type="text/javascript"></script>
<script src="/assets/js/datetime/moment.js" type="text/javascript"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/postLoan/overdue.js"></script>
<script>
$('.investRecordRange').daterangepicker({
    format: 'YYYY-MM-DD',
    opens: 'left',
    ranges: {
        '今天': [moment(), moment()],
        '昨天': [moment().subtract('days', 1), moment().subtract('days', 1)],
        '过去一周': [moment().subtract('days', 6), moment()],
        '过去30天': [moment().subtract('days', 29), moment()],
        '本月': [moment().startOf('month'), moment().endOf('month')],
        '上个月': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
    },
    startDate: moment().subtract('days', 29),
    endDate: moment(),
    locale: {
        applyLabel: '确定',
        clearLabel: "取消",
        fromLabel: '开始时间',
        toLabel: '结束时间',
        weekLabel: '周',
        customRangeLabel: '选择范围',
        daysOfWeek: "日_一_二_三_四_五_六".split("_"),
        monthNames: "一月_二月_三月_四月_五月_六月_七月_八月_九月_十月_十一月_十二月".split("_"),
        firstDay: 0
    }
}, function(start, end) {
    $('.investRecordRange').val(start.format("YYYY-MM-DD")+' - '+ end.format("YYYY-MM-DD"));
}).prev();
$('input[name=date-range-picker]').val(moment().subtract('days', 29).format("YYYY-MM-DD")+' - '+ moment().format("YYYY-MM-DD"));


</script>
</body>
</html>
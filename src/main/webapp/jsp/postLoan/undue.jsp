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
    <title>尚未到期欠款</title>
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
                    <li class="active">尚未到期欠款</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                       尚未到期欠款(同当日还款)
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
            
				<div class="">
				    <div class="tabbable">
						<ul class="nav nav-tabs" id="myTab">
				            <li class="active">
				                <a data-toggle="tab" href="#zhitou">
				                    	直投项目
				                </a>
				            </li>
				            <li class="tab-red">
				                <a data-toggle="tab" href="#youxuan">
				                  	  优选计划
				                </a>
				            </li>
				        </ul>
				
				        <div class="tab-content" style="padding-bottom:50px;">
				            <div id="zhitou" class="tab-pane active">

								<table class="table table-striped table-hover dataTable no-footer" id="BBT-list" aria-describedby="simpledatatable_info">
								    <thead id="list_th">
										<tr>
								                <th>借款人</th>
								                <th>借款标题</th>          
								                <th>期数</th>
								                <th>待还本息 </th>
								                <th>账户余额</th>
								                <th>到期日</th>
											    <th>状态</th>
								                <th>操作</th>
								        </tr>
								    </thead>
								    <tbody>

									</tbody>
								</table>
				            </div>
				
				            <div id="youxuan" class="tab-pane">

								<table class="table table-striped  table-hover dataTable no-footer"  id="UPLAN-list">
								    <thead id="">
										<tr>
											<th>借款人</th>
								        	<th>产品名称</th>
								            <th>待还本息</th>
								            <%--<th>借款期限</th>		 --%>		       
								            <th>投标数</th>
								            <th>到期日</th>
											<th>操作</th>
								        </tr>
								    </thead>
								    <tbody>
								    	<c:forEach items="${uploanTodayList }" var="uploanToday" >
										<tr>
											<td>
												<a href="/user/profile/?userId=${uploanToday.planerId}">
														${uploanToday.planerName} </a>
											</td>
											<td>
												<a href="/uplan/details/${uploanToday.planId}/showAllInfos">
													${uploanToday.productName}
											    </a>
											</td>
											<td>￥${uploanToday.totalPrincipal+uploanToday.totalInterrest }</td>
											<%--<td>${uploanToday.timeLimit }天</td> --%>
											<td>${uploanToday.bids }</td>
											<td><fmt:formatDate value="${uploanToday.repaymentDate }"
                                                                         pattern="yy年M月d日 HH:mm"/></td>
											<td>
												<a class="btn btn-sm btn-success repay-btn"
												   onclick="showConfirm('确定要还款【${uploanToday.productName}】么？','/postLoan/repay/UPLAN/${uploanToday.planId}')"
														>
													还款
												</a>
											</td>
										</tr>
									</c:forEach>				       
									</tbody>
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
<script src="/assets/js/toastr/toastr.js"></script>
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
<script src="/assets/js/postLoan/undue.js"></script>

<script type="text/javascript">
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
    startDate: moment(),
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
    //$('.investRecordRange').val(moment().subtract('days', 6).format("YYYY-MM-DD")+' - '+ moment().format("YYYY-MM-DD"));
}).prev();

<c:if test="${not empty start}">
$('input[name=date-range-picker]').val('${start} - ${end}');
</c:if>
<c:if test="${empty start}">
$('input[name=date-range-picker]').val(moment().subtract('days', 6).format("YYYY-MM-DD")+' - '+ moment().format("YYYY-MM-DD"));
</c:if>

</script>
</body>
</html>
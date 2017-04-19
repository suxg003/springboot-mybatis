
<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/18
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>现金红包</title>
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
                    <li class="active">营销管理</li>
                    <li class="active">红包</li>
                    <li class="active">现金红包查询</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        现金红包查询
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
                <div class="well">
<!--                     <div class="table-toolbar"> -->
<!--                         <a  class="btn btn-small " -->
<!--                            data-toggle="modal" -->
<!--                            href="" id = "downloadHistoryBtn"> -->
<!--                             <i class="fa fa-download"></i>下载列表 -->
<!--                         </a> -->
<!--                     </div> -->
					<div class="row">
						<div class="col-lg-5 col-sm-5 col-xs-5 F-right">
							<div class="buttons-preview">
								<span class="F-left MargT-5" >日期范围：</span>
								<div class="controls col-lg-7 col-sm-7 col-xs-7" style="display:inline-block">
	                                <div class="input-group">
	                                    <span class="input-group-addon">
	                                        <i class="fa fa-calendar"></i>
	                                    </span>
	                                    <input type="text" class="form-control input-sm active" name="date-range-picker" id="date-range-picker">
	                                </div>
	                            </div>
				            	<a href="javascript:void(0);" id ="searchRechargeHistory" class="btn btn-sm btn-blue">查询</a>
				            	<a href="javascript:void(0);" id="downloadHistoryBtn" class="btn btn-sm btn-palegreen">下载</a>

				            </div>
						</div>
					
	                    <div class="form-horizontal gift-left gift-height col-lg-5 col-sm-5 col-xs-5">
                            <div class="form-group">
                                <label class="gift-lable col-sm-2 control-label no-padding-right">红包类型</label>

                                <div class="giftclass col-sm-10">
                                    <c:if test="${typesList !=null}">
                                        <select id="redPackage" class="giftoption">
                                            <option value=""></option>
                                            <c:forEach var="type" items="${typesList}">
                                                <option value="${type}">${type.key}</option>
                                            </c:forEach>
                                        </select>
                                    </c:if>
                                </div>
                            </div>
                        </div>
					</div>
                    
                    <div class="widget-main no-padding">
                    	<table id="chunjiegift" class="table table-bordered">
                            <thead style="font-size: 14px;">
	                            <tr>
		                            <th>红包总额</th>
		                            <th>兑现总额</th>
		                            <th>领取总人数</th>
		                            <th>转化率(投资人数/总人数)</th>
	                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="statistics"><input id="stat_sentPackets" value="${statistics.sentPackets}"
                                                              readonly="readonly"></td>
                                <td class="statistics"><input id="stat_totalCashed" value="${statistics.totalCashed}"
                                                              readonly="readonly"></td>
                                <td class="statistics"><input id="stat_gotPeoples" value="${statistics.gotPeoples}"
                                                              readonly="readonly"></td>
                                <td class="statistics"><input id="stat_transfer" value="${statistics.transfer}"
                                                              readonly="readonly"></td>
                            </tr>
                            </tbody>
                    	</table>
                    </div>
                    <br>
                    <table  class="table table-hover" id="commonDataTable" aria-describedby="simpledatatable_info">
                    	<thead>
                        	<tr style="font-size: 14px;">
                            	<th style="width:8%;">用户名</th>
                                <th style="width: 9%;">红包</th>
                                <th style="width: 8%;">金额（元）</th>
                                <th style="width: 8%;">来源</th>
                                <th style="width: 11%;">手机</th>
                                <th style="width: 9%;">类型</th>
                                <th style="width: 9%;">微信</th>
                                <th style="width: 10%;">获得时间</th>
                                <th style="width: 10%;">兑现时间</th>
                                <th style="width: 10%;">过期时间</th>
                                <th style="width: 8%;">是否新用户</th>
                            </tr>
                        </thead>
                        <tbody style="font-size: 14px;">
                        </tbody>
					</table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/datetime/bootstrap-datepicker.js"></script>
<script src="/assets/js/datetime/bootstrap-timepicker.js"></script>
<script src="/assets/js/datetime/moment.js"></script>
<script src="/assets/js/datetime/daterangepicker.js"></script>

<script>
    var source = {};
    <c:forEach var="s" items="${Source}">
    source['${s}'] = '${s.key}';
    </c:forEach>
</script>
<script src="/assets/js/user/cashgift.js"></script>

</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 15/7/9
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <title>系统测试平台</title>
  <meta name="description" content="系统测试平台管理系统" />
  <%@include file="../../common/head.jspf" %>
  <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
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
          <li class="active">对账管理</li>
          <li class="active">回款记录</li>
       
        </ul>
      </div>
      <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        回款记录
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
	        <div class="row">

	        	<div class="col-lg-12 col-sm-12 col-xs-12">
		        	<div class=" F-right" style="width:150px;">
			        	<div class="form-group pull-right">
			            	<button class="btn btn-small btn-primary" id="searchRechargeHistory">查询</button>
	                        <span class="btn btn-small btn-danger downloadLink" id="downloadrepay" target="_blank" >下载</span>
			        	</div>
		          	</div>
		          	<div class="F-right" style="width:350px;">
						<div class="form-group pull-right">
			            	<label for="date-range-picker" class=" control-label no-padding-right MargT-7 F-left" style="width:110px; text-align:right;margin-right:5px;">日期范围</label>
				            <div class="input-group F-left" style="width:230px;">
				            	<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
				                <input type="text" name="date-range-picker" id="date-range-picker" class="form-control"/>
				        	</div>
						</div>
					</div>
					
               	 </div>

				</div>
				<hr class="MargT-10 MargB-10">
				<div class="buttons-preview Settle_btn investBtnGroup">
					  <div class="horizontal-space"></div>
					  分类：
					  <a href="javascript:;" class="btn btn-sm btn-sky" data-id="">全部</a>
					  <a href="javascript:;" class="btn btn-sm" data-id="UPLAN">优选项目</a>
					  <a href="javascript:;" class="btn btn-sm" data-id="BBT">直投项目</a>
					  <div class="horizontal-space"></div>
				  </div>
				<table id="repayRecordsTable" class="table table-bordered">
		        	<thead>
		            	<tr>
		              		<th>投标人</th>
		              		<th>真实姓名</th>
		              		<th>回款订单号	</th>		              		
		              		<th>标的名称</th>
			              	<th>业务类型</th>
			              	<th>还款金额</th>
			              	<th>还款时间</th>
			            </tr>
		            </thead>
					<tbody>
		            </tbody>
				</table>
			</div>
        </div>
	</div>
      <!-- /Page Body -->
    </div>
    <!-- /Page Content -->
  </div>

<%@include file="../../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script type="text/javascript" src="/assets/js/bbtTool.js"></script>
<script type="text/javascript" src="/assets/js/moment.min.js"></script>
<script type="text/javascript" src="/assets/js/daterangepicker.min.js"></script>
<script type="text/javascript" src="/assets/js/ace-extra.js"></script>

<script src="/assets/js/datetime/daterangepicker.min.js" type="text/javascript"></script>
<script src="/assets/js/datetime/moment.js" type="text/javascript"></script>
<script src="/assets/js/fund/reconciliation/repayRecords.js"></script>
</body>
</html>

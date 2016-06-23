<%--
  Created by IntelliJ IDEA.
  User: lxl
  Date: 15/7/9
  Time: 11:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <title>千金所测试平台</title>
  <meta name="description" content="千金所测试平台管理系统" />
  <%@include file="../common/head.jspf" %>
  <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
  <link rel="stylesheet" href="/assets/css/daterangepicker.css"/>
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
          <li class="active">活动统计</li>
          <li class="active">推广管理</li>
          <li class="active">注册统计</li>
        </ul>
      </div>
      <!-- /Page Breadcrumb -->
      <!-- Page Header -->
      <div class="page-header position-relative">
        <div class="header-title">
          <h1>
            注册统计
          </h1>
        </div>
        <!--Header Buttons-->
        <div class="header-buttons">
        </div>
        <!--Header Buttons End-->
      </div>
      <!-- /Page Header -->
      <!-- Page Body -->
      <div class="page-body">
        <div class="well">
          <div class="row">
	        	<div class="col-lg-12 col-sm-12 col-xs-12">
		        	<div class=" F-right">
			        	<div class="form-group pull-right">
			            	<button class="btn btn-small btn-primary" id="searchRechargeHistory">查询</button>
			        	</div>
		          	</div>
		          	<div class=" F-right MargR-30" style="width:350px;">
			        	<div class="form-group pull-right">
			            	<label for="date-range-picker" class="control-label no-padding-right MargT-7 F-left" style="width:110px; text-align:right;margin-right:5px;">注册日期范围</label>
				            <div class="input-group F-left" style="width:230px;" >
				            	<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
				            	
				                <input type="text" name="date-range-picker" id="date-range-picker" class="form-control"/>
				              </div>
				            </div>
			          	</div>
					</div>
				</div>
				<hr class="MargT-10 MargB-10">


          <table id="commonDataTable" class="table table-bordered">
            <thead>
            <tr>
              <th>注册来源</th>
              <th>注册人数</th>
              <th>开通托管账户人数</th>
              <th>参与投资人数</th>
              <th>开通托管账户比例</th>
              <th>参与投资比例</th>
              <th>投资总金额</th>
              <th>充值总金额</th>
              <th>提现总金额</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
          </table>
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
<script src="/assets/js/datatable/datatables-init.js"></script>
<script type="text/javascript" src="/assets/js/bbtTool.js"></script>
<script type="text/javascript" src="/assets/js/moment.min.js"></script>
<script type="text/javascript" src="/assets/js/daterangepicker.min.js"></script>
<script type="text/javascript" src="/assets/js/ace-extra.js"></script>

<script src="/assets/js/datetime/daterangepicker.min.js" type="text/javascript"></script>
<script src="/assets/js/datetime/moment.js" type="text/javascript"></script>
<script src="/assets/js/promote/statistics.js"></script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: lxl
  Date: 15/8/27
  Time: 09:51
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
          <li class="active">产品管理</li>
          <li class="active">借款管理</li>
          <li class="active">借款申请列表</li>
        </ul>
      </div>
      <!-- /Page Breadcrumb -->
      <!-- Page Header -->
      <div class="page-header position-relative">
        <div class="header-title">
          <h1>
            借款申请列表
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
              <div class=" F-right">
                <div class="form-group pull-right">
                  <button class="btn btn-small btn-primary" id="searchRechargeHistory">查询</button>
                  <button class="btn btn-small btn-primary" id="downList">下载借款列表</button>
                </div>
              </div>
              <div class=" F-right MargR-30" style="width:350px;">
                <div class="form-group pull-right">
                  <label for="returnVisitStatus" class="control-label">回款状态</label>
                  <select name="returnVisitStatus" id="returnVisitStatus" style="padding: 4px 12px;width:200px;">
                    <option value="ALL" selected>全部</option>
                    <option value="0">未回访</option>
                    <option value="1">已回访</option>
                  </select>
                </div>
              </div>
              <div class=" F-right MargR-30" style="width:350px;">
                <div class="form-group pull-right">
                  <label for="date-range-picker" class="control-label no-padding-right MargT-7 F-left" style="width:110px; text-align:right;margin-right:5px;">日期范围</label>
                  <div class="input-group F-left" style="width:230px;" >
                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>

                    <input type="text" name="date-range-picker" id="date-range-picker" class="form-control"/>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <hr class="MargT-10 MargB-10">

          <table class="table table-striped table-bordered table-hover dataTable no-footer" id="APPLY_LIST" aria-describedby="simpledatatable_info">
            <thead id="list_th">
            </thead>
            <tbody >
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
<script src="/assets/js/loan/applyList.js" type="text/javascript"></script>

</body>
</html>
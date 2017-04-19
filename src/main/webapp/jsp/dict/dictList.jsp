<%--
  Created by IntelliJ IDEA.
  User: lxl
  Date: 15/7/7
  Time: 10:51
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
          <li class="active">系统管理</li>
          <li class="active">字典管理</li>
        </ul>
      </div>
      <!-- /Page Breadcrumb -->
      <!-- Page Header -->
      <div class="page-header position-relative">
        <div class="header-title">
          <h1>
            字典管理
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
          <div class="table-toolbar">
            <a onclick="showSingleDict()" data-target="#singleDict" href="javascript:void(0);" class="btn btn-default">
              <i class="fa fa-plus"></i> 增加字典
            </a>
          </div>
          <div class="row">
            <div class=" F-right" >
              <div class="form-group pull-right">
                <button class="btn btn-small btn-primary" id="searchRechargeHistory">查询</button>
                <a class="btn btn-small btn-danger downloadLink" id="clearBtn" href="">清空</a>
              </div>
            </div>
          </div>
          <hr class="MargT-10 MargB-10">

          <table id="commonDataTable" class="table table-bordered">
            <thead>
            <tr>
              <th>ID</th>
              <th>数据值</th>
              <th>标签名</th>
              <th>类型</th>
              <th>描述</th>
              <th>排序（升序）</th>
              <th>父级编号</th>
              <th>备注信息</th>
              <th>创建时间</th>
              <th>删除标记</th>
              <th>操作</th>
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

<%@include file="../common/foot.jspf" %>
<script id="singleDict-template" type="text/x-handlebars-template">
  <form id="dictForm" class="form-horizontal" action="/dict/save" method="POST">
    <div class="row">
      <div class="col-md-12">
        <div class="form-group">
          <label class="control-label col-lg-4" for="value">数据值:</label>
          <div class="controls col-lg-6">
            <input type="hidden" name="id" class="form-control" value="{{id}}"/>
            <input id="value" class="form-control"
                   type="text"
                   name="value"
                   placeholder=""
                   value="{{value}}"/>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-lg-4" for="label">标签名:</label>
          <div class="controls col-lg-6">
            <input id="label" class="form-control"
                   type="text"
                   name="label"
                   data-bv-notempty="true"
                   data-bv-notempty-message="请输入标签名"
                   placeholder=""
                   value="{{label}}"/>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-lg-4" for="type">类型:</label>
          <div class="controls col-lg-6">
            <input id="type" class="form-control"
                   type="text"
                   name="type"
                   placeholder=""
                   value="{{type}}"/>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-lg-4" for="description">描述:</label>
          <div class="controls col-lg-6">
            <input id="description" class="form-control"
                   type="text"
                   name="description"
                   placeholder=""
                   value="{{description}}"/>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-lg-4" for="sort">排序:</label>
          <div class="controls col-lg-6">
            <input id="sort" class="form-control"
                   type="text"
                   name="sort"
                   placeholder=""
                   value="{{sort}}"/>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-lg-4" for="parentId">父级编号:</label>
          <div class="controls col-lg-6">
            <input id="parentId" class="form-control"
                   type="text"
                   name="parentId"
                   placeholder=""
                   value="{{parentId}}"/>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-lg-4" for="remarks">备注信息:</label>
          <div class="controls col-lg-6">
            <input id="remarks" class="form-control"
                   type="text"
                   name="remarks"
                   placeholder=""
                   value="{{remarks}}"/>
          </div>
        </div>
        </div>
        <div class="form-group">
          <label class="control-label col-lg-4"></label>
          <div class="controls col-lg-6">
            <%--<input type="button" class="btn btn-primary" value="保存记录"  />--%>
            <button type="submit" class="btn btn-primary">保存记录</button>
            <button type="reset" class="btn">重置</button>
          </div>
        </div>
      </div>
    </div>

  </form>
</script>
<!-- employee form for create/edit -->
<div id="singleDict" class="modal fade">
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
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/dict/dictList.js"></script>
</body>
</html>

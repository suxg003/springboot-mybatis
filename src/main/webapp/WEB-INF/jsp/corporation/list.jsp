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
    <title>企业用户 系统测试平台</title>
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
                    <li class="active">用户管理</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        企业用户列表
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
                    <div class="table-toolbar">
                        <a id="createUser" onclick="showSingleUser()" href="javascript:void(0);" class="btn btn-default">
                            <i class="fa fa-plus"></i> 增加企业用户
                        </a>
                        <a  class="btn btn-small "
                            data-toggle="modal"
                            href="user/download">
                            <i class="fa fa-download"></i>下载列表
                        </a>
                    </div>
                    <table class="table table-hover" id="userList" aria-describedby="simpledatatable_info">
                        <thead id="list_th" class="bordered-blue">
                        <thead>
                        <tr>
                            <th>企业简称</th>
                            <th>登录名</th>
                            <th>公司负责人</th>
                            <th>公司法人</th>
                            <th>企业全称</th>
                            <th>企业类型</th>
                            <th>类别</th>
                            <th>组织机构代码</th>
                            <th>营业执照号</th>
                            <th>税务登记号</th>
                            <th><i class="icon-time hidden-phone"></i> 上次登录</th>
                            <th><i class="icon-time hidden-phone"></i> 注册时间</th>
                            <th><i class="icon-cog"></i> 操作</th>
                        </tr>
                        </thead>
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
<!--用户信息模板-->
<script id="singleUser-template" type="text/x-handlebars-template">
    <form id="userForm" class="form-horizontal" action="/user/create" method="POST">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-lg-4" for="loginName">用户登录名:</label>
                    <div class="controls col-lg-6">
                        <input id="loginName" class="form-control"
                               type="text"
                               name="loginName"
                               placeholder="lijianguo"
                               value="{{loginName}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="name">用户姓名:</label>
                    <div class="controls col-lg-6">
                        <input id="name" class="form-control"
                               type="text"
                               name="userName"
                               data-bv-notempty="true"
                               data-bv-notempty-message="请输入员工姓名"
                               placeholder="李建国"
                               value="{{name}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="IdNumber">用户身份证号:</label>
                    <div class="controls col-lg-6">
                        <input id="IdNumber" class="form-control"
                               type="text"
                               name="idNumber"
                               placeholder="110105198304299999"
                               value="{{idNumber}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="mobile">用户手机号:</label>
                    <div class="controls col-lg-6">
                        <input id="mobile" class="form-control"
                               type="text"
                               name="mobile"
                               placeholder="13800138000"
                               value="{{mobile}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="employeeId">电子邮箱:</label>
                    <div class="controls col-lg-6">
                        <input id="employeeId" class="form-control"
                               type="text"
                               name="empId"
                               placeholder="电子邮箱"
                               value="{{employeeId}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4"></label>
                    <div class="controls col-lg-6">
                        <button type="submit" class="btn btn-primary">保存记录</button>
                        <button type="reset" class="btn">重置</button>
                    </div>
                </div>
            </div>
        </div>

    </form>
</script>
<script id="editUser" type="text/x-handlebars-template">
    <div class="hidden-phone visible-desktop btn-group">
        <a class="btn btn-xs btn-info"  title="编辑" onclick="showSingleUser(this,'/user/edit/{{userId}}')"><i class="fa fa-edit"></i>&nbsp;</a>
        {{#if isEnabled}}
        <a class="btn btn-danger btn-xs ban" title="禁用" onclick="showConfirm('确定要禁用 【{{name}}】 么？','/user/disable/{{userId}}')"><i class="fa fa-ban"></i>&nbsp;</a>
        {{else}}
        <a class="btn btn-success btn-xs ban" title="启用" onclick="showConfirm('确定要启用 【{{name}}】 么？','/user/enable/{{userId}}')"><i class="fa fa-check"></i>&nbsp;</a>
        {{/if}}
    </div>
</script>
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
<script>
    /*var operationHTML = '<div class="hidden-phone visible-desktop btn-group">';
     <cm:securityTag privilegeString="USER_ALTER">
     operationHTML += '<a class="btn btn-mini btn-info" data-toggle="modal" data-target="#singleUser" href="user/edit/user.id"><i class="icon-pencil"></i> 编辑</a>';
     </cm:securityTag>
     <cm:securityTag privilegeString="USER_DELETE">
     operationHTML += '<a class="btn btn-mini btn-danger" href="user/disable/user.id" confirm="确定要禁用 【user.name】 么？"><i class="icon-ban-circle"></i> 禁用</a>';
     </cm:securityTag>
     operationHTML += '</div>';*/
    var source = {};
    <c:forEach var="s" items="${Source}">
    source['${s}'] = '${s.key}';
    </c:forEach>

</script>
<script src="/assets/js/corporation/coporationList.js"></script>
</body>
</html>
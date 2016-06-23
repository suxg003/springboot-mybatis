<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>千金所测试平台</title>
    <meta name="description" content="千金所测试平台管理系统" />
    <%@include file="../../common/head.jspf" %>
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
    <%--<link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />--%>
    <style>
        #uploadImageBtn {height: 100px;line-height: 100px; width: 100px; border: 1px solid #eee; background: #fafafa; display: inline-block;font-size: 14px;
            color: #666;  text-align: center; cursor: pointer;}
        #uploadImageBtn:hover {background: #f0f0f0;}
        #imageFileInput {display: none;}
        #uploadBtn { width: 100px;display: none; }
        #articleTable {  font-size: 14px;}
        .ace-thumbnails li{float:left;width:100px;height:100px;list-style:none;border:1px solid #eee;padding:1px;margin:0 10px 10px 0;}
        .ace-thumbnails li img{width:96px;height:96px;}
    </style>
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
                    <li class="active">产品管理</li>
                    <li class="active">直投项目</li>
                    <li class="active">推荐项目管理</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        推荐项目管理
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
				<cm:securityTag privilegeString="LOAN_DELETE_RECOMMEND">
				<input type="hidden" value="LOAN_DELETE_RECOMMEND" id="LOAN_DELETE_RECOMMEND">
				</cm:securityTag>
				<cm:securityTag privilegeString="LOAN_CREATE_RECOMMEND">
				<input type="hidden" value="LOAN_CREATE_RECOMMEND" id="LOAN_CREATE_RECOMMEND">
				</cm:securityTag>
                    <input type="hidden" value="${msId}" id="msId">

                <table class="table table-striped table-bordered table-hover dataTable no-footer" id="LOANS_LIST" aria-describedby="simpledatatable_info">
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

<script  type="text/x-handlebars-template" id="myModal">
    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal" role="form">
                <div class="form-group">
                    <label for="loan_title" class="col-sm-2 control-label no-padding-right">标题</label>
                    <div class="col-sm-10">
                        <input type="hidden" class="form-control" id="m_loan_id" value="m_loan_id_value"/>
                        <input type="text" class="form-control" id="m_loan_title" value="m_loan_title_value"/>
                        <input type="hidden" class="form-control" id="m_loan_url" value=""/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="loan_type" class="col-sm-2 control-label no-padding-right">类型</label>
                    <div class="col-sm-10">
                        <select class="form-control" id="m_loan_type">
                            <c:forEach items="${loanRecommendTypes}" var="type">
                                <option value="${type}">${type.key}</option>
                            </c:forEach>

                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="loan_title" class="col-sm-2 control-label no-padding-right">图片上传</label>
                    <div class="col-sm-10">
                        <div class="row-fluid cbcontainer">
                            <ul class="ace-thumbnails">
                                <!--<li><img src="/assets/img/logo.png"></li>  -->
                            </ul>
                            <div id="uploadImageBtn">
                                <i class="fa fa-plus"></i> 上传图片
                            </div>
                            <form action="" name="uploadImageForm">
                                <input type="file" class="imageFileInput" id="imageFileInput" />
                                <button class="btn btn-danger btn-mini" id="uploadBtn"><i class="icon-ok"></i> 上传</button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="loan_type" class="col-sm-2 control-label no-padding-right"></label>
                    <div class="col-sm-10">
                        <input type="button" id="recommendConfirm" class="btn btn-primary" value="确认推荐">
                    </div>
                </div>

            </div>
        </div>
    </div>
</script>
<!-- recommend to front -->
<div id="recommendToFront" class="modal hide fade"></div>
<%@include file="../../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script type="text/javascript" src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/uplan/uplanManager/recommended.js" type="text/javascript"></script>
</body>
</html>
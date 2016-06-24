<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/16
  Time: 13:43
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
                    <li class="active">产品推荐位置</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        产品推荐位置
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
					<cm:securityTag privilegeString="LOAN_ARCHIVE">
                     	<input type="hidden" value="LOAN_ARCHIVE" id="LOAN_ARCHIVE">
                     </cm:securityTag>
                    <table class="table table-striped table-bordered table-hover dataTable no-footer " id="editabledatatable" aria-describedby="simpledatatable_info">
                        <thead >
	                        <tr><th rowspan="2" style="padding:0; vertical-align:middle;">产品名称</th><th colspan="3" style="text-align:center">PC端</th><th colspan="3" style="text-align:center">M站</th><th colspan="3" style="text-align:center">APP端</th><th rowspan="2" style="padding:0; vertical-align:middle;">操作</th></tr>
	                        <tr><th>首页位置</th><th >债权列表页位置</th><th >直投列表页位置</th><th>首页位置</th><th >债权列表页位置</th><th >直投列表页位置</th><th>首页位置</th><th >债权列表页位置</th><th >直投列表页位置</th></tr>
                        </thead>
                        <tbody >                     
                        	<c:forEach var="item" items="${aaData}">
	                            <tr>
	                            	<td>${item.productName }</td>
	                            	<td>${item.pcHomeIndex }</td>
	                            	<td>${item.pcClaimListIndex }</td>
	                            	<td>${item.pcBbtListIndex }</td>
	                            	<td>${item.MHomeIndex }</td>
	                            	<td>${item.MClaimListIndex }</td>
	                            	<td>${item.MBbtListIndex }</td>
	                            	<td>${item.appHomeIndex }</td>
	                            	<td>${item.appClaimListIndex }</td>
	                            	<td>${item.appBbtListIndex }</td>
	                            	<td><span href="" onclick="showSingleUser(true,'/productConfig/getProductConfigById/?productId=${item.productId}&productType=${item.productType }')"  class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> 编辑</span></td>
	                            </tr>
	                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>

<!-- 标的信息模板-->
<script id="singleUser-template" type="text/x-handlebars-template">
    <form id="userForm" class="form-horizontal" action="/productConfig/savaProductConfig" method="GET">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-lg-4" for="loginName">PC端首页位置:</label>
                    <div class="controls col-lg-6">
                        <input id="pcHomeIndex" class="form-control"
                               type="text"
                               name="pcHomeIndex"
                               placeholder=""
                               value="{{pcHomeIndex}}"/>
					<input id="loginName" 
                               type="hidden"
                               name="userId"
                               value="{{userId}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="name">PC端债权列表页位置:</label>
                    <div class="controls col-lg-6">
                        <input id="pcClaimListIndex" class="form-control"
                               type="text"
                               name="pcClaimListIndex"
                               placeholder=""
                               value="{{pcClaimListIndex}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="IdNumber">PC端直投列表页位置:</label>
                    <div class="controls col-lg-6">
                        <input id="pcBbtListIndex" class="form-control"
                               type="text"
                               name="pcBbtListIndex"
                               placeholder=""
                               value="{{pcBbtListIndex}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="userMobile">M站首页位置:</label>
                    <div class="controls col-lg-6">
                        <input id="mHomeIndex" class="form-control"
                               type="text"
                               name="mHomeIndex"
                               placeholder=""
                               value="{{mHomeIndex}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="employeeId">M站债权列表页位置:</label>

                    <div class="controls col-lg-6">
                        <input id="mClaimListIndex" class="form-control"
                               type="text"
                               name="mClaimListIndex"
                               placeholder=""
                               value="{{mClaimListIndex}}"/>
                    </div>
                </div>
				<div class="form-group">
                    <label class="control-label col-lg-4" for="employeeId">M站直投列表页位置:</label>

                    <div class="controls col-lg-6">
                        <input id="mBbtListIndex" class="form-control"
                               type="text"
                               name="mBbtListIndex"
                               placeholder=""
                               value="{{mBbtListIndex}}"/>
                    </div>
                </div>
				<div class="form-group">
                    <label class="control-label col-lg-4" for="userMobile">APP端首页位置:</label>
                    <div class="controls col-lg-6">
                        <input id="appHomeIndex" class="form-control"
                               type="text"
                               name="appHomeIndex"
                               placeholder=""
                               value="{{appHomeIndex}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="employeeId">APP端债权列表页位置:</label>

                    <div class="controls col-lg-6">
                        <input id="appClaimListIndex" class="form-control"
                               type="text"
                               name="appClaimListIndex"
                               placeholder=""
                               value="{{appClaimListIndex}}"/>
                    </div>
                </div>
				<div class="form-group">
                    <label class="control-label col-lg-4" for="employeeId">APP端直投列表页位置:</label>

                    <div class="controls col-lg-6">
                        <input id="appBbtListIndex" class="form-control"
                               type="text"
                               name="appBbtListIndex"
                               placeholder=""
                               value="{{appBbtListIndex}}"/>
                    </div>
                </div>
				<input id="productId" name="productId" type="hidden" value="{{productId}}"/>
				<input id="productType" name="productType" type="hidden" value="{{productType}}"/>
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
<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/customerBootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/claim/productConfig.js" type="text/javascript"></script>

</body>
</html>

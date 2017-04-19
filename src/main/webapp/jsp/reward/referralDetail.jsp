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
    <title>推荐记录</title>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
</head>
<body data-userid="${userId}">
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
                    <li class="active">奖励管理</li>
                    <li class="active">推荐记录</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        推荐记录
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
                
<div class="col-lg-12 col-sm-12 col-xs-12">
	<div class="widget-header bordered-bottom bordered-sky blue">
		<i class="fa fa-clipboard widget-caption Font-16 MargR-10"></i>
		<span class="widget-caption Font-16"> <span style="color:#dd5a43">${userLoginName}</span>的推荐用户列表</span>	
	</div>
    <div class="widget-body">

			<table class="table table-hover" id="referreeTbody">
				<thead>
				<tr>
					<th>
						推荐用户
					</th>
					<th>
						手机号码
					</th>
					<th>
						注册日期
					</th>
				</tr>
				</thead>
				<tbody>
		
				</tbody>
			</table>
    	
    </div>
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
   /* var operationHTML = '<div class="hidden-phone visible-desktop btn-group">';
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
<script src="/assets/js/reward/referralDetail.js"></script>

</body>
</html>
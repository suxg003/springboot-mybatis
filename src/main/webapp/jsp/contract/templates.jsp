<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/16
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>系统测试平台</title>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
</head>
<body>
<%@include file="../common/navbar.jspf" %>
<!-- Main Container start-->
<div class="main-container container-fluid">
    <!-- Page Container start-->
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
                    <li class="active">合同管理</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
          	<!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        合同管理
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
						<div class="col-lg-4">
						<cm:securityTag privilegeString="CONTRACT_ADD"> 
								<button class="btn btn-small btn-success btn-block" id="uploadTemplateBtn"> <i class="icon-plus"></i> 增加模板 </button>
								<br>
								<br>
						</cm:securityTag>
								<c:if test="${fn:length(contractTemplates)== 0}">
									<span class="bold">暂无模板 </span>
								</c:if>
								<c:forEach var="temp" items="${contractTemplates}">
									<div class="templateItem" data-id="${temp.id}">
										<span class="bold">${temp.name}
										<cm:securityTag privilegeString="CONTRACT_DELETE"> 
											<span class="pull-right size-12 edit-link red"> 
												<i class="fa fa-trash-o"></i> 
												<a href="javascript:;" class="delete-template-link red" data-id="${temp.id}">删除</a>
											</span>
										</cm:securityTag>
										<cm:securityTag privilegeString="CONTRACTS_SETDEFAULT"> 
											<span class="pull-right size-12 edit-link"> 
												<i class="fa fa-check-square "></i> 
												<a href="javascript:;" class="set-default-link" data-id="${temp.id}">默认</a>
											</span>
										</cm:securityTag>
										</span>
									</div>
								</c:forEach>
							</div>
							<div class="col-lg-8">
								<div id="mediaContainer" class="media" style="background-color: rgb(255, 255, 255); width: 100%;">
									<iframe width="100%" height="85%" src="" id="pdfIFrame"></iframe>
								</div>
							</div>

						</div>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->                    
    </div>
    <!-- Page Container end-->
</div>
</div>
<!-- Main Container end-->
<!-- 上传模板弹出层 -->
<script id="localFilePanel" type="text/x-handlebars-template">
    <form class="form-horizontal" id="upf">
        <input type="file" id="uploadTemplateInput" name="uploadImageLocalInput"/>
        <div class="form-group col-lg-12">
            <label class="control-label col-lg-4">模板名称</label>
            <div class="controls  col-lg-6">
                <input type="text"
                       placeholder="请输入模板名称"
                       id="templateName"
                       name="templateName" class="form-control" />
            </div>
        </div>
        <div class="center-align">
            <button type="button" class="btn btn-primary" id="saveFileBtn" disabled><i class="icon-ok"></i> 上传</button>
            <button type="button" class="btn btn-danger bootbox-close-button" id="cancelFileBtn"><i class="icon-remove"></i> 取消</button>
        </div>
    </form>
    <div class="load_masker hide" id="fileMasker"></div>
</script>
<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script type="text/javascript" src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/contract/templates.js"></script>
</body>
</html>
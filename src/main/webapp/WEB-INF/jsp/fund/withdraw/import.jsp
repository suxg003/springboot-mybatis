<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
<title>系统测试平台</title>
<meta name="description" content="系统测试平台管理系统" />
<%@include file="../../common/head.jspf"%>
<link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
</head>
<body>
	<%@include file="../../common/navbar.jspf"%>
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<%@include file="../../common/sidebar.jspf"%>
			<!-- Page Content -->
			<div class="page-content">
				<!-- Page Breadcrumb -->
				<div class="page-breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="fa fa-home"></i> <a href="/">首页</a></li>
						<li class="active">资金管理</li>
						<li class="active">提现管理</li>
						<li class="active">提现结果导入</li>
					</ul>
				</div>
				<!-- /Page Breadcrumb -->
				<!-- Page Header -->
				<div class="page-header position-relative">
					<div class="header-title">
						<h1>提现结果导入</h1>
					</div>
					<!--Header Buttons-->
					<div class="header-buttons">
						<a class="sidebar-toggler" href="#"> <i class="fa fa-arrows-h"></i>
						</a> <a class="refresh" id="refresh-toggler" href=""> <i
							class="glyphicon glyphicon-refresh"></i>
						</a> <a class="fullscreen" id="fullscreen-toggler" href="#"> <i
							class="glyphicon glyphicon-fullscreen"></i>
						</a>
					</div>
					<!--Header Buttons End-->
				</div>
				<!-- /Page Header -->
				<!-- Page Body -->
	            <div class="page-body">
	                <div class="well row">
	                    <div class="col-lg-8"><form>
	                        <input multiple id="uploadFileInput" type="file" name="uploadFileInput">
	                	</form>
	                	<center class="margin-top-20">
		                	<cm:securityTag privilegeString="WITHDRAW_IMPORT"> 
		                    	<button class="btn btn-submit btn-success" id="saveFileBtn">确定上传</button>
		                    </cm:securityTag>
	                	</center>
	                	</div>
	                	<div class="row"></div>
	                </div>
	            </div>
            	<!-- /Page Body -->
			</div>
			<!-- /Page Content -->
		</div>
	</div>
    <!--Danger Modal Templates-->
    <div id="modal-danger" class="modal modal-message modal-danger fade" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <i class="glyphicon glyphicon-fire"></i>
                </div>
                <div class="modal-title">Alert</div>

                <div class="modal-body">You'vd done bad!</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">OK</button>
                </div>
            </div> <!-- / .modal-content -->
        </div> <!-- / .modal-dialog -->
    </div>
    <div class="cc-alert-bg hide cc-alert-failed">
        <div class="cc-alert-content">
            <div class="cc-alert-head">
                <h4><i class="icon-info-sign"></i> 系统提示 </h4>
            </div>
            <h4 class="cc-alert-info">
                <i class="icon-warning-sign bigger-120 red"></i>
                <span class="cc-alert-message"></span>
            </h4>

            <div class="cc-alert-actions">
            	<cm:securityTag privilegeString="WITHDRAW_IMPORT"> 
                	<button class="btn btn-danger btn-normal cc-alert-failed-btn">确定</button>
                </cm:securityTag>
            </div>
        </div>
    </div>

	<%@include file="../../common/foot.jspf"%>
	<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
	<script src="/assets/js/datatable/ZeroClipboard.js"></script>
	<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
	<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
	<script src="/assets/js/handlebars/handlebars.min.js"></script>
	<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
	<script src="/assets/js/bootbox/bootbox.js"></script>
	<script src="/assets/js/amountFormat.js"></script>
	<script src="/assets/js/bbtTool.js" type="text/javascript" ></script>
	<script src="/assets/js/fund/withdraw/import.js" type="text/javascript"></script>
</body>
</html>
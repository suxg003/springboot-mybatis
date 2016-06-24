<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/25
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="../../common/head.jspf" %>
    <link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
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
                    <li class="active">商户向用户转账</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        商户向用户转账
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
					<div id="page-content" class="">
						<div class="row">
							
							<div class="col-lg-12" id="yonghu">
								<div class="widget-header bordered-bottom bordered-sky blue">
									<i class="fa fa-retweet widget-caption Font-16 MargR-10"></i>
									<span class="widget-caption Font-16">商户向用户转账</span>
									
								</div>
						
								<div class="widget-body">
									<form novalidate="" class="form-horizontal rechargeForm" name="formUserTransfer" action="payment/userTransfer" method="POST" target="_blank">
										<div class="form-group">
											<div class="col-sm-2 control-label no-padding-right">平台账户</div>
											<div class="col-sm-10" id="userTransferOutCard">
												<select name="userTransferOutAcct" data-for="#userTransferOutCard" class="forCard pull-left">
													<option value="7099027">
															${account.key}
													</option>
												</select>
												<div class="pull-left card-info" style="margin:7px 0 0 10px;">
													<div class="pull-left info-item">账户类型：<span class="bold cardType">专属借记账户</span></div>
													<div class="pull-left info-item">可用余额：<span class="red bold available" data-amount="${accountAmount}">${accountAmount}</span></div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label no-padding-right">转入用户</div>
											<div class="col-sm-10">
												<div class="col-md-6" style="padding-left:0;">
													<input id="userSelection" type="text" class="prependedInput form-control col-md-6" name="queryUser" placeholder="请输入用户登录名...">
												</div>
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-2 control-label no-padding-right">转账金额</div>
											<div class="col-sm-10 relative">
												<div class="col-md-6" style="padding-left:0;">					                        		     		
					                        		<div class="input-group">
					                        			<span class="input-group-addon"><i class="fa fa-yen"></i></span>
		                                            	<input type="text" class="prependedInput form-control" name="userTransferValue"  placeholder="0">
                                         				<span class="input-group-addon"  id="resetUserTransferValue"><i class="fa fa-times purple darkorange add-on resetBtn" style="cursor:pointer"></i></span>
                                       				 </div>
												</div>		
												
											</div>
										</div>
											<div class="form-group">
												<div class="col-sm-2 control-label no-padding-right">备注信息</div>
												<div class="col-sm-10">
													<div class="col-md-6" style="padding-left:0;">
														<input id="descriptioninfo" type="text" class="prependedInput form-control col-md-6" name="queryUser">
													</div>
												</div>
											</div>
										<div class="form-group">
											<div class="col-sm-2 control-label no-padding-right">转账类型</div>
											<div class="col-sm-10">
												<select id="transferType" name="transferType" class="row-fluid">
													<c:forEach var="type" items="${transferType}">
														<option value="${type}">${type.key}</option>
													</c:forEach>
												</select>
												<cm:securityTag privilegeString="USER_TRANSFER">
												&ensp;
												<button type="button" class="btn btn-blue " id="userTransferBtn">提交申请</button>
												</cm:securityTag>
											</div>
											
										</div>
										<cm:securityTag privilegeString="USER_TRANSFER">
										<div class="form-group">
											<div class="col-sm-2 control-label no-padding-right">批量上传转账申请</div>
											<div class="col-sm-10">
												<div class="col-md-6 PaddL-0" >
													<button type="button" class="btn F-left MargR-10" id="uploadTemplateBtn">选择文件</button>							
												
												</div>
											</div>
												
										</div>
										</cm:securityTag>
									</form>
								</div>
								<div class="space-10"></div>
							</div>
							
						</div>
						<div class="row MargT-20">
							<div class="col-lg-12 col-sm-12 col-xs-12">
								<div class="widget-header bordered-bottom bordered-sky blue">
									<i class="fa fa-share-square-o widget-caption Font-16 MargR-10"></i>
									<span class="widget-caption Font-16">未处理的转账申请</span>
									
								</div>

								<div class="widget-body">
									<div class="widget-main no-padding">
                                        <div class="row" style="position:relative">
                                            <div class="col-lg-12 col-sm-12 col-xs-12 MargT-10 MargB-10">
                                            <cm:securityTag privilegeString="USER_TRANSFER_AUDIT">
                                            <input type="hidden" value="USER_TRANSFER_AUDIT" id="USER_TRANSFER_AUDIT">
                                                <div class="col-lg-5 col-sm-5 col-xs-5">
                                                    <div class="buttons-preview">
                                                        <span>批量操作：</span>
                                                        <a id="link_audit_all" class="btn btn-sm btn-blue">全部批准</a>
                                                        <a id="link_audit_refuse" class="btn btn-sm btn-danger">全部拒绝</a>
                                                        <a id="link_audit_cancel" class="btn btn-sm btn-default">全部取消</a>
                                                    </div>
                                                </div>
                                                </cm:securityTag>
                                                <div class="col-lg-5 col-sm-5 col-xs-5 F-right">
                                                    <div class="buttons-preview">
                                                        <span class="F-left MargT-5">日期范围</span>
                                                        <div class="controls col-lg-7 col-sm-7 col-xs-7" style="display: inline-block">
                                                            <div class="input-group">
													<span class="input-group-addon"><i
                                                            class="fa fa-calendar"></i></span> <input type="text"
                                                                                                      name="rangeDate" id="rangeDate"
                                                                                                      class="form-control investRecordRange" />
                                                            </div>
                                                        </div>
                                                        <a id="findTranserBtn" class="btn btn-sm btn-blue">查询</a>
														<a id="transerReqBtn" class="btn btn-sm btn-palegreen">下载</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="position:relative;">

										<table class="table table-hover dataTable no-footer" id="Untreated_accounts">
											<thead>
												<tr>
													<th>
														<label class="MargB-0">
                                                    		<input type="checkbox" class="check_all">
                                                    		<span class="text bold">全选</span>
                                                    	</label>
                                                    </th>
													<th>序号</th>
													<th>用户</th>
													<th>用户姓名</th>
													<th>转账金额</th>
													<th>转账类型</th>
													<th>状态</th>
													<th>备注</th>
													<th>申请时间</th>
													<th>申请员工</th>
													<th>操作</th>
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
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>
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

<%@include file="../../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/fund/reconciliation/transfer.js"></script>
<script src="/assets/js/datetime/bootstrap-datepicker.js"></script>
<script src="/assets/js/datetime/bootstrap-timepicker.js"></script>
<script src="/assets/js/datetime/daterangepicker.min.js" type="text/javascript"></script>
<script src="/assets/js/datetime/moment.js"></script>
<script src="/assets/js/datetime/daterangepicker.js"></script>
<script src="/assets/js/select2/select2.js"></script>
<script type="text/javascript" src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/fund/reconciliation/import.js"></script>
</body>
</html>
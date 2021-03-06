<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>系统测试平台</title>
    <meta name="description" content="系统测试平台管理系统"/>
    <%@include file="../../common/head.jspf" %>
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet"/>
    <style type="text/css">
        #list_th th {
            font-size: 13px;
        }
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
                    <li><i class="fa fa-home"></i> <a href="/">首页</a></li>
                    <li class="active">资金管理</li>
                    <li class="active">提现管理</li>
                    <li class="active">导入结果审核</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        导入结果审核
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
                            <div class="F-right" style="width:350px;">
                                <div class="form-group pull-right">
                                    <label for="date-range-picker"
                                           class=" control-label no-padding-right MargT-7 F-left"
                                           style="width:110px; text-align:right;margin-right:5px;">日期范围</label>

                                    <div class="input-group F-left " style="width:230px;">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        <input type="text" name="date-range-picker"
                                               id="date-range-picker" class="form-control investRecordRange"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-7 col-sm-7 col-xs-12 ">
                            <cm:securityTag privilegeString="WITHDRAW_CHECK"> 
                                <a href="javascript:void(0)" onclick="queryInfos()"
                                   class="btn btn-small btn-primary F-left MargR-10" id="downloadLoan"> 查询</a>
                                <a href="javascript:void(0)" class="btn btn-small btn-primary F-left "
                                   id="downloadByBatchNo"> 按批次号下载全部</a>
                                <span class="col-lg-3 col-sm-3 col-xs-12"><input type="text" class="form-control"
                                                                                 name="batchNo" id="batchNo"></span>
                                <span class="MargT-7 F-left">批次号</span>
                               <span class="MargT-7 F-left MargL-10"> 提现结果</span>
                                <select id="resultType" name="resultType">
                                	<option value="ALL">全部</option>
                                	<option value="SUCCESSFUL">成功</option>
                                	<option value="FAILURE">失败</option>
                                </select>
                             </cm:securityTag>
                            </div>
                        </div>
                        <input type="hidden" id="startDate" name="startDate" value='${start}'/>
                        <input type="hidden" id="endDate" name="endDate" value='${end}'/>
                    </div>
                    <div style="clear:both;"></div>

                    <table class="table table-striped table-hover dataTable no-footer" id="commonDataTable"
                           aria-describedby="simpledatatable_info">
                        <thead id="list_th" class="bordered-blue">
                        <tr>
                            <th>
                                <div class="checkbox">
                                    <label><input type="checkbox" id="cbx_all"/>
                                        <span class="text">全选</span></label></div></th>
                            <th>提现时间</th>
                            <th>批次号</th>
                            <th>提现金额</th>
                            <th>审核结果</th>
                            <th>提现结果</th>
                            <th>上传人</th>
                            <th>上传时间</th>
                            <th>姓名</th>
                            <th>身份证</th>
                            <th>备注</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <textarea id="recordId" name="recordId" style="position:absolute;margin-left:-1000px"></textarea>
                </div>
                <cm:securityTag privilegeString="WITHDRAW_CHECK"> 
	                <input type="button" class="btn btn-small btn-success" id="btnOk" value="审核通过"/>
	                <input type="button" class="btn btn-small btn-success" id="btnCancel" value="审核拒绝"/>
                </cm:securityTag>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>
<%@include file="../../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datetime/daterangepicker.min.js" type="text/javascript"></script>
<script src="/assets/js/datetime/moment.js" type="text/javascript"></script>
<script src="/assets/js/datatable/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="/assets/js/datatable/ZeroClipboard.js" type="text/javascript"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js" type="text/javascript"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js" type="text/javascript"></script>
<script src="/assets/js/datatable/datatables-init.js" type="text/javascript"></script>
<script src="/assets/js/handlebars/handlebars.min.js" type="text/javascript"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js" type="text/javascript"></script>
<script src="/assets/js/amountFormat.js" type="text/javascript"></script>
<script src="/assets/js/bbtTool.js" type="text/javascript"></script>
<script src="/assets/js/fund/withdraw/check.js" type="text/javascript"></script>

</body>
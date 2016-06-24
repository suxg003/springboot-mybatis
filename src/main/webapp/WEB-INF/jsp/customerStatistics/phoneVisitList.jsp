<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/18
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <li class="active">电话回访</li>
                    
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>电话回访</h1>
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
            
            <!-- Page Body -->
            <div class="page-body">

                    <div class="well">
                    
                    	<div class="row">
                    		<div class="col-lg-3 col-sm-3 col-xs-12 form-horizontal">
                    			<div class="control-group">
	                                <label class="callStatus-lable col-sm-4 control-label no-padding-right">回访状态</label>
	                                <div class="callStatus pull-left col-sm-8">                                    
	                                        <select id="callStatus" class="callStatus">
	                                            <option value="0">全部</option>                                            
	                                            <option value="1">未回访</option>                                        
	                                            <option value="2">已回访</option>                                            
	                                        </select>                                    
	                                </div>
	                            </div>
                    		</div>
                    		<div class="col-lg-6 col-sm-6 col-xs-12 form-horizontal">
                    			<div class="form-group MargR-15">
	                                <label for="dateRangePicker"  class="control-label col-sm-3 control-label no-padding-right">注册日期范围</label>
	
	                                <div class="controls col-sm-6" style="display:inline-block;padding-right:0">
			                        	<div class="input-group">
			                            	<span class="input-group-addon">
			                                	<i class="fa fa-calendar"></i>
			                            	</span>
			                            	<input type="text" class="form-control input-sm active" id="reservation">
			                            </div>
			                            
		                    		</div>
									<span class="controls col-sm-3" style="display:inline-block;padding-left:0"><button class="btn btn-sm btn-primary" id="userCalled" style="height:30px;">查询</button></span>
		                    			
                            	</div>
                    		</div>
                    		<div class="col-lg-3 col-sm-3 col-xs-12">
                    			<%--  <cm:securityTag > --%>
	                            	<cm:securityTag privilegeString="CUSTOMER_STATIS_DOWNLOAD">
	                                <a  class="pull-right btn btn-small btn-primary" id="downloadLoan"><i class="fa fa-download"></i> 回访列表下载</a>
	                                </cm:securityTag>
	                        	<%--  </cm:securityTag> --%>
                    		</div>
                    		
                    		
                    	</div>
                        <hr class="wide">
                    <!-- 
                        <ul class="nav nav-pills" id="loanTabs">
                            <li>
                            <div class="form-horizontal gift-left gift-height">
                            <div class="control-group pull-left">
                                <label class="callStatus-lable pull-left">回访状态</label>
                                <div class="callStatus pull-left">                                    
                                        <select id="callStatus" class="callStatus">
                                            <option value="0">全部</option>                                            
                                            <option value="1">未回访</option>                                        
                                            <option value="2">已回访</option>                                            
                                        </select>                                    
                                </div>
                            </div>
                            <div class="control-group pull-left">
                                <label for="date-range-picker" class="control-label">注册日期范围</label>
                                <div class="controls">
                                    <div class="input-prepend">
                                                <span class="add-on">
                                                    <i class="icon-calendar"></i>
                                                </span>
                                        <input type="text" name="date-range-picker" id="date-range-picker"/>
                                    </div>
                                </div>
                            </div>
                        </div><div></div></li>

                           <%--  <cm:securityTag > --%>
                            	<button class="btn btn-small btn-primary" id="userCalled">查询</button>
                                <a href="CustomerStatistics/download/" class="pull-right btn btn-small btn-primary" id="downloadLoan"><i class="icon-download-alt"></i> 回访列表下载</a>
                           <%--  </cm:securityTag> --%>
                        </ul>
						 -->
						 
						 

                            <div class="tab-pane active">
                                    <table id="USERCALLED_LIST" class="table table-striped table-hover">
                                        <thead id="list_th">
                                            <tr>
                                            	<td>登录名</td>
                                            	<td>姓名</td>
                                            	<td>手机号码</td>
                                            	<td>注册时间</td>
                                            	<td>投资次数</td>
                                            	<td>投资总额</td>
                                            	<td>来源</td>
                                            	<td>操作</td>
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
</div>
<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script src="/assets/js/datetime/moment.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/datetime/daterangepicker.min.js"></script>
<script src="/assets/js/select2/select2.js"></script>
<script src="/assets/js/customerStatistics/phoneVisitList.js"></script>

</body>
</html>
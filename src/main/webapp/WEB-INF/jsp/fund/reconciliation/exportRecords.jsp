<%--
  Created by IntelliJ IDEA.
  User: apple
  Date: 15/7/9
  Time: 16:22
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
  <%@include file="../../common/head.jspf" %>
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
          <li class="active">对账管理</li>
          <li class="active">导入第三方充值记录</li>
       
        </ul>
      </div>
      <!-- /Page Breadcrumb -->
      <!-- Page Header -->
      <div class="page-header position-relative">
          <div class="header-title">
              <h1>
                 导入第三方充值记录
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
      
      <div class="page-body">
        <div class="well">
	        <div class="row">      
         
			      <form id="exportRecords" class="form-horizontal" action="/fund/uploadRecords" method="POST" enctype="multipart/form-data" >
			        <div class="row">
			            <div class="col-md-12">
			                <div class="form-group">
			                    <label class="control-label col-lg-2" for="loginName">充值平台:</label>
			                     <div class="controls col-lg-6">
			                     		<select name="payPath" class="">
						                        <!-- <option value="">全部</option> -->
			                                    <c:forEach var="path" items="${payPath}">
			                                        <option value="${path}">${path.key}</option>
			                                    </c:forEach>
						                    </select> 
						          </div>          
			                </div>
			                <div class="form-group">
			                    <label class="control-label col-lg-2" for="name">上传三方文件:</label>
			                    <div class="controls col-lg-6">
			                        <input id="name" class="form-control"
			                               type="file"
			                               name="file"
			                               data-bv-notempty="true"
			                               data-bv-notempty-message="请上传excel文件"
			                               placeholder=""
			                               />
			                    </div>
			                </div>
			                  <div class="form-group">
			                    <label class="control-label col-lg-2"></label>
			                    <div class="controls col-lg-6">
			                    <cm:securityTag privilegeString="FUND_EXPORT_RECORDS_SAVE">
			                        <button type="submit" class="btn btn-primary">保存记录</button>
			                        <button type="reset" class="btn">重置</button>
			                    </cm:securityTag>
			                    </div>
			                </div>
			               
			       		 </div>
			       </div>
			
			    </form>
    
	    	</div>
	    </div>
    </div>
    
    
    
    </div>
      <!-- /Page Body -->
    </div>
    <!-- /Page Content -->
</div>

<%@include file="../../common/foot.jspf" %>
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

<script src="/assets/js/datetime/daterangepicker.min.js" type="text/javascript"></script>
<script src="/assets/js/datetime/moment.js" type="text/javascript"></script>

</body>
</html>

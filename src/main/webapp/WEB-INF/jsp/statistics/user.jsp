<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>用户统计</title>
    <%@include file="../common/head.jspf" %>
    <link rel="stylesheet" href="/assets/css/statistic.css"/>
</head>
<body class="navbar-fixed">
<%@include file="../common/navbar.jspf" %>

<div class="container-fluid main-container" id="main-container">
	 <div class="page-container">
    <%@include file="../common/sidebar.jspf" %>
    <div  class=" page-content">

         <!-- Page Breadcrumb -->
	      <div class="page-breadcrumbs">
	        <ul class="breadcrumb">
	          <li>
	            <i class="fa fa-home"></i>
	            <a href="/">首页</a>
	          </li>
	          <li class="active">活数据计</li>
	          <li class="active">用户统计</li>
	          
	        </ul>
	      </div>
	      <!-- /Page Breadcrumb -->
			<!-- Page Header -->
		      <div class="page-header position-relative">
		        <div class="header-title">
		          <h1>
		            用户统计
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

            <div class="widget-box transparent">
            	<div id="page-content" class="">
            		<div class="row">
            			<div class="col-lg-12 col-sm-12 col-xs-12">
	            			<div class="widget-header bordered-bottom bordered-sky blue">
								<i class="fa fa-retweet widget-caption Font-16 MargR-10"></i>
								<span class="widget-caption Font-16"> 用户注册</span>
								
							</div>
			
			                <div class="widget-body">
			                   <div id="registerChart" class="widget-main no-padding"></div>
			                </div>
		                </div>
	                </div>
	                 <div class="horizontal-space"></div>
	                <div class="row">
            			<div class="col-lg-12 col-sm-12 col-xs-12">
	            			<div class="widget-header bordered-bottom bordered-sky blue">
								<i class="fa fa-retweet widget-caption Font-16 MargR-10"></i>
								<span class="widget-caption Font-16">   用户登录</span>
								
							</div>
			
			                <div class="widget-body">
			                    <div id="loginChart" class="widget-main no-padding"></div>
			                </div>
		                </div>
	                </div>
	                <div class="horizontal-space"></div>
	                <div class="row">
            			<div class="col-lg-4 col-sm-4 col-xs-12">
	            			<div class="widget-header bordered-bottom bordered-sky blue">
								<i class="fa fa-retweet widget-caption Font-16 MargR-10"></i>
								<span class="widget-caption Font-16"> 今日登录用户（<span class="red bold">${todaySize}</span>人）</span>
								
							</div>
			
			                <div class="widget-body">
			                   <table class="table table-hover dataTable no-footer" id="loginUsersTable">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>登录名</th>
                                            <th>真实姓名</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        <c:forEach var="user" items="${today}" varStatus="idx">
                                        	<tr>
                                                <td>${idx.index + 1}</td>
                                                <td><a href="/user/profile?userId=${user.userId}"
                                                       target="_blank">${user.loginName}</a></td>
                                                <td>${user.userName}</td>
                                            </tr>
                                        </c:forEach>

                                        </tbody>
                                    </table>
			                </div>
		                </div>
		                
		                <div class="col-lg-4 col-sm-4 col-xs-12">
	            			<div class="widget-header bordered-bottom bordered-sky blue">
								<i class="fa fa-retweet widget-caption Font-16 MargR-10"></i>
								<span class="widget-caption Font-16">  昨日登录用户（<span class="red bold">${yesterdaySize}</span>人）</span>
								
							</div>
			
			                <div class="widget-body">
			                   <table class="table table-hover dataTable no-footer">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>登录名</th>
                                            <th>真实姓名</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="user" items="${yesterday}" varStatus="idx">
                                            <tr>
                                                <td>${idx.index + 1}</td>
                                                <td><a href="/user/profile?userId=${user.userId}"
                                                       target="_blank">${user.loginName}</a></td>
                                                <td>${user.userName}</td>
                                            </tr>
                                        </c:forEach>

                                        </tbody>
                                    </table>
			                </div>
		                </div>
		                <div class="col-lg-4 col-sm-4 col-xs-12">
	            			<div class="widget-header bordered-bottom bordered-sky blue">
								<i class="fa fa-retweet widget-caption Font-16 MargR-10"></i>
								<span class="widget-caption Font-16">    前日登录用户（<span class="red bold">${beforeYesterdaySize}</span>人）</span>
								
							</div>
			
			                <div class="widget-body">
			                   <table class="table table-hover dataTable no-footer">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>登录名</th>
                                            <th>真实姓名</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="user" items="${beforeYesterday}" varStatus="idx">
                                            <tr>
                                                <td>${idx.index + 1}</td>
                                                <td><a href="/user/profile?userId=${user.userId}"
                                                       target="_blank">${user.loginName}</a></td>
                                                <td>${user.userName}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
			                </div>
		                </div>
		                
	                </div>
	                
	                
                </div>
            </div>


          
			<!-- 
            <div class="row-fluid">
                <div class="span4">
                    <div class="widget-box transparent">
                        <div class="widget-header widget-header-flat">
                            <h4>
                                <i class="icon-signin"></i>
                                今日登录用户（<span class="red bold">${today.size()}</span>人）
                            </h4>
                        </div>
                        <div class="widget-body">
                            <div class="widget-main no-padding">
                                <div class="row-fluid">
                                    <table class="table table-bordered" id="loginUsersTable">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>登录名</th>
                                            <th>真实姓名</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        <c:forEach var="user" items="${today}" varStatus="idx">
                                            <tr>
                                                <td>${idx.index + 1}</td>
                                                <td><a href="user/profile/${user.userId}"
                                                       target="_blank">${user.loginName}</a></td>
                                                <td>${user.userName}</td>
                                            </tr>
                                        </c:forEach>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="span4">
                    <div class="widget-box transparent">
                        <div class="widget-header widget-header-flat">
                            <h4>
                                <i class="icon-signin"></i>
                                昨日登录用户（<span class="red bold">${yesterday.size()}</span>人）
                            </h4>
                        </div>
                        <div class="widget-body">
                            <div class="widget-main no-padding">
                                <div class="row-fluid">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>登录名</th>
                                            <th>真实姓名</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="user" items="${yesterday}" varStatus="idx">
                                            <tr>
                                                <td>${idx.index + 1}</td>
                                                <td><a href="user/profile/${user.userId}"
                                                       target="_blank">${user.loginName}</a></td>
                                                <td>${user.userName}</td>
                                            </tr>
                                        </c:forEach>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="span4">
                    <div class="widget-box transparent">
                        <div class="widget-header widget-header-flat">
                            <h4>
                                <i class="icon-signin"></i>
                                前日登录用户（<span class="red bold">${beforeYesterday.size()}</span>人）
                            </h4>
                        </div>
                        <div class="widget-body">
                            <div class="widget-main no-padding">
                                <div class="row-fluid">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>登录名</th>
                                            <th>真实姓名</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="user" items="${beforeYesterday}" varStatus="idx">
                                            <tr>
                                                <td>${idx.index + 1}</td>
                                                <td><a href="user/profile/${user.userId}"
                                                       target="_blank">${user.loginName}</a></td>
                                                <td>${user.userName}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
			 -->
        </div>
    </div>
    </div>
</div>
<%@include file="../common/foot.jspf" %>
<script src="/assets/js/highstock.js"></script>
<script src="/assets/js/modules/exporting.js"></script>
<script type="text/javascript" src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script>
    $(function () {

        Highcharts.setOptions({
            global: {
                useUTC: false,
                timezoneOffset: 8
            }
        });
        $.getJSON('/statistics/user/register', function (data) {
            $('#registerChart').highcharts('StockChart', {
                rangeSelector: {
                    selected: 1
                },
                title: {
                    text: '用户注册时间统计'
                },
                series: [{
                    name: '注册数',
                    data: data,
                    marker: {
                        enabled: true,
                        radius: 3
                    },
                    shadow: true,
                    tooltip: {
                        valueSuffix: '人'
                    }
                }],
                credits: {
                    enabled: false
                }
            });
        });


        $.getJSON('/statistics/user/login', function (data) {
            $('#loginChart').highcharts('StockChart', {
                rangeSelector: {
                    selected: 1
                },
                title: {
                    text: '用户登录次数统计'
                },
                series: [{
                    name: '登录人次',
                    data: data,
                    marker: {
                        enabled: true,
                        radius: 3
                    },
                    shadow: true,
                    tooltip: {
                        valueSuffix: '人次'
                    }
                }],
                credits: {
                    enabled: false
                }
            });
        });
    });
</script>
</body>
</html>

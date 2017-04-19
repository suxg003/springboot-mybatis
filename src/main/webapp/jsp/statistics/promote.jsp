<%--
  Created by IntelliJ IDEA.
  User: lxl
  Date: 15/7/11
  Time: 17:59
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <title>推广统计</title>
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
				    <li class="active">活动统计</li>
				    <li class="active">推广管理</li>
				    <li class="active">推广统计</li>
		          
		        </ul>
		    </div>
			<!-- /Page Breadcrumb -->		
   			<!-- Page Header -->
		    <div class="page-header position-relative">
		        <div class="header-title">
		          <h1>
		            推广统计
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
									<select id="type" name="type" class="row-fluid" style="padding:3px 12px;margin:2px 5px 0 0;">
										<c:forEach var="ty" items="${type}">
											<option value="${ty}">${ty.key}</option>
										</c:forEach>
									</select>
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
									<span class="widget-caption Font-16"> 用户登录</span>
								</div>
				
				                <div class="widget-body">
				                   <div id="loginChart" class="widget-main no-padding"></div>
				                </div>
			                </div>
		                </div>		
						<div class="horizontal-space"></div>
	            		<div class="row">
	            			<div class="col-lg-12 col-sm-12 col-xs-12">
		            			<div class="widget-header bordered-bottom bordered-sky blue">
									<i class="fa fa-retweet widget-caption Font-16 MargR-10"></i>
									<span class="widget-caption Font-16"> 开通托管账户</span>
								</div>
				
				                <div class="widget-body">
				                   <div id="umpChart" class="widget-main no-padding"></div>
				                </div>
			                </div>
		                </div>		
		                <div class="horizontal-space"></div>
	            		<div class="row">
	            			<div class="col-lg-12 col-sm-12 col-xs-12">
		            			<div class="widget-header bordered-bottom bordered-sky blue">
									<i class="fa fa-retweet widget-caption Font-16 MargR-10"></i>
									<span class="widget-caption Font-16"> 投资情况</span>
								</div>
				
				                <div class="widget-body">
				                   <div id="investChart" class="widget-main no-padding"></div>
				                </div>
			                </div>
		                </div>				                
		                
		                					
					
					</div>
				</div>
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
    //渲染
    function render(type){
      $.getJSON('/statistics/promoteRegister/'+type, function (data) {
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
      $.getJSON('/statistics/promoteLogin/'+type, function (data) {
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

      $.getJSON('/statistics/promoteUmp/'+type, function (data) {
        $('#umpChart').highcharts('StockChart', {
          rangeSelector: {
            selected: 1
          },
          title: {
            text: '用户开通托管账户统计'
          },
          series: [{
            name: '开通人数',
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

      $.getJSON('/statistics/promoteInvest/'+type, function (data) {
        var count = [],
                sum = [],
                dataLength=data.length,
                i = 0;
        for (i;i<dataLength;i += 1) {

          count.push([
            data[i][0],
            data[i][1]
          ]);
          sum.push([
            data[i][0],
            data[i][2]
          ])
        }
        $('#investChart').highcharts('StockChart', {
          rangeSelector: {
            selected: 1
          },
          title: {
            text: '用户投资情况统计'
          },
          series: [{
            name: '投资次数',
            data: count,
            marker: {
              enabled: true,
              radius: 3
            },
            shadow: true,
            tooltip: {
              valueSuffix: '次'
            }
          },{
            name: '投资总金额',
            data: sum,
            color:'#EA7500',
            marker: {
              enabled: true,
              radius: 3
            },
            shadow: true,
            tooltip: {
              valueSuffix: '元'
            }
          }],
          credits: {
            enabled: false
          }
        });
      });
    }

    var type = $('select[name=type]').val();
    $('select[name=type]').change(function(){
      var type1=$(this).children('option:selected').val();
      render(type1);
    });
    render(type);
  });
</script>
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: lxl
  Date: 15/7/10
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <title>红包统计</title>
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
				    <li class="active">数据统计</li>
				    <li class="active">红包统计</li>		          
		        </ul>
		    </div>
			<!-- /Page Breadcrumb -->		
   			<!-- Page Header -->
		    <div class="page-header position-relative">
		        <div class="header-title">
		          <h1>
		            红包统计
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
									<span class="widget-caption Font-16">红包统计</span>
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
									<span class="widget-caption Font-16">红包使用情况</span>
								</div>
				
				                <div class="widget-body">
				                   <div id="loginChart" class="widget-main no-padding"></div>
				                </div>
			                </div>
		                </div>		
						<div class="horizontal-space"></div>			
								
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
      },
      lang:{
          contextButtonTitle:"图表导出菜单",
          decimalPoint:".",
          downloadJPEG:"下载JPEG图片",
          downloadPDF:"下载PDF文件",
          downloadPNG:"下载PNG文件",
          downloadSVG:"下载SVG文件",
          drillUpText:"返回 {series.name}",
          loading:"加载中",
          months:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
          noData:"没有数据",
          numericSymbols: [ "千" , "兆" , "G" , "T" , "P" , "E"],
          printChart:"打印图表",
          resetZoom:"恢复缩放",
          resetZoomTitle:"恢复图表",
          shortMonths: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
          thousandsSep:",",
          weekdays: ["星期一", "星期二", "星期三", "星期三", "星期四", "星期五", "星期六","星期天"]
       }
    });
    $.getJSON('/statistics/giftCard', function (data) {
      $('#registerChart').highcharts('StockChart', {
        rangeSelector: {
          selected: 1
        },
        title: {
          text: '红包发放时间统计'
        },
        series: [{
          name: '红包发放数',
          data: data,
          marker: {
            enabled: true,
            radius: 3
          },
          shadow: true,
          tooltip: {
            valueSuffix: '个'
          }
        }],
        credits: {
          enabled: false
        }
      });
    });


    $.getJSON('/statistics/giftCardRecord', function (data) {
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
      $('#loginChart').highcharts('StockChart', {
        rangeSelector: {
          selected: 1
        },
        title: {
          text: '红包使用情况统计'
        },
        series: [{
          name: '红包使用次数',
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
          name: '红包使用总金额',
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
  });
</script>
</body>
</html>
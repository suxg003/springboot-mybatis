<%--
  Created by IntelliJ IDEA.
  User: lxl
  Date: 15/7/11
  Time: 16:19
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
          <li class="active">活动统计</li>
          <li class="active">数据统计</li>
          <li class="active">资金统计</li>
        </ul>
      </div>
      <!-- /Page Breadcrumb -->
      <!-- Page Header -->
      <div class="page-header position-relative">
        <div class="header-title">
          <h1>
            用户资金列表
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
          <table class="table table-striped table-bordered table-hover dataTable no-footer" id="FUND_LIST" aria-describedby="simpledatatable_info">
            <thead id="list_th">
            </thead>
            <tbody >
            </tbody>
          </table>
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
<script type="text/javascript" src="/assets/js/bbtTool.js"></script>
<script type="text/javascript" src="/assets/js/moment.min.js"></script>
<script>
  function getList(){
    var th='';
    th+='<tr>\
            <th>登录名</th>\
            <th>姓名</th>\
            <th>可用余额</th>\
            <th>待收总额</th>';
    th+='</tr>';
    $('#list_th').html(th);
    var oTable = $('#FUND_LIST').dataTable({
      "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
      "iDisplayLength": 50,
      "bProcessing": true,
      "bServerSide": true,
      "bSort": false,
      "bFilter": true,
      "bPaginate": true,
      "aoColumns": [
        {"mData": "loginName"},
        {"mData": "userName"},
        {"mData": "availableAmount"},
        {"mData": "dueInAmount"}
      ],
      "aoColumnDefs": [
        {
          "bSortable": false,
          "aTargets": [0],
          "mRender": function (data, type, row) {
            return "<a href='/user/profile?userId="+row.userId+"' target='_blank'>" + data + "</a>";
          }
        },
        {
          "bSortable": false,
          "aTargets":[1]
        },{
          "bSortable": false,
          "aTargets":[2],
          "mRender":function(data){
            return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
          }
        },{
          "bSortable": false,
          "aTargets":[3],
          "mRender":function(data){
            return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
          }
        }
      ],
      "fnDrawCallback": function (oSettings) {
        $("#searchRechargeHistory").html('查询');
        $("#searchRechargeHistory").prop('disabled', false);
      },
      "sAjaxSource": "/statistics/fund/records",
      "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
        aoData.push({});
        oSettings.jqXHR = $.ajax({
          "dataType": 'json',
          "type": "GET",
          "url": sSource,
          "data": aoData,
          "success": fnCallback,
          "error": function () {
            console.log('error');
          }
        });
      },
      "oLanguage": {
        "sLengthMenu": "_MENU_",
        "sSearch": "",
        "sInfo": "显示第 _START_ - _END_ 条记录，共 _TOTAL_ 条",
        "sInfoEmpty": "没有符合条件的记录",
        "sZeroRecords": "没有符合条件的记录",
        "oPaginate": {
			"sFirst": "首页",
			"sPrevious": "前一页",
			"sNext": "后一页",
			"sLast": "尾页"
		}
      }
    });

    //Check All Functionality
    jQuery('#simpledatatable .group-checkable').change(function () {
      var set = $(".checkboxes");
      var checked = jQuery(this).is(":checked");
      jQuery(set).each(function () {
        if (checked) {
          $(this).prop("checked", true);
          $(this).parents('tr').addClass("active");
        } else {
          $(this).prop("checked", false);
          $(this).parents('tr').removeClass("active");
        }
      });

    });
    jQuery('#simpledatatable tbody tr .checkboxes').change(function () {
      $(this).parents('tr').toggleClass("active");
    });
  }
  getList();
 </script>
</body>
</html>


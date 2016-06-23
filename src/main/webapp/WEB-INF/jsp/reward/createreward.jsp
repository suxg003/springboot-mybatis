
<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/18
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>发放红包</title>
    <meta name="description" content="千金所测试平台管理系统" />
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
                    <li class="active">营销管理</li>
                    <li class="active">红包</li>
                    <li class="active">发放红包</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        发放红包
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
                <div class="widget-box transparent"  id="yonghu">
                    <div id="page-content" class="">
                        <div class="row">
                            <cm:securityTag privilegeString="GIFTCARD_HANDOUT">
                            <input type="hidden" value="GIFTCARD_HANDOUT" id="GIFTCARD_HANDOUT">
                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                    <div class="widget-header bordered-bottom bordered-sky blue">
                                        <i class="fa fa-envelope widget-caption Font-16 MargR-10"></i>
                                        <span class="widget-caption Font-16">发放红包</span>

                                    </div>

                                    <div class="widget-body">
                                        <form novalidate class="form-horizontal rechargeForm" name="formUserTransfer"  action="/reward/createGiftCard" method="POST" target="_blank">

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label no-padding-right">发放用户</label>
                                                <div class="col-sm-6">
                                                    <input id="userSelection" type="text" class="prependedInput form-control" name="queryUser"
                                                           placeholder="请输入用户登录名..."/>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label no-padding-right">红包金额</label>
                                                <div class="input-prepend relative col-sm-6">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><i class="fa fa-yen"></i></span>
                                                        <input type="text" class="prependedInput form-control" name="userTransferValue"  placeholder="0">
                                                        <span class="input-group-addon"  id="resetUserTransferValue"><i class="fa fa-times purple darkorange add-on resetBtn" style="cursor:pointer"></i></span>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label no-padding-right">红包类型</label>
                                                <div class="col-sm-6">
                                                    <select id="transferType" name="transferType" class="row-fluid">
                                                        <c:forEach var="type" items="${type}">
                                                            <option value="${type}">${type.key}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label no-padding-right"></label>
                                                <div class="col-sm-6" >
                                                    <button type="button" class="btn btn-primary post-btn"
                                                            id="userTransferBtn">发放红包
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-2 control-label no-padding-right">批量发送红包</div>
                                                <div class="col-sm-10">
                                                    <div class="col-md-6 PaddL-0">
                                                        <button type="button" class="btn F-left MargR-10" id="uploadGiftBtn">
                                                            选择文件
                                                        </button>

                                                    </div>
                                                </div>

                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </cm:securityTag>
                        </div>
                        <div class="horizontal-space"></div>

                        <div class="row">
                            <div class="col-lg-12 col-sm-12 col-xs-12">
                                <div class="widget-header bordered-bottom bordered-sky blue">
                                    <i class="fa fa-clipboard widget-caption Font-16 MargR-10"></i>
                                    <span class="widget-caption Font-16"> 发放红包记录</span>

                                </div>

                                <div class="widget-body">
                                    <div class="row">
                                        <div class="col-lg-4 col-sm-4 col-xs-12 F-right">
                                            <div class="buttons-preview F-right">
                                                <span class="F-left MargT-5" >日期范围：</span>
                                                <div class="controls col-lg-8 col-sm-8 col-xs-12" style="display:inline-block">
                                                    <div class="input-group">
					                                    <span class="input-group-addon">
					                                        <i class="fa fa-calendar"></i>
					                                    </span>
                                                        <input type="text" class="form-control input-sm active" name="date-range-picker" id="date-range-picker">
                                                    </div>
                                                </div>
                                                <a onclick="getList()" id ="searchRechargeHistory" class="btn btn-sm btn-primary">查询</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="horizontal-space"></div>
                                    <table class="table table-hover" id="commonDataTable" aria-describedby="simpledatatable_info">
                                        <thead id="list_th" class="bordered-blue">
                                        <tr>
                                            <th>Id</th>
                                            <th>可用(元)</th>
                                            <th>已用(元)</th>
                                            <th>投资返现比例</th>
                                            <th>类型</th>
                                            <th>用户</th>
                                            <th>状态</th>
                                            <th>获得时间</th>
                                            <th>过期时间</th>
                                            <th>发放员工</th>
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
    </div>
</div>
<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
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
                       name="templateName" class="form-control"/>
            </div>
        </div>
        <div class="center-align">
            <button type="button" class="btn btn-primary" id="saveFileBtn" disabled><i class="icon-ok"></i> 上传</button>
            <button type="button" class="btn btn-danger bootbox-close-button" id="cancelFileBtn"><i
                    class="icon-remove"></i> 取消
            </button>
        </div>
    </form>
    <div class="load_masker hide" id="fileMasker"></div>
</script>

<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/datetime/bootstrap-datepicker.js"></script>
<script src="/assets/js/datetime/bootstrap-timepicker.js"></script>
<script src="/assets/js/datetime/moment.js"></script>
<script src="/assets/js/datetime/daterangepicker.js"></script>
<script src="/assets/js/reward/import.js"></script>

<script>
    var source = {};
    <c:forEach var="s" items="${Source}">
    source['${s}'] = '${s.key}';
    </c:forEach>
</script>
<script src="/assets/js/reward/createreward.js"></script>


<div id="userTransferPanel" class="modal hide fade">
    <!--     <div class="modal-header"> -->
    <!--         <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="$('#rechargePanel').get(0).reset();">&times;</button> -->
    <!--         <h3><i class='icon-refresh'></i> 正在提交申请（共 <span class="red bold" id="userNum"></span> 人）</h3> -->
    <!--     </div> -->
    <div class="modal-body relative">
        <div id="userContainer">
        </div>
    </div>
    <!--     <div class="form-actions"> -->
    <!--         <button class="btn btn-primary" id="closeModalBtn" disabled>确定</button> -->
    <!--     </div> -->
</div>

<!-- 
<div id="userTransferPanel" class="modal hide fade">
    <div class="modal-header">
        <h3><i class='icon-refresh'></i> 正在提交申请</h3>
    </div>
    <div class="modal-body relative">
        <div id="userContainer">
        </div>
    </div>
    <div class="form-actions">
        <button class="btn btn-primary" id="closeModalBtn" disabled>确定</button>
    </div>
</div>


 -->
<script type="text/template" id="userTemplate">
    <div class="userItem clear" id="uid-$id" style="font-size:30px;">
        <div class="inline-block userContainer blue pull-left">
            <span class="userName">$user</span>：
        </div>
        <div class="status inline-block pull-left"><i class='icon-cog icon-spin'></i> 申请中...</div>
    </div>
</script>
</body>

</html>
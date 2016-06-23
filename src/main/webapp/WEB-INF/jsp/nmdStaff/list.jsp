<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/18
  Time: 14:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>员工列表 千金所测试平台</title>
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
                    <li class="active">诺曼底后台</li>
                    <li class="active">员工列表</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        员工列表
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
                       <div class="table-toolbar">
                               <a onclick="showSingleStaff()" data-target="#singleStaff" href="javascript:void(0);" class="btn btn-default">
                                   <i class="fa fa-plus"></i> 单笔录入新员工
                               </a>
                               <a onclick="uploadStaffInfo()" data-target="#batchStaff" href="javascript:void(0);" class="btn btn-default">
                                   <i class="fa fa-upload"></i> 批量更新
                               </a>
                               <a id="downstafflist" href="/nmdStaff/staffExport" class="btn btn-default">
                                   <i class="fa fa-download"></i> 下载员工信息
                               </a>
                       </div>
                    <table class="table table-striped table-bordered table-hover dataTable no-footer" id="LOANS_LIST" aria-describedby="simpledatatable_info">
                        <thead id="list_th">
                        <tr>
                            <th>员工编号</th>
                            <th class="hidden-480">姓名</th>
                            <th class="hidden-480">身份证号</th>
                            <th class="hidden-480"> 分公司</th>
                            <th class="hidden-480">部门</th>
                            <th class="hidden-480">职位</th>
                            <th class="hidden-phone"><i class="fa fa-clock-o"></i>入职日期</th>
                            <th class="hidden-phone"><i class="fa fa-clock-o"></i>离职日期</th>
                        </tr>
                        </thead>
                        <tbody >
                        <%--<c:forEach var="nmdStaff" items="${nmdStaffList}">--%>
                            <%--<tr>--%>
                                <%--<td class="hidden-480">${nmdStaff.staffId}</td>--%>
                                <%--<td class="hidden-480">${nmdStaff.staffName}</td>--%>
                                <%--<td class="hidden-480">${nmdStaff.id}</td>--%>
                                <%--<td class="hidden-480">${nmdStaff.branchOffice}</td>--%>
                                <%--<td class="hidden-480">${nmdStaff.department}</td>--%>
                                <%--<td class="hidden-480">${nmdStaff.position}</td>--%>
                                <%--<td class="hidden-phone"><fmt:formatDate value="${nmdStaff.inductionTime}"--%>
                                                                         <%--pattern="yy年M月d日"/></td>--%>
                                <%--<td class="hidden-phone"><fmt:formatDate value="${nmdStaff.quitTime}"--%>
                                                                         <%--pattern="yy年M月d日"/></td>--%>
                            <%--</tr>--%>
                        <%--</c:forEach>--%>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>
<!--员工信息模板-->
<script id="singleStaff-template" type="text/x-handlebars-template">
    <form id="staffForm" class="form-horizontal" action="/nmdStaff/create" method="POST">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-lg-4" for="staffId">员工编号:</label>
                    <div class="controls col-lg-6">
                        <input id="staffId" class="form-control"
                               type="text"
                               name="staffId"
                               placeholder=""
                               value="{{staffId}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="staffName">姓名:</label>
                    <div class="controls col-lg-6">
                        <input id="staffName" class="form-control"
                               type="text"
                               name="staffName"
                               data-bv-notempty="true"
                               data-bv-notempty-message="请输入员工姓名"
                               placeholder=""
                               value="{{staffName}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="id">身份证号:</label>
                    <div class="controls col-lg-6">
                        <input id="id" class="form-control"
                               type="text"
                               name="id"
                               placeholder=""
                               value="{{id}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="branchOffice">分公司:</label>
                    <div class="controls col-lg-6">
                        <input id="branchOffice" class="form-control"
                               type="text"
                               name="branchOffice"
                               placeholder=""
                               value="{{branchOffice}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="department">部门:</label>
                    <div class="controls col-lg-6">
                        <input id="department" class="form-control"
                               type="text"
                               name="department"
                               placeholder=""
                               value="{{department}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="position">职位:</label>
                    <div class="controls col-lg-6">
                        <input id="position" class="form-control"
                               type="text"
                               name="position"
                               placeholder=""
                               value="{{position}}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-lg-4" for="position">入职日期:</label>
                    <div class="controls col-lg-6">
                        <input type="text" name="inductionTime" id="inductionTime"
                               placeholder="入职日期" class="form-control date-picker"
                               value="{{formatdata inductionTime}}"
                               data-date-format="yyyy-mm-dd"/>
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        <div class="errorText hide"><i class="icon-warning-sign"></i> 请输入正确的入职日期</div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4"></label>
                    <div class="controls col-lg-6">
                        <%--<input type="button" class="btn btn-primary" value="保存记录"  />--%>
                        <button type="submit" class="btn btn-primary">保存记录</button>
                        <button type="reset" class="btn">重置</button>
                    </div>
                </div>
            </div>
        </div>

    </form>
</script>
<!-- employee form for create/edit -->
<div id="singleStaff" class="modal fade">
</div>
<div id="batchStaff" class="modal fade">
</div>
<!-- 上传staff start -->
<div class="modal fade" id="uploadLocalModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body" style="margin:auto; margin-top:10px; margin-bottom:10px;">
                <form>
                    <input multiple id="uploadFileInput" type="file" name="uploadFileInput">
                </form>
                <div class="margin-top-20 text-center">
                        <button class="btn btn-submit btn-success" id="saveFileBtn">确定上传</button>
                        &nbsp;&nbsp;
                        <button data-dismiss="modal" class="btn btn-reset">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script type="text/javascript" src="/assets/js/datetime/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="/assets/js/datetime/bootstrap-timepicker.js"></script>
<script type="text/javascript" src="/assets/js/datetime/daterangepicker.js"></script>
<script type="text/javascript" src="/assets/js/datetime/moment.js"></script>

<script src="/assets/js/validation/customerBootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/staff/staff-list.js"></script>

</body>
</html>
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
    <title>层级列表 系统测试平台</title>
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
                    <li class="active">诺曼底后台</li>
                    <li class="active">层级列表</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        层级列表
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
                               <a onclick="uploadStaffLevelsInfo()" data-target="#singleEmployee" href="javascript:void(0);" class="btn btn-default">
                                   <i class="fa fa-upload"></i> 批量更新
                               </a>
                               <a id="downstafflevellist" href="/nmdStaffLevels/staffExport" class="btn btn-default">
                                   <i class="fa fa-download"></i> 下载员工层级信息
                               </a>
                       </div>
                    <table class="table table-striped table-bordered table-hover dataTable no-footer" id="LOANS_LIST" aria-describedby="simpledatatable_info">
                        <thead id="list_th">
                        <tr>
                            <th>员工编号</th>
                            <th>姓名</th>
                            <th class="hidden-480">分公司</th>
                            <th class="hidden-480">部门</th>
                            <th class="hidden-480"> 职位</th>
                            <th class="hidden-480">直接上级</th>
                            <th class="hidden-480">团队经理编码</th>
                            <th class="hidden-480">团队经理姓名</th>
                            <th class="hidden-480">营业部经理编码</th>
                            <th class="hidden-480">营业部经理姓名</th>
                            <th class="hidden-480">门店经理编码</th>
                            <th class="hidden-480">门店经理姓名</th>
                            <th class="hidden-480">城市经理编码</th>
                            <th class="hidden-480">城市经理姓名</th>
                        </tr>
                        </thead>
                        <tbody >
                        <c:forEach var="NmdStaffLevel" items="${nmdStaffLevelsList}">
                            <tr>
                                <td >${NmdStaffLevel.staffId}</td>
                                <td >${NmdStaffLevel.staffName}</td>
                                <td class="hidden-480">${NmdStaffLevel.branchOffice}</td>
                                <td class="hidden-480">${NmdStaffLevel.department}</td>
                                <td class="hidden-480">${NmdStaffLevel.position}</td>
                                <td class="hidden-480">${NmdStaffLevel.immediateSuperior}</td>
                                <td class="hidden-480">${NmdStaffLevel.teamManagerCode}</td>
                                <td class="hidden-480">${NmdStaffLevel.teamManagerName}</td>
                                <td class="hidden-480">${NmdStaffLevel.businessOfficesCode}</td>
                                <td class="hidden-480">${NmdStaffLevel.businessOfficesName}</td>
                                <td class="hidden-480">${NmdStaffLevel.storeManagerCode}</td>
                                <td class="hidden-480">${NmdStaffLevel.storeManagerName}</td>
                                <td class="hidden-480">${NmdStaffLevel.cityManagerCode}</td>
                                <td class="hidden-480">${NmdStaffLevel.cityManagerName}</td>
                            </tr>
                        </c:forEach>
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
<script id="singleEmployee-template" type="text/x-handlebars-template">
    <form id="employeeForm" class="form-horizontal" action="/nmdStaffLevels/save" method="POST">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-lg-4" for="staffId">员工编号:</label>
                    <div class="controls col-lg-6">
                        <input type="hidden" name="staffId" class="form-control" value="{{staffId}}"/>
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
                    <label class="control-label col-lg-4" for="immediateSuperior">直接上级:</label>
                    <div class="controls col-lg-6">
                        <input id="immediateSuperior" class="form-control"
                               type="text"
                               name="immediateSuperior"
                               placeholder=""
                               value="{{immediateSuperior}}"/>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-lg-4" for="teamManagerCode">团队经理编码:</label>
                    <div class="controls col-lg-6">
                        <input id="teamManagerCode" class="form-control"
                               type="text"
                               name="teamManagerCode"
                               placeholder=""
                               value="{{teamManagerCode}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="teamManagerName">团队经理姓名:</label>
                    <div class="controls col-lg-6">
                        <input id="teamManagerName" class="form-control"
                               type="text"
                               name="teamManagerName"
                               placeholder=""
                               value="{{teamManagerName}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="businessOfficesCode">营业部经理编码:</label>
                    <div class="controls col-lg-6">
                        <input id="businessOfficesCode" class="form-control"
                               type="text"
                               name="businessOfficesCode"
                               placeholder=""
                               value="{{businessOfficesCode}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="businessOfficeName">营业部经理姓名:</label>
                    <div class="controls col-lg-6">
                        <input id="businessOfficeName" class="form-control"
                               type="text"
                               name="businessOfficeName"
                               placeholder=""
                               value="{{businessOfficeName}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="storeManagerCode">门店经理编码:</label>
                    <div class="controls col-lg-6">
                        <input id="storeManagerCode" class="form-control"
                               type="text"
                               name="storeManagerCode"
                               placeholder=""
                               value="{{storeManagerCode}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="storeManagerName">门店经理姓名:</label>
                    <div class="controls col-lg-6">
                        <input id="storeManagerName" class="form-control"
                               type="text"
                               name="storeManagerName"
                               placeholder=""
                               value="{{storeManagerName}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="cityManagerCode">城市经理编码:</label>
                    <div class="controls col-lg-6">
                        <input id="cityManagerCode" class="form-control"
                               type="text"
                               name="cityManagerCode"
                               placeholder=""
                               value="{{cityManagerCode}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="cityManagerName">城市经理姓名:</label>
                    <div class="controls col-lg-6">
                        <input id="cityManagerName" class="form-control"
                               type="text"
                               name="cityManagerName"
                               placeholder=""
                               value="{{cityManagerName}}"/>
                    </div>
                </div>
        </div>
        </div>
    </form>
</script>
<!-- employee form for create/edit -->
<div id="singleEmployee" class="modal fade">
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
<script src="/assets/js/validation/customerBootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/stafflevel/staff-level-list.js"></script>

</body>
</html>
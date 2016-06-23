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
                    <li class="active">系统管理</li>
                    <li class="active">员工管理</li>
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
                 <%--   <cm:securityTag privilegeString="EMPLOYEE_ALTER"> --%>
                    <div class="table-toolbar">
                        <a onclick="showSingleEmployee()" data-target="#singleEmployee" href="javascript:void(0);" class="btn btn-default">
                            <i class="fa fa-plus"></i> 增加员工
                        </a>
                    </div>
                  <%--   </cm:securityTag> --%>
                    <table class="table table-striped table-bordered table-hover dataTable no-footer" id="LOANS_LIST" aria-describedby="simpledatatable_info">
                        <thead id="list_th">
                        <tr>
                            <th>姓名</th>
                            <th class="hidden-480">登录名</th>
                            <th>唯一号</th>
                            <th class="hidden-480"><i class="fa fa-mobile"></i> 手机号码</th>
                            <th class="hidden-phone"><i class="fa fa-clock-o"></i>注册时间</th>
                            <th class="hidden-phone"><i class="fa fa-clock-o"></i>上次登录</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody >
                        <c:forEach var="emp" items="${employeeList}">
                            <tr>
                                <td>
                                <cm:securityTag privilegeString="EMPLOYEE_DETAIL">
                                    <a href="/employee/profile/${emp.empId}">${emp.userName}</a>
                                    </cm:securityTag>
                                </td>
                                <td>${emp.loginName}</td>
                                <td class="hidden-480">${emp.empCode}</td>
                                <td class="hidden-480">${emp.userMobile}</td>
                                <td class="hidden-phone"><fmt:formatDate value="${emp.registerTime}"
                                                                         pattern="yy年M月d日 HH:mm"/></td>
                                <td class="hidden-phone"><fmt:formatDate value="${emp.lastLoginTime}"
                                                                         pattern="yy年M月d日 HH:mm"/></td>
                                <td>
                                    <div class="hidden-phone visible-desktop btn-group">
                                     <cm:securityTag privilegeString="EMPLOYEE_ALTER">
                                        <a class="btn btn-info btn-xs edit"title="编辑" onclick="showSingleEmployee(this)" data-EmpId="${emp.empId}">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        </cm:securityTag>
                                        <cm:securityTag privilegeString="EMPLOYEE_ALTER">
                                        <c:choose>
                                            <c:when test="${emp.enabled == true}">
                                                <a class="btn btn-danger btn-xs ban"
                                                   title="禁用"
                                                   onclick="showConfirm('确定要禁用用户 ${emp.userName} 么？','/employee/disable/${emp.empId}')">
                                                    <i class="fa fa-ban"></i>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a class="btn btn-success  btn-xs ok"
                                                   title="启用"
                                                   onclick="showConfirm('确定要启用用户 ${emp.userName} 么？','/employee/enable/${emp.empId}')">
                                                    <i class="fa fa-check"></i>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                        </cm:securityTag>
                                    </div>
                                    <%--< div class="hidden-desktop visible-phone">
                                        <div class="inline position-relative">
                                            <button class="btn btn-minier btn-yellow dropdown-toggle"
                                                    data-toggle="dropdown"><i class="icon-caret-down icon-only"></i>
                                            </button>
                                            <ul class="dropdown-menu dropdown-icon-only dropdown-yellow pull-right dropdown-caret dropdown-close">
                                                <li>
                                                    <a href="/employee/edit/${emp.empId}"
                                                       data-toggle="modal"
                                                       data-target="#singleEmployee"
                                                       class="tooltip-success"
                                                       data-rel="tooltip"
                                                       title="修改"
                                                       data-placement="left">
                                                        <span class="green"><i class="icon-edit"></i></span>
                                                    </a>
                                                </li>
                                                <li>
                                                    <c:choose>
                                                        <c:when test="${emp.enabled == true}">
                                                            <a href="employee/disable/${emp.empId}"
                                                               confirm="确定要禁用用户 ${emp.name} 么？"
                                                               class="tooltip-error"
                                                               data-rel="tooltip"
                                                               title="禁用"
                                                               data-placement="left">
                                                                <span class="red"><i class="icon-ban-circle"></i></span>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="employee/enable/${emp.empId}"
                                                               confirm="确定要启用用户 ${emp.name} 么？"
                                                               class="tooltip-error"
                                                               data-rel="tooltip"
                                                               title="启用"
                                                               data-placement="left">
                                                                <span class="green"><i class="icon-ok"></i></span>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </li>
                                            </ul>
                                        </div>
                                    </div> --%>
                                </td>
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
    <form id="employeeForm" class="form-horizontal" action="/employee/create" method="POST">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label class="control-label col-lg-4" for="loginName">员工登录名:</label>
                    <div class="controls col-lg-6">
                        <input type="hidden" name="empId" class="form-control" value="{{empId}}"/>
                        <input id="loginName" class="form-control"
                               type="text"
                               name="loginName"
                               placeholder=""
                               value="{{loginName}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="name">员工姓名:</label>
                    <div class="controls col-lg-6">
                        <input id="name" class="form-control"
                               type="text"
                               name="userName"
                               data-bv-notempty="true"
                               data-bv-notempty-message="请输入员工姓名"
                               placeholder=""
                               value="{{userName}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="IdNumber">员工身份证号:</label>
                    <div class="controls col-lg-6">
                        <input id="IdNumber" class="form-control"
                               type="text"
                               name="idNumber"
                               placeholder=""
                               value="{{idNumber}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="userMobile">员工手机号:</label>
                    <div class="controls col-lg-6">
                        <input id="userMobile" class="form-control"
                               type="text"
                               name="userMobile"
								
                               placeholder=""
                               value="{{userMobile}}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4" for="employeeId">员工唯一号:</label>
                    <div class="controls col-lg-6">
                        <input id="employeeId" class="form-control"
                               type="text"
                               name="empCode"
                               placeholder=""
                               value="{{empCode}}"/>
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
<div id="singleEmployee" class="modal fade">
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
<script src="/assets/js/employee/list.js"></script>

</body>
</html>
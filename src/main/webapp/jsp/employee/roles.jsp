<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/18
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>系统测试平台</title>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
    <style type="text/css">
        .panel-body{padding:0}
        .panel-body .roleCh{padding:10px 10px 10px 15px; list-style: none; cursor: pointer}
    </style>
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
                    <li class="active">角色权限</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        角色权限
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
                <div class="tabbable tabs-left clear">

					<!-- 角色列表 -->
					<div class="col-lg-2 col-sm-2 col-xs-12 PaddL-0">
					    <div class="widget">
					        <div class="widget-header bordered-bottom bordered-blue">
					            <span class="widget-caption">角色列表</span>
					            <cm:securityTag privilegeString="EMPLOYEE_ROLES_ADD">
									<button class="newRoles btn btn-palegreen btn-xs" style="margin-top: 4px; margin-right: 3px;"><i class="fa fa-plus"></i>新增</button>
                                 </cm:securityTag>
					        </div>
					        <div class="widget-body no-padding">
					            <div class="widget-main ">
					                <div class="panel-group accordion" id="accordion">
						                <c:forEach var="role" items="${roles}">
					                    <div class="panel panel-default">
					                        <div class="panel-heading ">
					                            <h4 class="panel-title">
					                                <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#roles" href="#${role.roleId}" onclick="fetch('${role.roleId}')">
					                                    ${role.roleName}
					                                </a>
					                            </h4>
					                        </div>

                                            <div id="${role.roleId}" class="panel-body accordion-body collapse" name="roleId${role.roleId}" style="height: 0px;background:#f5f5f5;">
                                                <div class="accordion-inner"></div>

                                            </div>
					                    </div>
					                    </c:forEach>
					                </div>
					            </div>
					        </div>
					    </div>
					</div>
					<!-- 角色列表 -->
					<!-- 角色详情 -->
					<div class="col-lg-5 col-sm-5 col-xs-12">
					    <div class="well with-header  with-footer">
                            <form class="form-horizontal" id="editRoles"  action="/employee/saveRoles" method="POST">
                                <div class="header bordered-blue">角色详情
                                    <div class="widget-toolbar no-border" style="position:absolute;right:5px;top:7px;">
                                        <cm:securityTag privilegeString="EMPLOYEE_ROLES_SAVE">

                                            <button type="submit" class="btn btn-xs btn-success roleEditbtn" style="display: none">
                                                <i class="fa-floppy-o fa"></i>  保存
                                            </button>
                                        </cm:securityTag>
                                        <cm:securityTag privilegeString="EMPLOYEE_ROLES_DELETE">
                                            <button type="button" id="delete_role" class="btn btn-xs btn-danger" style="display: none">
                                                <i class="fa fa-bug"></i> 删除
                                            </button>
                                        </cm:securityTag>
                                    </div>
                                </div>
                                <div id="roleDefaultC" style="font-size: 20px;color:#bebebe; text-align:center; text-shadow: 2px 2px 0px #f5f5f5;">请选择角色！</div>
                                <div class="widget-main no-padding editRolesWarp" style="display: none">
                                    <input id="roleId" name="roleId" type="hidden" value="0"/>

                                    <div class="hr-12"></div>
                                    <div class="row-fluid">
                                        <label for="roleName">名称：</label>
                                        <input id="roleName"
                                               name="roleName"
                                               type="text"
                                               class="form-control input-sm"
                                               style="width: 97%"/>
                                    </div>
                                    <div class="horizontal-space"></div>
                                    <div class="row-fluid">
                                        <label for="roleDesc">详情：</label>
					                	<textarea id="roleDesc"
                                                  name="description"
                                                  rows="5"
                                                  class="form-control"
                                                  style="width: 97%"></textarea>
                                    </div>
                                    <div class="horizontal-space"></div>
                                    <label>权限： <input class="ace first-input" type="checkbox"><span class="lbl text"></span></label>

                                    <c:forEach var="p" items="${ps}">
                                        <div class="widget">
                                            <div class="widget-header" style="position:relative;">
                                                <label style="position:absolute;left:11px;top:7px;">
                                                    <input class="ace check_all" type="checkbox">
                                                    <span class="widget-caption blue Font-16 lbl text"> ${p.description}</span>
                                                </label>

                                                <div class="widget-buttons">
                                                    <a href="#" data-toggle="collapse">
                                                        <i class="fa fa-minus blue"></i>
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="widget-body Loan-Info" style="display: block;">

                                                <div class="widget-main no-padding">
                                                    <c:forEach var="privilege" items="${Privileges}">
                                                        <c:if test="${p.realm == privilege.realm}">
                                                            <label>
                                                                <input id="${privilege.key}"
                                                                       class="ace check_each"
                                                                       type="checkbox"
                                                                       name="privileges"
                                                                       value="${privilege}">
                                                                <span class="lbl text"> ${privilege.key}</span>
                                                            </label><br>

                                                        </c:if>
                                                    </c:forEach>
                                                </div>

                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </form>
                            <form class="form-horizontal" id="newRolesDt" style="display: none"  action="/employee/saveRoles" method="POST">
                                <div class="header bordered-blue">角色详情
                                    <div class="widget-toolbar no-border" style="position:absolute;right:5px;top:7px;">
                                        <cm:securityTag privilegeString="EMPLOYEE_ROLES_SAVE">
                                            <button type="submit" class="btn btn-xs btn-success">
                                                <i class="fa-floppy-o fa"></i>  保存
                                            </button>
                                        </cm:securityTag>
                                    </div>
                                </div>

                                <div class="widget-main no-padding">
                                   <%-- <input id="rolePid" name="rolePid" type="hidden" value="0"/>
--%>
                                    <div class="hr-12"></div>
                                    <div class="row-fluid">
                                        <label for="roleName">父级角色：</label><br/>
                                        <input type="hidden" name="rolePid" value="">
                                        <div class="btn-group">
                                            <a class="btn btn-sm btn-default roleDefault" href="javascript:void(0);">顶级角色</a>
                                            <a class="btn btn-sm btn-default  dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);"><i class="fa fa-angle-down"></i></a>
                                            <ul class="dropdown-menu">
                                                <c:forEach var="role" items="${roles}">
                                                    <li>
                                                        <a href="javascript:void(0);" value="${role.roleId}">${role.roleName}</a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                       <div class="horizontal-space"></div>
                                    <div class="row-fluid">
                                        <label for="roleName">名称：</label>
                                        <input id="roleName"
                                               name="roleName"
                                               type="text"
                                               class="form-control input-sm"
                                               style="width: 97%"/>
                                    </div>
                                    <div class="horizontal-space"></div>
                                    <div class="row-fluid">
                                        <label for="roleDesc">详情：</label>
					                	<textarea id="roleDesc"
                                                  name="description"
                                                  rows="5"
                                                  class="form-control"
                                                  style="width: 97%"></textarea>
                                    </div>
                                    <div class="horizontal-space"></div>
                                       <input id="${privilege.key}"
                                              class="ace check_each"
                                              type="checkbox"
                                              name="privileges"
                                              value="${privilege}" style="display: none">

                                </div>
                            </form>
					     </div>
					</div>             		
             		<!-- 角色详情 -->
             		
             		
             		<!-- 成员列表 -->
					<div class="col-lg-5 col-sm-5 col-xs-12">
					    <div class="well with-header  with-footer">
					        <div class="header bordered-blue">成员列表 
					        	<div class="widget-toolbar" style="position:absolute;right:5px;top:7px;">
					                <span id="membersCount" class="bold">0</span>  人
					            </div>
					        	
					        </div>
					        <div class="widget-main no-padding">
					            <table id="members" class="table table-striped">
					                <thead>
					                <tr>
					                    <th>姓名</th>
					                    <th>唯一号</th>
					                    <th>登录名</th>
					                </tr>
					                </thead>
					                <tbody>
					                </tbody>
					            </table>
					        </div>
					
					    </div>
					</div>             		
             		<!-- 成员列表 -->

             		
                     
                     
                   
               
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
<script src="/assets/js/employee/roles.js" type="text/javascript"></script>
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/25
  Time: 12:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>员工详情 千金所测试平台</title>
    <meta name="description" content="千金所测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <%--<link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />--%>
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
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        员工详情
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
                <div class="profile-container">
                    <div class="profile-header row">
                        <div class="col-lg-2 col-md-4 col-sm-12 text-center">
                            <img src="/assets/img/avatars/male.jpg" alt="" class="header-avatar">
                        </div>
                        <div class="col-lg-2 col-md-8 col-sm-12 profile-info">
                            <div class="header-fullname">
                            ${employee.userName }
                            </div><br/><br/>
                            <cm:securityTag privilegeString="USER_RESETPASSWORD">
                            <a href=""  class="btn btn-palegreen btn-sm czma">
                                <i class="fa fa-refresh"></i>    重置密码
                            </a>
							</cm:securityTag>
                        </div>
                        <div class="col-lg-8 col-md-12 col-sm-12 col-xs-12">
                        	<br><br>
                        
                        	<div class="profile-user-info">
                                <div class="profile-info-row">
                                    <div class="profile-info-name">登录名</div>
                                    <div class="profile-info-value">
                                        <span> ${employee.loginName }</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name">唯一号</div>
                                    <div class="profile-info-value">
                                        <span>${employee.empCode }</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 手机号</div>
                                    <div class="profile-info-value">
                                        <span>${employee.userMobile }</span>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name">上次登录</div>
                                    <div class="profile-info-value">
                                        <span><fmt:formatDate value="${employee.lastLoginTime}" pattern="yy年M月d日 HH:mm"/></span>
                                    </div>
                                </div>
                            	
                                <%-- <div class="profile-info-row">
                                    <div class="profile-info-name">系统角色</div>
                                    <div class="profile-info-value blue">
                                        <form action="employee/${employee.id}/roles" method="POST"
                                              class="no-margin no-padding no-border">
                                            <select name="roles" multiple="multiple" size="3">
                                                <c:forEach var="role" items="${allRoles}">
                                                    <option value="${role.id}"
                                                            <c:if test="${cm:contains(rolesIds, role.id)}">selected="true"</c:if>>
                                                            ${role.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <input class="btn btn-mini btn-warning" type="submit" value="保存"/>
                                        </form>
                                    </div>
                                </div>
                                 --%>
                                 
                                 <div class="profile-info-row">
                                    <div class="profile-info-name">系统角色</div>
                                    <div class="profile-info-value blue">
                                        <form action="/employee/${employee.empId}/roles" method="POST"
                                              class="no-margin no-padding no-border">
                                            <select name="roles" multiple="multiple" size="5">
                                                <c:forEach var="role" items="${allRoles}">
                                                    <option value="${role.roleId}" 
                                                            <c:if test="${cm:contains(rolesIds, role.roleId)}">selected="true"</c:if>
                                                            <c:if test="${not empty role.rolePid}">
                                                            style="color: orange" 
                                                            </c:if>
                                                            <c:if test="${empty role.rolePid}">
                                                            style="color: green"
                                                            </c:if>
                                                     >
                                                            <c:if test="${not empty role.rolePid}">
                                                            &nbsp;&nbsp;&nbsp;
                                                            </c:if>
                                                            ${role.roleName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <cm:securityTag privilegeString="EMPLOYEE_OWN_ROLES_SAVE">
                                            <input class="btn btn-mini btn-warning" type="submit" value="保存"/>
                                            </cm:securityTag>
                                        </form>
                                    </div>
                                </div>
                                <div class="profile-info-row">
                                    <div class="profile-info-name">操作权限</div>
                                    
                                    <div class="profile-info-value green">
                                        <c:forEach var="privilege" items="${privileges}">
                                            ${privilege.key}&nbsp;
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        
 							<!--  
                            <div class="contact-info">
                                <p>
                               
                                  		  登录名	:  ${employee.loginName } <br>
                                  		
                                  		  唯一号		:   ${employee.empId }
                                </p>
                                <p>
                               		     手机号		:  ${employee.userMobile }
                                    <br>
                                 		   上次登录		: <fmt:formatDate value="${employee.lastLoginTime}"
                                                                         pattern="yy年M月d日 HH:mm"/>
                                </p>
                                <p>
                                 		   系统角色	: facebook.com/Kim.Ryder
                                    <br>
                                    Twitter	: @KimRyder
                                </p>
                            </div>
                            -->
                            
                            
                            <br><br>
                        </div>
                    </div>

                </div>



            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
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
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/employee/list.js"></script>

<script>
function sure()
{
	if(confirm("确定要重置密码么？"))
	{
		$.ajax({ 
			type: 'POST',
			url: "/setting/resetPassword", 
			data:{empId:'${employee.empId}'},
			dataType:'json',
			async:false, 
			success: function(data){
				if(data.success =="1" ){       
			    	alert(data.comment);    
			    	window.location.reload();    
				}else{    
					alert(data.comment);    
			    	window.location.reload();  
			    }    
			}
		});
	}else{
		return false;   
	}
}

$('.czma').click(function(){
	sure();
});
</script>
</body>
</html>

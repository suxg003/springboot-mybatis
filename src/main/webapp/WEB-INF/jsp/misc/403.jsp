<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>403 Forbidden</title>
    <%@include file="../common/head.jspf" %>
</head>
<body class="navbar-fixed">
<%@include file="../common/navbar.jspf" %>

<div class="container-fluid main-container" id="main-container">
    <%@include file="../common/sidebar.jspf" %>
    <div id="main-content" class="clearfix main-content">

        <div id="breadcrumbs" class="breadcrumbs">
            <ul class="breadcrumb">
                <li><i class="icon-home"></i> <a href="dashboard">首页</a><span class="divider"><i
                        class="icon-angle-right"></i></span></li>
                <li class="active">错误 403</li>
            </ul>
            <!--.breadcrumb-->
        </div>
        <!--#breadcrumbs-->

        <div id="page-content" class="clearfix page-content">
            <div class="row-fluid">
                <!-- PAGE CONTENT BEGINS HERE -->
                <div class="error-container">
                    <div class="well">
<!--                         <h5 class="grey lighter smaller"> -->
<!--                             <span class="blue bigger-125"><i class="icon-question"></i> 403</span> 没有权限 -->
<%--                             <small>${fn:escapeXml(pageContext.request.scheme)}://${fn:escapeXml(header.host)}${fn:escapeXml(pageContext.errorData.requestURI)}</small> --%>
<!--                         </h5> -->
                        <hr/>
                        <h3 class="lighter smaller">您需要 ${insufficientPrivilege} 权限访问相关资源！</h3>

                        <div>
                            <div class="space"></div>
                            <h4 class="smaller">您可以尝试:</h4>
                            <ul class="unstyled spaced inline bigger-110">
                                <li><i class="icon-hand-right blue"></i> 检查路径拼写是否正确</li>
                                <li><i class="icon-hand-right blue"></i> 查阅系统使用说明</li>
                                <li><i class="icon-hand-right blue"></i> 联系系统管理员</li>
                            </ul>
                        </div>
                        <hr/>
                        <div class="space"></div>
                        <div class="row-fluid">
                            <div class="center">
                                <a href="#" class="btn btn-grey" onclick="history.back()"><i
                                        class="icon-arrow-left"></i>快速返回</a>
                                <a href="/index" class="btn btn-primary"><i class="icon-dashboard"></i>工作面板</a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- PAGE CONTENT ENDS HERE -->
            </div>
            <!--/row-->
        </div>
        <!--/#page-content-->
    </div>
</div>
<%@include file="../common/foot.jspf" %>
</body>
</html>

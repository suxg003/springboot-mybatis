<%-- 
    Document   : postLoan/inspect
    Created on : Aug 23, 2013, 5:10:21 PM
    Author     : sobranie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>Blank 空白页面</title>
    <%@include file="../common/head.jspf" %>
</head>
<body class="navbar-fixed">
<%@include file="../common/navbar.jspf" %>

<div class="container-fluid main-container" id="main-container">
    <%@include file="../common/sidebar.jspf" %>
    <div id="main-content" class="clearfix main-content">

        <div id="breadcrumbs" class="breadcrumbs">
            <ul class="breadcrumb">
                <li>
                    <i class="icon-home home-icon"></i> <a href="dashboard">首页</a>
                            <span class="divider">
                                <i class="icon-angle-right"></i>
                            </span>
                </li>
                <li>
                    空白页面
                            <span class="divider">
                                <i class="icon-angle-right"></i>
                            </span>
                </li>
                <li class="active">空白页面</li>
            </ul>
            <!--.breadcrumb-->
        </div>
        <!--#breadcrumbs-->

        <div id="page-content" class="clearfix page-content">


        </div>
    </div>
</div>
<%@include file="../common/foot.jspf" %>
</body>
</html>

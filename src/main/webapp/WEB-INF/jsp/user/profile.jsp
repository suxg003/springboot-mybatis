<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/27
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>用户信息-千金所测试平台</title>
    <meta name="description" content="千金所测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <link href="/assets/css/camera.css" rel="stylesheet" />
    <link href="/assets/css/royalslider.css" rel="stylesheet" />
    <link href="/assets/css/rs-default.css" rel="stylesheet" />
    <link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
    <style>
        .pagination>li.active {display: inline;}
    </style>
    <script>
        var CC = (typeof CC == "undefined") ? {} : CC;
        CC.user = {
            id: '${user.userId}',
            name: '${user.userName}',
            idNumber: '${user.idNumber}'
        };
    </script>
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
                    <li class="active">
                        <a href="/user/list">个人用户列表</a></li>
                    <li class="active">用户管理</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        用户信息
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
                <div class="row">
                    <div class="col-md-12">
                        <div class="profile-container">
                            <div class="profile-header row UserInfo-Header" style=" margin: 15px 0px 0;height: 230px;">
                                <div class="col-lg-2 col-md-2 col-sm-12 text-center" style="padding: 0;height: 230px;">
                                    <c:choose>
                                        <c:when test="${not empty avatar}"><img src="${avatar}" alt="" class="header-avatar"></c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${user.male}"><img src="/assets/img/avatars/male.jpg" alt="" class="header-avatar"></c:when>
                                                <c:otherwise><img src="/assets/img/avatars/female.jpg" alt="" class="header-avatar"></c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-12 profile-info"style="padding:10px 0 30px 0;height: 220px;" >
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12 col-sm-12 header-fullname">
                                            <span class="MargT-10 MargB-10 " style="float: left;margin-right: 10px">${user.userName }</span>
                                            <c:choose>
                                                <c:when test="${user.coreUserAuth.idAuth}">
                                                    <span class="MargT-10 MargB-10 success" style="float: left;font-size: 14px"><i class="fa  fa-credit-card"></i>&nbsp;已认证 </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="MargT-10 MargB-10 error" style="float: left;font-size: 14px"><i class="fa  fa-credit-card"></i>&nbsp;未认证 </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                            <div class="col-lg-6 col-md-6 col-sm-12 PaddL-5 PaddR-5 " >
                                                <div class="stats-value pink Font-16">${user.countLoan }</div>
                                                <div class="stats-title">贷款次数</div>
                                            </div>
                                            <div class="col-lg-6 col-md-6 col-sm-12 PaddL-5 PaddR-5 ">
                                                <div class="stats-value pink Font-16">${user.countInvest }</div>
                                                <div class="stats-title">投资次数</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 inlinestats-col Line-Height-24">

                                            <div class="stats-title text-left" style="font-size: 12px">注册时间:<fmt:formatDate value="${user.registerTime }"
                                                                                                                            pattern="yy年M月d日 HH:mm"/></div>
                                            <div class="stats-title text-left " style="font-size: 12px">上次登录:<fmt:formatDate value="${user.lastLoginTime }"
                                                                                                                             pattern="yy年M月d日 HH:mm"/></div>




                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-1 col-md-2 col-sm-12 profile-stats" style="padding: 0;width: 10%;height: 230px;">
                                    <div class="row">
                                        <h4 class="header-io text-center">信用信息</h4>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 inlinestats-col Line-Height-24">
                                            <div class="stats-title text-left"> 信用等级：HR</div>
                                            <div class="stats-title text-left"> 信用评分:</div>
                                            <div class="stats-title text-left"> 信用额度: <strong class="pink">￥0.00</strong></div>
                                            <div class="stats-title text-left"> 可用额度: <strong class="pink">￥0.00</strong></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-6 col-md-4 col-sm-12 profile-stats" style="padding: 0;width: 56.6%;height: 230px;">
                                    <div class="row">
                                        <h4 class="header-io text-center">资金信息</h4>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 inlinestats-col Line-Height-24" style="font-size: 12px;height: auto !important;">
                                            <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 " style="padding: 0 0 0 8px">
                                                <div class="stats-title text-left">可用金额: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.balance}" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">冻结金额: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.frozen}" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">零存宝持有: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.currentBalance}" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">月盈持有: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.monthDueIn }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">复利持有: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.recycleDueIn }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">定期待收本息: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.fixedRealDueIn }" type="currency" pattern=",##0.00"/></strong></div>
                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 " style="padding: 0 0 0 8px">
                                                <div class="stats-title text-left">直投待收本息: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.rmbDueIn }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">原优选待收本息: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.uplanDueIn }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">零存宝累计收益: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.currentInterest }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">月盈已收利息: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.monthInterest }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">复利已收利息: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.recycleInterest }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">定期已收利息: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.fixedInterest }" type="currency" pattern=",##0.00"/></strong></div>

                                            </div>
                                            <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 " style="padding: 0 0 0 8px">
                                                <div class="stats-title text-left">直投已收利息: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.rmbInterest }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">原优选已收利息: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.uplanInterest }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">红包返现: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.platformRedPackage }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">平台其他福利: <strong class="pink">￥<fmt:formatNumber value="${accountDetail.platformReward }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">待还总额: <strong class="pink">￥<fmt:formatNumber value="${user.dueOutAmount }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">充值总额: <strong class="pink">￥<fmt:formatNumber value="${user.depositAmount }" type="currency" pattern=",##0.00"/></strong></div>
                                                <div class="stats-title text-left">提取总额: <strong class="pink">￥<fmt:formatNumber value="${user.withdrawAmount }" type="currency" pattern=",##0.00"/></strong></div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <cm:securityTag privilegeString="USER_DETAIL_ALTER">
                                <div class="profile-body row">
                                    <div class="col-lg-12">
                                        <div class="tabbable">
                                            <ul class="nav nav-tabs tabs-flat  nav-justified" id="myTab11">
                                                <li class="active" tab-toggle="personal-tab">
                                                    <a data-toggle="tab" href="#profile-account">个人信息</a>
                                                </li>
                                                <li tab-toggle="certificate-tab">
                                                    <a data-toggle="tab" href="#certifications">认证信息</a>
                                                </li>
                                                <li tab-toggle="loan-tab">
                                                    <a data-toggle="tab" href="#profile-login">登录信息</a>
                                                </li>
                                                <li tab-toggle="loan-tab">
                                                    <a data-toggle="tab" href="#profile-loan">借入历史</a>
                                                </li>
                                                <li tab-toggle="rent-tab">
                                                    <a data-toggle="tab" href="#profile-rent">借出历史</a>
                                                </li>
                                                <li tab-toggle="licai-tab">
                                                    <a data-toggle="tab" href="#profile-licai">资金记录</a>
                                                </li>
                                                <li tab-toggle="others-tab">
                                                    <a data-toggle="tab" href="#profile-others">其他</a>
                                                </li>
                                            </ul>
                                            <div class="tab-content tabs-flat">
                                                <div id="profile-account" class="tab-pane active">
                                                    <div class="tabbable">
                                                        <ul class="nav nav-tabs padding-16">
                                                            <li class="active">
                                                                <a data-toggle="tab" href="#detail-info">
                                                                    <i class="green icon-edit-sign bigger-125"></i>详细信息
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a data-toggle="tab" href="#assets-info">
                                                                    <i class="purple icon-trophy bigger-125"></i>资产信息
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a data-toggle="tab" href="#career-info">
                                                                    <i class="blue icon-linkedin-sign bigger-125"></i>工作信息
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a data-toggle="tab" href="#contact-info">
                                                                    <i class="orange icon-phone-sign bigger-125"></i>联系人信息
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a data-toggle="tab" href="#bank-cards">
                                                                    <i class="red icon-credit-card bigger-125"></i>绑定银行卡
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a data-toggle="tab" href="#id-info">
                                                                    <i class="pink icon-star bigger-125"></i> 身份认证
                                                                </a>
                                                            </li>
                                                            <li>
                                                                <a data-toggle="tab" href="#recommend-info">
                                                                    <i class="pink icon-star bigger-125"></i> 推荐记录
                                                                </a>
                                                            </li>
                                                        </ul>

                                                        <div class="tab-content profile-edit-tab-content">
                                                            <div id="detail-info" class="tab-pane in active clear">
                                                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                                                    <div class="space-10"></div>
                                                                    <c:if test="${user.enterprise}">
                                                                    <button class="btn btn-small btn-danger pull-right margin-top-10-inverse"
                                                                            id="updateENPersonalInfo">保存修改
                                                                    </button>
                                                                    </c:if>
                                                                    <c:if test="${!user.enterprise}">
                                                                        <button class="btn btn-small btn-danger pull-right margin-top-10-inverse"
                                                                                id="updatePersonalInfo">保存修改
                                                                        </button>
                                                                    </c:if>
                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">基本信息</h5>
                                                                    <c:if test="${user.enterprise}">
                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">登录名（企业简称）：</div>
                                                                            <div class="profile-info-value">
                                                                                <a href="###">${user.loginName}</a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">企业名称（全称）：</div>
                                                                            <div class="profile-info-value">
                                                                                <a href="###">${user.userName}</a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">法人身份证号：</div>
                                                                            <div class="profile-info-value">
                                                                                <a href="###">${user.idNumber}</a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">法人手机号：</div>
                                                                            <div class="profile-info-value">
                                                                                <a href="###">${user.userMobile}</a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">企业营业执照编号：</div>
                                                                            <div class="profile-info-value">
                                                                                <a href="###">${user.enLicenseNo}</a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">企业邮箱：</div>
                                                                            <div class="profile-info-value">
                                                                                <a href="###">${user.email}</a>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">详情信息</h5>
                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">公司地址：</div>
                                                                            <div class="profile-info-value">
                                                                                <input id="e_userId" name="userId" value="${user.userId}" type="hidden"/>
                                                                                <input id="e_enAddress" name="enAddress" value="${user.enAddress}"/>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">公司座机：</div>
                                                                            <div class="profile-info-value">
                                                                                <input id="e_enPhone" name="enPhone" value="${user.enPhone}"/>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">企业性质：</div>
                                                                            <div class="profile-info-value">
                                                                                <input id="e_enNature" name="enNature" value="${user.enNature}"/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    </c:if>
                                                                    <c:if test="${!user.enterprise}">
                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">用户名：</div>
                                                                            <div class="profile-info-value">
                                                                                    <%--  <a href="user/profile/${user.userId}">${user.loginName}</a> --%>
                                                                                <a href="###">${user.loginName}</a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">真实姓名：</div>
                                                                            <div class="profile-info-value">
                                                                                    ${user.userName}
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">身份证号码：</div>
                                                                            <div class="profile-info-value">
                                                                                    ${user.idNumber}
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">手机号码：</div>
                                                                            <div class="profile-info-value">
                                                                                    ${user.userMobile}
                                                                            </div>
                                                                        </div>
                                                                            <%--  <c:if test="${user.email != default_email}"> --%>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">电子邮箱：</div>
                                                                            <div class="profile-info-value">
                                                                                    ${user.email}
                                                                                    <%--  ${user.email} --%>
                                                                            </div>
                                                                        </div>
                                                                            <%--  </c:if> --%>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">推荐人：</div>
                                                                            <div class="profile-info-value">
                                                                                    ${user.referralLoginName}
                                                                                    <%--  <c:choose>
                                                                                         <c:when test="${user.referralEntity.realm == 'EMPLOYEE'}">
                                                                                             <a href="employee/profile/${user.referralEntity.entityId}"
                                                                                                target="_blank">${user.referralLoginName}</a>
                                                                                         </c:when>
                                                                                         <c:when test="${user.referralEntity.realm == 'USER'}">
                                                                                             <a href="user/profile/${user.referralEntity.entityId}"
                                                                                                target="_blank">${user.referralLoginName}</a>
                                                                                         </c:when>
                                                                                     </c:choose> --%>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name radioLabel">性别：</div>

                                                                            <div class="profile-info-value">
                                                                                <label class="inline MargR-10">
                                                                                    <input type="radio" name="male" id="maleRadios1" value="true" checked="checked"/>
                                                                                    <span class="lbl text">男</span>
                                                                                </label>
                                                                                <label class="inline">
                                                                                    <input type="radio" name="male" id="maleRadios2" value="false"/>
                                                                                    <span class="lbl text">女</span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">出生日期：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="dateOfBirth"
                                                                                  class=""
                                                                                  data-type="combodate"
                                                                                  data-value="${userInfo.personal.dateOfBirth}"
                                                                                  data-format="YYYY-MM-DD"
                                                                                  data-viewformat="YYYY年 MM月DD日"
                                                                                  data-template="YYYY 年 MMM 月 D 日">
                                                                             </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">民族：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="ethnic">
                                                                                    ${userInfo.personal.ethnic.key}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">婚姻状况：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="maritalStatus">
                                                                                    ${userInfo.personal.maritalStatus.key}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name radioLabel">有无子女：</div>
                                                                            <div class="profile-info-value">
                                                                                <label class="inline margin-right-10">
                                                                                    <input type="radio" name="children" id="childrenRadios1" value="true" checked="checked"/>
                                                                                    <span class="lbl text">有</span>
                                                                                </label>
                                                                                <label class="inline">
                                                                                    <input type="radio" name="children" id="childrenRadios2" value="false"/>
                                                                                    <span class="lbl text">无</span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">教育信息</h5>

                                                                    <div class="profile-user-info">
                                                                        <div class="profile-user-info">
                                                                            <div class="profile-info-row">
                                                                                <div class="profile-info-name">最高学历：</div>
                                                                                <div class="profile-info-value">
                                                                                <span id="educationLevel"
                                                                                      class="">
                                                                                        ${userInfo.personal.education.educationLevel.key}
                                                                                </span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="profile-info-row">
                                                                                <div class="profile-info-name">入学年份：</div>
                                                                                <div class="profile-info-value">
                                                                               <span id="enrollmentYear"
                                                                                     class=""
                                                                                     data-placeholder="最高学历入学年份"
                                                                                     data-type="text">
                                                                                       ${userInfo.personal.education.enrollmentYear}
                                                                               </span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="profile-info-row">
                                                                                <div class="profile-info-name">毕业学校：</div>
                                                                                <div class="profile-info-value">
                                                                                <span id="school"
                                                                                      class="editable"
                                                                                      data-placeholder="学校名称"
                                                                                      data-type="text">
                                                                                        ${userInfo.personal.education.school}
                                                                                </span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">户籍信息</h5>
                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">籍贯：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="nativeProvince"
                                                                                  class="editable"
                                                                                  data-placeholder="籍贯省"
                                                                                  data-type="text">
                                                                                    ${userInfo.personal.place.nativeProvince}
                                                                            </span>
                                                                            <span id="nativeCity"
                                                                                  class="editable"
                                                                                  data-placeholder="籍贯市"
                                                                                  data-type="text">
                                                                                    ${userInfo.personal.place.nativeCity}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">户口所在地：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="hukouProvince"
                                                                                  class="editable"
                                                                                  data-placeholder="户口所在省"
                                                                                  data-type="text">
                                                                                    ${userInfo.personal.place.hukouProvince}
                                                                            </span>
                                                                            <span id="hukouCity"
                                                                                  class="editable"
                                                                                  data-placeholder="户口所在城市"
                                                                                  data-type="text">
                                                                                    ${userInfo.personal.place.hukouCity}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">现居住地址：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="currentAddress"
                                                                                  class="editable"
                                                                                  data-placeholder="详细地址"
                                                                                  data-type="text">
                                                                                    ${userInfo.personal.place.currentAddress}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">联系电话：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="currentPhone"
                                                                                  class="phone_number"
                                                                                  data-type="text">
                                                                                    ${userInfo.personal.place.currentPhone}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                            <c:if test="${user.enterprise==false}">
                                                            <div id="assets-info" class="tab-pane clear">
                                                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                                                    <div class="space-10"></div>
                                                                    <button class="btn btn-small btn-danger pull-right margin-top-10-inverse"
                                                                            id="updateFinanceInfo">保存修改
                                                                    </button>
                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">房产信息</h5>

                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name radioLabel">是否有房：</div>
                                                                            <div class="profile-info-value">
                                                                                <label class="inline margin-right-10">
                                                                                    <input type="radio" name="house" id="houseRadios1" value="true"/>
                                                                                    <span class="lbl text">有</span>
                                                                                </label>
                                                                                <label class="inline">
                                                                                    <input type="radio" name="house" id="houseRadios2" value="false" checked/>
                                                                                    <span class="lbl text"> 无</span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row houseNumber hide">
                                                                            <div class="profile-info-name">房产数目：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="houseNumber"
                                                                                  class=""
                                                                                  data-value="${userInfo.finance.houseNumber}"
                                                                                  data-type="number">
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row houseLoan hide">
                                                                            <div class="profile-info-name radioLabel">有无房贷：</div>
                                                                            <div class="profile-info-value">
                                                                                <label class="inline margin-right-10">
                                                                                    <input type="radio" name="houseLoan" id="houseLoanRadios1" value="true"/>
                                                                                    <span class="lbl text">  有</span>
                                                                                </label>
                                                                                <label class="inline">
                                                                                    <input type="radio" name="houseLoan" id="houseLoanRadios2" value="false" checked/>
                                                                                    <span class="lbl text"> 无</span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">车辆信息</h5>

                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name radioLabel">是否有车：</div>
                                                                            <div class="profile-info-value">
                                                                                <label class="inline margin-right-10">
                                                                                    <input type="radio" name="car" id="carRadios1"  value="true"/>
                                                                                    <span class="lbl text">  有</span>
                                                                                </label>
                                                                                <label class="inline">
                                                                                    <input type="radio" name="car" id="carRadios2" value="false" checked/>
                                                                                    <span class="lbl text">  无</span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row carNumber hide">
                                                                            <div class="profile-info-name">车辆数目：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="carNumber"
                                                                                  class=""
                                                                                  data-value="${userInfo.finance.carNumber}"
                                                                                  data-type="number">
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row carLoan hide">
                                                                            <div class="profile-info-name radioLabel">有无车贷：</div>
                                                                            <div class="profile-info-value">
                                                                                <label class="inline margin-right-10">
                                                                                    <input type="radio" name="carLoan" id="carLoanRadios1" value="true"/>
                                                                                    <span class="lbl text"> 有</span>
                                                                                </label>
                                                                                <label class="inline">
                                                                                    <input type="radio" name="carLoan" id="carLoanRadios2" value="false"  checked/>
                                                                                    <span class="lbl text "> 无 </span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div id="career-info" class="tab-pane clear">
                                                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                                                    <div class="space-10"></div>
                                                                    <button class="btn btn-small btn-danger pull-right margin-top-10-inverse"
                                                                            id="updateCareerInfo">保存修改
                                                                    </button>

                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">公司信息</h5>
                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">公司名称：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="companyName"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.career.company.name}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">公司类别：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="companyType"
                                                                                  class="">
                                                                                    ${userInfo.career.company.type.key}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">所属行业：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="companyIndustry"
                                                                                  class="">
                                                                                    ${userInfo.career.company.industry.key}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">公司规模：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="companySize"
                                                                                  class="">
                                                                                    ${userInfo.career.company.companySize.key}
                                                                            </span>
                                                                            </div>
                                                                        </div>

                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">公司电话：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="companyPhone">
                                                                                    ${userInfo.career.company.phone}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">公司地址：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="companyAddres"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.career.company.address}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">工作状态</h5>
                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">职业状态：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="careerStatus"
                                                                                  class="">
                                                                                    ${userInfo.career.careerStatus.key}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">具体职位：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="position"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.career.position}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">月收入：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="salary"
                                                                                  class="">
                                                                                    ${userInfo.career.salary.key}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">工作年限：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="yearOfService"
                                                                                  class="">
                                                                                    ${userInfo.career.yearOfService.key}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">工作省份：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="province"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.career.province}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">工作城市：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="city"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.career.city}
                                                                            </span>
                                                                            </div>
                                                                        </div>

                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">工作邮箱：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="workMail"
                                                                                  class="editable"
                                                                                  data-type="email">
                                                                                    ${userInfo.career.workMail}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div id="contact-info" class="tab-pane clear">
                                                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                                                    <div class="space-10"></div>
                                                                    <button class="btn btn-small btn-danger pull-right margin-top-10-inverse"
                                                                            id="updateContactInfo">保存修改
                                                                    </button>
                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">紧急联系人</h5>

                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">姓名：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="emergency_name"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.contact.emergency.name}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">与用户关系：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="emergency_relation"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.contact.emergency.relation}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">手机号码：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="emergency_mobile"
                                                                                  class="phone_number"
                                                                                  data-type="text">
                                                                                    ${userInfo.contact.emergency.mobile}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">同事</h5>

                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">姓名：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="colleague_name"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.contact.colleague.name}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">与用户关系：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="colleague_relation"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.contact.colleague.relation}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">手机号码：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="colleague_mobile"
                                                                                  class="phone_number"
                                                                                  data-type="text">
                                                                                    ${userInfo.contact.colleague.mobile}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">其他联系人</h5>

                                                                    <div class="profile-user-info">
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">姓名：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="other_name"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.contact.other.name}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">与用户关系：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="other_relation"
                                                                                  class="editable"
                                                                                  data-type="text">
                                                                                    ${userInfo.contact.other.relation}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="profile-info-row">
                                                                            <div class="profile-info-name">手机号码：</div>
                                                                            <div class="profile-info-value">
                                                                            <span id="other_mobile"
                                                                                  class="phone_number"
                                                                                  data-type="text">
                                                                                    ${userInfo.contact.other.mobile}
                                                                            </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            </c:if>
                                                            <c:if test="${user.enterprise==true}">
                                                                <div id="assets-info" class="tab-pane clear">
                                                                    <div class="col-lg-12 col-sm-12 col-xs-12">
                                                                        <div class="space-10"></div>
                                                                        <button class="btn btn-small btn-danger pull-right margin-top-10-inverse"
                                                                                id="updateFinanceInfo">保存修改
                                                                        </button>
                                                                        <h5 class="row-title before-blue header blue MargT-20 MargL-0">房产信息</h5>

                                                                        <div class="profile-user-info">
                                                                            <div class="profile-info-row">
                                                                                <div class="profile-info-name radioLabel">是否有房：</div>
                                                                                <div class="profile-info-value">
                                                                                    <label class="inline margin-right-10">
                                                                                        <input type="radio" name="house" id="houseRadios1" value="true"/>
                                                                                        <span class="lbl text">有</span>
                                                                                    </label>
                                                                                    <label class="inline">
                                                                                        <input type="radio" name="house" id="houseRadios2" value="false" checked/>
                                                                                        <span class="lbl text"> 无</span>
                                                                                    </label>
                                                                                </div>
                                                                            </div>
                                                                            <div class="profile-info-row houseNumber hide">
                                                                                <div class="profile-info-name">房产数目：</div>
                                                                                <div class="profile-info-value">
                                                                            <span id="houseNumber"
                                                                                  class=""
                                                                                  data-value="${userInfo.finance.houseNumber}"
                                                                                  data-type="number">
                                                                            </span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="profile-info-row houseLoan hide">
                                                                                <div class="profile-info-name radioLabel">有无房贷：</div>
                                                                                <div class="profile-info-value">
                                                                                    <label class="inline margin-right-10">
                                                                                        <input type="radio" name="houseLoan" id="houseLoanRadios1" value="true"/>
                                                                                        <span class="lbl text">  有</span>
                                                                                    </label>
                                                                                    <label class="inline">
                                                                                        <input type="radio" name="houseLoan" id="houseLoanRadios2" value="false" checked/>
                                                                                        <span class="lbl text"> 无</span>
                                                                                    </label>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <h5 class="row-title before-blue header blue MargT-20 MargL-0">车辆信息</h5>

                                                                        <div class="profile-user-info">
                                                                            <div class="profile-info-row">
                                                                                <div class="profile-info-name radioLabel">是否有车：</div>
                                                                                <div class="profile-info-value">
                                                                                    <label class="inline margin-right-10">
                                                                                        <input type="radio" name="car" id="carRadios1"  value="true"/>
                                                                                        <span class="lbl text">  有</span>
                                                                                    </label>
                                                                                    <label class="inline">
                                                                                        <input type="radio" name="car" id="carRadios2" value="false" checked/>
                                                                                        <span class="lbl text">  无</span>
                                                                                    </label>
                                                                                </div>
                                                                            </div>
                                                                            <div class="profile-info-row carNumber hide">
                                                                                <div class="profile-info-name">车辆数目：</div>
                                                                                <div class="profile-info-value">
                                                                            <span id="carNumber"
                                                                                  class=""
                                                                                  data-value="${userInfo.finance.carNumber}"
                                                                                  data-type="number">
                                                                            </span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="profile-info-row carLoan hide">
                                                                                <div class="profile-info-name radioLabel">有无车贷：</div>
                                                                                <div class="profile-info-value">
                                                                                    <label class="inline margin-right-10">
                                                                                        <input type="radio" name="carLoan" id="carLoanRadios1" value="true"/>
                                                                                        <span class="lbl text"> 有</span>
                                                                                    </label>
                                                                                    <label class="inline">
                                                                                        <input type="radio" name="carLoan" id="carLoanRadios2" value="false"  checked/>
                                                                                        <span class="lbl text "> 无 </span>
                                                                                    </label>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                            </c:if>
                                                            <div id="bank-cards" class="tab-pane clear">
                                                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                                                    <div class="space-10"></div>
                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0">已绑定的银行卡</h5>
                                                                    <c:choose>
                                                                        <c:when test="${user.coreBinding.withdrawBankCard == null || user.coreBinding.withdrawBankCard == ''}">
                                                                            <div class="row-fluid">
                                                                                还未绑定银行卡
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="row">
                                                                                <div class="col-lg-4 col-sm-4 col-xs-12">
                                                                                    <div class="userCard">
                                                                                        <div class="card-header">
                                                                                            <div class="pull-left blue card-type">
                                                                                                <i class="fa fa-credit-card blue"></i>
                                                                                                    ${user.coreBinding.userName}
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="card-content">
                                                                                            <div class="card-detail card-account-number">
                                                                                                <cm:bankAccountString
                                                                                                        account="${user.coreBinding.withdrawBankCard}"/>
                                                                                            </div>
                                                                                            <div class="card-detail card-add-time">
                                                                                                添加于：<fmt:formatDate
                                                                                                    value="${user.coreBinding.bindingTime}"
                                                                                                    pattern="yyyy年MM月dd日"/>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <a id="change-card" class="btn btn-blue" onclick="bandBankCard()">换绑</a>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>

                                                            <div id="id-info" class="tab-pane clear">
                                                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                                                    <div class="space-10"></div>

                                                                    <c:if test="${!user.coreUserAuth.idAuth}">
                                                                        <button class="btn btn-small btn-danger pull-right margin-top-10-inverse"
                                                                                id="accept-ID" data-id="">认证身份<%--  ${user.id} --%>
                                                                        </button>
                                                                    </c:if>

                                                                    <c:choose>
                                                                        <c:when test="${user.coreUserAuth.idAuth}">
                                                                            <p class="user-verify-status">
                                                                                <i class="icon-ok-sign green"></i>
                                                                                <span>认证通过</span>
                                                                            </p>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <p class="user-verify-status">
                                                                                <i class="fa fa-exclamation-circle grey"></i>
                                                                                <span>未认证</span>
                                                                            </p>
                                                                        </c:otherwise>
                                                                    </c:choose>

                                                                    <p style="line-height: 26px;">
                                                                        用户姓名：${user.userName}<br>
                                                                        身份证号：${user.idNumber}
                                                                    </p>

                                                                    <c:if test="${IDImages.size()>0}">
                                                                        <h5 class="row-title before-blue header blue MargT-20 MargL-0">身份认证信息</h5>

                                                                        <c:forEach var="img" items="${IDImages}">
                                                                            <a href="${img.uri}" target="_blank">
                                                                                <img src="${img.uri}!1" title="${img.imageName}">
                                                                            </a>
                                                                        </c:forEach>
                                                                    </c:if>
                                                                </div>
                                                            </div>

                                                            <div id="recommend-info" class="tab-pane clear">
                                                                <div class="widget-box transparent">
                                                                    <div class="widget-body">
                                                                        <div class="widget-main no-padding">
                                                                            <c:choose>
                                                                                <c:when test="${not empty user.recommendUserList}">
                                                                                    <table id="loanHistoryTable"
                                                                                           class="table table-hover dataTable no-footer">
                                                                                        <thead>
                                                                                        <tr>
                                                                                            <th>推荐用户</th>
                                                                                            <th>姓名</th>
                                                                                            <th>手机号码</th>
                                                                                            <th>注册时间</th>

                                                                                        </tr>
                                                                                        </thead>
                                                                                        <tbody>
                                                                                        <c:forEach var="recommendUser" items="${user.recommendUserList}">
                                                                                            <tr>
                                                                                                <td>
                                                                                                        ${recommendUser.loginName}
                                                                                                </td>
                                                                                                <td>
                                                                                                        ${recommendUser.userName}
                                                                                                </td>
                                                                                                <td>
                                                                                                        ${recommendUser.userMobile}
                                                                                                </td>
                                                                                                <td >
                                                                                                    <fmt:formatDate value="${recommendUser.registerTime}"
                                                                                                                    pattern="yy年M月d日 HH:mm"/>

                                                                                                </td>

                                                                                            </tr>
                                                                                        </c:forEach>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    暂无数据
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>


                                                        <div class="load_masker hide"></div>
                                                        <div class="yellow_fadeout highlight hide"></div>
                                                    </div>

                                                </div>

                                                <!-- 认证信息 -->
                                                <div id="certifications" class="tab-pane">
                                                    <div class="tabbable">
                                                        <ul class="nav nav-tabs padding-16">
                                                            <c:forEach var="cert" items="${CertificateType}" varStatus="idx">
                                                                <c:if test="${cert != 'LOANPURPOSE' && cert != 'GUARANTEE'}">
                                                                    <li
                                                                            <c:if test="${idx.index == 0}">class="active"</c:if>
                                                                            data-type="${cert}">
                                                                        <a data-toggle="tab" href="#${cert}_TAB">
                                                                                ${cert.key}
                                                                        </a>
                                                                    </li>
                                                                </c:if>
                                                            </c:forEach>
                                                        </ul>
                                                        <div class="tab-content profile-edit-tab-content">

                                                            <c:forEach var="cert" items="${CertificateType}" varStatus="idx">
                                                                <c:if test="${cert != 'LOANPURPOSE' && cert != 'GUARANTEE'}">

                                                                    <div id="${cert}_TAB"
                                                                         class="tab-pane clear <c:if test="${idx.index == 0}">active</c:if>">
                                                                        <div class="col-lg-12 col-sm-12 col-xs-12">
                                                                            <h5 class="row-title before-blue header blue MargT-20 MargL-0"><i class="fa fa-bell"></i>审核</h5>

                                                                            <div class="credit-score-box clearfix">
                                                                                <div class="col-lg-4 col-sm-4 col-xs-12">
                                                                                    <div class="input-group">
                                                                                        <span class="input-group-addon"><i class="fa  fa-star blue"></i> 评分</span>
                                                                                        <input type="text" class="prependedInput form-control pingfen-input" id="${cert}_pingfen_input"  name="" placeholder="0">
						                                         				<span class="input-group-addon" id="resetUserTransferValue"><i class="fa fa-star orange add-on resetBtn" style="cursor:pointer"></i> 权重：<span
                                                                                        id="${cert}_typeWeight"></span>%<%--总得分：<span id="totalScore"></span>--%></span>
                                                                                    </div>
                                                                                </div>


                                                                                <div class="pull-left shenhetongguo">
                                                                                    <label class="pull-left" style="margin: 5px 5px;">
                                                                                        <input name="${cert}_shenhe-radio"
                                                                                               value="true" type="radio"
                                                                                               class="ace certificateStatusRadio"
                                                                                               data-type="${cert}"/>
                                                                                        <span class="lbl text"> 审核通过</span>
                                                                                    </label>
                                                                                    <label class="pull-left" style="margin: 5px 5px;">
                                                                                        <input name="${cert}_shenhe-radio"
                                                                                               value="false" type="radio"
                                                                                               class="ace certificateStatusRadio"
                                                                                               data-type="${cert}" checked/>
                                                                                        <span class="lbl text"> 不通过</span>
                                                                                    </label>
                                                                                    <div class="col-lg-6 col-sm-6 col-xs-12">
                                                                                        <input type="text" class="form-control" name="auditInfo"  id="${cert}_auditInfo" >
                                                                                    </div>
                                                                                </div>
                                                                                    <%-- <cm:securityTag privilegeString="LOANREQUEST_ALTER"> --%>
                                                                                <button class="btn btn-primary btn-mini pull-left updateCertificateBtn"
                                                                                        data-type="${cert}">保存修改
                                                                                </button>
                                                                                    <%--  </cm:securityTag> --%>
                                                                            </div>

                                                                            <div class="space-10"></div>

                                                                            <h5 class="row-title before-blue header blue MargT-20 MargL-0"><i class="fa fa-picture-o"></i>认证图片</h5>


                                                                            <div class="row-fluid cbcontainer"></div>

                                                                            <h5 class="row-title before-blue header blue MargT-20 MargL-0"><i class="fa fa-file-text-o"></i>认证文档</h5>


                                                                            <div class="row-fluid doccontainer"></div>
                                                                        </div>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>


                                                    <%--登录信息--%>
                                                <div id="profile-login" class="tab-pane">
                                                    <div class="widget-box transparent">

                                                        <div class="widget-body">

                                                            <div class="widget-main no-padding">
                                                                <form class="form-inline" name="fundHistoryForm">
                                                                    <div class="form-group MargR-15">
                                                                        <label for="dateRangePicker1"
                                                                               class="control-label">日期范围</label>

                                                                        <div class="controls" style="display:inline-block">
                                                                            <div class="input-group">
												                            	<span class="input-group-addon">
												                                	<i class="fa fa-calendar"></i>
												                            	</span><input type="text" class="form-control input-sm active" id="reservation">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group MargR-15">
                                                                        <label for="operationType" class="control-label">登录渠道</label>
                                                                        <select name="source" id="login_fund-type" style="padding: 4px 12px;width:200px;">
                                                                            <option value="ALL" >全部</option>
                                                                            <option value="WEB" >公共网络</option>
                                                                            <option value="BACK" >系统后台</option>
                                                                            <option value="MSTATION" >M站</option>
                                                                            <option value="MOBILE" >移动端</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="form-group MargR-15">
                                                                        <label class="inline-block checkbox-label">
                                                                            <input class="showAllOperations"
                                                                                   name="showAllOperations" type="checkbox"
                                                                                   value=""/>
                                                                            <span class="lbl text"> 显示全部操作</span>
                                                                        </label>
                                                                        <button type="button" class="btn btn-sm btn-primary"
                                                                                id="searchLoginBtn">查询
                                                                        </button>
                                                                    </div>
                                                                    <br><br>
                                                                    <input type="hidden" id="loginStartDate"/>
                                                                    <input type="hidden" id="loginEndDate"/>
                                                                </form>
                                                                <table id="loginHistoryTable"
                                                                       class="table table-hover dataTable no-footer">
                                                                    <thead style="text-align: center">
                                                                    <tr>
                                                                        <th>登录时间</th>
                                                                        <th>登录渠道</th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>



                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                    <%--借入历史--%>
                                                <div id="profile-loan" class="tab-pane">
                                                    <div class="widget-box transparent">
                                                        <div class="widget-body">
                                                            <div class="widget-main no-padding">
                                                                <c:choose>
                                                                    <c:when test="${loans.totalRows != 0}">
                                                                        <table id="loanHistoryTable"
                                                                               class="table table-hover dataTable no-footer">
                                                                            <thead>
                                                                            <tr>
                                                                                <th>标题</th>
                                                                                <th>金额</th>
                                                                                <th>年利率</th>
                                                                                <th><i class="icon-time"></i> 期限</th>
                                                                                <th>还款方式</th>
                                                                                <th>有无抵押</th>
                                                                                <th>借款状态</th>
                                                                            </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                            <c:forEach var="loan" items="${user.loanRequestList}">
                                                                                <tr>
                                                                                    <td><a href="/loan/1/${loan.requestId}"
                                                                                           target="_blank"
                                                                                           title="${loan.requestTitle}">${loan.requestTitle}</a>
                                                                                    </td>
                                                                                    <td class="red"><fmt:formatNumber
                                                                                            type="currency"
                                                                                            maxFractionDigits="0"
                                                                                            value="${loan.amount}"/></td>
                                                                                    <td><fmt:formatNumber
                                                                                            value="${loan.rate/100}"
                                                                                            maxFractionDigits="1"/>%
                                                                                    </td>
                                                                                    <td><cm:durationString
                                                                                            duration="${loan.duration}"/></td>
                                                                                    <td>${loan.requestMethod.key}</td>
                                                                                    <td>
                                                                                        <c:choose>
                                                                                            <c:when test="${loan.mortgaged}">
                                                                                                有
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                无
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </td>
                                                                                    <td>
                                                                                        <c:choose>
                                                                                            <c:when test="${loan.status.key == '已安排'}">
		                                                                                        <span class="badge badge-yellow"><i
                                                                                                        class="icon-time"></i> ${loan.status.key}</span>
                                                                                            </c:when>
                                                                                            <c:when test="${loan.status.key == '开放投标'}">
                                                                                                <span class="badge badge-info">${loan.status.key}</span>
                                                                                            </c:when>
                                                                                            <c:when test="${loan.status.key == '逾期'}">
		                                                                                        <span class="badge badge-important"><i
                                                                                                        class="icon-time"></i> ${loan.status.key}</span>
                                                                                            </c:when>
                                                                                            <c:when test="${loan.status.key == '流标'}">
		                                                                                        <span class="badge badge-purple"><i
                                                                                                        class="icon-flag"></i> ${loan.status.key}</span>
                                                                                            </c:when>
                                                                                            <c:when test="${loan.status.key == '已结算'}">
		                                                                                        <span class="badge badge-pink"><i
                                                                                                        class="icon-lock"></i> ${loan.status.key}</span>
                                                                                            </c:when>
                                                                                            <c:when test="${loan.status.key == '已满标'}">
		                                                                                        <span class="badge badge-success"><i
                                                                                                        class="icon-ok"></i> ${loan.status.key}</span>
                                                                                            </c:when>
                                                                                            <c:when test="${loan.status.key == '已取消'}">
		                                                                                        <span class="badge badge-grey"><i
                                                                                                        class="icon-remove"></i> ${loan.status.key}</span>
                                                                                            </c:when>
                                                                                            <c:when test="${loan.status.key == '违约'}">
		                                                                                        <span class="badge badge-inverse"><i
                                                                                                        class="icon-exclamation"></i> ${loan.status.key}</span>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <span class="badge">${loan.status.key}</span>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>
                                                                            </tbody>
                                                                        </table>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        暂无数据
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                    <%--借出历史--%>
                                                <div id="profile-rent" class="tab-pane">
                                                    <div class="widget-box transparent">
                                                        <div class="widget-body">
                                                            <div class="widget-main no-padding">
                                                                <c:choose>
                                                                    <c:when test="${user.countInvest> 0}">
                                                                        <table id="investHistoryTable"
                                                                               class="table table-hover dataTable no-footer">
                                                                            <thead>
                                                                            <tr>
                                                                                <th>标题</th>
                                                                                <th>金额(元)</th>
                                                                                <th>年利率</th>
                                                                                <th>期限</th>
                                                                                <th>还款方式</th>
                                                                                <th>投标方式</th>
                                                                                <th>投标状态</th>
                                                                                <th>投标日期</th>
                                                                            </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                            <c:forEach var="invest"
                                                                                       items="${user.investHistoryList}">
                                                                                <tr>
                                                                                    <td>
                                                                                        <c:choose>
                                                                                        	<c:when test="${invest.investType=='claimInvest'}">
                                                                                        	<c:choose>
                                                                                                <c:when test="${invest.productType=='CURRENT_DEPOSIT'}">
                                                                                                	<a href="/claimInvest/currentList">${invest.productTitle}</a>
                                                                                            	</c:when>
	                                                                                            <c:when test="${invest.productType=='MONTH_WIN'}">
	                                                                                                <a href="/claimInvest/pmInvest?productId=${invest.productId}">${invest.productTitle}</a>
	                                                                                            </c:when>
	                                                                                            <c:when test="${invest.productType=='RECYCLE_INTEREST'}">
	                                                                                                <a href="/claimInvest/reInvest?productId=${invest.productId}">${invest.productTitle}</a>
	                                                                                            </c:when>
	                                                                                            <c:when test="${invest.productType=='FIXED_DEPOSIT_1'}">
	                                                                                                <a href="/claimInvest/planAInvest?productId=${invest.productId}">${invest.productTitle}</a>
	                                                                                            </c:when>
	                                                                                            <c:when test="${invest.productType=='FIXED_DEPOSIT_3'}">
	                                                                                                <a href="/claimInvest/planBInvest?productId=${invest.productId}">${invest.productTitle}</a>
	                                                                                            </c:when>
	                                                                                            <c:when test="${invest.productType=='FIXED_DEPOSIT_6'}">
	                                                                                                <a href="/claimInvest/planCInvest?productId=${invest.productId}">${invest.productTitle}</a>
	                                                                                            </c:when>
	                                                                                            <c:when test="${invest.productType=='FIXED_DEPOSIT_9'}">
	                                                                                                <a href="/claimInvest/planDInvest?productId=${invest.productId}">${invest.productTitle}</a>
	                                                                                            </c:when>
	                                                                                            </c:choose>
                                                                                            </c:when>
                                                                                            <c:when test="${invest.investType=='rmbInvest'}">
                                                                                            	<a href="/loan/0/${invest.productId}">${invest.productTitle}</a>
                                                                                            </c:when>
                                                                                            <c:when test="${invest.investType=='uplanInvest'}">
                                                                                            	<a href="/uplan/details/${invest.productId}/showAllInfos">${invest.productTitle}</a>
                                                                                            </c:when>
                                                                                        </c:choose>
                                                                                    </td>
                                                                                    <td class="red">
                                                                                        <fmt:formatNumber type="currency"
                                                                                                          value="${invest.amount}"
                                                                                                          maxFractionDigits="0"/>
                                                                                    </td>
                                                                                    <td class="green">
                                                                                        
                                                                                             <c:choose>
                                                                                            	<c:when test="${invest.investType=='claimInvest'}">
	                                                                                            	<fmt:formatNumber value="${invest.claimYearRate}" pattern="#.##"></fmt:formatNumber>%
                                                                                            	</c:when>
                                                                                            	<c:otherwise>
                                                                                            		<fmt:formatNumber type="percent"
                                                                                                          value="${invest.yearRate/10000}"
                                                                                                          maxFractionDigits="1"/>
                                                                                            	</c:otherwise>
                                                                                            </c:choose>
                                                                                    </td>
                                                                                    <td>
                                                                                            <c:choose>
                                                                                            	<c:when test="${invest.investType=='rmbInvest'}">
	                                                                                            	<cm:durationString
	                                                                                                duration="${invest.duration}"/>
                                                                                            	</c:when>
                                                                                            	<c:otherwise>
                                                                                            		${invest.closurePeriod}
                                                                                            	</c:otherwise>
                                                                                            </c:choose>
                                                                                            
                                                                                    </td>
                                                                                    <td>${invest.repaymentWay}</td>
                                                                                    <td>手动投标</td>
                                                                                    <td>${invest.investStatus}</td>
                                                                                    <td>
                                                                                        <fmt:formatDate
                                                                                                value="${invest.submitTime}"
                                                                                                pattern="yy年 M月d日"/>
                                                                                    </td>
                                                                                </tr>
                                                                            </c:forEach>

                                                                            </tbody>
                                                                        </table>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        暂无数据
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- 资金记录Tab页 -->
                                                <div id="profile-licai" class="tab-pane">
                                                    <div class="widget-box transparent">
                                                        <div class="widget-body">
                                                            <div class="widget-main">
                                                                <form class="form-inline" name="fundHistoryForm">
                                                                    <div class="form-group MargR-15">
                                                                        <label for="operationType" class="control-label">资金类型</label>
                                                                        <select name="type" id="fund-type" style="padding: 4px 12px;width:200px;">
                                                                            <option value="ALL" selected>全部</option>
                                                                            <c:forEach var="purpose" items="${OperationType}">
                                                                                <option value="${purpose}">${purpose.key}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                    <div class="form-group MargR-15">
                                                                        <label for="dateRangePicker"
                                                                               class="control-label">日期范围</label>

                                                                        <div class="controls" style="display:inline-block">
                                                                            <div class="input-group">
												                            	<span class="input-group-addon">
												                                	<i class="fa fa-calendar"></i>
												                            	</span><input type="text" class="form-control input-sm active" id="login_reservation">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group MargR-15">
                                                                        <label for="fundRecordStatus" class="control-label">状态</label>
                                                                        <select name="fundRecordStatus" id="fundRecordStatus" style="padding: 4px 12px;width:200px;">
                                                                            <option value="ALL" selected>全部</option>
                                                                            <c:forEach var="status" items="${FundRecordStatus}">
                                                                                <option value="${status}"
                                                                                        <c:if test="${status == 'SUCCESSFUL'}">selected</c:if>>${status.key}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                    <br><br>
                                                                    <div class="form-group MargR-15">
                                                                        <label class="inline-block checkbox-label">
                                                                            <input class="showAllOperations"
                                                                                   name="showAllOperations" type="checkbox"
                                                                                   value=""/>
                                                                            <span class="lbl text"> 显示全部操作</span>
                                                                        </label>
                                                                        <button type="button" class="btn btn-sm btn-primary"
                                                                                id="searchClientFundBtn">查询
                                                                        </button>
                                                                    </div>
                                                                    <br><br>
                                                                    <input type="hidden" id="fundStartDate"/>
                                                                    <input type="hidden" id="fundEndDate"/>
                                                                </form>

                                                                <table class="table table-hover dataTable no-footer"
                                                                       id="fundHistoryTable">
                                                                    <thead>
                                                                    <tr>
                                                                        <th>金额(元)</th>
                                                                        <th>交易订单号</th>
                                                                        <th>类型</th>
                                                                        <th>操作</th>
                                                                        <th>状态</th>
                                                                        <th>时间</th>
                                                                        <th>备注</th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody id="result-wrap">
                                                                        <%--<c:forEach var="fund" items="${user.coreUserFundRecords}">--%>
                                                                        <%--<tr>--%>
                                                                        <%--<td>${fund.amount}</td>--%>
                                                                        <%--<td>${fund.orderId}</td>--%>
                                                                        <%--<td>${fund.directType.key}</td>--%>
                                                                        <%--<td>${fund.operationType.key}</td>--%>
                                                                        <%--<td>${fund.operationStatus.key}</td>--%>
                                                                        <%--<td>${fund.recordTime}</td>--%>
                                                                        <%--<td>${fund.description}</td>--%>
                                                                        <%--</tr>--%>
                                                                        <%--</c:forEach>--%>
                                                                    </tbody>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div id="profile-others" class="tab-pane">
                                                    <div class="widget-box transparent">
                                                        <div class="widget-body">
                                                            <div class="widget-main no-padding clear">
                                                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                                                    <div class="space-10"></div>
                                                                    <h5 class="row-title before-blue header blue MargT-20 MargL-0"><i class="fa fa-cogs"></i>相关操作</h5>

                                                                        <%--   <cm:securityTag privilegeString="USER_RESETPASSWORD"> --%>
                                                                    <div class="control-group">
                                                                        <label class="control-label blue" for="labels"><i
                                                                                class="fa fa-lock"></i> 安全设置</label>

                                                                            <%--  <div class="controls">
                                                                                 <button class="btn btn-small btn-danger"
                                                                                         data-url="user/resetPassword/${user.userMobile}"
                                                                                         id="resetPasswordBtn">重置密码
                                                                                 </button>
                                                                             </div> --%>
                                                                    </div>
                                                                </div>
                                                                    <%--  </cm:securityTag> --%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </cm:securityTag>
                        </div>


                    </div>



                </div>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>
<script id="bank-template" type="text/x-handlebars-template">
    <form class="form-horizontal form-card" id="bankForm" action="/user/changebankcard" method="POST">
        <div class="form-group">
            <label for="" class="col-sm-2 control-label no-padding-right">开户名</label>
            <div class="col-sm-10">
                <span style="position:relative; top:6px;">${user.coreBinding.userName}</span>
            </div>
        </div>
        <div class="form-group">
            <label for="" class="col-sm-2 control-label no-padding-right">选择银行</label>
            <div class="col-sm-10">
                <select name="bankName" id="bankName">
                    <c:forEach var="bankName" items="${bankNameList}">
                        <option value="${bankName}">${bankName.bankName}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <input name="userId" type="hidden" value="${user.userId}"/>
        <div class="form-group">
            <label for="" class="col-sm-2 control-label no-padding-right">银行卡号</label>
            <div class="col-sm-10">
                <input type="text" id="bankNum" name="bankCard" class="form-control" placeholder="">
            </div>
        </div>
        <div class="form-group">
            <label for="" class="col-sm-2 control-label no-padding-right">确认卡号</label>
            <div class="col-sm-10">
                <input type="text" id="bankNumConfirm" name="bankNumConfirm" class="form-control" placeholder="">
            </div>
        </div>
        <div class="controls text-center">
            <button type="button" id="bankcardBtn" class="btn btn-primary">提交</button>
        </div>
    </form>

</script>


<script type="text/template" id="cbLiTemplate">
    <li>
        <a href="$link" target="_blank" data-rel="colorbox">
            <img alt="150x150" src="$src!1"/>

            <div class="text">
                <div class="inner">
                    <span>$name</span>

                    <span>上传者：$uploader</span>

                    <span>$date</span>
                </div>
            </div>
        </a>
    </li>
</script>
<script type="text/template" id="docTemplate">
    <div class="profile-activity clearfix">
        <div>
            <div class="pull-left commentAvadar">
                <img id="pdfImg" src="img/$icon.png"/>
            </div>
            <div class="pull-left">
                <a href="$uri" target="_blank" class="margin-right-10">$name</a> <a class="download-link grey"
                                                                                    href="$downloadLink" download><i
                    class="icon-download-alt"></i> 下载</a>

                <div class="time">
                    <i class="icon-time bigger-110"></i>
                    $submitTime -
                    <a target="_blank" href="$link">$uploader</a>
                </div>
            </div>
        </div>
    </div>
</script>
<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/bootstrap-editable.min.js"></script>
<script src="/assets/js/ace-extra.js"></script>
<script src="/assets/js/ace-editable.min.js"></script>
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/bbtTool.js"></script>

<div id="json-documents" style="display:none">${documents }</div>
<div id="json-certificates" style="display:none">${certificates }</div>
<div id="json-weights" style="display:none">${certificateTypeWeights }</div>
<script src="/assets/js/datetime/bootstrap-datepicker.js"></script>
<script src="/assets/js/datetime/bootstrap-timepicker.js"></script>
<script src="/assets/js/datetime/moment.js"></script>
<script src="/assets/js/datetime/daterangepicker.js"></script>
<script src="/assets/js/select2/select2.js"></script>
<script src="/assets/js/jquery.colorbox-min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>



<script type="text/javascript">
    //日历
    $('#reservation').daterangepicker();
    $('#login_reservation').daterangepicker();
    var MaritalStatus = [],
            EducationLevel = [],
            CareerStatus = [],
            CompanyType = [],
            CompanyIndustry = [],
            CompanySize = [],
            MonthlySalary = [],
            YearOfService = [],
            EthnicGroup = [],
            hasHouse = false,
            hasHouseLoan = false,
            hasCar = false,
            hasCarLoan = false,
            male = false,
            children = false;
    var OperationType = {};
    <c:forEach var="type" items="${OperationType}">
    OperationType['${type}'] = '${type.key}';
    </c:forEach>
    var FundRecordStatus = {};
    <c:forEach var="type" items="${FundRecordStatus}">
    FundRecordStatus['${type}'] = '${type.key}';
    </c:forEach>
    var FundRecordOperation = {};
    <c:forEach var="type" items="${FundRecordOperation}">
    FundRecordOperation['${type}'] = '${type.key}';
    </c:forEach>
    var CertificateTypes = [];
    <c:forEach var="type" items="${CertificateType}">
    CertificateTypes.push('${type}');
    </c:forEach>
</script>
<script type="text/javascript" src="/assets/js/user/userProfile.js"></script>
</body>
</html>
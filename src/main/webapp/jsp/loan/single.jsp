<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/16
  Time: 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>系统测试平台</title>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="../common/head.jspf" %>

    <link href="/assets/css/royalslider.css" rel="stylesheet" />
    <link href="/assets/css/rs-default.css" rel="stylesheet" />
    <link href="/assets/css/camera.css" rel="stylesheet" />
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="/assets/css/bootstrap-datetimepicker.css" rel="stylesheet" />
    <link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
</head>
<body data-loanid="${loanInfo.requestId}">
<%@include file="../common/navbar.jspf" %>
<!-- Main Container start-->
<div class="main-container container-fluid">
    <!-- Page Container start-->
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
                    <li class="active">产品管理</li>
                    <li class="active">直投项目</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Body -->
            <div class="page-body">
                <div class="well">

                    <ul class="nav nav-pills" id="loanTabs">
                        <li class="btn-sm active"><a data-toggle="tab" href="#loanInfo"> 借款信息</a></li>
                        <li class="btn-sm"><a data-toggle="tab" href="#investHistory"> 投资记录</a></li>
                        <li class="btn-sm"><a data-toggle="tab" href="#loanDeclare"> 借款说明</a></li>
                        <li class="btn-sm"><a data-toggle="tab" href="#securityCertificate"> 安全认证</a></li>
                    </ul>
                    <br>
                    <!-- loanDetails start-->
                    <div id="loanDetails">
                        <!-- detail-box1 start-->
                        <div class="detail-box">
                            <!-- Page Module one-->
                            <div class="row">
                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                    <div class="widget">
                                        <div class="widget-header">
                                            <i class="widget-icon fa fa-file-text-o blue Line-Height-36  Font-15"></i>
                                            <span class="widget-caption blue Font-16">产品详情 </span>

                                            <div class="widget-buttons">
                                                <a href="#" data-toggle="collapse">
                                                    <i class="fa fa-minus blue"></i>
                                                </a>
                                            </div><!--Widget Buttons-->
                                        </div><!--Widget Header-->
                                        <input type="text" id="userId" style="display:none" value="${loanInfo.userId}"/>
                                        <div class="widget-body Loan-Info" style="display: block;">
                                            <h4>
                                                <small class="widget-caption" >
                                                    账户名：<a href="/user/profile?userId=${loanInfo.userId}" target="_blank">${loanInfo.userLoginName}</a>&emsp;&emsp;
                                                    贷款申请：<a href="javascript:;" class="jksq">${loanInfo.title}</a>&emsp;&emsp;
                                                    <span>最小投资额：<strong class="red"><fmt:formatNumber type="currency" maxFractionDigits="0" value="${loanInfo.minAmount}" /></strong>，</span>
                                                    <span>最大投资额：<strong class="red"><fmt:formatNumber type="currency" maxFractionDigits="0" value="${loanInfo.maxAmount}" /></strong>，</span>
                                                    <span>投资增量：<strong class="red"><fmt:formatNumber type="currency" maxFractionDigits="0" value="${loanInfo.stepAmount}" /></strong></span>
                                                </small>
                                            </h4>
                                            <div class="Loan-Info-con">
                                                <div class="F-left col-md-5">
                                                    <dl>
                                                        <dt>产品名称：</dt>
                                                        <dd>
                                                            <span class="s-title" id="loanInfo_title">${loanInfo.title}</span>
                                                            <a href="javascript:;" class="bootbox-regular" id="editLoanTitleBtn"><i class="fa fa-edit"></i> 修改</a>
                                                        </dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>借款金额：</dt>
                                                        <dd id="loanAmount" data-amount="${loanInfo.loanAmount}"><span class="red bold"><fmt:formatNumber type="currency" maxFractionDigits="0" value= "${loanInfo.loanAmount}"/> <small id="amountToChinese" class="grey"></small></span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>借款类型：</dt>
                                                        <dd>${loanInfo.requestType}</dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>借款期限：</dt>
                                                        <dd><c:if test="${loanInfo.years>0}">${loanInfo.years}年</c:if><c:if test="${loanInfo.months>0}">${loanInfo.months}月</c:if><c:if test="${loanInfo.days>0}">${loanInfo.days}天</c:if></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>年化利率：</dt>
                                                        <dd>${loanInfo.rate}&nbsp;<small class="grey">(候补年利率：${loanInfo.rateAdd})</small></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>还款方式：</dt>
                                                        <dd>${loanInfo.requestMethod.key}</dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>抵押品：</dt>
                                                        <dd>${loanInfo.mortgaged}</dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>借款人姓名：</dt>
                                                        <dd>${loanInfo.loanName}</dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>借款人身份证号：</dt>
                                                        <dd> ${loanInfo.idNumber}</dd>
                                                    </dl>
                                                </div>
                                                <div class="F-right col-md-2">
                                                    <div class="pull-right text-left">
                                                        <div class="alert alert-info no-margin">
                                                            <div>信用等级：<span class="red bold" id="creditRank">${userCredit.creditRank}
                                                            </div>
                                                            </span>
                                                            <div>信用评分：<span class="red bold" id="creditScore">${userCredit.score}</div>
                                                            </span>
                                                            <div>信用额度：<span class="value red bold"><fmt:formatNumber type="currency"
                                                                                                                     maxFractionDigits="0"
                                                                                                                     value="${userCredit.creditLimit}"/></span>
                                                            </div>
                                                            <div>可用额度：<span class="value red bold"><fmt:formatNumber type="currency"
                                                                                                                     maxFractionDigits="0"
                                                                                                                     value="${userCredit.creditAvailable}"/></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="F-right col-md-4">
                                                    <dl>
                                                        <dt>借款状态：</dt>
                                                        <dd><i class="fa fa-check green"></i> ${loanInfo.status}</dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>投标进度：</dt>
                                                        <dd>
                                                            <div class="progress progress-striped active">
                                                                <c:choose>

                                                                    <c:when test="${not empty loanInfo.process}">

                                                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: ${loanInfo.process}%">
																		<span style="color:white;text-align:center;"><b>
                                                                                ${loanInfo.process}%
                                                                        </b></span>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: ${loanInfo.process}%">
																		<span style="color:white;text-align:center;"><b>
                                                                            0%
                                                                        </b></span>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>剩余额度：</dt>
                                                        <dd><fmt:formatNumber type="currency" value="${loanInfo.loanAmount-loanInfo.investedAmount}" maxFractionDigits="2" maxIntegerDigits="15" /></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>投标数：</dt>
                                                        <dd>${loanInfo.investedNumber}</dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>开标时间：</dt>
                                                        <dd><fmt:formatDate value="${loanInfo.timeOpen}" pattern="yy年 M月d日 HH:mm" /></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>满标时间：</dt>
                                                        <dd><c:if test="${loanInfo.timeFinished != null}">
                                                            <fmt:formatDate value="${loanInfo.timeFinished}" pattern="yy年 M月d日 HH:mm" />
                                                        </c:if></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>结标时间：</dt>
                                                        <dd><c:if test="${loanInfo.timeSettled != null}">
                                                            <fmt:formatDate value="${loanInfo.timeSettled}" pattern="yy年 M月d日 HH:mm" />
                                                        </c:if></dd>
                                                    </dl>
                                                </div>
                                                <div class="clear"></div>
                                                <div class="F-right col-md-12">
                                                    服务费率
                                                    <br>
                                                    担保费率：<fmt:formatNumber value="${fee.loanGuaranteeFee*100}" minFractionDigits="2"/>%&nbsp;
                                                    服务费率：<fmt:formatNumber value="${fee.loanServiceFee*100}" minFractionDigits="2"/>%&nbsp;
                                                    风险管理费：<fmt:formatNumber value="${fee.loanRiskFee*100}" minFractionDigits="2"/>%&nbsp;
                                                    借款管理费：<fmt:formatNumber value="${fee.loanManageFee*100}" minFractionDigits="2"/>%&nbsp;
                                                    还款(借款)利息管理费：<fmt:formatNumber value="${fee.loanInterestFee*100}" minFractionDigits="2"/>%&nbsp;
                                                    回款(投资)利息管理费：<fmt:formatNumber value="${fee.investInterestFee*100}" minFractionDigits="2"/>%
                                                </div>

                                            </div>

                                            <br>
                                            <div class="buttons-preview">
                                                <c:if test="${loanInfo.loanRequestStatus!='UNASSIGNED'}">
                                                    <button type="button" class="btn btn-grey" disabled="disabled">已发布</button>
                                                    <button type="button" class="btn btn-grey" disabled="disabled">不可修改</button>
                                                </c:if>
                                                <c:if test="${loanInfo.loanRequestStatus=='UNASSIGNED'}">
                                                <cm:securityTag privilegeString="LOANREQUEST_IMMEDIATELY_CHANGE">
                                                    <button type="button" class="btn btn-green" onclick="location.href='/loan/quickLoanRequest?loanRequestId=${loanInfo.requestId}'">立即修改</button>
                                                   </cm:securityTag>
                                                </c:if>
                                            </div>
                                        </div><!--Widget Body-->
                                    </div><!--Widget-->
                                </div>
                            </div>
                            <!-- /Page Module one-->
                            <input type="text" style="display:none" value="${loanInfo.requestId}" id="loanRequestId"/>
                            <!-- Page Module two-->
                            <div class="row">
                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                    <div class="widget">
                                        <div class="widget-header">
                                            <i class="widget-icon fa fa-calendar blue Line-Height-36  Font-15"></i>
                                            <span class="widget-caption blue Font-16">还款计划 &ensp;<c:if test="${loanInfo.status=='募集中'}">|&ensp; </c:if></span>
                                            <c:if test="${loanInfo.status=='募集中'}"><small  class="widget-caption">假设该贷款在申请日期之后三天被批准</small></c:if>
                                            <div class="widget-buttons">
                                                <a href="#" data-toggle="collapse">
                                                    <i class="fa fa-minus blue"></i>
                                                </a>
                                            </div><!--Widget Buttons-->
                                        </div><!--Widget Header-->
                                        <div class="widget-body Loan-Info" style="display: block;">
                                            <c:if test="${repaymentPlan!=null}">
                                                <table class="table table-hover dataTable no-footer" id="userList" aria-describedby="userList_info" role="grid" style="width: 100%;">
                                                    <thead id="list_th" class="bordered-blue">
                                                    <tr role="row">
                                                        <th class="sorting" rowspan="1" colspan="1" aria-label="还款日期" style="width: 20%;"><i class="fa fa-clock-o blue"></i> 还款日期</th>
                                                        <th class="sorting" rowspan="1" colspan="1" aria-label="还款金额" style="width: 20%;"><i class="fa fa-yen blue"></i> 还款金额</th>
                                                        <th class="sorting" rowspan="1" colspan="1" aria-label="偿还本金" style="width: 20%;"><i class="fa fa-yen blue"></i> 偿还本金</th>
                                                        <th class="sorting" tabindex="0" rowspan="1" colspan="1" aria-label="偿还利息"  style="width: 20%;"><i class="fa fa-yen blue"></i>  偿还利息</th>
                                                        <th class="sorting" tabindex="0"  rowspan="1" colspan="1" aria-label="剩余本金"  style="width: 20%;"><i class="fa fa-yen blue"></i> 剩余本金</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="rp" items="${repaymentPlan.repayments}">
                                                        <tr role="row" class="odd">
                                                            <td><fmt:formatDate value="${rp.dueDate}" pattern="yy年MM月dd日" /></td>
                                                            <td><span class="red bold"><fmt:formatNumber value="${rp.amountPrincipal+rp.amountInterest}" currencySymbol="¥" type="currency"/></span></td>
                                                            <td><span class="red bold"><fmt:formatNumber value="${rp.amountPrincipal}" currencySymbol="¥" type="currency"/></span></td>
                                                            <td><span class="red bold"><fmt:formatNumber value="${rp.amountInterest}" currencySymbol="¥" type="currency"/></span></td>
                                                            <td><span class="red bold"><fmt:formatNumber value="${rp.amountOutstanding}" currencySymbol="¥" type="currency"/></span></td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </c:if>
                                            <c:if test="${repayments!=null}">
                                                <table class="table table-hover dataTable no-footer" id="repayment_list" aria-describedby="userList_info" role="grid" style="width: 100%;">
                                                    <thead id="list_th" class="bordered-blue">
                                                    <tr role="row">
                                                        <th class="sorting" rowspan="1" colspan="1" aria-label="还款期数" style="width: 10%;"><i class="fa fa-clock-o blue"></i> 还款期数</th>
                                                        <th class="sorting" rowspan="1" colspan="1" aria-label="应还日期" style="width: 15%;"><i class="fa fa-yen blue"></i> 应还日期</th>
                                                        <th class="sorting" rowspan="1" colspan="1" aria-label="应还本金" style="width: 10%;"><i class="fa fa-yen blue"></i> 应还本金</th>
                                                        <th class="sorting" tabindex="0" rowspan="1" colspan="1" aria-label="应还利息"  style="width: 10%;"><i class="fa fa-yen blue"></i>  应还利息</th>
                                                        <th class="sorting" tabindex="0"  rowspan="1" colspan="1" aria-label="剩余本金"  style="width: 10%;"><i class="fa fa-yen blue"></i> 剩余本金</th>
                                                        <th class="sorting" tabindex="0"  rowspan="1" colspan="1" aria-label="实际还款金额"  style="width: 15%;"><i class="fa fa-yen blue"></i> 实际还款金额</th>
                                                        <th class="sorting" tabindex="0"  rowspan="1" colspan="1" aria-label="实际还款日期"  style="width: 20%;"><i class="fa fa-yen blue"></i> 实际还款日期</th>
                                                        <th class="sorting" tabindex="0"  rowspan="1" colspan="1" aria-label="偿还状态"  style="width: 10%;"><i class="fa fa-yen blue"></i> 偿还状态</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="repayment" items="${repayments}">
                                                        <tr>
                                                            <td>${repayment.currentPeriod}</td>
                                                            <td><fmt:formatDate value="${repayment.dueDate}" pattern="yyyy年MM月dd日" /></td>
                                                            <td>
                                                                <b class="red"><fmt:formatNumber value="${repayment.amountPrincipal}" currencySymbol="¥" type="currency"/></b>
                                                            </td>
                                                            <td>
                                                                <b class="red"><fmt:formatNumber value="${repayment.amountInterest}" currencySymbol="¥" type="currency"/></b>
                                                            </td>
                                                            <td>
                                                                <b class="red"><fmt:formatNumber value="${repayment.amountOutStanding}" currencySymbol="¥" type="currency"/></b>
                                                            </td>
                                                            <td>
                                                                <b class="green"><fmt:formatNumber value="${repayment.repayAmount}" currencySymbol="¥" type="currency"/></b>
                                                            </td>
                                                            <td><fmt:formatDate value="${repayment.repayTime}" pattern="yyyy年MM月dd日" /></td>
                                                            <td>
                                                                    ${repayment.repayStatus.key}
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </c:if>

                                        </div><!--Widget Body-->
                                    </div><!--Widget-->
                                </div>
                            </div>
                            <!-- /Page Module two-->
                        </div>
                        <!-- detail-box1 end-->

                        <!-- detail-box2 start-->
                        <div class="detail-box">
                            <div class="row">
                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                    <div class="widget">
                                        <div class="widget-header" style="position:relative">
                                            <i class="widget-icon fa fa-list-ul blue Line-Height-36  Font-15"></i>
                                            <span class="widget-caption blue Font-16">投资记录</span>


                                            <div class="widget-buttons">
                                                <a href="#" data-toggle="collapse">
                                                    <i class="fa fa-minus blue"></i>
                                                </a>
                                            </div><!--Widget Buttons-->
                                        </div><!--Widget Header-->
                                        <div class="widget-body Loan-Info" style="display: block;">
                                            <c:choose>
                                                <c:when test="${empty(rmbInvests) }">
                                                    暂无记录
                                                </c:when>
                                                <c:otherwise>
                                                    <table class="table table-hover dataTable no-footer" id="rmbInvests_list" aria-describedby="simpledatatable_info" role="grid" style="width: 100%;">
                                                        <thead id="list_th" class="bordered-blue">
                                                        <tr role="row">
                                                            <th class="sorting" rowspan="1" colspan="1" aria-label="还款日期" ><i class="fa fa-list-ol blue"></i> 序号</th>
                                                            <th class="sorting" rowspan="1" colspan="1" aria-label="还款金额" ><i class="fa fa-sort-amount-asc blue"></i> 订单号</th>
                                                            <th class="sorting" rowspan="1" colspan="1" aria-label="投资人" ><i class="fa fa-male blue"></i> 投资人</th>
                                                            <th class="sorting" rowspan="1" colspan="1" aria-label="真实姓名"  ><i class="fa  fa-user blue"></i> 真实姓名</th>
                                                            <th class="sorting" rowspan="1" colspan="1" aria-label="投资金额" ><i class="fa fa-yen blue"></i> 投资金额</th>
                                                            <th class="sorting" rowspan="1" colspan="1" aria-label="投资方式"  ><i class="fa fa-chain blue"></i> 投资方式</th>
                                                            <th class="sorting" rowspan="1" colspan="1" aria-label="投资时间"><i class="fa  fa-clock-o blue"></i> 投资时间</th>
                                                            <th class="sorting" rowspan="1" colspan="1" aria-label="投资状态" ><i class="fa fa-check-square-o blue"></i> 投资状态</th>
                                                            <th class="sorting" rowspan="1" colspan="1" aria-label="合同" ><i class="fa fa-clipboard blue"></i>  合同</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="rmbInvest" items="${rmbInvests}" varStatus="vs">
                                                            <tr role="row" class="odd">
                                                                <td>${vs.index+1}</td>
                                                                <td>${rmbInvest.orderId}</td>
                                                                <td>${rmbInvest.coreUser.loginName}</td>
                                                                <td>${rmbInvest.coreUser.userName}</td>
                                                                <td><span class="red bold"><fmt:formatNumber value="${rmbInvest.investAmount}" currencySymbol="¥" type="currency"/></span></td>
                                                                <td>手动投标</td>
                                                                <td><fmt:formatDate value="${rmbInvest.submitTime}" pattern="yy年 M月d日HH:mm:ss" /></td>
                                                                <td>${rmbInvest.status.key}</td>
                                                                <td>
                                                                <cm:securityTag privilegeString="LOANREQUEST_CONTRACT_VIEW">
                                                                <a href="/contract/check/${rmbInvest.investId}" target="_blank">查看</a>
                                                                </cm:securityTag>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </c:otherwise>
                                            </c:choose>
                                            <br>
                                            <%--<div class="row ">--%>
                                            <%--<div class="col-sm-6">--%>
                                            <%--<div class="dataTables_info" id="userList_info" role="status" aria-live="polite">显示第 1 - 10 条记录，共 56,086 条</div>--%>
                                            <%--</div>--%>
                                            <%--<div class="col-sm-6">--%>
                                            <%--<div class="dataTables_paginate paging_bootstrap" id="userList_paginate">--%>
                                            <%--<ul class="pagination F-right">--%>
                                            <%--<li class="prev disabled"><a href="#">上一页</a></li>--%>
                                            <%--<li class="active"><a href="#">1</a></li>--%>
                                            <%--<li><a href="#">2</a></li><li><a href="#">3</a></li>--%>
                                            <%--<li><a href="#">4</a></li><li><a href="#">5</a></li>--%>
                                            <%--<li class="next"><a href="#">下一页</a></li>--%>
                                            <%--</ul>--%>
                                            <%--</div>--%>
                                            <%--</div>--%>
                                            <%--</div>--%>
                                        </div><!--Widget Body-->



                                    </div><!--Widget-->
                                </div>
                            </div>
                        </div>
                        <!-- detail-box2 end-->
                        <!-- detail-box3 start-->
                        <div class="detail-box">
                            <div class="row">
                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                    <div class="widget">
                                        <div class="widget-header" style="position:relative">
                                            <i class="widget-icon fa fa-list-ul blue Line-Height-36  Font-15"></i>
                                            <span class="widget-caption blue Font-16">担保/抵押信息</span>
                                            <div class="widget-buttons">
                                                <a href="#" data-toggle="collapse">
                                                    <i class="fa fa-minus blue"></i>
                                                </a>
                                            </div><!--Widget Buttons-->
                                        </div><!--Widget Header-->
                                        <div class="widget-body Loan-Info" style="display: block;">
                                            <table>
                                                <tr>
                                                    <td>借款说明:</td>
                                                    <td><textarea readonly style="width:500px;height:100px;">${loanInfo.requestDes}</textarea></td>
                                                </tr>
                                                <tr>
                                                    <td>担保信息:</td>
                                                    <td><textarea readonly style="width:500px;height:100px;">${loanInfo.guaranteeInfo}</textarea></td>
                                                </tr>
                                                <tr>
                                                    <td>抵押信息:</td>
                                                    <td><textarea readonly style="width:500px;height:100px;">${loanInfo.mortgagedInfo}</textarea></td>
                                                </tr>
                                                <tr>
                                                    <td>风险措施:</td>
                                                    <td><textarea readonly style="width:500px;height:100px;">${loanInfo.riskInfo}</textarea></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- detail-box3 end-->
                        <!-- detail-box4 start-->
                        <div class="detail-box">
                            <div class="row">
                                <div class="col-lg-12 col-sm-12 col-xs-12">
                                    <div class="widget">
                                        <div class="widget-header" style="position:relative">
                                            <i class="widget-icon fa fa-list-ul blue Line-Height-36  Font-15"></i>
                                            <span class="widget-caption blue Font-16">安全认证</span>
                                            <div class="widget-buttons">
                                                <a href="#" data-toggle="collapse">
                                                    <i class="fa fa-minus blue"></i>
                                                </a>
                                            </div><!--Widget Buttons-->
                                        </div><!--Widget Header-->
                                        <cm:securityTag privilegeString="LOANREQUEST_SAFETY_CER_OPERATION">
                                        <div class="widget-body Loan-Info" style="display: block;">
                                            <form action="/loan/approve/${loanInfo.requestId}" id="approvalForm">
                                                <div class="form-horizontal">
                                                    <div class="form-group">&nbsp;</div>
                                                    <div class="databox databox-halved radius-bordered databox-shadowed">
                                                        <div class="databox-top bg-white  credit-info-wp">
                                                            <div class="pull-left">
                                                                <a href="user/profile/${loanInfo.userId}" target="_blank">
                                                                    <img class="avadar"
                                                                         alt="user/${loanInfo.userId}"
                                                                         src="/assets/img/avatars/male.jpg" style="width:50px; height:50px;" class="image-circular bordered-3 bordered-palegreen">
                                                                </a>
                                                            </div>
                                                            <div class="pull-left credit-score-box text-align-left">
                                                                <div class="pull-left input-prepend ">
                                                                    <span class="add-on"><i class="fa fa-star blue"></i> <span id="certificateName"></span> 评分</span>
                                                                    <input class="pingfen-input" style="width:100px;height:28px;font-size:12px;" value="" type="text" id="score" placeholder="0"/>
                                        <span class="add-on">
                                        <i class="fa fa-star orange"></i> <span id="certificateName"></span> 权重：<span
                                                id="typeWeight"></span></span>
                                                                </div>
                                                                <div class="pull-left shenhetongguo">
                                                                    <div class="radio pull-left">
                                                                        <label>
                                                                            <input name="shenhe-radio" type="radio" value="true">
                                                                            <span class="text">审核通过 </span>
                                                                        </label>
                                                                    </div>
                                                                    <div class="radio pull-left">
                                                                        <label>
                                                                            <input  name="shenhe-radio" value="false" type="radio">
                                                                            <span class="text">不通过 </span>
                                                                        </label>
                                                                    </div>
                                                                    <input type="text" name="auditInfo" id="auditInfo" style="height:28px;width:150px"/>
                                                                </div>
                                                                    <c:if test="${statusIndex==1}">
                                                                        <span class="btn btn-primary btn-small pull-right" id="updateCertificateBtn">保存修改</span>
                                                                    </c:if>
                                                            </div>
                                                        </div>

                                                    </div>


                                                    <div class="space-4"></div>

                                                    <div class="row-fluid credit-tags-wp">
                                                        <div class="tabs-wrap">
                                                            <div class="tabs-arrow tabs-arrow-left">
                                                                <i class="fa fa-chevron-left"></i>
                                                            </div>
                                                            <div class="tabs-arrow tabs-arrow-right">
                                                                <i class="fa fa-chevron-right"></i>
                                                            </div>
                                                            <div class="tabs-content reset-width">
                                                                <ul class="nav nav-tabs" id="shenheList">
                                                                    <c:choose>
                                                                        <c:when test="${!empty CertificateType}">
                                                                            <c:forEach var="type" items="${CertificateType}">
                                                                                <li data-type="${type.name()}" data-key="${type.key}" data-toggle="tooltip">
                                                                                    <a data-toggle="tab" href="#id_renzheng">
                                                                                        <div>
                                                                                            <span class="ctype">${type.key}</span>
                                                                                            <span class="score"></span>
                                                                                            <span class="status"></span>
                                                                                        </div>
                                                                                        <div class="documentCountLine">
                                                    <span><i class="fa fa-picture-o"></i> <span
                                                            class="picNum"></span></span>
                                                    <span><i class="fa fa-file-o"></i> <span
                                                            class="docNum"></span></span>
                                                                                        </div>
                                                                                    </a>
                                                                                </li>
                                                                            </c:forEach>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <li data-type="LOANPURPOSE" data-key="借款用途认证" data-toggle="tooltip">
                                                                                <a data-toggle="tab" href="#id_renzheng">
                                                                                    <div>
                                                                                        <span class="ctype">借款用途认证</span>
                                                                                        <span class="score"></span>
                                                                                        <span class="status"></span>
                                                                                    </div>
                                                                                    <div class="documentCountLine">
                                                           <span><i class="fa fa-picture-o"></i> <span
                                                                   class="picNum"></span></span>
                                                    <span><i class="fa fa-file-o"></i> <span
                                                            class="docNum"></span></span>
                                                                                    </div>
                                                                                </a>
                                                                            </li>
                                                                            <li data-type="GUARANTEE" data-key="担保认证" data-toggle="tooltip">
                                                                                <a data-toggle="tab" href="#id_renzheng">
                                                                                    <div>
                                                                                        <span class="ctype">担保认证</span>
                                                                                        <span class="score"></span>
                                                                                        <span class="status"></span>
                                                                                    </div>
                                                                                    <div class="documentCountLine">
                                                            <span><i class="fa fa-picture-o"></i> <span
                                                                    class="picNum"></span></span>
                                                    <span><i class="fa fa-file-o"></i> <span
                                                            class="docNum"></span></span>
                                                                                    </div>
                                                                                </a>
                                                                            </li>
                                                                            <c:if test="${applicationUtils.clientFeatures.enableFactoring}">
                                                                                <li data-type="FACTORING" data-key="保理认证" data-toggle="tooltip">
                                                                                    <a data-toggle="tab" href="#id_renzheng">
                                                                                        <div>
                                                                                            <span class="ctype">保理认证</span>
                                                                                            <span class="score"></span>
                                                                                            <span class="status"></span>
                                                                                        </div>
                                                                                        <div class="documentCountLine">
                                                    <span><i class="fa fa-picture-o"></i> <span
                                                            class="picNum"></span></span>
                                                    <span><i class="fa fa-file-o"></i> <span
                                                            class="docNum"></span></span>
                                                                                        </div>
                                                                                    </a>
                                                                                </li>
                                                                            </c:if>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div id="document">
                                                        <div class="row">
                                                            <div class="col-sm-7">
                                                                <div class="tabbable tabs-left relative">
                                                                    <div class="" id="certificationContent">
                                                                        <div id="id_renzheng" class="tab-pane in active">
                                                                            <div class="row-fluid">

                                                                                <div class="widget-box transparent">
                                                                                    <div class="margin-l-10"></div>
                                                                                    <div class="widget-header widget-header-small">
                                                                                        <h4 class="blue smaller">
                                                                                            <i class="fa fa-briefcase"></i>
                                                                                            认证图片
                                                                                        </h4>
                                                                                            <c:if test="${statusIndex==1}">
																						<span class="btn btn-danger btn-sm pull-right"
                                                                                              id="deleteImageBtn">
																							<i class="fa fa-times"></i> 删除图片
																						</span>
																						<span class="btn btn-primary btn-sm pull-right"
                                                                                              id="setCoverBtn">
																							<i class="fa fa-paperclip"></i> 设为封面
																						</span>
																						<span class="btn btn-success btn-sm pull-right"
                                                                                              data-toggle="modal" data-target="#cameraPanel"
                                                                                              id="uploadWithCamera">
																							<i class="fa fa-camera"></i> 拍照上传
																						</span>
																						<span class="btn btn-primary btn-sm pull-right"
                                                                                              data-toggle="modal" data-target="#localFilePanel"
                                                                                              id="uploadLocally">
																							<i class="fa fa-upload"></i> 本地上传
																						</span>
                                                                                            </c:if>
                                                                                    </div>
                                                                                    <div class="">
                                                                                        <div class="widget-main">
                                                                                            <div class="royalSlider rsDefault" data-isfirst = 'false'>
                                                                                                <img class="rsImg" />
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <%-- <div class="widget-box transparent" id="certificationDocuments">
                                                                                    <div class="widget-header widget-header-small">
                                                                                        <h4 class="blue smaller">
                                                                                            <i class="fa fa-briefcase"></i>
                                                                                            认证材料
                                                                                        </h4>
                                                                                        <cm:securityTag privilegeString="LOANREQUEST_ALTER">
                                                                                            <c:if test="${statusIndex==1}">
                                                                                            <span class="btn btn-primary btn-sm pull-right"
                                                                                                    data-toggle="modal" data-target="#uploadFilePanel"
                                                                                                    id="uploadDocument">
                                                                                                <i class="fa fa-upload"></i> 上传材料
                                                                                            </span>
                                                                                            </c:if>
                                                                                        </cm:securityTag>
                                                                                    </div>
                                                                                    <div class="">
                                                                                        <div class="widget-main">
                                                                                            <div class="profile-feed" id="fileContainer"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div> --%>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-sm-5">
                                                                <div class="margin-t-10"></div>
                                                                <div class="tabbable" id="approvalIploadTabs">
                                                                    <ul class="nav nav-tabs tabs-flat">
                                                                        <li class="active">
                                                                            <a data-toggle="tab" href="#id_activity">
                                                                                <i class="fa fa-list"></i>
                                                                                审批流程
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a data-toggle="tab" href="#id_proof_history">
                                                                                <i class="fa fa-list"></i>
                                                                                上传记录
                                                                            </a>
                                                                        </li>
                                                                    </ul>
                                                                    <div class="tab-content tabs-flat" style="background:#fff;">
                                                                        <div id="id_activity" class="tab-pane in active">
                                                                            <div id="approvalHistory" class="profile-feed">

                                                                            </div>
                                                                        </div>
                                                                        <div id="id_proof_history" class="tab-pane in">
                                                                            <div id="uploadHistory" class="profile-feed">

                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="space-20"></div>
                                                        <div class="row-fluid">
                                                            <div class="span12">
                                                                <div class="widget-box transparent">
                                                                    <div class=" widget-header-small">
                                                                        <h4 class="blue smaller">
                                                                            <i class="fa fa-legal"></i>
                                                                            借款申请评审
                                                                        </h4>
                                                                    </div>
                                                                    <div class="">
                                                                        <c:choose>
                                                                            <c:when test="${data.request.status.key == '已批准'}">
                                                                                <div class="space-10"></div>
                                                                                <div class="alert alert-block alert-success successMessage">
                                                                                    <i class="fa fa-check bigger-130 green"></i>
                                                                                    本申请已经被批准！
                                                                                </div>
                                                                            </c:when>
                                                                            <c:when test="${data.request.status.key == '已驳回'}">
                                                                                <div class="space-10"></div>
                                                                                <div class="alert alert-block alert-error">
                                                                                    <i class="fa fa-times bigger-130 red"></i>
                                                                                    本申请已经被驳回！
                                                                                </div>
                                                                            </c:when>
                                                                            <c:when test="${data.request.status.key == '已发放'}">
                                                                                <div class="space-10"></div>
                                                                                <div class="alert alert-block alert-success successMessage">
                                                                                    <i class="fa fa-check bigger-130 green"></i>
                                                                                    申请通过，贷款已经成功发放！
                                                                                </div>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="form-actions">
                                                <textarea name="loanReqApprovalComment" id="loanReqApprovalComment"
                                                          placeHolder="请输入您的评论..."></textarea>

                                                                                    <div class="pull-right">
                                                                                            <c:if test="${statusIndex==1}">
                                                                                                <div class="checkbox pull-left" style="margin-right:10px;">
                                                                                                    <label>
                                                                                                        <input style="position:relative; left:0px; opacity:1; vertical-align: middle;" value="publishNow" type="checkbox" id="publishNow" name="publishType" />
                                                                                                        <span>立即发布 &nbsp;&nbsp;&nbsp;</span>
                                                                                                    </label>
                                                                                                    <label>
                                                                                                        <input style="position:relative; left:0px; opacity:1; vertical-align: middle;" type="checkbox" id="publishSchedule" value="publishSchedule" name="publishType" />
                                                                                                        <span>预告发布</span>
                                                                                                    </label>
                                                                                                    <span style="margin-left:10px;">发布时间：</span>
                                                                                                    <input type="text" id="timeOpen" name="timeOpen" style="width:120px;"/>
                                                                                                    <span>募集天数：</span>
                                                                                                    <input type="text" id="timeOut" name="timeOut" value="3" style="width:40px; text-align:center;"/>
                                                                                                </div>
                                                                                                <button type="button" onclick="submitForm(1);" id="submitReqBtn"
                                                                                                        class="btn btn-primary pull-left" style="margin-right:5px;">
                                                                                                    <i class="fa fa-check bigger-140"></i>
                                                                                                    批准发布
                                                                                                </button>
                                                                                                &nbsp;
                                                                                                <button type="button" onclick="submitForm(2);" id="submitReqBtn2"
                                                                                                        class="btn btn-danger pull-left">
                                                                                                    <i class="fa fa-times bigger-140"></i>
                                                                                                    拒绝发布
                                                                                                </button>
                                                                                            </c:if>
                                                                                    </div>
                                                                                </div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    <%--<center><button type="button" id="backToStep3" class="btn btn-info btn-small"><i class="fa fa-angle-left"></i>上一步</button>&nbsp;<button type="button" id="submitForm" class="btn btn-success btn-large">提交申请</button></center>--%>
                                                </div>
                                            </form>
                                        </div>
                                        </cm:securityTag>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- detail-box4 end-->
                    </div>
                    <!-- loanDetails end-->


                </div>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
    <!-- Page Container end-->
</div>
<!--
////////////////////////////////////////////////////////////////////////////////
上传材料弹出层
////////////////////////////////////////////////////////////////////////////////
-->
<div id="uploadFilePanel" class="bootbox modal fade modal-darkorange">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="bootbox-close-button close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title">上传材料</h4>
            </div>
            <div class="modal-body">
                <div class="bootbox-body">
                    <form class="form-horizontal" id="upf">
                        <input multiple type="file" id="uploadFileInput" name="uploadFileInput"/>

                        <div class="control-group">
                            <label class="control-label" for="certificateType2">材料类型</label>

                            <div class="controls">
                                <div class="btn-group">
                                    <select class="" name="certificateType">
                                        <c:forEach var="ctype" items="${CertificateType}">
                                            <optgroup label="${ctype.key}">
                                                <c:forEach var="ptype" items="${ProofType}">
                                                    <c:if test="${ptype.certificateType == ctype}">
                                                        <option value="${ptype.key}">${ptype.key}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </optgroup>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">材料描述</label>

                            <div class="controls">
                                        <textarea type="text"
                                                  placeholder="请输入材料描述"
                                                  rows="2"
                                                  id="fileDescription"
                                                  name="fileDescription"
                                                  class="perform-validate"
                                                  required
                                                  data-validation-required-message="材料描述不能为空"></textarea>
                            </div>
                        </div>
                        <div id="" class="center-align">
                            <div class="form-actions">
                                <button type="button" class="btn btn-success" id="uploadFileBtn" disabled><i class="icon-ok"></i> 保存
                                </button>
                                <button type="button" class="btn btn-danger" id="clearUploadFileBtn"><i class="icon-remove"></i> 清空
                                </button>
                            </div>
                        </div>
                    </form>
                    <div class="load_masker hide" id="uploadFileMasker"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--
////////////////////////////////////////////////////////////////////////////////
本地上传照片弹出层
////////////////////////////////////////////////////////////////////////////////
-->
<div id="localFilePanel" class="bootbox modal fade modal-darkorange">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="bootbox-close-button close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title">上传图片</h4>
            </div>
            <div class="modal-body">
                <div class="bootbox-body">
                    <form class="form-horizontal" id="lupf">
                        <input multiple type="file" id="uploadImageLocalInput" name="uploadImageLocalInput"/>

                        <div class="control-group">
                            <label class="control-label" for="certificateType2">认证类型</label>

                            <div class="controls">
                                <div class="btn-group">
                                    <select class="" id="certificateType2" name="certificateType2">
                                        <c:forEach var="ctype" items="${CertificateType}">
                                            <optgroup label="${ctype.key}">
                                                <c:forEach var="ptype" items="${ProofType}">
                                                    <c:if test="${ptype.certificateType == ctype}">
                                                        <option value="${ptype.key}">${ptype.key}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </optgroup>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!--  <div class="control-group">
                             <label class="control-label">是否打码</label>
                             <div class="controls">
                                 <label>
                                     <input type="radio" name="if_mosaic" id="mosaic1" value="false" checked />
                                     <span class="lbl">
                                         否
                                     </span>
                                 </label>
                                 <label>
                                     <input type="radio" name="if_mosaic" id="mosaic2" value="true" />
                                     <span class="lbl">
                                         是
                                     </span>
                                 </label>
                             </div>
                         </div> -->
                        <div class="control-group">
                            <label class="control-label">图片描述</label>

                            <div class="controls">
                            <textarea type="text"
                                      placeholder="请输入图片描述"
                                      rows="2"
                                      id="imageDescription2"
                                      name="imageDescription2"
                                      class="perform-validate"
                                      required
                                      data-validation-required-message="图片描述不能为空"></textarea>
                            </div>
                        </div>
                        <div id="" class="center-align">
                            <div class="form-actions">
                                <button type="button" class="btn btn-success" id="saveFileBtn" disabled><i class="icon-ok"></i> 保存
                                </button>
                                <button type="button" class="btn btn-danger" id="clearFileBtn"><i class="icon-remove"></i> 清空
                                </button>
                            </div>
                        </div>
                    </form>
                    <div class="load_masker hide" id="fileMasker"></div>
                </div>
            </div>
        </div><!-- /.modal-dialog -->
    </div>
</div>

<!--
////////////////////////////////////////////////////////////////////////////////
拍照上传弹出层
////////////////////////////////////////////////////////////////////////////////
-->
<div id="cameraPanel" class="bootbox modal fade modal-darkorange">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="bootbox-close-button close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title">上传图片</h4>
            </div>
            <div class="modal-body">
                <div class="bootbox-body">
                    <div class="camera">
                        <div id="step1">
                            <div id="captureBtn" class="form-actions hide">
                                <button id="snapImage" class="btn btn-danger"><i class="icon-camera bigger-110"></i> 拍照</button>
                            </div>
                            <div id="videoContainer" class="center-align">
                                <video autoplay id="video"></video>
                                <canvas id="canvas" width="960" height="720" class="hide"></canvas>
                            </div>
                        </div>
                        <div id="step2" class="center-align hide">
                            <div class="form-actions">
                                <button class="btn btn-success" id="saveImageBtn"><i class="icon-ok"></i> 保存</button>
                                <button class="btn btn-danger" id="chongpai"><i class="icon-repeat"></i> 重拍</button>
                            </div>
                            <img id="tupian"/>
                        </div>
                        <div id="step3" class="hide">
                            <form class="form-horizontal" novalidate>
                                <div class="control-group">
                                    <label class="control-label">图片预览</label>

                                    <div class="controls">
                                        <img id="tupian-small"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">图片名称</label>

                                    <div class="controls">
                                        <input type="text"
                                               placeholder="请输入图片名称"
                                               id="imageName"
                                               required
                                               class="perform-validate"
                                               value=""
                                               data-validation-required-message="图片名称不能为空"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="certificateType">认证类型</label>

                                    <div class="controls">
                                        <div class="btn-group">
                                            <select class="" id="certificateType" name="certificateType">
                                                <c:forEach var="ctype" items="${CertificateType}">
                                                    <optgroup label="${ctype.key}">
                                                        <c:forEach var="ptype" items="${ProofType}">
                                                            <c:if test="${ptype.certificateType == ctype}">
                                                                <option value="${ptype.key}">${ptype.key}</option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </optgroup>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">是否打码</label>

                                    <div class="controls">
                                        <label>
                                            <input type="radio" name="mosaic" id="mosaicRadios1" value="false" checked/>
                                        <span class="lbl">
                                            否
                                        </span>
                                        </label>
                                        <label>
                                            <input type="radio" name="mosaic" id="mosaicRadios2" value="true"/>
                                        <span class="lbl">
                                            是
                                        </span>
                                        </label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">图片描述</label>

                                    <div class="controls">
                                    <textarea type="text"
                                              placeholder="请输入图片描述"
                                              rows="2"
                                              id="imageDescription"
                                              class="perform-validate"
                                              required
                                              data-validation-required-message="图片描述不能为空"></textarea>
                                    </div>
                                </div>
                            </form>
                            <div class="form-actions">
                                <button class="btn btn-primary" id="uploadImageBtn"><i class="icon-cloud-upload bigger-130"></i>
                                    上传图片
                                </button>
                                <button class="btn btn-danger" id="cancelUploadImageBtn"><i class="icon-remove bigger-110"></i> 取消
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="load_masker hide" id="imageMasker"></div>
                </div>
            </div>

        </div><!-- /.modal-dialog -->
    </div>
</div>

<!--
////////////////////////////////////////////////////////////////////////////////
分配任务弹出层
////////////////////////////////////////////////////////////////////////////////
-->
<div id="assignPanel" class="modal hide fade">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                onclick="$('#assignPanel').get(0).reset();">&times;</button>
        <h3><i class="icon-truck"></i> 创建任务</h3>
    </div>
    <div class="modal-body relative">
        <form class="form-horizontal" id="assignTask">
            <div class="">
                <div class="size-16">
                    负责人：
                    <select name="reporter">
                        <c:forEach var="e" items="${data.employees}">
                            <option value="${data.e.id}">${data.e.name}</option>
                        </c:forEach>
                    </select>

                    <div class="hsplit-dotted"></div>
                    <label class="checkbox inline-block">
                        <input id="simpleTask" type="checkbox" name="">
                        <span class="lbl"> 同时审查用户</span>
                    </label>
                </div>
                <div class="hr-10"></div>
                <div>
                    <label class="checkbox">
                        <input id="checkAllType" type="checkbox" name="" checked="true">
                        <span class="lbl"> 全选</span>
                    </label>
                    <c:forEach var="type" items="${CertificateType}">
                        <label class="checkbox inline-block">
                            <input class="certificateType" type="checkbox" name="certificateType"
                                   checked="true">
                            <span class="lbl"> ${type.key}</span>
                        </label>
                    </c:forEach>
                </div>
                <div class="hr-10"></div>
                <div class="margin-bottom-5">
                    时间：
                    <span id="taskTime" class="blue" data-type="combodate" data-template="YYYY 年 MM 月 DD 日 HH : mm"
                          data-format="YYYY 年 MM 月 DD 日 HH : mm" data-viewformat="YYYY年MM月DD日, HH:mm"></span>
                </div>
                <div class="margin-bottom-5">
                    地点：
                            <span class="blue" id="taskAddress"
                                  data-placeholder="请输入地址 .."
                                  data-type="text">
                            </span>
                </div>
            </div>
            <textarea name="loanRequestApprovalDescription" id="loanRequestApprovalDescription"
                      placeHolder="请输入认证说明 ..."></textarea>

            <div class="text-center">
                <button type="button" id="doAssign" class="btn btn btn-primary">
                    <i class="icon-ok"></i>
                    确定
                </button>
                &nbsp;
                <button type="button" class="btn btn-danger btn" id="hideAssignTaskPanelBtn">
                    <i class="icon-remove"></i>
                    取消
                </button>
            </div>
        </form>
        <div class="load_masker hide" id="waishenMasker"></div>
    </div>
</div>


<div id="changeLoanRequestPanel" class="modal hide fade">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                onclick="$('#changeLoanRequestPanel').get(0).reset();">&times;</button>
        <h3><i class='icon-edit'></i> 修改贷款请求</h3>
    </div>
    <div class="modal-body relative">
        <form action="" class="form-horizontal">
            <div class="control-group">
                <label class="control-label" for="title">借款标题</label>

                <div class="controls">
                    <input class="performValidate"
                           type="text"
                           name="title"
                           value="${data.request.title}"
                           readonly/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="usage">借款用途</label>

                <div class="controls">
                    <select class="" id="usage" name="usage">
                        <c:forEach var="purpose" items="${LoanPurpose}">
                            <option value="${purpose}"
                                    <c:if test="${data.request.purpose == purpose}">selected</c:if>>${purpose.key}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="dueDate">借款金额</label>

                <div class="controls credit-amount">
                    <div class="input-prepend">
                                <span class="add-on rmb">
                                    <i class="icon-yen"></i>
                                </span>
                        <input class="prependedInput performValidate"
                               type="text"
                               name="amount"
                               value="${data.request.amount}"/>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="dueDate">借款期限</label>

                <div class="controls credit-amount">
                    <div class="input-prepend">
                                <span class="add-on rmb">
                                    年
                                </span>
                        <input class="prependedInput shortInput"
                               type="text"
                               id="years"
                               name="years"
                               placeholder="0"/>
                    </div>
                    <div class="input-prepend">
                                <span class="add-on rmb">
                                    月
                                </span>
                        <input class="prependedInput shortInput"
                               type="text"
                               id="months"
                               name="months"
                               placeholder="0"/>
                    </div>
                    <div class="input-prepend">
                                <span class="add-on rmb">
                                    日
                                </span>
                        <input class="prependedInput shortInput"
                               type="text"
                               id="days"
                               name="days"
                               placeholder="0"/>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="annualRate">年利率</label>

                <div class="controls">
                    <div class="input-append annualRate-input">
                        <input type="text"
                               name="annualRate"
                               class=""
                               value="<fmt:formatNumber maxFractionDigits="1" value="${data.request.rate/100}"/>"/>
                        <span class="add-on">%</span>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="paymentMethod">还款方式</label>

                <div class="controls payment-method-lb">
                    <c:forEach var="method" items="${RepaymentMethod}" varStatus="item">
                        <label>
                            <input name="paymentMethod"
                                   class="ace"
                                   type="radio"
                                   value="${method}"
                                   <c:if test="${data.request.method == method}">checked</c:if>
                                   required
                                   data-validation-required-message="请选择还款方式"/>
                            <span class="lbl"> ${method.key}<span class="gap greyText">-</span><span
                                    class="greyText smallSize">${method.desc}</span></span>
                        </label>
                    </c:forEach>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="description">借款说明</label>

                <div class="controls">
                    <textarea name="description" placeholder="输入贷款说明" required
                              data-validation-required-message="请输入贷款说明" value="${data.request.description}"></textarea>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for=""></label>

                <div class="controls">
                    <button type="button" id="submitForm" class="btn btn-success btn-large">提交申请</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Main Container end-->
<%@include file="../common/foot.jspf" %>


<script type="text/template" id="docTemplate">
    <div class="profile-activity clearfix">
        <div>
            <div class="pull-left commentAvadar">
                <img id="pdfImg" src="/assets/img/$icon.png"/>
            </div>
            <div class="pull-left">
                <a href="$uri" target="_blank">$name</a> <a class="download-link" href="$downloadLink" download><i
                    class="icon-download-alt"></i> 下载</a>

                <div class="time">
                    <i class="icon-time bigger-110"></i>
                    $submitTime -<a href="$link" target="_blank">$uploader</a>
                </div>
            </div>
        </div>
    </div>
</script>
<script id="bank-template" type="text/x-handlebars-template">

 </script>
<%--<div id="json-documents" style="display:none">${data.documents}</div>
<div id="json-certificates" style="display:none">${data.certificates}</div>
<div id="json-weights" style="display:none">${data.certificateTypeWeights}</div>--%>


<script type="text/javascript">
    var CC = CC || {};
    CC.requestId = '${loanInfo.requestId}';
    CC.user = {
        id: '${loanInfo.userId}',
        name: '${loanInfo.userName}',
        loginName: '${loanInfo.userLoginName}'
    };
</script>
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script src="/assets/js/amountFormat.js"></script>
<script type="text/javascript" src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>

<script src="/assets/js/toastr/toastr.js"></script>

<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js"></script>
<script src="/assets/js/loan/jquery.slimscroll.min.js"></script>
<script src="/assets/js/jquery.easy-pie-chart.min.js"></script>
<script src="/assets/js/loan/jquery.royalslider.min.js"></script>
<script src="/assets/js/datetime/bootstrap-datepicker.js"></script>
<script src="/assets/js/datetime/moment-with-locales.js"></script>
<script src="/assets/js/datetime/bootstrap-datetimepicker.js"></script>
<script src="/assets/js/loan/request.js"></script>
<script src="/assets/js/loan/single.js"></script>

<script>
    $('#rmbInvests_list').dataTable({
        "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
        "bRetrieve": true,
        "iDisplayLength": 10,
        "oLanguage": {
            "sLengthMenu": "_MENU_",
            "sSearch": "",
            "sInfo": "显示第 _START_ - _END_ 条记录，共 _TOTAL_ 条<span style='float:right;color:red'>合计：<fmt:formatNumber value='${sumInvestAmount}' currencySymbol='¥' type='currency'/></span>",
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
    //弹出层 借款标题修改
    $(".bootbox-regular").on('click', function () {
        bootbox.prompt("借款标题修改", function (result) {
            if (result === null) {
                //Example.show("Prompt dismissed");
            } else {
                //Example.show("Hi <b>"+result+"</b>");
                $.ajax({
                    type:'POST',
                    url:'/loan/updateRequestTitle',
                    data:{
                        loanId:'${loanInfo.loanId}',
                        requestId:'${loanInfo.requestId}',
                        title:result
                    },
                    dataType:'json',
                    success:function(data){
                        if($('.bootbox-form .bootbox-input').val()!=''){
                            $('.s-title').html(result);
                            $('.jksq').html(result);
                        }
                    }
                })
            }
        });
    });
</script>
</body>
</html>
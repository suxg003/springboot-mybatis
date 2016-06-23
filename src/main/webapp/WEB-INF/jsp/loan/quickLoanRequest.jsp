<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>千金所测试平台</title>
    <meta name="description" content="千金所测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
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
                    <li>产品管理</li>
                    <li>直投项目</li>
                    <li>发布新产品</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        个人借款
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
            <div class="page-body" style="position: relative;">

                <!-- 借款类型-->
                <div id="registerStep0" class="screenCentered well registerStep">
                    <div class="wizard wizard-wired" data-target="#WiredWizardsteps">
                        <ul class="steps">
                            <li href="#tab1" class="active" onclick="goBackStep0()"><span class="step">1</span><span class="title">借款类型</span><span class="chevron"></span></li>
                            <li href="#tab2" class="step"><span class="step">2</span><span class="title">借款人信息</span><span class="chevron"></span></li>
                            <li href="#tab3"  ><span class="step">3</span><span class="title">借款申请表单</span> <span class="chevron"></span></li>
                            <li href="#tab4"  ><span class="step">4</span><span class="title">担保/抵押信息</span> <span class="chevron"></span></li>
                          <!--   <li href="#tab4"  class="" ><span class="step">5</span><span class="title">安全认证</span> <span class="chevron"></span></li> -->
                        </ul>
                    </div>

                    <div class="buttonWrapper">
                        <div class="buttonPanel">
                            <button class="btn btn-info shiny" id="geren"><i class="fa fa-user"></i> 个人借款</button>
                        </div>
                        <div class="buttonPanel">
                            <button class="btn btn-success shiny" id="qiye"><i class="fa fa-home"></i> 企业借款</button>
                        </div>
                        <%-- <div class="buttonPanel">
                             <button class="btn btn-danger" id="licai"><i class="icon-suitcase"></i> 理财产品</button>
                         </div>--%>
                    </div>
                </div>
                <!-- 借款人信息 -->
                <div id="registerStep1" style="display: none" class="screenCentered well row registerStep">
                    <div class="wizard wizard-wired" data-target="#WiredWizardsteps">
                        <ul class="steps">
                            <li href="#tab1" class="complete" onclick="goBackStep0()"><span class="step">1</span><span class="title">借款类型</span><span class="chevron"></span></li>
                            <li href="#tab2" class="active"><span class="step">2</span><span class="title">借款人信息</span><span class="chevron"></span></li>
                            <li href="#tab3" ><span class="step">3</span><span class="title">借款申请表单</span> <span class="chevron"></span></li>
                            <li href="#tab4" ><span class="step">4</span><span class="title">担保/抵押信息</span> <span class="chevron"></span></li>
                            <!-- <li href="#tab4"  class="" ><span class="step">5</span><span class="title">安全认证</span> <span class="chevron"></span></li> -->
                        </ul>
                    </div>
                    <form id="registrationForm" method="post" class="form-horizontal"
                          data-bv-message="This value is not valid"
                          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
                          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
                          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
                        <div class="form-group">&nbsp;</div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">账户名：</label>
                            <div class="col-lg-6">
								<input type="text" style="display:none;" value="${coreUser.loanRequest.requestId }"  id="requestIdCheck"/>
                                <input type="text" id="regedUserLoginName" class="form-control pull-left" value="${coreUser.loginName }" name="regedUserLoginName" placeholder="请输入注册用户账户名"
                                       data-bv-notempty="true"
                                       data-bv-notempty-message="请输入已注册用户账户名" />
                                <div class="errorText hide"><i class="icon-warning-sign"></i> 用户不存在</div>
                            </div>
                            <div class="pull-left col-lg-1"><span class="input-group-btn">
                                                                    <button class="btn btn-default shiny" id="queryUserBtn" type="button">查询</button>
                                                                </span></div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label">真实姓名：</label>
                            <div class="col-lg-6 MargT-7" id="regedRealName" data-id="${coreUser.userId }">${coreUser.userName }
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label">身份证号：</label>
                            <div class="col-lg-6 MargT-7" id="regedIdNumber">${coreUser.idNumber }
                            </div>
                        </div>
                       <!--  <div class="form-group">
                            <label class="col-lg-3 control-label">无密还款协议：</label>
                            <div class="col-lg-6 MargT-7" id="allowNoPwdRepay">
                            </div>
                        </div> -->
                        <div class="form-group" id="corporationInfo">
                            <label class="col-lg-3 control-label" for="">企业名称：</label>

                            <div class="col-lg-6 MargT-7" id="corporationName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">合同显示借款人：</label>
                            <div class="col-lg-6">
                                <input type="text"  class="form-control"
                                       id="contractBorrower"
                                       name="contractBorrower"
                                       value="${coreUser.loanRequest.loanName }"
                                       placeholder="请输入合同显示借款人"/>
                                <div class="errorText hide"><i class="icon-warning-sign"></i> 合同显示借款人不能为空</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-3 control-label">合同显示借款人身份证：</label>
                            <div class="col-lg-6">
                                <input type="text" class="form-control"
                                       id="contractBorrowerID"
                                       name="contractBorrowerID"
                                        value="${coreUser.loanRequest.idNumber }"
                                       placeholder="请输入合同显示借款人身份证"/>
                                <div class="errorText hide" style="margin-top: 15px"><i class="icon-warning-sign"></i> 合同显示借款人身份证输入有误</div>
                            </div>
                        </div>
                        <div class="form-group"></div><div class="form-group"></div>
                        <center><button type="button" id="backToStep0" class="btn btn-info btn-small"><i class="fa fa-angle-left"></i>上一步</button>&nbsp;<button type="button" id="useOldUser" class="btn btn-info btn-large">下一步&nbsp;<i class="fa fa-angle-right"></i></button></center>
                    </form>
                </div>
                <!-- 借款申请表单 -->
                <div id="registerStep2" style="display: none" class="screenCentered well registerStep">
                    <div class="wizard wizard-wired" data-target="#WiredWizardsteps">
                        <ul class="steps">
                            <li href="#tab1" class="complete"><span class="step">1</span><span class="title">借款类型</span><span class="chevron"></span></li>
                            <li href="#tab2" class="complete" onclick="goBackStep1()"><span class="step">2</span><span class="title">借款人信息</span><span class="chevron"></span></li>
                            <li href="#tab3" class="active"><span class="step">3</span><span class="title">借款申请表单</span> <span class="chevron"></span></li>
                            <li href="#tab4"  ><span class="step">4</span><span class="title">担保/抵押信息</span> <span class="chevron"></span></li>
                            <!-- <li href="#tab4"  class="" ><span class="step">5</span><span class="title">安全认证</span> <span class="chevron"></span></li> -->
                        </ul>
                    </div>
                    <form class="form-horizontal" id="" novalidate onsubmit="return false;">
                        <div class="form-group">&nbsp;</div>
                        <div class="form-group">
                            <label class="control-label col-lg-3 " for="title">借款标题</label>

                            <div class="controls col-lg-6">
                                <input class="form-control"
                                       type="text"
                                       id="title"
                                       name="title"
                                        value="${coreUser.loanRequest.requestTitle }"
                                       placeholder="输入借款标题"
                                       required/>

                                <div class="errorText inline hide"><i class="icon-warning-sign"></i> 请正确输入贷款标题</div>

                            </div><div class="inline-block grey">（输入的中文或字符位数至少为4位）</div>
                        </div>
                        <div class="form-group">

                            <label class="control-label col-lg-3" for="loanRequestType">借款类型</label>

                            <div class="controls col-lg-6">
                                <select class="form-control" id="loanRequestType" name="requestType">
                                    <c:forEach var="type" items="${LoanRequestTypes}">
                                        <option value="${type}"  <c:if test="${coreUser.loanRequest.requestType == type}">selected</c:if>>${type.key}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="usage">借款用途</label>

                            <div class="controls col-lg-6">
                                <select class="form-control" id="usage" name="purpose">
                                    <c:forEach var="purpose" items="${LoanPurpose}">
                                        <option value="${purpose}" <c:if test="${coreUser.loanRequest.purpose == purpose}">selected</c:if>>${purpose.key}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="guaranteeType">保障类型</label>

                            <div class="controls col-lg-6">
                                <select class="form-control" id="guaranteeType" name="guaranteeInfo">
                                    <c:forEach var="guarantee" items="${GuaranteeType}">
                                        <option value="${guarantee}"  <c:if test="${coreUser.loanRequest.guaranteeType == guarantee}">selected</c:if>>${guarantee.key}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="dueDate">借款金额</label>

                            <div class="controls col-lg-4 credit-amount">
                                <div class="input-group">
                                    <span class="input-group-addon">￥</span>
                                    <input class="prependedInput form-control"
                                           type="text"
                                           id="amount"
                                           name="amount"
                                            value="<fmt:formatNumber value='${coreUser.loanRequest.amount }' pattern="0"/>"
                                           placeholder="0"/>
                                </div>

                            </div>
                            <div class="inline grey">（<fmt:formatNumber type="currency" currencySymbol=""
                                                                        value="${MIN_INVEST_AMOUNT }"
                                                                        maxFractionDigits="0"/>~<fmt:formatNumber
                                    type="currency" currencySymbol="" value="${MAX_LOAN_AMOUNT}"
                                    maxFractionDigits="0"/> 之间的整数）
                            </div>
                            <div class="errorText inline hide"><i class="icon-warning-sign"></i> 请输入正确的贷款金额</div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="minAmount">最小投资额</label>

                            <div class="controls col-lg-4">
                                <div class="input-group">
                                    <span class="input-group-addon">￥</span>
                                    <input type="text"
                                           id="minAmount"
                                           name="minAmount"
                                           class="form-control"
                                            value="${coreUser.loanRequest.minAmount }"
                                           value="100"
                                           placeholder="输入最小投资额度"/>
                                </div>
                            </div>
                            <div class="inline grey">（<fmt:formatNumber type="currency" currencySymbol=""
                                                                        value="${MIN_INVEST_AMOUNT }"
                                                                        maxFractionDigits="0"/>~<fmt:formatNumber
                                    type="currency" currencySymbol="" value="${MAX_LOAN_AMOUNT}"
                                    maxFractionDigits="0"/> 之间的整数）
                           	 </div>
                            <div class="errorText inline hide"><i class="icon-warning-sign"></i> 额度错误</div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="maxAmount">最大投资额</label>

                            <div class="controls col-lg-4">
                                <div class="input-group">
                                    <span class="input-group-addon">￥</span>
                                    <input type="text"
                                           id="maxAmount"
                                           name="maxAmount"
											value="${coreUser.loanRequest.maxAmount }"
                                           value="${MAX_LOAN_AMOUNT }"
                                           placeholder="输入最大投资额度"
                                           class="form-control"/>
                                </div>
                            </div>
                            <div class="inline grey">（<fmt:formatNumber type="currency" currencySymbol=""
                                                                        value="${MIN_INVEST_AMOUNT }"
                                                                        maxFractionDigits="0"/>~<fmt:formatNumber
                                    type="currency" currencySymbol="" value="${MAX_LOAN_AMOUNT}"
                                    maxFractionDigits="0"/> 之间的整数）
                           			 </div>
                            <div class="errorText inline hide"><i class="icon-warning-sign"></i> 额度错误</div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="stepAmount">投资增量</label>

                            <div class="controls col-lg-4">
                                <div class="input-group">
                                    <span class="input-group-addon">￥</span>
                                    <input type="text"
                                           id="stepAmount"
                                           name="stepAmount"
                                           value="${coreUser.loanRequest.stepAmount }"
                                           value="100"
                                           placeholder="输入投资增量额度"
                                           class="form-control"/>
                                </div>
                            </div>
                            <div class="inline grey">（<fmt:formatNumber type="currency" currencySymbol=""
                                                                        value="${MIN_INVEST_AMOUNT }"
                                                                        maxFractionDigits="0"/>~<fmt:formatNumber
                                    type="currency" currencySymbol="" value="${MAX_LOAN_AMOUNT}"
                                    maxFractionDigits="0"/> 之间的整数）
                           			 </div>
                            <div class="errorText inline hide"><i class="icon-warning-sign"></i> 额度错误</div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="dueDate">借款期限</label>
                            <div class="col-lg-2 col-sm-2 col-xs-2">
                                <div class="input-group input-group-sm ">
                                    <input class="prependedInput form-control"
                                           type="text"
                                           id="years"
                                           name="years"
                                           value="${coreUser.loanRequest.years }"
                                           placeholder="0"/>
                                    <span class="input-group-addon">年</span>
                                </div>
                            </div>
                            <div class="col-lg-2 col-sm-2 col-xs-2">
                                <div class="input-group input-group-sm ">
                                    <input class="prependedInput form-control"
                                           type="text"
                                           id="months"
                                           name="months"
                                           value="${coreUser.loanRequest.months}"
                                           placeholder="0"/>
                                    <span class="input-group-addon">月</span>
                                </div>
                            </div>
                            <div class="col-lg-2 col-sm-2 col-xs-2">
                                <div class="input-group input-group-sm ">
                                    <input class="prependedInput form-control"
                                           type="text"
                                           id="days"
                                           name="days"
                                           value="${coreUser.loanRequest.days}"
                                           placeholder="0"/>
                                    <span class="input-group-addon">日</span>
                                </div>
                            </div>
                            <button class="btn btn-light" id="resetDurationBtn">重置</button>
                            <div class="errorText inline hide"><i class="icon-warning-sign"></i> <span
                                    class="error-detail"></span></div>

                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="annualRate">年利率</label>

                            <div class="controls col-lg-4">
                                <div class="input-append input-group">
                                    <input type="text"
                                           id="annualRate"
                                           name="annualRate"
                                           class="form-control"
                                             data-value="24.0"
                                           value="<fmt:formatNumber minFractionDigits="2" value='${coreUser.loanRequest.rate / 100}' pattern="0"/>"/>
                                    <span class="input-group-addon">%</span>
                                </div>

                            </div>
                            <div class="inline-block grey">（年利率范围：0% ~ 24%）</div>
                            <div class="errorText inline hide"><i class="icon-warning-sign"></i> 请输入正确的年利率</div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="addAnnualRate">候补年利率</label>

                            <div class="controls col-lg-4">
                                <div class="input-append input-group">
                                    <input type="text"
                                           id="addAnnualRate"
                                           name="addAnnualRate"
                                           class="form-control"
                                           
                                            data-value="24.0"
                                           value="<fmt:formatNumber minFractionDigits="2" value='${coreUser.loanRequest.rateAdd / 100}' pattern="0"/>"/>
                                    <span class="input-group-addon">%</span>
                                </div>

                            </div>
                            <div class="inline-block grey">（候补年利率：0% ~ 24%）</div>
                            <div class="errorText inline hide"><i class="icon-warning-sign"></i> 请输入正确的年利率</div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="mortgaged">抵押品</label>

                            <div class="controls col-lg-6 mortgaged-lb" data-checked = "${coreUser.loanRequest.mortgaged}">
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="mortgaged" class="ace" id="optionsRadios1" value="false" />
                                        <span class="text"> 无抵押 <span class="gap greyText">-</span><span class="greyText smallSize">信用借款</span></span>
                                    </label>
                                </div>

                                <div class="radio">
                                    <label>
                                        <input type="radio" name="mortgaged" class="ace" id="optionsRadios2" value="true" />
                                                    <span class="text"> 有抵押<span class="gap greyText">-</span><span class="greyText smallSize">${coreUser.loanRequest.mortgagedInfo }</span>
                                            <span class="gap greyText"></span>
                                          
                                    </label>
                                </div>

                                <%-- <select multiple="" class="form-control tag-input-style" data-placeholder="请选择..."
                                        name="mortgageType">
                                    <c:forEach var="type" items="${MortgageType}">
                                        <option value="${type}"
                                         <c:if test="${coreUser.loanRequest.requestMethod == type}">checked</c:if>
                                        >${type.key}</option>
                                    </c:forEach>
                                </select> --%>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="paymentMethod">还款方式</label>

                            <div class="controls col-lg-5 payment-method-lb" data-checked = "${coreUser.loanRequest.requestMethod}">
                                <c:forEach var="method" items="${repaymethod}" varStatus="item">
                                    <div class="radio">
                                        <label>
                                            <input name="paymentMethod"
                                                   type="radio"
                                                   value="${method}"                                                   
                                                   required  checded="checded"
                                                   data-validation-required-message="请选择还款方式"/>
                                    <span class="text"> ${method.key}<span class="gap greyText">-</span><span
                                            class="greyText smallSize">${method.desc}</span></span>
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                       <!--  <div class="form-group">
                            <label class="control-label col-lg-3" for="outtimes">募集时间</label>

                            <div class="controls col-lg-4">
                                <div class="input-append input-group">
                                    <input type="text"
                                           id="outtimes"
                                           name="outtimes"
                                           class="form-control"
                                           value=""/>
                                    <span class="input-group-addon">天</span>
                                </div>

                            </div>
                            <div class="inline-block grey"></div>
                            <div class="errorText inline hide"><i class="icon-warning-sign"></i> 请输入正确的年利率</div>
                        </div> -->

                         <div class="form-group">
                                <label class="control-label col-lg-3" for="danbaoRate">合同模版</label>

                                <div class="controls col-lg-4">
                                    <select name="template">
                                        <c:forEach var="temp" items="${data.templates}">
                                            <option value="${temp.id}"
	                                            <c:if test="${ data.currentTemplate.id == temp.id}">selected</c:if>
	                                            >
	                                            ${temp.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3"  for="danbaoRate">担保费率</label>

                            <div class="controls col-lg-4">
                                <div class="input-append input-group">
                                    <input type="text"
                                           id="loanGuaranteeFee"
                                           name="loanGuaranteeFee"
                                           class="form-control monitoring rateValue serviceFee"
                                           data-label="担保费率"
                                           data-value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.loanGuaranteeFee * 100}"/>"
                                           value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.loanGuaranteeFee * 100}"/>"/>
                                    <span class="input-group-addon">%</span>
                                </div>

                                <div class="inline-block grey hidden">（费率范围：1% ~ 10%）</div>
                                <div class="errorText inline hidden"><i class="icon-warning-sign"></i> 请输入正确的费率
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3"  for="serviceRate">服务费率</label>

                            <div class="controls col-lg-4">
                                <div class="input-append input-group">
                                    <input type="text"
                                           id="loanServiceFee"
                                           name="loanServiceFee"
                                           data-label="服务费率"
                                           class="form-control monitoring rateValue serviceFee"
                                           data-value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.loanServiceFee * 100}"/>"
                                           value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.loanServiceFee * 100}"/>"/>
                                    <span class="input-group-addon">%</span>
                                </div>
                                <div class="errorText inline hidden"><i class="icon-warning-sign"></i> 请输入正确的费率
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3"  for="riskRate">风险管理费率</label>

                            <div class="controls col-lg-4">
                                <div class="input-append input-group">
                                    <input type="text"
                                           id="loanRiskFee"
                                           name="loanRiskFee"
                                           class="form-control monitoring rateValue serviceFee"
                                           data-label="风险管理费率"
                                           data-value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.loanRiskFee * 100}"/>"
                                           value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.loanRiskFee * 100}"/>"/>
                                    <span class="input-group-addon">%</span>
                                </div>
                                <div class="inline-block grey hidden">（费率范围：1% ~ 10%）</div>
                                <div class="errorText inline hidden"><i class="icon-warning-sign"></i> 请输入正确的费率
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3"  for="serviceRate">借款管理费率</label>

                            <div class="controls col-lg-4">
                                <div class="input-append input-group">
                                    <input type="text"
                                           id="loanManageFee"
                                           name="loanManageFee"
                                           class="form-control monitoring rateValue serviceFee"
                                           data-label="借款管理费率"
                                           data-value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.loanManageFee * 100}"/>"
                                           value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.loanManageFee * 100}"/>"/>
                                    <span class="input-group-addon">%</span>
                                </div>
                                <div class="errorText inline hidden"><i class="icon-warning-sign"></i> 请输入正确的费率
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3"  for="serviceRate">还款(借款)利息管理费率</label>

                            <div class="controls col-lg-4">
                                <div class="input-append input-group">
                                    <input type="text"
                                           id="loanInterestFee"
                                           name="loanInterestFee"
                                           class="form-control monitoring rateValue serviceFee"
                                           data-label="还款(借款)利息管理费率"
                                           data-value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.loanInterestFee * 100}"/>"
                                           value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.loanInterestFee * 100}"/>"/>
                                    <span class="input-group-addon">%</span>
                                </div>
                                <div class="errorText inline hidden"><i class="icon-warning-sign"></i> 请输入正确费率</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3"  for="serviceRate">回款(投资)利息管理费率</label>

                            <div class="controls col-lg-4">
                                <div class="input-append input-group">
                                    <input type="text"
                                           id="investInterestFee"
                                           name="investInterestFee"
                                           class="form-control monitoring rateValue serviceFee"
                                           data-label="回款(投资)利息管理费率"
                                           data-value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.investInterestFee * 100}"/>"
                                           value="<fmt:formatNumber minFractionDigits="2" value="${coreUser.loanRequest.rmbLoanRequestFee.investInterestFee * 100}"/>"/>
                                    <span class="input-group-addon">%</span>
                                </div>
                                <div class="errorText inline hidden"><i class="icon-warning-sign"></i> 请输入正确的费率
                                </div>
                            </div>
                        </div>
                        <center><button type="button" id="backToStep1" class="btn btn-info btn-small"><i class="fa fa-angle-left"></i>上一步</button>&nbsp;<button type="button" id="gotoStep3" class="btn btn-info btn-large">下一步&nbsp;<i class="fa fa-angle-right"></i></button></center>

                    </form>
                </div>
                <!--  担保/抵押信息 -->
                <div id="registerStep3" style="display: none" class="screenCentered well registerStep">
                    <div class="wizard wizard-wired" data-target="#WiredWizardsteps">
                        <ul class="steps">
                            <li href="#tab1" class="complete"><span class="step">1</span><span class="title">借款类型</span><span class="chevron"></span></li>
                            <li href="#tab2" class="complete"><span class="step">2</span><span class="title">借款人信息</span><span class="chevron"></span></li>
                            <li href="#tab3" class="complete" onclick="goBackStep2()"><span class="step">3</span><span class="title">借款申请表单</span> <span class="chevron"></span></li>
                            <li href="#tab4"  class="active" ><span class="step">4</span><span class="title">担保/抵押信息</span> <span class="chevron"></span></li>
                          <!--   <li href="#tab4"  class="" ><span class="step">5</span><span class="title">安全认证</span> <span class="chevron"></span></li> -->
                        </ul>
                    </div>
                    <div class="form-horizontal">
                        <div class="form-group">&nbsp;</div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="description">借款说明</label>

                            <div class="controls col-lg-6">
                                <textarea name="requestDes" maxlength="8000" class="form-control" id="description" placeholder="输入借款说明" required>${coreUser.loanRequest.requestDes }</textarea>

                                <div class="errorText hide" style="margin-top: 10px;margin-left:0"><i class="icon-warning-sign"></i> 请输入借款说明</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="guaranteeInfo">担保信息</label>

                            <div class="controls col-lg-6">
                                <textarea name="guaranteeInfo" maxlength="200" class="form-control" id="guaranteeInfo" placeholder="输入担保信息" required>${coreUser.loanRequest.guaranteeInfo }</textarea>

                                <div class="errorText hide" style="margin-top: 10px;margin-left:0"><i class="icon-warning-sign"></i> 请输入担保信息</div>
                            </div>
                        </div>
                        <div class="form-group" id="dyxx">
                            <label class="control-label col-lg-3" for="mortgageInfo">抵押信息</label>

                            <div class="controls col-lg-6">
                                <textarea name="mortgagedInfo" maxlength="200" class="form-control" id="mortgageInfo" placeholder="输入抵押信息" required>${coreUser.loanRequest.mortgagedInfo }</textarea>

                                <div class="errorText hide" style="margin-top: 10px;margin-left:0"><i class="icon-warning-sign"></i> 输入抵押信息</div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="riskInfo">风险措施</label>

                            <div class="controls col-lg-6">
                                <textarea name="riskInfo" maxlength="5000" class="form-control" id="riskInfo" placeholder="输入风险措施" required>${coreUser.loanRequest.riskInfo }</textarea>

                                <div class="errorText hide" style="margin-top: 10px;margin-left:0"><i class="icon-warning-sign"></i> 输入风险措施</div>
                            </div>
                        </div>
                        <%-- <center><button type="button" id="backToStep2" class="btn btn-info btn-small"><i class="fa fa-angle-left"></i>上一步</button>&nbsp;<button type="button" id="gotoStep4" class="btn btn-info btn-large">下一步</button></center>
 --%>
						    <div class="pull-right">
                                                                <%-- <cm:securityTag privilegeString="LOANREQUEST_APPROVE">
                                                                    <div class="checkbox pull-left">
                                                                        <label>
                                                                            <input class="ace-checkbox-2" value="" type="checkbox"  name="publishNow">
                                                                            <span class="text">立即发布 &nbsp;&nbsp;&nbsp;</span>
                                                                        </label>
                                                                    </div>
                                                                    <button type="button" onclick="submitForm(1);" id="submitReqBtn"
                                                                            class="btn btn-primary pull-left">
                                                                        <i class="fa fa-check bigger-140"></i>
                                                                        批准发布
                                                                    </button>
                                                                </cm:securityTag>
                                                                &nbsp; --%>
                                                                <cm:securityTag privilegeString="LOAN_QUICKLOANREQUEST">
                                                                    <button type="button" id="backToStep3" class="btn btn-info btn-small"><i class="fa fa-angle-left"></i>上一步</button>&nbsp;<button type="button" onclick="submitForm(0);" id="submitReqBtn"
                                                                            class="btn btn-azure">
                                                                        <i class="fa fa-save bigger-140"></i>
                                                                        保存
                                                                    </button>
                                                                </cm:securityTag>
                                                            </div>
 
                    </div>
                </div>
                <!--  安全认证 -->

            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>


<%@include file="../common/foot.jspf" %>

<script type="text/javascript">
    var CC = CC || {};
    CC.requestId = '${data.request.id}';
    CC.user = {
        id: '${data.user.id}',
        name: '${data.user.name}',
        loginName: '${data.user.loginName}'
    };
</script>
<!--Page Related Scripts-->
<script src="/assets/js/fuelux/wizard/jquery.bootstrap.wizard.js"></script>
<script src="/assets/js/toastr/toastr.js"></script>
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js"></script>
<script src="/assets/js/loan/jquery.slimscroll.min.js"></script>
<script src="/assets/js/jquery.easy-pie-chart.min.js"></script>
<script src="/assets/js/loan/jquery.royalslider.min.js"></script>

<script src="/assets/js/datetime/bootstrap-datepicker.js"></script>
<script src="/assets/js/datetime/moment.min.js"></script>

<script src="/assets/js/quickLoanRequest.js"></script>

</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/29
  Time: 20:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
    <div class="row-fluid">
        <div class="alert alert-block alert-grey clearfix" id="loanRequestBrief">
            <div class="row-fluid">
                <div class="span9">
                    <div class="loan-title lightGrey">
                        <span class="title">${data.request.title}</span>
                        <c:if test="${data.request.serial != null}">
                                                <span class="purpose">
                                                    （唯一号：${data.request.serial}）
                                                </span>
                            <span class="split">|</span>
                        </c:if>
                                            <span class="purpose">
                                                ${data.request.purpose.key}
                                            </span>
                        <span class="split">|</span>
                                            <span class="status">
                                                <c:choose>
                                                    <c:when test="${data.request.status.key == '已批准' || request.status.key == '已发放'}">
                                                        <span class="green"><i
                                                                class="icon-ok"></i> ${data.request.status.key}</span>
                                                    </c:when>
                                                    <c:when test="${data.request.status.key == '已驳回'}">
                                                        <span class="red"><i
                                                                class="icon-remove"></i> ${data.request.status.key}</span>
                                                    </c:when>
                                                    <c:when test="${data.request.status.key == '未处理' || request.status.key == '已取消' || request.status.key == '已删除'}">
                                                        ${data.request.status.key}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="blue">${data.request.status.key}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                        <span class="split">|</span>
                                    <span>最小投资额：<span class="value red bold"><fmt:formatNumber type="currency"
                                                                                               maxFractionDigits="0"
                                                                                               value="${data.request.investRule.minAmount}"/></span>，</span>
                                    <span>最大投资额：<span class="value red bold"><fmt:formatNumber type="currency"
                                                                                               maxFractionDigits="0"
                                                                                               value="${data.request.investRule.maxAmount}"/></span>，</span>
                                    <span>投资增量：<span class="value red bold"><fmt:formatNumber type="currency"
                                                                                              maxFractionDigits="0"
                                                                                              value="${data.request.investRule.stepAmount}"/></span></span>
                    </div>
                    <div>
                        <div class="attritutions  margin-bottom-5">
                                                <span class="loan-attr">
                                                    金额：<span class="value red bold"><fmt:formatNumber type="currency"
                                                                                                      maxFractionDigits="0"
                                                                                                      value="${data.request.amount}"/></span>
                                                    <span class="value lightGrey">
                                                        <c:choose>
                                                            <c:when test="${data.request.mortgaged}">
                                                                （有抵押）
                                                            </c:when>
                                                            <c:otherwise>
                                                                （无抵押）
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </span>，
                                                <span class="loan-attr">
                                                    年利率：<span class="value green bold"><fmt:formatNumber
                                                        minFractionDigits="1" maxFractionDigits="1"
                                                        value="${data.request.rate/10000}"
                                                        type="percent"/></span>（${data.request.method.key}）
                                                </span>，
                                                <span class="loan-attr">
                                                    候补年利率：<span class="value green bold"><fmt:formatNumber
                                                        minFractionDigits="1" maxFractionDigits="1"
                                                        value="${data.request.rateAdd/10000}"
                                                        type="percent"/></span>（${data.request.method.key}）
                                                </span>，
                                                <span class="loan-attr">
                                                    期限：<span class="value"><cm:durationString
                                                        duration="${data.request.duration}"/></span>（总利息：<span
                                                        class="value red bold"><fmt:formatNumber type="currency"
                                                                                                 maxFractionDigits="2"
                                                                                                 value="${data.detail.interest}"/></span>）
                                                </span>，
                                                <span class="loan-attr">
                                                    申请日期：<span class="value"><fmt:formatDate
                                                        value="${data.request.timeSubmit}"
                                                        pattern="yyyy年M月d日 HH:mm"/></span>
                                                </span>
                        </div>
                        <div class="attritutions">
                                                <span class="loan-attr">
                                                    担保费率：<span class="green bold"><fmt:formatNumber
                                                        minFractionDigits="1" maxFractionDigits="2"
                                                        value="${data.loanFee.loanGuaranteeFee}" type="percent"/></span>
                                                </span>，
                                                <span class="loan-attr">
                                                    风险管理费率：<span class="green bold"><fmt:formatNumber
                                                        minFractionDigits="1" maxFractionDigits="2"
                                                        value="${data.loanFee.loanRiskFee}" type="percent"/></span>
                                                </span>，
                                                <span class="loan-attr">
                                                    服务费率：<span class="green bold"><fmt:formatNumber
                                                        minFractionDigits="1" maxFractionDigits="2"
                                                        value="${data.loanFee.loanServiceFee}" type="percent"/></span>
                                                </span>，
                                                <span class="loan-attr">
                                                    借款管理率：<span class="green bold"><fmt:formatNumber
                                                        minFractionDigits="1" maxFractionDigits="2"
                                                        value="${data.loanFee.loanManageFee}" type="percent"/></span>
                                                </span>，
                            <c:if test="${data.request.type != null}">
                								<span class="loan-attr">
                	借款类型：<span class="green bold">${data.request.type.key}</span>
                                                </span>，
                            </c:if>
                								<span class="loan-attr">
                                                    还款(借款)利息管理费率：<span class="green bold"><fmt:formatNumber
                                                        minFractionDigits="1" maxFractionDigits="2"
                                                        value="${data.loanFee.loanInterestFee}" type="percent"/></span>
                                                </span>，
                                                <span class="loan-attr">
                                                    回款(投资)利息管理费率：<span class="green bold"><fmt:formatNumber
                                                        minFractionDigits="1" maxFractionDigits="2"
                                                        value="${data.loanFee.investInterestFee}"
                                                        type="percent"/></span>
                                                </span>
                        </div>
                        <div class="description clearfix">
                            <div class="pull-left">贷款说明：</div>
                            <div class="pull-left descriptionPre">${data.request.description}</div>
                        </div>
                        <div class="description clearfix">
                            <div class="pull-left">风险控制：</div>
                            <div class="pull-left descriptionPre">${data.request.riskInfo}</div>
                        </div>
                    </div>
                </div>
                <div class="span3">
                    <div class="pull-right text-left">
                        <div class="alert alert-info no-margin">
                            <div>信用等级：<span class="red bold" id="creditRank">${data.userCredit.creditRank}
                            </div>
                            </span>
                            <div>信用评分：<span class="red bold" id="creditScore">${data.userCredit.score}</div>
                            </span>
                            <div>信用额度：<span class="value red bold"><fmt:formatNumber type="currency"
                                                                                     maxFractionDigits="0"
                                                                                     value="${data.userCredit.creditLimit}"/></span>
                            </div>
                            <div>可用额度：<span class="value red bold"><fmt:formatNumber type="currency"
                                                                                     maxFractionDigits="0"
                                                                                     value="${data.userCredit.creditAvailable}"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid hidden" id="eidtableLoanRequest">
        <div class="alert alert-block alert-grey clearfix">
            <div class="row-fluid">
                <div class="span9">
                    <div class="loan-title lightGrey">
                        <span class="title editable">${data.request.title}</span>
                        <span class="purpose">${data.request.purpose.key}</span>
                        <span class="split">|</span>
                                            <span class="status">
                                                <c:choose>
                                                    <c:when test="${data.request.status.key == '已批准'}">
                                                        <span class="green"><i
                                                                class="icon-ok"></i> ${data.request.status.key}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${data.request.status.key}
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                        <span class="split">|</span>
                    </div>
                    <div>
                        <div class="attritutions">
                                                <span class="loan-attr">
                                                    金额：<span class="value red bold editable"
                                                             id="editableAmount"><fmt:formatNumber type="currency"
                                                                                                   maxFractionDigits="0"
                                                                                                   value="${data.request.amount}"/></span>
                                                    <span class="value lightGrey">
                                                        <c:choose>
                                                            <c:when test="${data.request.mortgaged}">
                                                                （有抵押）
                                                            </c:when>
                                                            <c:otherwise>
                                                                （无抵押）
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </span>，
                                                <span class="loan-attr">
                                                    年利率：<span class="value green bold editable"
                                                              id="editableRate"><fmt:formatNumber minFractionDigits="1"
                                                                                                  maxFractionDigits="1"
                                                                                                  value="${data.request.rate/10000}"
                                                                                                  type="percent"/></span>（${data.request.method.key}）
                                                </span>，
                                                <span class="loan-attr">
                                                    期限：<span class="value"><cm:durationString
                                                        duration="${data.request.duration}"/></span>（总利息：<span
                                                        class="value red bold"><fmt:formatNumber type="currency"
                                                                                                 maxFractionDigits="2"
                                                                                                 value="${data.detail.interest}"/></span>）
                                                </span>，
                                                <span class="loan-attr">
                                                    申请日期：<span class="value"><fmt:formatDate
                                                        value="${data.request.timeSubmit}"
                                                        pattern="yyyy年M月d日 HH:mm"/></span>
                                                </span>
                        </div>
                        <div class="description">
                            <div class="pull-left">贷款说明：</div>
                            <div class="pull-left">
                                ${data.request.description}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="span3">
                    <div class="pull-right text-left">
                        <div class="alert alert-info no-margin">
                            <div>信用等级：<span class="red bold">${data.userCredit.creditRank}</div>
                            </span>
                            <div>信用评分：<span class="red bold">${data.userCredit.score}</div>
                            </span>
                            <div>信用额度：<span class="value red bold"><fmt:formatNumber type="currency"
                                                                                     maxFractionDigits="0"
                                                                                     value="${data.userCredit.creditLimit}"/></span>
                            </div>
                            <div>可用额度：<span class="value red bold"><fmt:formatNumber type="currency"
                                                                                     maxFractionDigits="0"
                                                                                     value="${data.userCredit.creditAvailable}"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<div class="row-fluid credit-info-wp">
    <div class="pull-left" id="user" data-id="${data.user.id}">
        <a href="user/profile/${data.user.id}" target="_blank">
            <img class="avadar"
                 alt="user/${data.user.id}"
                 src="data:image/jpg;base64, ${data.avatar}">
        </a>
    </div>
    <div class="pull-left credit-score-box">
        <div class="input-prepend input-append pull-left no-margin-bottom">
                                <span class="add-on">
                                    <i class="icon-star blue"></i> <span id="certificateName"></span> 评分
                                </span>
            <input class="pingfen-input" type="text" placeholder="0"/>
                                <span class="add-on">
                                    <i class="icon-star orange"></i> <span id="certificateName"></span> 权重：<span
                                        id="typeWeight"></span>%<%--总得分：<span id="totalScore"></span>--%>
                                </span>
        </div>
        <div class="pull-left shenhetongguo">
            <label class="pull-left">
                <input name="shenhe-radio" value="true" type="radio" class="ace certificateStatusRadio"/>
                <span class="lbl"> 审核通过</span>
            </label>
            <label class="pull-left">
                <input name="shenhe-radio" value="false" type="radio" class="ace certificateStatusRadio"
                       checked/>
                <span class="lbl"> 不通过</span>
            </label>
            <input type="text" name="auditInfo" id="auditInfo"/>
        </div>
<!--         <cm:securityTag privilegeString="LOANREQUEST_ALTER"> -->
            <button class="btn btn-primary btn-small pull-right" id="updateCertificateBtn">保存修改</button>
<!--         </cm:securityTag> -->
    </div>
</div>

<div class="space-4"></div>

<div class="row-fluid credit-tags-wp">
    <div class="tabs-wrap">
        <div class="tabs-arrow tabs-arrow-left">
            <i class="icon-arrow-left"></i>
        </div>
        <div class="tabs-arrow tabs-arrow-right">
            <i class="icon-arrow-right"></i>
        </div>
        <div class="tabs-content reset-width">
            <ul class="nav nav-tabs" id="shenheList">
                <c:choose>
                    <c:when test="${data.user.enterprise == false && data.isLegalPerson == false}">
                        <c:forEach var="type" items="${CertificateType}">
                            <li data-type="${type.name()}" data-key="${type.key}" data-toggle="tooltip">
                                <a data-toggle="tab" href="#id_renzheng">
                                    <div>
                                        <span class="ctype">${type.key}</span>
                                        <span class="score"></span>
                                        <span class="status"></span>
                                    </div>
                                    <div class="documentCountLine">
                                                    <span><i class="icon-picture"></i> <span
                                                            class="picNum"></span></span>
                                                    <span><i class="icon-file-alt"></i> <span
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
                                    <span><i class="icon-picture"></i> <span class="picNum"></span></span>
                                    <span><i class="icon-file-alt"></i> <span class="docNum"></span></span>
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
                                    <span><i class="icon-picture"></i> <span class="picNum"></span></span>
                                    <span><i class="icon-file-alt"></i> <span class="docNum"></span></span>
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
                                                    <span><i class="icon-picture"></i> <span
                                                            class="picNum"></span></span>
                                                    <span><i class="icon-file-alt"></i> <span
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
    <div class="row-fluid">
        <div class="span7">
            <div class="tabbable tabs-left relative">
                <div class="tab-content" id="certificationContent">
                    <div id="id_renzheng" class="tab-pane in active">
                        <div class="row-fluid">
                            <div class="widget-box transparent">
                                <div class="widget-header widget-header-small">
                                    <h4 class="blue smaller">
                                        <i class="icon-briefcase"></i>
                                        认证图片
                                    </h4>
<!--                                     <cm:securityTag privilegeString="LOANREQUEST_ALTER"> -->
                                        <button class="btn btn-danger btn-mini pull-right"
                                                id="deleteImageBtn">
                                            <i class="icon-remove"></i> 删除图片
                                        </button>
                                        <button class="btn btn-primary btn-mini pull-right"
                                                id="setCoverBtn">
                                            <i class="icon-paper-clip"></i> 设为封面
                                        </button>
                                        <button class="btn btn-success btn-mini pull-right"
                                                data-toggle="modal" data-target="#cameraPanel"
                                                id="uploadWithCamera">
                                            <i class="icon-camera"></i> 拍照上传
                                        </button>
                                        <button class="btn btn-primary btn-mini pull-right"
                                                data-toggle="modal" data-target="#localFilePanel"
                                                id="uploadLocally">
                                            <i class="icon-upload-alt"></i> 本地上传
                                        </button>
<!--                                     </cm:securityTag> -->
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main">
                                        <div class="royalSlider rsDefault">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-box transparent" id="certificationDocuments">
                                <div class="widget-header widget-header-small">
                                    <h4 class="blue smaller">
                                        <i class="icon-briefcase"></i>
                                        认证材料
                                    </h4>
<!--                                     <cm:securityTag privilegeString="LOANREQUEST_ALTER"> -->
                                        <button class="btn btn-primary btn-mini pull-right"
                                                data-toggle="modal" data-target="#uploadFilePanel"
                                                id="uploadDocument">
                                            <i class="icon-upload-alt"></i> 上传材料
                                        </button>
<!--                                     </cm:securityTag> -->
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main">
                                        <div class="profile-feed" id="fileContainer"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="span5">
            <div class="tabbable" id="approvalIploadTabs">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a data-toggle="tab" href="#id_activity">
                            <i class="icon-th-list"></i>
                            审批流程
                        </a>
                    </li>
                    <li>
                        <a data-toggle="tab" href="#id_proof_history">
                            <i class="icon-th-list"></i>
                            上传记录
                        </a>
                    </li>
                    <li class="<c:if test="${data.request.purpose != 'CAR'}">hidden</c:if>">
                    <a data-toggle="tab" href="#car_infomation">
                        <i class="icon-truck"></i>
                        车辆信息
                    </a>
                    </li>
                </ul>
                <div class="tab-content no-border no-padding-left no-padding-right">
                    <div id="id_activity" class="tab-pane in active">
                        <div id="approvalHistory" class="profile-feed">
                            <c:forEach var="activity" items="${data.activitys}">
                                <div class="profile-activity clearfix">
                                    <div>
                                        <c:choose>
                                            <c:when test="${activity.performerName != '用户本人'}">
                                                <a href="employee/profile/${activity.performerId}"
                                                   target="_blank">${activity.performerName}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="user/profile/${data.user.id}"
                                                   target="_blank">${data.activity.performerName}</a>
                                            </c:otherwise>
                                        </c:choose>
                                        ${activity.type.key} <span
                                            class="blue">${activity.description}</span>

                                        <div class="time">
                                            <i class="icon-time bigger-110"></i>
                                            <fmt:formatDate value="${activity.timeRecorded}"
                                                            pattern="yyyy年M月d日 HH:mm"/>
                                        </div>
                                    </div>
                                    <%--
                                    <div class="tools action-buttons">
                                        <a href="#" class="blue">
                                            <i class="icon-pencil bigger-125"></i>
                                        </a>
                                        <a href="#" class="red">
                                            <i class="icon-remove bigger-125"></i>
                                        </a>
                                    </div>
                                    --%>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div id="id_proof_history" class="tab-pane in">
                        <div id="uploadHistory" class="profile-feed">
                            <c:forEach var="item" items="${data.proofHistory}">
                                <div class="profile-activity clearfix">
                                    <div>
                                        <c:forEach var="proofExt" items="${item.value}">
                                            <c:choose>
                                                <c:when test="${!empty(proofExt.proof.employee)}">
                                                    <a href="employee/profile/${proofExt.proof.employee}"
                                                       target="_blank">${proofExt.uploader}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="user/profile/${data.user.id}"
                                                       target="_blank">${proofExt.uploader}</a>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${proofExt.proof.contentType == 'IMAGE'}">
                                                    上传了图片
                                                </c:when>
                                                <c:otherwise>
                                                    上传了文档
                                                </c:otherwise>
                                            </c:choose>
                                            <a href="${proofExt.uri}">${proofExt.proof.content}</a>

                                            <div class="time">
                                                <i class="icon-time bigger-110"></i>
                                                <fmt:formatDate value="${proofExt.proof.submitTime}"
                                                                pattern="yyyy年M月d日 HH:mm"/>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <%--
                                    <div class="tools action-buttons">
                                        <a href="#" class="blue">
                                            <i class="icon-pencil bigger-125"></i>
                                        </a>

                                        <a href="#" class="red">
                                            <i class="icon-remove bigger-125"></i>
                                        </a>
                                    </div>
                                    --%>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div id="car_infomation" class="tab-pane">
                        <div id="carInformation" class="profile-feed">
                            <c:choose>
                                <c:when test="${data.vehicle != null}">
                                    <div class="profile-activity clearfix">
                                        <label for="">车辆品牌</label>
                                        <input type="text" name="brand" placeholder="车辆品牌"
                                               value="${data.vehicle.brand}"/>
                                        <span class="errorText red">车辆品牌不可为空</span>
                                    </div>
                                    <div class="profile-activity clearfix">
                                        <label for="">车辆型号</label>
                                        <input type="text" name="model" placeholder="车辆型号"
                                               value="${data.vehicle.model}"/>
                                        <span class="errorText red">车辆型号不可为空</span>
                                    </div>
                                    <div class="profile-activity clearfix">
                                        <label for="">车辆类型</label>
                                        <select name="type" id="">
                                            <c:forEach var="ctype" items="${VehicleType}">
                                                <option value="${ctype}"
                                                <c:if test="${data.vehicle.type == ctype}">selected</c:if>>${ctype.key}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="profile-activity clearfix">
                                        <label for="">行驶证号码</label>
                                        <input type="text" name="vehicleLicense" placeholder="行驶证号码"
                                               value="${data.vehicle.vehicleLicense}"/>
                                        <span class="errorText red">行驶证号码不可为空</span>
                                    </div>
                                    <div class="profile-activity clearfix">
                                        <label for="">车牌号码</label>
                                        <input type="text" name="plateNumber" placeholder="车牌号码"
                                               value="${data.vehicle.plateNumber}"/>
                                        <span class="errorText red">车牌号码不可为空</span>
                                    </div>
                                    <div class="profile-activity clearfix">
                                        <label for="">购车年月份</label>
                                        <input type="text" name="yearOfPurchase" placeholder="201201"
                                               value="${data.vehicle.yearOfPurchase}"/>
                                        <span class="errorText red">购车年月份不可为空</span>
                                    </div>
                                    <div class="profile-activity clearfix">
                                        <label for="">购车价格</label>
                                        <input type="text" name="priceOfPurchase" placeholder="购车价格"
                                               value="${data.vehicle.priceOfPurchase}"/>
                                        <span class="errorText red">购车价格不可为空</span>
                                    </div>
                                    <div class="profile-activity clearfix">
                                        <label for="">行驶里程(公里)</label>
                                        <input type="text" name="mileage" placeholder="行驶里程（公里）"
                                               value="${data.vehicle.mileage}"/>
                                        <span class="errorText red">行车里程不可为空</span>
                                    </div>
                                    <div class="profile-activity clearfix">
                                        <label for="">车辆性质</label>
                                        <input type="radio" name="operating"
                                        <c:if test="${!data.vehicle.operating}">checked</c:if>
                                        value="false"/> 非运营
                                        <input type="radio" name="operating"
                                        <c:if test="${data.vehicle.operating}">checked</c:if> value="true"/>
                                        运营
                                    </div>
                                    <div class="profile-activity clearfix">
                                        <label for="">车辆估值</label>
                                        <input type="text" name="estimatedValue" placeholder="车辆估值"
                                               value="${data.vehicle.estimatedValue}"/>
                                        <span class="errorText red">车辆估值不可为空</span>
                                    </div>
                                    <div class="clearfix">
                                        <input type="hidden" value="${SessionUtils.employee.id}" name="employeeId"/>
                                        <input type="hidden" value="${data.vehicle.id}" name="vehicleId"/>
                                        <button class="btn btn-small btn-primary" id="saveVehicleBtn"><i
                                                class="icon-ok"></i> 保存
                                        </button>
                                    </div>
                        </div>
                        </c:when>
                        <c:otherwise>
                            <div class="profile-activity clearfix">
                                <label for="">车辆品牌</label>
                                <input type="text" name="brand" placeholder="车辆品牌" value=""/>
                                <span class="errorText red">车辆品牌不可为空</span>
                            </div>
                            <div class="profile-activity clearfix">
                                <label for="">车辆型号</label>
                                <input type="text" name="model" placeholder="车辆型号" value=""/>
                                <span class="errorText red">车辆型号不可为空</span>
                            </div>
                            <div class="profile-activity clearfix">
                                <label for="">车辆类型</label>
                                <select name="type" id="">
                                    <c:forEach var="ctype" items="${VehicleType}">
                                        <option value="${ctype}">${ctype.key}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="profile-activity clearfix">
                                <label for="">行驶证号码</label>
                                <input type="text" name="vehicleLicense" placeholder="行驶证号码"/>
                                <span class="errorText red">行驶证号码不可为空</span>
                            </div>
                            <div class="profile-activity clearfix">
                                <label for="">车牌号码</label>
                                <input type="text" name="plateNumber" placeholder="车牌号码"/>
                                <span class="errorText red">车牌号码不可为空</span>
                            </div>
                            <div class="profile-activity clearfix">
                                <label for="">购车年月份</label>
                                <input type="text" name="yearOfPurchase" placeholder="201201"/>
                                <span class="errorText red">购车年月份不可为空</span>
                            </div>
                            <div class="profile-activity clearfix">
                                <label for="">购车价格</label>
                                <input type="text" name="priceOfPurchase" placeholder="购车价格"/>
                                <span class="errorText red">购车价格不可为空</span>
                            </div>
                            <div class="profile-activity clearfix">
                                <label for="">行驶里程(公里)</label>
                                <input type="text" name="mileage" placeholder="行驶里程（公里）"/>
                                <span class="errorText red">行车里程不可为空</span>
                            </div>
                            <div class="profile-activity clearfix">
                                <label for="">车辆性质</label>
                                <input type="radio" name="operating" checked value="false"/> 非运营
                                <input type="radio" name="operating" value="true"/> 运营
                            </div>
                            <div class="profile-activity clearfix">
                                <label for="">车辆估值</label>
                                <input type="text" name="estimatedValue" placeholder="车辆估值"/>
                                <span class="errorText red">车辆估值不可为空</span>
                            </div>
                            <div class="clearfix">
                                <input type="hidden" value="${SessionUtils.employee.id}" name="employeeId"/>
                                <input type="hidden" value="" name="vehicleId"/>
                                <button class="btn btn-small btn-primary" id="saveVehicleBtn"><i
                                        class="icon-ok"></i> 保存
                                </button>
                            </div>
                        </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="space-20"></div>
<!-- <cm:securityTag privilegeString="LOANREQUEST_APPROVE,LOANREQUEST_REJECT"> -->
    <div class="row-fluid">
        <div class="span12">
            <div class="widget-box transparent">
                <div class="widget-header widget-header-small">
                    <h4 class="blue smaller">
                        <i class="icon-legal"></i>
                        借款申请评审
                    </h4>
                </div>
                <div class="widget-body">
                    <c:choose>
                        <c:when test="${data.request.status.key == '已批准'}">
                            <div class="space-10"></div>
                            <div class="alert alert-block alert-success successMessage">
                                <i class="icon-ok bigger-130 green"></i>
                                本申请已经被批准！
                            </div>
                        </c:when>
                        <c:when test="${data.request.status.key == '已驳回'}">
                            <div class="space-10"></div>
                            <div class="alert alert-block alert-error">
                                <i class="icon-remove bigger-130 red"></i>
                                本申请已经被驳回！
                            </div>
                        </c:when>
                        <c:when test="${data.request.status.key == '已发放'}">
                            <div class="space-10"></div>
                            <div class="alert alert-block alert-success successMessage">
                                <i class="icon-ok bigger-130 green"></i>
                                申请通过，贷款已经成功发放！
                            </div>
                        </c:when>
                        <c:otherwise>
                            <form id="approvalForm" method="POST">
                                <div class="form-actions">
                                                <textarea name="loanReqApprovalComment" id="loanReqApprovalComment"
                                                          placeHolder="请输入您的评论..."></textarea>

                                    <div class="pull-right">
                                        <cm:securityTag privilegeString="LOANREQUEST_APPROVE">
                                            <label class="checkbox"
                                                   style="padding: 10px; display: inline-block;">
                                                <input class="ace-checkbox-2" type="checkbox"
                                                       name="publishNow">
                                                <span class="lbl"> 立即发布</span>
                                            </label>
                                            <button type="button" onclick="submitForm(1);" id="submitReqBtn"
                                                    class="btn btn-primary">
                                                <i class="icon-ok bigger-140"></i>
                                                批准申请
                                            </button>
                                        </cm:securityTag>
                                        &nbsp;
                                        <cm:securityTag privilegeString="LOANREQUEST_REJECT">
                                            <button type="button" onclick="submitForm(0);" id="submitReqBtn"
                                                    class="btn btn-danger">
                                                <i class="icon-remove bigger-140"></i>
                                                拒绝申请
                                            </button>
                                        </cm:securityTag>
                                    </div>
                                </div>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
<!-- </cm:securityTag> -->
<!--
////////////////////////////////////////////////////////////////////////////////
上传材料弹出层
////////////////////////////////////////////////////////////////////////////////
-->
<div id="uploadFilePanel" class="modal hide fade">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                onclick="$('#uploadFilePanel').get(0).reset();">&times;</button>
        <h3><i class="icon-upload-alt"></i> 上传材料</h3>
    </div>
    <div class="modal-body relative">
        <form class="form-horizontal" id="upf">
            <input multiple="" type="file" id="uploadFileInput" name="uploadFileInput"/>

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

<!--
////////////////////////////////////////////////////////////////////////////////
本地上传照片弹出层
////////////////////////////////////////////////////////////////////////////////
-->
<div id="localFilePanel" class="modal hide fade">
    <div class="modal-header">
        <h3><i class="icon-upload-alt"></i> 上传图片</h3>
    </div>
    <div class="modal-body relative">
        <form class="form-horizontal" id="upf">
            <input multiple="" type="file" id="uploadImageLocalInput" name="uploadImageLocalInput"/>

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

<!--
////////////////////////////////////////////////////////////////////////////////
拍照上传弹出层
////////////////////////////////////////////////////////////////////////////////
-->
<div id="cameraPanel" class="modal hide fade">
    <div class="modal-header">
        <h3><i class="icon-cloud-upload"></i> 上传图片</h3>
    </div>
    <div class="modal-body relative">
        <div class="camera">
            <div id="step1">
                <div id="captureBtn" class="form-actions hide">
                    <button id="snapImage" class="btn btn-danger"><i class="icon-camera bigger-110"></i> 拍照</button>
                </div>
                <div id="videoContainer" class="center-align">
                    <video autoplay="false" id="video"></video>
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
                            <input class="certificateType" value="${type.key}" type="checkbox" name="certificateType"
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
</body>
</html>

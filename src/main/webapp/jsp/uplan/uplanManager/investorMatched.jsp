<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <title>出借匹配详情页</title>
  <%@include file="../../common/head.jspf" %>
<link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
<link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
</head>
<body class="navbar-fixed">
<%@include file="../../common/navbar.jspf" %>
<div class="container-fluid main-container" id="main-container">
	<div class="page-container">
	<%@include file="../../common/sidebar.jspf" %>
		<div class="page-content">
			<div class="page-breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="fa fa-home"></i>
                        <a href="/">首页</a>
                    </li>
                    <li class="active">借款列表</li>
                    <li class="active">出借详情页</li>
                </ul>
          	</div>
          	<!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>  出借详情页  </h1>
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

			<div class="page-body">
				<div id="page-content" class="">
					<div class="tabbable">
        				<div class="tab-content no-border no-padding">          
							<div class="row">	
								<div class="col-lg-12" id="yonghu">
									<div class="widget-header bordered-bottom bordered-sky blue">
										<i class="fa fa-file-text-o widget-caption Font-16 MargR-10"></i>
										<span class="widget-caption Font-16">出借信息</span>										
									</div>
									<div class="widget-body">
										<div class="widget-main">
											<div class="profile-user-info">
												<div class="profile-info-row">
													<div class="profile-info-name">订单号：</div>
													<div class="profile-info-value"> ${invest.orderId}</div>
												</div>
												<div class="profile-info-row">
													<div class="profile-info-name">投标账号：</div>
													<div class="profile-info-value">${card.withdrawBankCard}</div>
												</div>
												<div class="profile-info-row">
													<div class="profile-info-name">投标人：</div>
													<div class="profile-info-value"><a href="/user/profile/?userId=${user.userId}">${user.loginName}</a></div>
												</div>
												<div class="profile-info-row">
													<div class="profile-info-name">真实姓名：</div>
													<div class="profile-info-value">${card.userName}</div>
												</div>
												<div class="profile-info-row">
													<div class="profile-info-name">投标时间：</div>
													<div class="profile-info-value"><fmt:formatDate value="${invest.submitTime}" pattern="yyyy-MM-dd HH:mm"/></div>
												</div>
												<div class="profile-info-row">
													<div class="profile-info-name">投标金额：</div>
													<div class="profile-info-value">￥${invest.amount}</div>
												</div>
												<div class="profile-info-row">
													<div class="profile-info-name">投标方式：</div>
													<div class="profile-info-value">手动投标</div>
												</div>
											</div>
											<div class="row-fluid" style="display:none">
												<div class="span6">
												<div class="profile-user-info">
													<div class="profile-info-row">
													<span>订单号：${invest.orderId}</span><br/>
													<span>投标账号:${card.withdrawBankCard}</span><br/>
													<span>投标人：${user.loginName}</span><br/>
													<span>真实姓名:${user.userName}</span><br/>
													<span>投标金额:${invest.amount}</span><br/>
													<span>投标时间:<fmt:formatDate value="${invest.submitTime}" pattern="yyyy-MM-dd HH:mm"/></span><br/>
													<span>投标方式：手动投标</span>
													</div>
												</div>
												</div>
											</div>
										</div>
											
									</div>		
								</div>	
							</div>          
  
							<div class="row MargT-20">
								<div class="col-lg-12 col-sm-12 col-xs-12">
									<div class="widget-header bordered-bottom bordered-sky blue">
										<i class="fa fa-list widget-caption Font-16 MargR-10"></i>
										<span class="widget-caption Font-16">既有债权列表</span>
										
									</div>		    
									<div class="widget-body">
										<div class="widget-main no-padding">
											<table class="table table-hover dataTable no-footer" id="Untreated_accounts">
												<thead>
													<tr>
														<th>序号</th>
														<th>借款人姓名</th>
														<th>身份证号</th>
														<th>还款日期</th>
														<th>职业状况</th>
														<th>借款用途</th>
														<th>借款金额</th>
														<th>年化利率</th>
														<th>期限（天）</th>
							
													</tr>
												</thead>
												<tbody>
													<c:if test="${!empty loanList}">
														<c:set var="index" value="0"/>
														<c:forEach  var="creditor" items="${loanList}" >
							                            <tr>
							                              <td>${index=index+1}</td>
							                              <td>${creditor.loanerName}</td>
							                              <td>${creditor.loanerCardNo}</td>
							                              <td><fmt:formatDate value="${creditor.loanEndDate}" pattern="yyyy/MM/dd"/> </td>
							                              <td>${creditor.loanerProfession.key}</td>
							                              <td>${creditor.loanerPurpose.key}</td>
							                              <td>￥${creditor.amount}</td>
							                              <td>${creditor.loanRate/100}%</td>
							                              <td>${creditor.loanTimeLimit}</td>
							                            </tr>
														</c:forEach>
													</c:if>
							                	</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							 
							<div id="investHistory" class="tab-pane">
					          	<div class="widget-box transparent">
					            	<div class="widget-header widget-header-flat" id="toubiaojilu"></div>
								</div>
							</div>

            			</div>
          			</div>    
				</div>
			</div>
		</div>
	</div>
</div>
<%-- <%@include file="../../common/alert.jspf" %> --%>
<%@include file="../../common/foot.jspf" %>
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/amountFormat.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/uplan/uplanManager/planDetail.js" type="text/javascript"></script>
</body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<title>${uplan.productName}</title>
<%@include file="../../common/head.jspf"%>
<link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
<link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
</head>
<body class="navbar-fixed">
	<%@include file="../../common/navbar.jspf"%>
	<div class="main-container container-fluid">
		<!-- Page Container start-->
		<div class="page-container">
			<%@include file="../../common/sidebar.jspf"%>
			<!-- Page Content -->
			<div class="page-content">
				<!-- Page Breadcrumb -->
				<div class="page-breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="fa fa-home"></i> <a href="/">首页</a></li>
						<li class="active">产品管理</li>
						<li class="active">优选计划</li>
					</ul>
				</div>
				<!-- /Page Breadcrumb -->
				<!-- Page Body -->
				<div class="page-body">
					<div class="well uplanDetail">
						<!-- 菜单 -->
						<ul class="nav nav-pills" id="loanTabs">
							<c:choose>
								<c:when test="${opType == 'showInvestHistory'}">
									<li class="btn-sm"><a data-toggle="tab" href="#loanInfo">借款信息</a></li>
									<li class="btn-sm active"><a data-toggle="tab"
										href="#investHistory" id="a_investHistory">投资记录</a></li>
								</c:when>
								<c:otherwise>
									<li class="btn-sm active"><a data-toggle="tab"
										href="#loanInfo">借款信息</a></li>
									<li class="btn-sm"><a data-toggle="tab"
										href="#investHistory" id="a_investHistory">投资记录</a></li>
								</c:otherwise>
							</c:choose>
							<li class="btn-sm"><a data-toggle="tab"
								href="#creditorMatching" id="a_creditorMatching">债权匹配</a></li>
							<li class="btn-sm"><a data-toggle="tab"
								href="#creditorMatched" id="a_creditorMatched">投资与匹配</a></li>
						</ul>
						<hr class="wide">
						<input type="hidden" name="opType" id="opType" value="${opType}"/>
						<div class="tab-content no-border no-padding">
							<c:if test="${opType == 'showInvestHistory'}">
								<div id="loanInfo" class="tab-pane">
							</c:if>
							<c:if test="${opType != 'showInvestHistory'}">
								<div id="loanInfo" class="tab-pane active">
							</c:if>
							<div class="widget">
								<div class="widget-header">
									<i
										class="widget-icon fa fa-file-text-o blue Line-Height-36  Font-15"></i>
									<span class="widget-caption blue Font-16">借款信息 </span>

									<div class="widget-buttons">
										<a href="#" data-toggle="collapse"> <i
											class="fa fa-minus blue"></i>
										</a>
									</div>
									<!--Widget Buttons-->
								</div>
								
								<!--Widget Header-->
								<div class="widget-body Loan-Info" style="display: block;">
									<h4 class="lighter">
										<i class="icon-list-alt bigger-100"></i>计划信息 <span
											class="hsplitor">|</span> <small> <span class="split">&nbsp;|&nbsp;</span>
											<span>最小投资额：<span class="value red bold"><fmt:formatNumber
														type="currency" maxFractionDigits="2"
														value="${uplan.minAmount}" /></span>，
										</span> <span>最大投资额：<span class="value red bold"><fmt:formatNumber
														type="currency" maxFractionDigits="2"
														value="${uplan.maxAmount}" /></span>，
										</span> <span>投资增量：<span class="value red bold"><fmt:formatNumber
														type="currency" maxFractionDigits="2"
														value="${uplan.increaseNum}" /></span></span>
										</small>
									</h4>
									<div class="Loan-Info-con">
										<div class="F-left col-md-6">
											<dl>
												<dt>产品名称：</dt>
												<dd>
													<span class="s-title">${uplan.productName}</span> <a
														href="javascript:;" class="bootbox-regular" id="loanTitle"
														data-id="${uplan.id}"><i class="fa fa-edit"></i> 修改</a>
												</dd>
											</dl>
											<dl>
												<dt>借款金额：</dt>
												<dd id="loanAmount" data-amount="${uplan.amount}">
													<fmt:formatNumber type="currency" maxFractionDigits="2"
														value="${uplan.amount}" />
													<small id="amountToChinese" class="grey"></small>
												</dd>
											</dl>
											<dl>
												<dt>还款时间：</dt>
												<dd>
													<fmt:formatDate value="${uplan.repaymentDate}"
														pattern="yy年 M月d日" />
												</dd>
											</dl>
											<dl>
												<dt>年化利率：</dt>
												<dd>${uplan.rate/100}%</dd>
											</dl>
											<dl>
												<dt>候补年化利率：</dt>
												<dd>${uplan.rateAdd==null? 0:uplan.rateAdd/100}%</dd>
											</dl>
											<dl>
												<dt>还款方式：</dt>
												<dd>${uplan.repaymentType.key}</dd>
											</dl>
											<dl>
												<dt>保障类型：</dt>
												<dd>${uplan.guaranteeType.key}</dd>
											</dl>
											<c:if test="${uplan.status eq 'UNPUBLISHED'}">
												操作：<button type="button" class="btn btn-grey"
													onclick="publishUplanByLoanId('${uplan.id}')">立即发布</button>
											</c:if>
										</div>
										<div class="F-right col-md-6">
											<dl>
												<dt>借款状态：</dt>
												<dd>
													<i class="fa fa-check green"></i> ${uplan.status.key}
												</dd>
											</dl>
											<dl>
												<dt>投标进度：</dt>
												<dd>
													<div class="progress progress-striped active">
														<div class="progress-bar progress-bar-success"
															role="progressbar" aria-valuenow="${uplan.progress}"
															aria-valuemin="0" aria-valuemax="100"
															style="width: ${uplan.progress*100}%">
															<span> ${uplan.progress*100}%</span>
															<span class="sr-only"> ${uplan.progress*100} </span>
														</div>
													</div>
												</dd>
											</dl>
											<dl>
												<dt>剩余额度：</dt>
												<dd>
													<fmt:formatNumber type="currency" maxFractionDigits="2" value="${uplan.remainAmount}" />
												</dd>
											</dl>
											<dl>
												<dt>投标数：</dt>
												<dd>${uplan.bidNumbers}</dd>
											</dl>
											<input type='hidden' id='investEndDate' value='${uplan.investEndDate}'/>
											<dl>
												<dt>开标时间：</dt>
												<dd>
													<fmt:formatDate value="${uplan.openTime}"
														pattern="yy年 M月d日    hh:mm" />
												</dd>
											</dl>
											<dl>
												<dt>满标时间：</dt>
												<dd>
													<c:if test="${uplan.finishedTime != null}">
														<fmt:formatDate value="${uplan.finishedTime}"
															pattern="yy年 M月d日" />
													</c:if>
												</dd>
											</dl>
											<dl>
												<dt>结标时间：</dt>
												<dd>
													<c:if test="${uplan.settledTime != null}">
														<fmt:formatDate value="${uplan.settledTime}"
															pattern="yy年 M月d日" />
													</c:if>
												</dd>
											</dl>
											<div class="buttons-preview">
											<c:if test="${uplan.status eq 'UNPUBLISHED'}">
												立即修改：<!-- <button type="button" class="btn btn-grey" >立即修改</button> -->
												<a class="btn btn-mini btn-success" href="/uplan/update/${uplan.id}"><i class="fa fa-check"></i>立即修改</a>
											</c:if>
										</div>
										</div>
										<br>
									</div>
								</div>
							</div>
							<div class="widget-box transparent">
								<div class="widget-header">
									<i
										class="widget-icon fa fa-file-text-o blue Line-Height-36  Font-15"></i>
									<span class="widget-caption blue Font-16"><c:if
											test="${incomeList!= null}">
                                            还款计划 <span class="hsplitor">|</span>
										</c:if></span>
								</div>

								<div class="widget-body">
									<div class="widget-main no-padding">
										<c:if test="${incomeList != null}">
											<h5 style="font-weight:400!important">
												还款时间：
												<fmt:formatDate value="${repayTime}" pattern="yyyy 年 M月 d日" />
											</h5>
											<table class="table table-hover dataTable no-footer">
												<thead>
													<tr>
														<th><i class="icon-time blue"></i> 借款人</th>
														<th><i class="icon-caret-gift blue"></i> 还款金额</th>
														<th><i class="icon-caret-right blue"></i> 偿还本金</th>
														<th class="hidden-phone"><i
															class="icon-caret-right blue"></i> 偿还利息</th>
														<th class="hidden-phone"><i
															class="icon-caret-right blue"></i> 剩余本金</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="income" items="${incomeList}">
														<tr>
															<td>${income.loaner}</td>
															<td><fmt:formatNumber type="currency" maxFractionDigits="2" value="${income.incomeAmount}" /></td>
															<td><fmt:formatNumber type="currency" maxFractionDigits="2" value="${income.repayPrincipal}" /></td>
															<td><fmt:formatNumber type="currency" maxFractionDigits="2" value="${income.repayInterest}" /></td>
															<td><fmt:formatNumber type="currency" maxFractionDigits="2" value="${income.remainAmount}" /></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</c:if>
									</div>
								</div>
							</div>
						</div>
						<!-- 投资记录 -->
						<c:choose>
							<c:when test="${opType == 'showInvestHistory'}">
								<div id="investHistory" class="tab-pane active">
							</c:when>
							<c:otherwise>
								<div id="investHistory" class="tab-pane">
							</c:otherwise>
						</c:choose>

								<div class="table-toolbar">
									<div id="investRecordHistory"
										style="padding-bottom: 15px; height: 30px;">
										<div class="control-group pull-right">
											<button class="btn btn-small btn-primary"
												id="searchRechargeHistory">查询</button>
											<a class="btn btn-small btn-danger downloadLink"
												id="downloadHistoryBtn" href="javascript:void(0)">全部下载 </a> <a
												class="btn btn-small btn-danger downloadLink"
												id="downloadHistoryBtn1" href="javascript:void(0)">批量下载 </a>
										</div>
										<div class="control-group  pull-right">
											<label for="date-range-picker" class="control-label pull-left"
												style="width: 100px; line-height: 30px;">投资日期范围</label>
		
											<div class="controls pull-left"
												style="width: 180px; margin-right: 15px;">
												<div class="input-group">
													<span class="input-group-addon"> <i class="fa fa-calendar"></i>
													</span> <input type="text" name="date-range-picker"
														id="date-range-picker"
														class="form-control investRecordRange" />
												</div>
											</div>
										</div>
									</div>
									<div class="row">&nbsp;</div>
									<div class="scrollWrapper">
										<table
											class="table table-striped table-hover dataTable no-footer"
											id="investRecordTable" aria-describedby="simpledatatable_info">
											<thead id="list_tb" class="bordered-blue">
												<tr>
													<th><div class="checkbox">
															<label><input id="cb_checkall" type="checkbox" /><span
																class="text">序号</span></label>
														</div></th>
													<th><i class="icon-user"></i>订单号</th>
													<th><i class="icon-user"></i> 投标人</th>
													<th><i class="icon-user"></i> 真实姓名</th>
													<th><i class="icon-yen"></i> 投标金额</th>
													<th><i class="icon-asterisk"></i> 投标方式</th>
													<th><i class="icon-time"></i> 投标时间</th>
													<th>投标状态</th>
													<th>计息时间</th>
													<th>债权/通知单</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
											<tr class="investCalculation">
												<td colspan="3" class="text-align-right bold size-16">合计</td>
												<td colspan="5" id="totalAmountTd"
													class="red bold size-16"><fmt:formatNumber type="currency" maxFractionDigits="2" value="${sumInvestAmount}" />元</td>
											</tr>
										</table>
									</div>
								</div>
							</div>

							<!--债权匹配 -->
							<div id="creditorMatching" class="tab-pane">

								<h4>债权包状态</h4>
								<div id="uplanPackage">
									<table id="lonalist_tab"
										class="table table-hover dataTable no-footer">
										<thead >
											<th>序号</th>
											<th>借款人</th>
											<th>身份证号</th>
											<th>还款日期</th>
											<th>借款人职业</th>
											<th>用途</th>
											<th>原始价值</th>
											<th>可用价值</th>
											<th>借款期限</th>
											<th>年化利率</th>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${empty loanList}">
												</c:when>
												<c:otherwise>
													<c:set var="index" value="0"></c:set>
													<c:forEach var="loan" items="${loanList}">
														<tr id="tr_${loan.loanId}">
															<td>${index=index+1}</td>
															<td>${loan.loanerName}</td>
															<td>${loan.loanerCardNo}</td>
															<td><fmt:formatDate value="${loan.loanEndDate}"
																	pattern="yyyy年MM月dd日" /></td>
															<td>${loan.loanerProfession.key}</td>
															<td>${loan.loanerPurpose.key}</td>
															<td><fmt:formatNumber type="currency" maxFractionDigits="2" value="${loan.amount}" /></td>
															<td><fmt:formatNumber type="currency" maxFractionDigits="2" value="${loan.remainAmount}" /></td>
															<td>${loan.loanTimeLimit}天</td>
															<td>${loan.loanRate/100}%</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
							</div>

							<!-- 投资与匹配-->
							<div id="creditorMatched" class="tab-pane"
								ng-controller="creditorMatched">
								<table id="investRecordsMatched_table"
									class="table table-hover dataTable no-footer">
									<thead>
										<tr>
											<th>序号</th>
											<th>订单号</th>
											<th>投标人</th>
											<th>真实姓名</th>
											<th>金额</th>
											<th>投标时间</th>
											<th>状态</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="cc-alert-bg hide" id="editLoanTitlePanel">
		<div class="cc-alert-content">
			<div class="cc-alert-head">
				<h4>
					<i class="icon-edit"></i> 借款标题修改
				</h4>
			</div>
			<h4 class="cc-alert-info">
				<input type="text" id="editLoanTitleInput"
					value="${uplan.productName}" />
			</h4>

			<div class="cc-alert-actions">
				<button class="btn btn-primary btn-normal" id="doEditLoanTitle">确定</button>
				<button class="btn btn-normal" id="cancelEditLoanTitle">取消</button>
			</div>
		</div>
	</div>
	<script id="showSingleInvestInfo-template" class="modal fade matchCreditModal bs-example-modal-lg  in" tabindex="-1" type="text/x-handlebars-template">
<div id="page-content" class="clearfix">
	<div class="row" style="">
	<div class="col-lg-12 col-sm-12 col-xs-12">
		<div class="widget">
		
			<div class="widget-header">						
				<span class="widget-caption blue Font-16">{{invest.investNo}}  </span>							
				<div class="widget-buttons">										
					<a href="#" data-toggle="collapse">
						<!-- <i class="fa fa-minus blue"></i> -->
					</a>										
				</div>
			</div>
			<div class="widget-body Loan-Info" style="display: block; overflow:hidden;line-height:36px;">
				<div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">投资金额：{{formatAmount invest.amount}}</div>
				<div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">投资时间：{{formatdata invest.submitTime}}</div>
				<div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">年化利率：{{formatRate invest.planRate}}</div>
				<div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">计划名称：{{invest.planTitle}}</div>
				<div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">
				<c:choose>
					<c:when test="{{invest.status == 'REMATCHING'}}">
					</c:when>
					<c:otherwise>
					计息时间：{{formatdata invest.countRateDate}}
					</c:otherwise>
				</c:choose>
				</div>
				<div class="widget-toolbar col-lg-4 col-sm-4 col-xs-4">投资状态：{{invest.statusKey}}</div>	
			</div>			
		</div>
	</div>
	</div>
	
	<div class="row" style="">
	<div class="col-lg-12 col-sm-12 col-xs-12">
        <div class="widget">
			<div class="widget-header">						
				<span class="widget-caption blue Font-16">投资债权列表  </span>							
				<div class="widget-buttons">										
					<a href="#" data-toggle="collapse">
					</a>										
				</div>
			</div>
			<div class="tab-pane" ng-controller="creditorMatched">
				<table id="commonDataTable" class="table table-hover dataTable no-footer">
					<thead>
						<tr>
							<th>借款人姓名</th>
							<th>借款人身份证号</th>
							<th>还款日期</th>
							<th>借款人职业情况</th>
							<th>借款用途</th>
							<th>借款金额/转让金额</th>
						</tr>
					</thead>
				<tbody>
					{{#each loanList}}
						<tr>
							<th>{{this.uplanLoan.loanerName}}</th>
							<th>{{this.uplanLoan.loanerCardNo}}</th>
							<th>{{formatdata this.uplanLoan.loanEndDate}}</th>
							<th>{{this.uplanLoan.loanerProfessionKey}}</th>
							<th>{{this.uplanLoan.loanerPurposeKey}}</th>
							<th>{{formatAmount this.uplanIncome.repayPrincipal}}</th>
						</tr>
					{{else}}
  						<tr>没有数据</tr>
					{{/each}}
				</tbody>
			</table>
		</div>
        </div>
	</div>
    </div>
</div>
</script>
<%@include file="../../common/foot.jspf"%>
<!--Page Related Scripts-->

<script src="/assets/js/datetime/daterangepicker.min.js"></script>
<script src="/assets/js/datetime/moment.js"></script>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<title>千金所测试平台</title>
<meta name="description" content="千金所测试平台管理系统" />
<%@include file="../../common/head.jspf"%>
    <link rel="stylesheet" href="/assets/css/uplan/newPlan.css"/>
    <link rel="stylesheet" href="/assets/css/dataTables.bootstrap.css"/>
</head>
<body>
	<%@include file="../../common/navbar.jspf"%>
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
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
						<li class="active">债权资源管理</li>
					</ul>
				</div>
				<!-- /Page Breadcrumb -->
				<!-- Page Header -->
				<div class="page-header position-relative">
					<div class="header-title">
						<h1>债权资源管理</h1>
					</div>
					<!--Header Buttons-->
					<div class="header-buttons">
						<a class="sidebar-toggler" href="#"> <i class="fa fa-arrows-h"></i>
						</a> <a class="refresh" id="refresh-toggler" href=""> <i
							class="glyphicon glyphicon-refresh"></i>
						</a> <a class="fullscreen" id="fullscreen-toggler" href="#"> <i
							class="glyphicon glyphicon-fullscreen"></i>
						</a>
					</div>
					<!--Header Buttons End-->
				</div>
				<!-- /Page Header -->
				<!-- Page Body -->
				<div class="page-body">
					<div class="well">
						<div class="table-toolbar">
							<cm:securityTag privilegeString="UPLANLOAN_CREDITLIST">
								<a onclick="addInvertInfo()" 
									href="javascript:void(0);" class="btn btn-default"> <i
									class="fa fa-plus"></i> 新增债权
								</a> <a onclick="uploadCreditorInfo()" data-toggle="modal"
									href="javascript:void(0);" class="btn btn-default"> <i
									class="fa fa-upload"></i> 上传本地债权
	                            </a>
                            </cm:securityTag>
                        </div>

                        <table
                                class="table table-striped table-bordered table-hover dataTable no-footer"
                                id="commonDataTable" aria-describedby="simpledatatable_info">
                            <thead id="list_th">
                            <tr>
                                <th>序号</th>
                                <th>借款人</th>
                                <th>身份证号</th>
                                <th>还款日期</th>
                                <th>借款人职业</th>
                                <th>借款用途</th>
                                <th>借款方式</th>
                                <th>借款状态</th>
                                <th>管辖城市</th>
                                <th>借款期限</th>
                                <th>年化利率</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
						</div>

					</div>
				</div>
				<!-- /Page Body -->
			</div>
			<!-- /Page Content -->
		</div>
	</div>
	
	<script id="addCreditInfo-template" type="text/x-handlebars-template">
    <form class="form-horizontal" id="addCreditor" method="post" action="/uplanLoan/saveOrUpdate">
                <div class="row-fluid" id="requestInfo">
                    <div class="span12">

                        <div class="control-group" style="display: none">
                            <input type="text" name="submitType" id="submitType"/>
                        </div>

						<input type="hidden" name="loanId" id="loanId" value="{{loanId}}">

						
						<div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">借款人姓名</label>
                            <div class="col-sm-6">
                               <input class="performValidate form-control"
                                       type="text"
                                       name="loanerName"
									   id="loanerName"
                                       placeholder="输入借款人姓名"
                                       value="{{loanerName}}"
                                       required/>
								<div class="errorText hide"><i class="icon-warning-sign"></i> 请输入借款人姓名</div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">身份证号</label>
                            <div class="col-sm-6">
                                <input class="performValidate  form-control"
                                       type="text"
                                       name="loanerCardNo"
                                       id="loanerCardNo"
                                       value="{{loanerCardNo}}"
                                       placeholder="输入借款人身份证号"/>
								<div class="errorText hide"><i class="icon-warning-sign"></i> 请输入借款人身份证号</div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">借款人职业情况</label>
                            <div class="col-sm-6">
                               <select name="loanerProfession" id="loanerProfession">
                                    <c:forEach var="careerStatus" items="${CareerStatus}">
                                        <option value="${careerStatus}"
                                                <c:if test="${careerStatus eq uPlanLoan.loanerProfession}">selected</c:if> >${careerStatus.key}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">借款用途</label>
                            <div class="col-sm-6">
                               <select name="loanerPurpose" id="loanerPurpose">
                                    <c:forEach var="purpose" items="${UplanLoanPurpose}">
                                        <option value="${purpose}"
                                                <c:if test="${purpose eq uPlanLoan.loanerPurpose}">selected</c:if> >${purpose.key}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">所在城市</label>
                            <div class="col-sm-6">
                                <select name="loanerAddress" id="loanerAddress">
                                    <c:forEach var="city" items="${City}">
                                        <option value="${city.name()}"
                                                <c:if test="${city.name() eq uPlanLoan.loanerAddress}">selected</c:if> >${city.name()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">借款金额</label>
                            <div class="col-sm-6">
                                <input class="performValidate form-control"
                                       type="text"
                                       name="amount"
             						   id="amount"
                                       value="{{amount}}"
                                       placeholder="输入借款金额"
                                       required/>
								<div class="errorText hide"><i class="icon-warning-sign"></i> 请输入正确的借款金额</div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">借款方式</label>
                            <div class="col-sm-6">
                                <select name="loanType" id="loanType">
                                    <c:forEach var="loanType" items="${LoanType}">
                                        <option value="${loanType}"
                                                <c:if test="${loanType eq uPlanLoan.loanType}">selected</c:if> >${loanType.key}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">借款期限</label>
                            <div class="col-sm-7">
								<span class=" col-sm-9 PaddL-0">
                                	<input class="performValidate form-control"
                                       type="number"
                                       name="loanTimeLimit"
									   id="loanTimeLimit"
                                       value="{{loanTimeLimit}}"
                                       placeholder="输入借款期限"
                                       required/>
								</span>
								<span class="col-sm-1 F-left PaddL-0 control-label">天</span>
								<div class="errorText hide"><i class="icon-warning-sign"></i> 请输入正确的借款期限</div>
                            </div>
                        </div>
						
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">借款日期</label>						
							<div class="input-group F-left col-md-6 PaddL-15">
                                <input type="text" name="loanStartDate" id="loanStartDate"
                                                   placeholder="借款日期" class="form-control date-picker"
												   value="{{formatdata loanStartDate}}"
                                                   data-date-format="yyyy-mm-dd"/>
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								<div class="errorText hide"><i class="icon-warning-sign"></i> 请输入正确的借款日期</div>
			                </div>							
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="rate">年利率</label>
                            <div class="col-sm-7">
                                <div class="input-append annualRate-input col-sm-12 PaddL-0 PaddR-0">
									<span class=" col-sm-9 PaddL-0">
                                    <input type="text"
											class=" form-control"
                                           id="floatRate"
                                           name="floatRate"
                                           value="{{loanRate}}"/>
									</span>
                                    <span class="add-on col-sm-1 F-left PaddL-0 control-label">%</span>
                                </div>
								<div class="errorText hide"><i class="icon-warning-sign"></i> 请输入正确的年利率</div>
                                <div class="help-block">（年利率范围：0% ~ 24%）</div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">还款方式</label>
                            <div class="col-sm-6">	
								<select name="loanRepaymentType" id="loanRepaymentType" >
                                	<option value='INCOME_REPAY'>一次性还本付息</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
							 <label class="col-sm-3 control-label no-padding-right"></label>
                            <div class="col-sm-6">
								<cm:securityTag privilegeString="UPLANLOAN_CREDITLIST">
                                	<button type="button" id="publishLoan" class="btn btn-success">立即放权</button>
                                	<button type="button" id="saveLoan" class="btn btn-success">保存</button>
								</cm:securityTag>
                            </div>
                        </div>

                    </div>

                </div>
            </form>
	</script>
	<!-- Modal -->
	<div class="modal fade" id="uploadLocalModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     	aria-hidden="true">
   	 	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-body" style="margin:auto; margin-top:10px; margin-bottom:10px;">
                	<form>
                        <input multiple id="uploadFileInput" type="file" name="uploadFileInput">
                	</form>
                	<div class="margin-top-20 text-center">
                		<cm:securityTag privilegeString="UPLANLOAN_CREDITLIST">
	                    	<button class="btn btn-submit btn-success" id="saveFileBtn">确定上传</button>
	                    	&nbsp;&nbsp;
	                    	<button data-dismiss="modal" class="btn btn-reset">取消</button>
                    	</cm:securityTag>
                	</div>
            	</div>
       		</div>
    	</div>
	</div>
    <!---->
    <!--Danger Modal Templates-->
    <div id="modal-danger" class="modal modal-message modal-danger fade" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <i class="glyphicon glyphicon-fire"></i>
                </div>
                <div class="modal-title">Alert</div>

                <div class="modal-body">You'vd done bad!</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">OK</button>
                </div>
            </div> <!-- / .modal-content -->
        </div> <!-- / .modal-dialog -->
    </div>
    <div class="cc-alert-bg hide cc-alert-failed">
        <div class="cc-alert-content">
            <div class="cc-alert-head">
                <h4><i class="icon-info-sign"></i> 系统提示 </h4>
            </div>
            <h4 class="cc-alert-info">
                <i class="icon-warning-sign bigger-120 red"></i>
                <span class="cc-alert-message"></span>
            </h4>

            <div class="cc-alert-actions">
                <button class="btn btn-danger btn-normal cc-alert-failed-btn">确定</button>
            </div>
        </div>
    </div>

	<%@include file="../../common/foot.jspf"%>
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script type="text/javascript" src="/assets/js/datetime/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="/assets/js/datetime/bootstrap-timepicker.js"></script>
<script type="text/javascript" src="/assets/js/datetime/daterangepicker.js"></script>
<script type="text/javascript" src="/assets/js/datetime/moment.js"></script>
<script type="text/javascript" src="/assets/js/bbtTool.js"></script>
<script type="text/javascript" src="/assets/js/amountFormat.js"></script>
<script src="/assets/js/uplan/creditor/creditList.js" type="text/javascript"></script>
	
</body>
</html>
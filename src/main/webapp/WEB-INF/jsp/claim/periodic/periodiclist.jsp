<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld"%>
<!DOCTYPE html>
<html lang="zh">
    <head>
        <title>数据列表</title>
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
                        <li class="active">列表项目</li>
                        <li class="active">列表管理</li>
                        <li class="active">数据列表</li>
                    </ul>
                </div>
                <!-- /Page Breadcrumb -->
                <!-- Page Header -->
                <div class="page-header position-relative">
                    <div class="header-title">
                        <h1>数据列表</h1>
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
                    <!---->
                    <div class="well">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <div class="row" style="color:#fff;text-align:center">
                      <!--               <div class="col-sm-6">
                                        <div class="databox databox-lg radius-bordered databox-shadowed" style="height:auto!important;">
                                            <div class="well bordered-left bordered-sky bg-white" style="margin-bottom: 0px;">
                                                <div>
                                                    <h4 class="darkgray">原始债权总价值</h4>
                                                </div>
                                                <div>
                                                    <span id="primaryAssert" class="databox-number sky"></span>
                                                </div>
                                                <div>
                                                    <span id="span_primary_15_30" class="databox-number red">0</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div> -->
                    <!--                 <div class="col-sm-6">
                                        <div class="databox databox-lg radius-bordered databox-shadowed">
                                            <div class="well bordered-left bordered-sky bg-white">
                                                <h4 class="darkgray">可用债权总价值</h4>
                                                <span id="remainAssert" class="databox-number sky"></span>
                                                <div>
                                                    <span id="span_remain_15_30" class="databox-number red">0</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div> -->
                                </div>
                                <div class="clearfix"></div>
                                <div class="table-toolbar">
                               <%--  <cm:securityTag privilegeString="CLAIM_FIXED_ADD"> --%>
                                        <a onclick="showClaimBox()" data-target="#addClaimBox" href="javascript:void(0);" class="btn btn-default">
                                        <i class="fa fa-plus"></i> 增加
                                        </a>
                                        <a onclick="uploadCreditorInfo()" data-target="#singleEmployee" href="javascript:void(0);" class="btn btn-default">
                                        <i class="fa fa-upload"></i> 上传本地数据
                                        </a>
                                   <%--      </cm:securityTag> --%>
                                        <%-- <cm:securityTag privilegeString="CLAIM_FIXED_IMPORT"> --%>
                                        <a id="downclaimlist" href="/claimLoan/fixedLoanListExport" class="btn btn-default">
                                        <i class="fa fa-download"></i> 导出报表
                                        </a>
                                   <%--      </cm:securityTag> --%>
                                </div>
                            </div>
                        </div>
                        <!---->
                        <div class="well">
                            <div class="table-toolbar">
                                <div id="investRecordHistory"
                                    style="padding-bottom: 15px; height: 30px;">
                                    <div class="control-group  pull-left">
                                        <label for="date-range-picker" class="control-label pull-left"
                                        style="line-height: 30px;">日期范围：
                                            <select id="dateFilter">
                                                <option value="">请选择</option>
                                                <option value="cashDate">借款日期</option>
                                                <option value="repayStartDate">首期还款日期</option>
                                                <option value="dueDate">末期还款日期</option>
                                            </select>
                                        </label>
                                        <div class="controls pull-left"
                                            style="width: 230px; margin-right: 10px;">
                                            <div class="input-group">
                                                <span class="input-group-addon"> <i class="fa fa-calendar"></i>
                                                </span> <input type="text" name="date-range-picker"
                                                id="date-range-picker"
                                                class="form-control investRecordRange" />
                                            </div>
                                        </div>
                                        <div class="control-group pull-left">
                                     <%--    <cm:securityTag privilegeString="CLAIM_FIXED_LIST"> --%>
                                            <button class="btn btn-small btn-primary"
                                            id="searchRechargeHistory">查询</button>
                                            <%-- </cm:securityTag> --%>

                                        </div>
                                    </div>
                                    <div class="control-group  pull-right">
                                        <div class="buttons-preview">
                                        <cm:securityTag privilegeString="CLAIM_FIXED_BATCH_OPEN">
                                            <span>批量操作：</span>
                                            <a id="open_all" class="btn btn-sm btn-blue">全部启用</a>
                                            <!-- <a id="close_all" class="btn btn-sm btn-danger">全部禁用</a> -->
                                            </cm:securityTag>
                                        </div>
                                    </div>
                                    <!-- <div class="form-horizontal pull-left" style="width:250px;">
                                        <div class="form-group pull-right">
                                            <label class=" control-label no-padding-right pull-left" style="width:70px;margin-right:5px;">启用状态：</label>
                                            <div class="pull-right" style="width:180px;">
                                                <select name="payPath" class="">
                                                    <option value="">全部</option>
                                                    <option value="">启用</option>
                                                    <option value="">禁用</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div> -->
                                    

                                </div>
                                <div class="row">&nbsp;</div>
                                <div class="scrollWrapper" style="overflow:auto">
                                    <div class="inner table_spe">
                                        <table class="table table-striped table-hover dataTable no-footer" id="curClaimDataTable" aria-describedby="simpledatatable_info" style="width:2500px;margin-bottom:50px">
                                            <thead id="list_tb" class="bordered-blue">
                                                <tr>
                                                    <th>
                                                        <label class="MargB-0">
                                                            <input type="checkbox" class="check_all">
                                                            <span class="text bold">全选</span>
                                                        </label>
                                                    </th>
                                                    <th>id</th>
                                                    <th>汽车类型</th>
                                                    <th>车牌号</th>
                                                    <th>品牌</th>
                                                    <th>车架号</th>
                                                    <th>身份证号</th>
                                                    <th>姓名</th>
                                                    <th>购车日期</th>
                                                    <th>联系地址</th>
                                                    <th>手机号</th>
                                                   <!--   <th>createtime</th>
                                                    <th>操作</th> --> 
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--审批通过  Templates-->
    <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="mySmallModalLabel">审批通过？</h4>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <button class="btn btn-success"  style="width:80px;">确定</button>
                        <button class="btn btn-default"  style="width:80px;">取消</button>
                    </div>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
    <!--End 审批通过  Templates-->

    <!--添加债权模板-->
    <script id="addClaimBox-template" type="text/x-handlebars-template">
        <form id="addClaimForm" class="form-horizontal" action="/claimLoan/saveOrUpdateFixed" method="POST">
            <div class="row">
                <div class="col-md-12">
                    <input type="hidden" id="loanId" name="loanId" class="form-control" value="{{loanId}}"/>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanerName"><em>*</em>借款人姓名:</label>
                        <div class="controls col-lg-6">
                            <input id="loanerName" name="loanerName" value="{{loanerName}}" class="form-control" type="text" placeholder=""/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanerCardNo"><em>*</em>身份证号:</label>
                        <div class="controls col-lg-6">
                            <input id="loanerCardNo" name="loanerCardNo" value="{{loanerCardNo}}" class="form-control" type="text" placeholder="" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanerAddress"><em>*</em>借款人所在城市:</label>
                        <div class="controls col-lg-6">
                            <select id="loanerAddress" name="loanerAddress" data-val="{{loanerAddress}}">
                                <c:forEach var="city" items="${City}">
                                    {{#select loanerAddress}}
                                    <option value="${city.name()}"
                                            <c:if test="${city.name() eq uPlanLoan.loanerAddress}">selected</c:if> >${city.name()}</option>
                                    {{/select}}
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanerProfession"><em>*</em>借款人职业情况:</label>
                        <div class="controls col-lg-6">
                            <select id="loanerProfession" name="loanerProfession" data-val="{{loanerProfession}}">
                                <c:forEach var="careerStatus" items="${CareerStatus}">
                                    {{#select loanerProfession}}
                                    <option value="${careerStatus}">
                                            ${careerStatus.key}</option>
                                    {{/select}}
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanerPurpose"><em>*</em>借款用途:</label>
                        <div class="controls col-lg-6">
                            <select id="loanerPurpose" name="loanerPurpose" data-val="{{loanerPurpose}}">
                                <c:forEach var="uplanLoanPurpose" items="${UplanLoanPurpose}">
                                    {{#select loanerPurpose}}
                                    <option value="${uplanLoanPurpose}">
                                            ${uplanLoanPurpose.key}</option>
                                    {{/select}}
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="contractId"><em>*</em>合同编号:</label>
                        <div class="controls col-lg-6">
                            <input id="contractId" name="contractId" value="{{contractId}}" class="form-control" type="text" placeholder="" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanAmount"><em>*</em>借款金额（元）:</label>
                        <div class="controls col-lg-6">
                            <input id="loanAmount" name="loanAmount" value="{{loanAmount}}" class="form-control" type="text" placeholder="" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanType"><em>*</em>借款方式:</label>
                        <div class="controls col-lg-6">
                            <select id="loanType" name="loanType" data-val="{{loanType}}">
                                <c:forEach var="loanType" items="${LoanType}">
                                    {{#select loanType}}
                                    <option value="${loanType}"
                                            <c:if test="${loanType eq uPlanLoan.loanType}">selected</c:if> >${loanType.key}</option>
                                    {{/select}}
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanRepaymentType"><em>*</em>还款方式:</label>
                        <div class="controls col-lg-6">
                            <select id="loanRepaymentType" name="loanRepaymentType" data-val="{{loanRepaymentType}}">
                                <c:forEach var="repayMethod" items="${RepayMethod}">
                                    {{#select loanRepaymentType}}
                                    <option value="${repayMethod}">${repayMethod.key}</option>
                                    {{/select}}
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanRate"><em>*</em>月利率（%）:</label>
                        <div class="controls col-lg-6">
                            <select id="loanRate" name="loanRate" data-val="{{loanRate}}">
                                {{#select loanRate}}
                                <option value="1.01">1.01</option>
                                <option value="1.02">1.02</option>
                                <option value="1.03">1.03</option>
                                <option value="1.04">1.04</option>
                                <option value="1.05">1.05</option>
                                <option value="1.06">1.06</option>
                                <option value="1.07">1.07</option>
                                <option value="1.08">1.08</option>
                                <option value="1.09">1.09</option>
                                <option value="1.10">1.10</option>
                                {{/select}}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="cashDate"><em>*</em>放款日期:</label>
                        <div class="controls col-lg-6">
                            <input id="cashDate" name="cashDate" value="{{{formatDate cashDate}}}" class="form-control date-picker" type="text" placeholder="" data-date-format="yyyy-mm-dd"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanTimeLimit"><em>*</em>借款期数:</label>
                        <div class="controls col-lg-6">
                            <input id="loanTimeLimit" name="loanTimeLimit" value="{{loanTimeLimit}}" class="form-control" type="text" placeholder="" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="manageFee"><em>*</em>月管理费率（%）:</label>
                        <div class="controls col-lg-6">
                            <input id="manageFee" name="manageFee" value="{{manageFee}}" class="form-control" type="text" placeholder="" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="mediatorLoginName"><em>*</em>居间人:</label>
                        <div class="controls col-lg-6">
                            <select id="mediatorLoginName" name="mediatorLoginName" data-val="{{mediatorLoginName}}">
                                <option value="难得糊涂">难得糊涂</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="loanSource"><em>*</em>债权来源:</label>
                        <div class="controls col-lg-6">
                            <select id="loanSource" name="loanSource" data-val="{{loanSource}}">
                                <c:forEach var="claimSource" items="${ClaimSource}">
                                    {{#select loanSource}}
                                    <option value="${claimSource}">${claimSource.key}</option>
                                    {{/select}}
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-4" for="flagBanned"><em>*</em>债权启用:</label>
                        <div class="controls col-lg-4" id="flagBannedRadio" data-val="{{flagBanned}}">
                            <label class="radio-inline">
                              <input type="radio" value="0" style="position:relative;left:0;height:auto;opacity:1" name="flagBanned" {{{setChecked false flagBanned}}}> 启用
                            </label>
                            <label class="radio-inline">
                              <input type="radio" value="1" style="position:relative;left:0;height:auto;opacity:1" name="flagBanned" {{{setChecked true flagBanned}}}> 禁用
                            </label>
                        </div>
                    </div>
                    <div class="form-group" id="form_btns">
                        <label class="control-label col-lg-4"></label>
                        <div class="controls col-lg-6">
                            
                            <button type="submit" class="btn btn-primary">保存记录</button>
                            <button type="reset" class="btn">重置</button>
                        </div>
                    </div>
                </div>
            </div>

        </form>
    </script>
    <!-- employee form for create/edit -->
    <div id="addClaimBox" class="modal fade">
    </div>

    <!-- 上传债权 start -->
    <div class="modal fade" id="uploadLocalModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body" style="margin:auto; margin-top:10px; margin-bottom:10px;">
                    <form>
                        <input multiple id="uploadFileInput" type="file" name="uploadFileInput">
                    </form>
                    <div class="margin-top-20 text-center">
                   <%--      <cm:securityTag privilegeString="UPLANLOAN_CREDITLIST"> --%>
                            <button class="btn btn-submit btn-success" id="saveFileBtn">确定上传</button>
                            &nbsp;&nbsp;
                            <button data-dismiss="modal" class="btn btn-reset">取消</button>
                      <%--   </cm:securityTag> --%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--上传债权 end-->
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
<script src="/assets/js/toastr/toastr.js"></script>
    <script src="/assets/js/amountFormat.js"></script>
    <script src="/assets/js/bbtTool.js"></script>
    <script type="text/javascript" src="/assets/js/datetime/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="/assets/js/datetime/bootstrap-timepicker.js"></script>
    <script type="text/javascript" src="/assets/js/datetime/daterangepicker.js"></script>
    <script src="/assets/js/claim/periodic_list.js" type="text/javascript"></script>
    </body>
</html>
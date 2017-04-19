<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/25
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta name="description" content="系统测试平台管理系统" />
  <%@include file="../../common/head.jspf" %>
  <link href="/assets/css/quickLoanRequest.css" rel="stylesheet" />
  <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />


</head>
<body>
<%@include file="../../common/navbar.jspf" %>
<!-- Main Container -->
<div class="main-container container-fluid">
  <!-- Page Container -->
      <div class="page-container">
        <%@include file="../../common/sidebar.jspf" %>
        <!-- Page Content -->
        <div class="page-content">
            <!-- Page Breadcrumb -->
            <div class="page-breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="fa fa-home"></i>
                        <a href="/">首页</a>
                    </li>
                    <li class="active">资金管理</li>
                    <li class="active">对账管理</li>
                    <li class="active">平台资金充值与提现</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                       平台资金充值与提现
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
				<div class="widget-box transparent"  id="yonghu">
	            	<div id="page-content" class="">
	            		<div class="row">
	            			<div class="col-lg-12 col-sm-12 col-xs-12">
		            			<div class="widget-header bordered-bottom bordered-sky blue">
									<i class="fa fa-plus-square widget-caption Font-16 MargR-10"></i>
									<span class="widget-caption Font-16">平台充值</span>
									
								</div>
				
				                <div class="widget-body">
				                	<form novalidate class="form-horizontal rechargeForm" name="formRecharge">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right">平台账户</label>
                                            <div class="input-prepend relative col-sm-6">
                                                <input type="hidden" value=""/>
                                                <select name="platformName" id="platformName">
                                                    <c:forEach var="platformType" items="${platformTypes}">
                                                        <option value="${platformType}">${platformType.key}</option>
                                                    </c:forEach>
                                                </select>

                                            </div>
                                        </div>
                              			<div class="form-group">
		                                	<label class="col-sm-2 control-label no-padding-right">充值金额</label>
		                                    <div class="input-prepend relative col-sm-6">
		                                    	<div class="input-group">
				                        			<span class="input-group-addon"><i class="fa fa-yen"></i></span>
	                                            	<input type="text" class="prependedInput form-control" id="rechargeValue" name="amount"  placeholder="0">
	                                       			<span class="input-group-addon"  id="resetValueIn"><i class="fa fa-times purple" style="cursor:pointer"></i></span>
	                                     		</div>

		                                    </div>
		                                </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right">备注</label>
                                            <div class="input-prepend relative col-sm-6">
                                                <input type="text" class="prependedInput form-control" id="rechargeRemark" name="rechargeRemark" maxlength="45" placeholder="请输入备注">
                                            </div>
                                        </div>
	
		                                <div class="form-group">
		                                    <label class="col-sm-2 control-label no-padding-right"></label>
		                                    <div class="col-sm-6" >
		                                        <button id="btn_recharge" type="button" class="btn btn-sm btn-primary post-btn" data-target=".bs-example-modal-sm">立即充值</button>
		                                    </div>
		                                </div>
		                                
		                            </form>
				                </div>
			                </div>
		                </div>
		                <div class="horizontal-space"></div>

                        <div class="row">
                            <div class="col-lg-12 col-sm-12 col-xs-12">
                                <div class="widget-header bordered-bottom bordered-sky blue">
                                    <i class="fa fa-plus-square widget-caption Font-16 MargR-10"></i>
                                    <span class="widget-caption Font-16">企业网银支付</span>

                                </div>

                                <div class="widget-body">
                                    <form novalidate class="form-horizontal rechargeForm" name="formRecharge">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right">平台账户</label>
                                            <div class="input-prepend relative col-sm-6">
                                                <input type="hidden" value=""/>
                                                <select name="platformName1" id="platformName1">
                                                    <c:forEach var="platformType" items="${platformTypes}">
                                                        <option value="${platformType}">${platformType.key}</option>
                                                    </c:forEach>
                                                </select>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right">选择银行</label>
                                            <div class="input-prepend relative col-sm-6">
                                                <input type="hidden" value=""/>
                                                <select name="bankformName" id="bankformName">
                                                    <option value="CMB" data-bankname="CMB" selected>招商银行</option>
                                                    <option value="ICBC" data-bankname="ICBC">中国工商银行</option>
                                                    <option value="ABC" data-bankname="ABC">中国农业银行</option>
                                                    <option value="CCB" data-bankname="CCB">中国建设银行</option>
                                                    <option value="BOC" data-bankname="BOC">中国银行</option>
                                                    <option value="BOCOM" data-bankname="BOCOM">交通银行</option>
                                                    <option value="CEB" data-bankname="CEB">中国光大银行</option>
                                                </select>

                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right">充值金额</label>
                                            <div class="input-prepend relative col-sm-6">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><i class="fa fa-yen"></i></span>
                                                    <input type="text" class="prependedInput form-control" id="rechargeValue1" name="amount"  placeholder="0">
                                                    <span class="input-group-addon"  id="resetValueIn1"><i class="fa fa-times purple" style="cursor:pointer"></i></span>
                                                </div>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right">备注</label>
                                            <div class="input-prepend relative col-sm-6">
                                                <input type="text" class="prependedInput form-control" id="rechargeRemark1" name="rechargeRemark1" maxlength="45" placeholder="请输入备注">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right"></label>
                                            <div class="col-sm-6" >
                                                <button id="btn_recharge1" type="button" class="btn btn-sm btn-primary post-btn" data-target=".bs-example-modal-sm">立即充值</button>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="horizontal-space"></div>

	            		<div class="row">
	            			<div class="col-lg-12 col-sm-12 col-xs-12">
		            			<div class="widget-header bordered-bottom bordered-sky blue">
									<i class="fa fa-minus-square widget-caption Font-16 MargR-10"></i>
									<span class="widget-caption Font-16">平台取现</span>									
								</div>
				
				                <div class="widget-body">
				                    <form novalidate class="form-horizontal rechargeForm" name="formWithdraw" action="/fund/platformFund/audit" method="POST">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right">平台账户</label>
                                            <div class="input-prepend relative col-sm-6">
                                                <input type="hidden" value=""/>
                                                <select name="platformName" id="platformNameOut">
                                                    <c:forEach var="platformType" items="${platformTypes}">
                                                        <option value="${platformType}">${platformType.key}</option>
                                                    </c:forEach>
                                                </select>

                                            </div>
                                        </div>
                                        <div class="form-group">
		                                	<label class="col-sm-2 control-label no-padding-right">取现金额</label>
		                                    <div class="input-prepend relative col-sm-6">
		                                    	<div class="input-group">
				                        			<span class="input-group-addon"><i class="fa fa-yen"></i></span>
	                                            	<input type="text" class="prependedInput form-control"  id="withdrawValue" name="amount" placeholder="0">
	                                       			<span class="input-group-addon"  id="resetValueOut"><i class="fa fa-times purple" style="cursor:pointer"></i></span>
	                                     		</div>

		                                    </div>
		                                </div>

                                        <div class="form-group">
                                            <label class="col-sm-2 control-label no-padding-right">备注</label>
                                            <div class="input-prepend relative col-sm-6">
                                                <input type="text" class="prependedInput form-control" id="withdrawRemark" name="withdrawRemark" maxlength="45" placeholder="请输入备注">
                                            </div>
                                        </div>
	
		                                <div class="form-group">
		                                    <label class="col-sm-2 control-label no-padding-right"></label>
		                                    <div class="col-sm-6" >
		                                         <button id="btn_withdraw" type="button" class="btn btn-sm btn-primary post-btn"  data-target=".bs-example-modal-sm-qx">立即取现</button>
		                                    </div>
		                                </div>
		                                
		                            </form>
				                </div>
			                </div>
		                </div>
	            		
	            	</div>
	            </div>
            </div>
        </div>
    </div>
</div>


<!--
////////////////////////////////////////////////////////////////////////////////
正在充值弹出层
////////////////////////////////////////////////////////////////////////////////
-->

    <div id="rechargePanel" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>       
                    <h4 class="modal-title"><i class='fa fa-spinner'></i> 正在充值</h4>
                </div>
                <div class="modal-body relative">
			        <div class="text-center">
			            <%--<button class="btn btn btn-success">--%>
			                <%--<i class="fa fa-check"></i>  充值成功--%>
			            <%--</button>--%>
			            <%--&nbsp;--%>
			            <%--<button class="btn btn-danger btn">--%>
			                <%--<i class="fa  fa-question"></i> 充值遇到问题--%>
			            <%--</button>--%>
			        </div>
			    </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>

<!-- 
<div id="rechargePanel" class="modal hide fade">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                onclick="$('#rechargePanel').get(0).reset();">&times;</button>
        <h3><i class='icon-cog icon-spin'></i> 正在充值</h3>
    </div>
    <div class="modal-body relative">
        <div class="text-center">
            <button class="btn btn btn-success">
                <i class="icon-ok"></i>
                充值成功
            </button>
            &nbsp;
            <button class="btn btn-danger btn">
                <i class="icon-question-sign"></i>
                充值遇到问题
            </button>
        </div>
    </div>
</div>
 -->
<!--
////////////////////////////////////////////////////////////////////////////////
正在取现弹出层
////////////////////////////////////////////////////////////////////////////////
-->

    <div id="withdrawPanel" class="modal fade bs-example-modal-sm-qx" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title"><i class='fa fa-spinner'></i> 正在取现</h4>
                </div>
                <div class="modal-body relative">
			        <div class="text-center">
			            <button class="btn btn btn-success">
			                <i class="fa fa-check"></i>  取现成功
			            </button>
			            &nbsp;
			            <button class="btn btn-danger btn">
			                <i class="fa  fa-question"></i> 取现遇到问题
			            </button>
			        </div>
			    </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
<!-- 
<div id="withdrawPanel" class="modal hide fade">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                onclick="$('#rechargePanel').get(0).reset();">&times;</button>
        <h3><i class='icon-cog icon-spin'></i> 正在取现</h3>
    </div>
    <div class="modal-body relative">
        <div class="text-center">
            <button class="btn btn btn-success">
                <i class="icon-ok"></i>
                取现成功
            </button>
            &nbsp;
            <button class="btn btn-danger btn">
                <i class="icon-question-sign"></i>
                取现遇到问题
            </button>
        </div>
    </div>
</div>
 -->

<%@include file="../../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/employee/list.js"></script>

<script type="text/javascript" src="/assets/js/amountFormat.js"></script>
<script type="text/javascript" src="/assets/js/fund/thirdParty.js"></script>

</body>
</html>
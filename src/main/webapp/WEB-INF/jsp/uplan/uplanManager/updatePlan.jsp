<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>修改计划</title>
    <%@include file="../../common/head.jspf" %>
    <link rel="stylesheet" href="/assets/css/uplan/newPlan.css"/>
    <link rel="stylesheet" href="/assets/css/dataTables.bootstrap.css"/>

</head>
<body class="navbar-fixed">
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
                    <li class="active">
                        <a href="/loan/loanList">优选计划</a></li>
                    <li class="active">修改计划</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        修改计划
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
                <form class="form-horizontal new-plan-form" name="new-plan-form" id="newPlanForm" action="/uplan/updateUplan" method="POST">
                        <div class="widget-box transparent">
                        	<input type='hidden' value="${uplan.id}" name="id" id="id">
                            <!-- 债权人信息 -->
                            <h5 class="row-title before-yellow">债权人信息</h5>
                            <div class="wizard">
                            <div class="form-group">&nbsp;</div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">登录名：</label>
                                <div class="col-lg-4">

                                    <input type="text" id="userLoginName" class="form-control pull-left" name="userLoginName" placeholder="请输入注册用户登录名"
                                           data-bv-notempty="true"
                                           data-bv-notempty-message="请输入已注册用户登录名" value="${uplan.userLoginName}"/>
                                    <div class="errorText hide"><i class="icon-warning-sign"></i> 用户不存在</div>
                                </div>
                                <div class="pull-left col-lg-1"><span class="input-group-btn">
                                                                    <button class="btn btn-default shiny" id="queryUserBtn" type="button">查询</button>
                                                                </span></div>
                            </div>

                            <div class="form-group">
                                <label class="col-lg-3 control-label">真实姓名：</label>
                                <div class="col-lg-4" id="realUserName" name="realUserName"data-id="">${uplan.userName}
                                </div>
                                <input type="hidden" id="userName" name="userName"  value="${uplan.userName}"/>
                            </div>

                            <div class="form-group">
                                <label class="col-lg-3 control-label">身份证号：</label>
                                <div class="col-lg-4" id="realUserIdNumber" name="realUserIdNumber">${uplan.userIdNumber}
                                </div>
                                <input type="hidden" id="userIdNumber" name="userIdNumber" value="${uplan.userIdNumber}"/>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">合同显示借款人：</label>
                                <div class="col-lg-4">
                                    <input type="text"  class="form-control"
                                           id="showUserName"
                                           name="showUserName"
                                           placeholder="请输入合同显示借款人"
                                           value="${uplan.showUserName}"/>
                                    <div class="errorText hide"><i class="icon-warning-sign"></i> 合同显示借款人不能为空</div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label">合同显示借款人身份证：</label>
                                <div class="col-lg-4">
                                    <input type="text" class="form-control"
                                           id="showUserIdNumber"
                                           name="showUserIdNumber"
                                           placeholder="请输入合同显示借款人身份证"
                                           value="${uplan.showUserIdNumber}"/>
                                    <div class="errorText hide"><i class="icon-warning-sign"></i> 合同显示借款人身份证不能为空</div>
                                </div>
                                <div class="form-group">&nbsp;</div>
                            </div>
                                </div>
                            <!-- 基本信息 -->
                            <h5 class="row-title">基本信息</h5>
                            <div class="wizard">
                                <div class="form-group">&nbsp;</div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label">产品名称：</label>
                                    <div class="col-lg-4">
                                        <input type="text" name="productName" class="form-control" placeholder="请输入产品名称" value="${uplan.productName}">
                                        <div class="errorText inline hide"><i class="icon-warning-sign"></i>
                                            输入的中文或字符位数至少为4位
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group has-feedback margin-top-10">
                                   <label class="col-lg-3 control-label">产品类型：</label>
                                    <div class="col-lg-4">
                                        <select name="productType" id="productType">
                                            <c:forEach var="productType" items="${ProductType}">
                                                <option value="${productType}">${productType.key}</option>
                                            </c:forEach>
                                        </select>
                                        <input type="hidden" id="productTypeStr" value="${uplan.productType}"/>
                                    </div>
                                </div>
                                <div class="form-group has-feedback margin-top-10">
                                   <label class="col-lg-3 control-label">产品介绍：</label>
                                    <div class="col-lg-4">
                                        <textarea name="productMemo" rows="3" cols="45">${uplan.productMemo}</textarea>

                                        <div class="errorText inline hide"><i class="icon-warning-sign"></i> 不超过200字
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">&nbsp;</div>
                            </div>

                            <div class="margin-top-30"></div>
                            <h5 class="row-title before-orange">
                                匹配债权包

                            </h5>
                            <div class="wizard">
                                <div class="form-group">&nbsp;</div>
                                <input type="text" name="creditList" id="creditListData" value="" style="position:absolute;left:-5000px">
                                <div class="creditInfoListWarp">
                                    <div class="table-toolbar">
                                        <a class="btn btn-small"  data-toggle="modal" data-target=".bs-example-modal-lg">
                                            <i class="icon-plus"></i>匹配债权包
                                        </a>
                                    </div>
                                    <table class="table margin-top-30" id="creditInfoList" data-checkedUplanId="">
                                        <thead class="bordered-blue">
                                        <tr>
                                            <th>借款人</th>
                                            <th>身份证号</th>
                                            <th>还款日期</th>
                                            <th>借款人职业</th>
                                            <th>借款人用途</th>
                                            <th>借款方式</th>
                                            <th>借款人状态</th>
                                            <th>管辖城市</th>
                                            <th>借款期限</th>
                                            <th>年化利率</th>
                                            <th>原始价值</th>
                                            <th>可用价值</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody class="creditListBody">
                                        </tbody>
                                    </table>
                                </div>
                                <div class="form-group">&nbsp;</div>
                                </div>
                                <!-- 计划指标 -->
                            <div class="margin-top-30"></div>

                            <h5 class="row-title before-palegreen">
                                不可修改区域
                            </h5>
                            <div class="wizard">
                                <div class="form-group">&nbsp;</div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">借款金额：</label>
                                    <div class="controls credit-amount col-lg-4">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-yen"></i></span>
                                            <input class="form-control performValidate"
                                                   type="text"
                                                   id="amount"
                                                   name="amount" value="${uplan.amount}"
                                                   placeholder="自动计算出已匹配债权的金额" readonly="readonly"
                                                   />
                                        </div>
                                    </div>
                                    <div class="errorText inline hide"><i class="icon-warning-sign"></i>
                                        请匹配债权会自动计算出贷款金额
                                    </div>
                                    <div class="inline-block grey">（1~100,000,000 之间的整数）</div>
                                </div>
                                <div class="form-group has-feedback margin-top-10">
                                    <label class="control-label col-lg-3" for="maxAmount">最大投资额：</label>
                                    <div class="controls col-lg-4">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-yen"></i></span>
                                            <input type="text" class="form-control"
                                                   id="maxAmount"
                                                   name="maxAmount"
                                                   value="${uplan.maxAmount}"
                                                   placeholder="输入最大投资额度"
                                                   readonly="readonly"/>
                                        </div>

                                    </div>
                                    <div class="errorText inline hide"><i class="icon-warning-sign"></i> 额度错误</div>
                                </div>
                                <div class="form-group has-feedback margin-top-10">
                                    <label class="control-label col-lg-3" for="rate">年利率：</label>
                                    <div class="controls col-lg-4">
                                        <div class="input-group">
                                            <input type="text" id="rate" name="rate" class="form-control" readonly="readonly" value="${uplan.rate / 100}"/>
                                            <span class="input-group-addon">%</span>
                                        </div>
                                    </div>
                                    <div class="errorText inline hide"><i class="icon-warning-sign"></i> 请输入正确的年利率
                                    </div>
                                    <div class="inline-block grey col-lg-4">（年利率范围：0% ~ 24%）</div>
                                </div>
                               	<div class="form-group has-feedback margin-top-10">
                                    <label class="control-label col-lg-3">还款时间：</label>
                                    <div class="controls col-lg-4">
                                        <input class="form-control" type="text" id="repaymentDate"
                                               name="repaymentDate"
                                               readonly="readonly" value='<fmt:formatDate value="${uplan.repaymentDate}"
														pattern="yyyy-MM-dd" />'>
                                    </div>
                                    <div class="inline-block grey col-lg-4">（该日期进行还款操作）</div>
                                </div>
                            <div class="margin-top-30"></div>
							</div>
                            <!-- 手工调整区域 -->
                            <h5 class="row-title before-yellow">手工调整区域</h5>
                            <div class="wizard">
                                <div class="form-group">&nbsp;</div>
                                <div class="form-group has-feedback margin-top-10">
                                    <label class="control-label col-lg-3">是否为新手标：</label>
                                    <div class="controls col-lg-4">
                                        <select name="freshPlan" id="freshPlan" class="form-control">
                                        	<option value="0">否</option>
                                            <option value="1">是</option>
                                        </select>
                                        <input type="hidden" id="freshPlanStr" value="${uplan.freshPlan}"/>
                                    </div>
                                </div>
                                <div class="form-group has-feedback margin-top-10">
                                    <label class="control-label col-lg-3">还款方式：</label>
                                    <div class="controls col-lg-4">
                                        <select name="repaymentType" id="repaymentType" class="form-control">
                                            <c:forEach var="repaymentType" items="${RepaymentType}">
                                                <option value="${repaymentType}">${repaymentType.key}</option>
                                            </c:forEach>
                                        </select>
										<input type="hidden" id="repaymentTypeStr" value="${uplan.repaymentType}"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">截止投标时间：</label>
                                    <div class="controls col-lg-4">
                                        <div class="input-group">
                                            <input type="text" name="investEndDate" id="investEndDate"
                                                   placeholder="自动调取还款日期的前的30天" class="date-picker form-control"
                                                   data-date-format="yyyy-mm-dd " value='<fmt:formatDate value="${uplan.investEndDate}"
														pattern="yyyy-MM-dd" />'/>
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                        <div class="errorText inline hide"><i class="icon-warning-sign"></i> 请输入正确的截止投标时间，不能小于当前时间</div>
                                    </div>
                                    <div class=" inline-block grey " style="margin-left: -94px;">（保证30天的收益）</div>
                                </div>
 
                                <div class="form-group has-feedback margin-top-10">
                                    <label class="control-label col-lg-3">保障类型：</label>
                                    <div class="controls col-lg-4">
                                        <select name="guaranteeType" id="guaranteeType" class="form-control">
                                            <c:forEach var="guaranteeType" items="${UplanGuaranteeType}">
                                                <option value="${guaranteeType}">${guaranteeType.key}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <input type="hidden" id="guaranteeTypeStr" value="${uplan.guaranteeType}"/>
                                </div>
                                <div class="form-group has-feedback margin-top-10">
                                    <label class="control-label col-lg-3">到期退出方式：</label>
                                    <div class="controls col-lg-4">
                                        <select name="expireOutType" id="expireOutType" class="form-control">
                                            <c:forEach var="expireOutType" items="${ExpireOutType}">
                                                <option value="${expireOutType}">${expireOutType.key}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <input type="hidden" id="expireOutTypeStr" value="${uplan.expireOutType}"/>
                                </div>
                                <div class="form-group has-feedback margin-top-10">
                                    <label class="control-label col-lg-3">提前退出方式：</label>
                                    <div class="controls col-lg-4">
                                        <select name="aheadOutType" id="aheadOutType" class="form-control">
                                            <c:forEach var="aheadOutType" items="${AheadOutType}">
                                                <option value="${aheadOutType}">${aheadOutType.key}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <input type="hidden" id="aheadOutTypeStr" value="${uplan.aheadOutType}">
                                </div>
                                <div class="form-group margin-top-10">
                                    <label class="control-label col-lg-3" for="rateAdd">候补年利率：</label>
                                    <div class="controls col-lg-4">
                                        <div class="input-group">
                                            <input type="text"id="rateAdd" name="rateAdd" class="form-control" value="${uplan.rateAdd / 100}" />
                                            <span class="input-group-addon">%</span>
                                        </div>
                                        <div class="errorText inline hide"><i class="icon-warning-sign"></i> 请输入正确的年利率</div>
                                    </div>
                                    <div class="inline-block grey col-lg-4">（年利率范围：0% ~ 24%）</div>
                                </div>
                                <div class="form-group margin-top-10">
                                    <label class="control-label col-lg-3" for="minAmount">最小投资额：</label>
                                    <div class="controls col-lg-4">
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-yen"></i></span>
                                            <input type="text"
                                                   id="minAmount"
                                                   name="minAmount"
                                                   class="form-control"
                                                   value="${uplan.minAmount}"
                                                   placeholder="输入最小投资额度"/>
                                        </div>

                                        <div class="errorText hide"><i class="icon-warning-sign"></i> 最小投资额错误</div>
                                    </div>
                                </div>
                                <div class="form-group margin-top-10">
                                    <label class="control-label col-lg-3">投资增量：</label>
                                    <div class="controls col-lg-4">
                                        <input class="form-control" type="text" id="increaseNum" name="increaseNum"
                                               placeholder="" value="${uplan.increaseNum}">
                                    </div>
                                    <div class="errorText inline hide"><i class="icon-warning-sign"></i> 投资增量额度错误</div>
                                </div>
                                <div class="form-group  margin-top-10">
                                    <label class="control-label col-lg-3">费用：</label>
                                    <div class="controls col-lg-4">
                                        <input class="form-control" type="text" id="fee" name="fee"
                                               placeholder="" value="${uplan.fee}">
                                    </div>
                                    <div class="errorText inline hide"><i class="icon-warning-sign"></i> 费用错误</div>
                                </div>
                                <div class="form-group">&nbsp;</div>
                            </div>

                            <div class="margin-top-30"></div>

                            <div class="form-group">
                                <label class="control-label col-lg-4"></label>

                                <div class="controls col-lg-4">
                                    <button type="button" id="addPlanBtn" class="btn btn-primary">立即发布</button>
                                    <button type="button" id="savePlanBtn" class="btn btn-info">保存</button>
                                </div>
                            </div>
                            <div class="form-group">&nbsp;</div>
                            <input type="hidden" name="opType" id="opType"/>
                        </div>
                    </form>
            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>
<!-- user form for create/edit -->
<div id="matchCreditWarp" class="modal fade matchCreditModal bs-example-modal-lg  in" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="false" style="display: none;">
    <div class="modal-dialog" style="width:1160px;">
        <div class="modal-content">
            <div class="modal-header" style="border-bottom: 3px solid #ed4e2a;">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myLargeModalLabel">选择可用债权</h4>
            </div>
            <form id="availableCredit" class="form-horizontal" action="" method="POST">
                <div class="form-group">&nbsp;</div>
                <div class="">
                            <div class="planFilterDate pull-left form-group" style="margin-left:20px;margin-right:50px;line-height:32px;">
                                    <div class="input-group">
                                        <div class="input-group"><span class="pull-left">还款日期&nbsp;</span>
                                                        <input type="text" id="loanEndDate" class="form-control date-picker"
                                                                      style="width:100px" data-date-format="yyyy-mm-dd"><span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </div>
                            </div>
                            <div class="planFilterDate pull-left form-group" id="planFilterDate" style="margin-left:20px;margin-right:50px;line-height:32px;">
                                    <div class="input-group">
                                        <div class="input-group"><span class="pull-left">收益率&nbsp;</span>
	                                                <input type="text" class="form-control" id="loanRate"
                                                                  style="width:100px"/><span class="input-group-addon">%</span>
                                        </div>
                                    </div>
                            </div>

                            <div class="pull-left">
                                <button type="button" id="queryPlan" class="btn btn-primary btn-small">匹配</button>
                                <button type="button" id="confirmMatch" class="btn btn-primary btn-small">确认添加</button>
                            </div>
                    <div style="clear:both"></div>
                        </div>
                  <div class="plansTableWarp">
                    <table class="table  margin-top-30 plansTable" id="plansTable">
                        <thead class="bordered-blue">
                        <tr>
                            <th>选择<label><input id="cb_checkall" type="checkbox"><span class="text"></span></label></th>
                            <th>借款人</th>
                            <th>身份证号</th>
                            <th>还款日期</th>
                            <th>借款人职业</th>
                            <th>借款人用途</th>
                            <th>借款方式</th>
                            <th>借款人状态</th>
                            <th>管辖城市</th>
                            <th>借款期限</th>
                            <th>年化利率</th>
                            <th>原始价值</th>
                            <th>可用价值</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                      <div class="form-group">&nbsp;</div>
                  </div>
            </form>
        </div>
    </div>
</div>

<%@include file="../../common/foot.jspf" %>
<!-- jquery dataTables -->
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
<script type="text/javascript" src="/assets/js/uplan/uplanManager/updatePlan.js"></script>

</body>
</html>
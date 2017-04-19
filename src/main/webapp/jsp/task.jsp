<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>系统测试平台</title>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="common/head.jspf" %>
</head>
<body>

    <%@include file="common/navbar.jspf" %>

    <!-- Main Container -->
    <div class="main-container container-fluid">
        <!-- Page Container -->
        <div class="page-container">
            <%@include file="common/sidebar.jspf" %>
                <!-- Page Content -->
                <div class="page-content">
                    <!-- Page Breadcrumb -->
                    <div class="page-breadcrumbs">
                        <ul class="breadcrumb">
                            <li>
                                <i class="fa fa-home"></i>
                                <a href="index">跑批</a>
                            </li>
 
                        </ul>
                    </div>
                    <!-- /Page Breadcrumb -->
                    <!-- Page Header -->
                    <div class="page-header position-relative">
                        <div class="header-title">
                            <h1>
                                跑批任务界面
                            </h1>
                        </div>

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

                    </div>
                    <!-- /Page Header -->
                    <!-- Page Body -->
                    <div class="page-body">
                        <%--<h5 class="blue">投资到期处理笔数失败笔数：${Info.count_investDuDate_fail}</h5>--%>
                        <%--<h5 class="blue">本金投资匹配失败笔数：${Info.count_invest_fail}</h5>--%>
                        <%--<h5 class="blue">利息投资失败笔数失败笔数：${Info.count_rate_fail}</h5>--%>
                        <%--<h5 class="blue">债权到期处理失败笔数：${Info.count_creditDuDate_fail}</h5>--%>
                        <table class="table table-striped table-bordered table-hover dataTable no-footer" aria-describedby="simpledatatable_info">
                            <thead>
                            <tr>
                                <th>投资到期失败笔数</th>
                                <th class="hidden-480">本金投资匹配失败笔数</th>
                                <th>利息投资失败笔数失败笔数</th>
                                <th class="hidden-480">债权到期处理失败笔数</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <h5 class="blue">
                                        ${Info.count_investDuDate_fail}
                                    </h5>
                                </td>
                                <td>
                                    <h5 class="blue">
                                        ${Info.count_invest_fail}
                                    </h5>
                                </td>
                                <td>
                                    <h5 class="blue">
                                        ${Info.count_rate_fail}
                                    </h5>
                                </td>
                                <td>
                                    <h5 class="blue">
                                        ${Info.count_creditDuDate_fail}
                                    </h5>
                                </td>
                                <td>
                                <cm:securityTag privilegeString="CLAIM_DAY_END_TASKS_RUN">
                                    <form id="daytask" class="daytask MargT-5" action="daytask/task" method="POST">
                                        <button type="submit" class="btn btn-sm btn-blue" id="about-dialog-button-bar">开始跑批</button>
                                    </form>
                                    <form id="daytask" class="daytask MargT-5" action="daytask/task2" method="POST">
                                        <input type="text" id="current_date" name="current_date">
                                        <button type="submit" class="btn btn-sm btn-blue" id="about-dialog-button-bar2">生成利息以及复投</button>
                                    </form>
                                    </cm:securityTag>
                                </td>
                            </tr>
                            </tbody>

                        </table>
                        <br><br><br>
                        <table class="table table-striped table-bordered table-hover dataTable no-footer" aria-describedby="simpledatatable_info">
                                        <thead>
                                            <tr>
                                                <th>可用金额</th>
                                                <th class="hidden-480">未匹配金额</th>
                                                <th>已匹配金额</th>
                                                <th class="hidden-480">差额</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <h5 class="blue">
                                                        活期15号债权可用金额：${Info.loanMap.get("curr_c_15")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        活期15号未匹配投资金额：${Info.investMap.get("curr_a_15")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        活期15号已匹配投资金额*5%：<fmt:formatNumber value="${Info.investMap.get('curr_b_15')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        差额： <fmt:formatNumber value="${Info.loanMap.get('curr_c_15')-Info.investMap.get('curr_a_15')-Info.investMap.get('curr_b_15')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h5 class="blue">
                                                        定期15号债权可用金额：${Info.loanMap.get("fix_c_15")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        定期15号未匹配投资金额：${Info.investMap.get("fix_a_15")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        定期15号已匹配投资金额*5%： <fmt:formatNumber value="${Info.investMap.get('fix_b_15')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        差额： <fmt:formatNumber value="${Info.loanMap.get('fix_c_15')-Info.investMap.get('fix_a_15')-Info.investMap.get('fix_b_15')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h5 class="blue">
                                                        活期30号债权可用金额：${Info.loanMap.get("curr_c_30")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        活期30号未匹配投资金额：${Info.investMap.get("curr_a_30")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        活期30号已匹配投资金额*5%： <fmt:formatNumber value="${Info.investMap.get('curr_b_30')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        差额： <fmt:formatNumber value="${Info.loanMap.get('curr_c_30')-Info.investMap.get('curr_a_30')-Info.investMap.get('curr_b_30')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h5 class="blue">
                                                        定期30号债权可用金额：${Info.loanMap.get("fix_c_30")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        定期30号未匹配投资金额：${Info.investMap.get("fix_a_30")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        定期30号已匹配投资金额*5%：<fmt:formatNumber value="${Info.investMap.get('fix_b_30')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        差额： <fmt:formatNumber value="${Info.loanMap.get('fix_c_30')-Info.investMap.get('fix_a_30')-Info.investMap.get('fix_b_30')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                            </tr>
                                        </tbody>

                                    </table>
                        <br><br><br>
                        <table class="table table-striped table-bordered table-hover dataTable no-footer" aria-describedby="simpledatatable_info">
                                        <thead>
                                            <tr>
                                                <th>可用金额</th>
                                                <th class="hidden-480">债权金额</th>
                                                <th>已匹配金额</th>
                                                <th class="hidden-480">差额</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <h5 class="blue">
                                                        下账单日活期15号债权可用金额：${Info.loanMap.get("curr_e_15")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        下账单日到期活期15号债权金额：${Info.loanMap.get("curr_d_15")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        活期15号已匹配投资金额*5%：<fmt:formatNumber value="${Info.investMap.get('curr_b_15')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        差额： <fmt:formatNumber value="${Info.loanMap.get('curr_e_15')-Info.investMap.get('curr_d_15')-Info.investMap.get('curr_b_15')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h5 class="blue">
                                                        下账单日活期30号债权可用金额：${Info.loanMap.get("curr_e_30")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        下账单日到期活期30号债权金额：${Info.loanMap.get("curr_d_30")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        活期30号已匹配投资金额*5%： <fmt:formatNumber value="${Info.investMap.get('curr_b_30')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        差额： <fmt:formatNumber value="${Info.loanMap.get('curr_e_30')-Info.investMap.get('curr_d_30')-Info.investMap.get('curr_b_30')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h5 class="blue">
                                                        下账单日定期15号债权可用金额：${Info.loanMap.get("fix_e_15")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        下账单日到期定期15号债权金额：${Info.loanMap.get("fix_d_15")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        定期15号已匹配投资金额*5%： <fmt:formatNumber value="${Info.investMap.get('fix_b_15')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        差额： <fmt:formatNumber value="${Info.loanMap.get('fix_e_15')-Info.investMap.get('fix_d_15')-Info.investMap.get('fix_b_15')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <h5 class="blue">
                                                        下账单日定期30号债权可用金额：${Info.loanMap.get("fix_e_30")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        下账单日到期定期30号债权金额：${Info.loanMap.get("fix_d_30")}
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        定期30号已匹配投资金额*5%：<fmt:formatNumber value="${Info.investMap.get('fix_b_30')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                                <td>
                                                    <h5 class="blue">
                                                        差额：<fmt:formatNumber value="${Info.loanMap.get('fix_e_30')-Info.investMap.get('fix_d_30')-Info.investMap.get('fix_b_30')}" type="currency" pattern="0.00"/>
                                                    </h5>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                    </div>
                    <!-- /Page Body -->
                </div>
            <!-- /Page Content -->
        </div>
    </div>
    <%@include file="common/foot.jspf" %>
    <!--Page Related Scripts-->
    <!--Sparkline Charts Needed Scripts-->
    <script src="/assets/js/charts/sparkline/jquery.sparkline.js"></script>
    <script src="/assets/js/charts/sparkline/sparkline-init.js"></script>

    <!--Easy Pie Charts Needed Scripts-->
    <script src="/assets/js/charts/easypiechart/jquery.easypiechart.js"></script>
    <script src="/assets/js/charts/easypiechart/easypiechart-init.js"></script>

    <!--Flot Charts Needed Scripts-->
    <script src="/assets/js/charts/flot/jquery.flot.js"></script>
    <script src="/assets/js/charts/flot/jquery.flot.resize.js"></script>
    <script src="/assets/js/charts/flot/jquery.flot.pie.js"></script>
    <script src="/assets/js/charts/flot/jquery.flot.tooltip.js"></script>
    <script src="/assets/js/charts/flot/jquery.flot.orderBars.js"></script>
</body>
</html>

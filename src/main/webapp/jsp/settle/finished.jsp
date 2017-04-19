<%-- 
    Document   : settle
    Created on : Aug 23, 2013, 5:10:21 PM
    Author     : sobranie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <title>结算管理</title>
  <%@include file="../common/head.jspf" %>
</head>
<body class="navbar-fixed">
<%@include file="../common/navbar.jspf" %>

<div class="container-fluid main-container" id="main-container">
	 <div class="page-container">
		<%@include file="../common/sidebar.jspf" %>
	<div class="page-content">
            <div class="page-breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="fa fa-home"></i>
                        <a href="/">首页</a>
                    </li>
                    <li class="active">项目管理</li>
                    <li class="active">结算管理</li>

                </ul>
			</div>
          	<!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                      结算管理
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

			<div class="page-body">

		      <div class="tabbable">
		        <ul class="nav nav-tabs">
		          <li class="active">
		            <a data-toggle="tab" href="#manbiaoshenhe">
		              <i class="green icon-legal bigger-125"></i>  满标项目列表
		            </a>
		          </li>
		        </ul>

		        <div class="tab-content no-border">
		          <div id="manbiaoshenhe" class="tab-pane active">
		          		
					  <div class="buttons-preview Settle_btn">
						  <div class="horizontal-space"></div>
						  分类：
						  <a href="/settle/finished" class="btn btn-sky btn-sm">全部</a>
						  <a href="/settle/finished?productType=UPLAN" class="btn btn-sm">优选</a>
						  <a href="/settle/finished?productType=BBT" class="btn btn-sm">直投</a>
						  <div class="horizontal-space"></div>
					  </div>
		            <div class="space-6"></div>
		            <c:if test="${loanInvestInfoList.size() == 0}">
		              <div class="space-16"></div>
		              <div class="row-fluid">
		                <div class="span12">
		                  <div class="alert alert-success">
		                    暂时没有需要审核的满标项目。
		                  </div>
		                </div>
		              </div>
		            </c:if>

		            <c:forEach var="loanInvest" items="${loanInvestInfoList}">
		              <div class="space-16"></div>
					  <div class="row">
						  <div class="col-lg-12 col-sm-12 col-xs-12">
							  <div class="widget">
							<div class="widget-header">
								<c:if test="${loanInvest.productType == 'UPLAN'}">
									<div class="widget-caption blue Font-16"><a href="/uplan/details/${loanInvest.id}/showAllInfos"> ${loanInvest.title}&ensp;|&ensp; </a></div>
								</c:if>
								<c:if test="${loanInvest.productType == 'BBT'}">
									<div class="widget-caption blue Font-16"><a href="/loan/0/${loanInvest.id}">${loanInvest.title}&ensp;|&ensp; </a></div>
								</c:if>
									<span class="widget-caption F-right">
										<small>已满标&ensp;|&ensp;</small>
										<small>开始时间:<fmt:formatDate value="${loanInvest.openTime}" pattern="yy年MM月dd日 HH:mm:ss"/>&ensp;|&ensp;</small>
										<small>用时:<cm:timeString time="${loanInvest.finishedTime.time - loanInvest.openTime.time}"/>&ensp;|&ensp;</small>
										<small>总金额:<span class="red bold"><fmt:formatNumber type="currency" maxFractionDigits="0" value="${loanInvest.amount}"/></span>&ensp;|&ensp;</small>
										<small>投标数:<fmt:formatNumber value="${loanInvest.investedNumbers}"/>&ensp;|&ensp;</small>
										<small>投标金额:<span class="red bold"><fmt:formatNumber type="currency" maxFractionDigits="0" value="${loanInvest.investedAmount}"/></span>&ensp;|&ensp;</small>
									</span>
								<div class="widget-buttons">
									<a href="#" data-toggle="collapse">
										<i class="fa fa-minus blue"></i>
									</a>
								</div><!--Widget Buttons-->
							</div><!--Widget Header-->

		                
							  <div class="widget-body Loan-Info" style="display: block;">
								<table class="table table-hover dataTable no-footer" id="" aria-describedby="userList_info" role="grid" style="width: 100%;">
									<thead id="" class="bordered-blue">
									<tr role="row">
										<th class="sorting" rowspan="1" colspan="1" aria-label="投资者" style="width: 25%;"><i class="fa fa-user blue"></i> 投资者</th>
										<th class="sorting" rowspan="1" colspan="1" aria-label="金额" style="width: 25%;"><i class="fa fa-yen blue"></i> 金额</th>
										<th class="sorting" rowspan="1" colspan="1" aria-label="状态" style="width: 25%;"><i class="fa fa-gear blue"></i> 状态</th>
										<th class="sorting" rowspan="1" colspan="1" aria-label="投标时间" style="width: 25%;"><i class="fa fa-clock-o blue"></i>  投标时间</th>
									</tr>

									</thead>
									<tbody>
									<c:forEach var="invest" items="${loanInvest.investList}">
										<tr>
											<td>
													${invest.userName}
											</td>
											<td>
												<b class="green">
													<fmt:formatNumber type="currency" maxFractionDigits="0" value="${invest.amount}"/>
												</b>
											</td>
											<td class="hidden-phone">
												<c:if test="${invest.status == 'MATCHED'}">
													匹配成功
												</c:if>
												<c:if test="${invest.status == 'FINISHED'}">
													满标
												</c:if>
											</td>
											<td class="hidden-phone">
												<fmt:formatDate value="${invest.submitTime}" pattern="yy年MM月dd日 HH:mm:ss"/>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
		                    </div>
								  <cm:securityTag privilegeString="SETTLE_FINISHED_CONFIRM">
		                	<div class="widget-toolbar no-border MargT-10 clear" style="background: 0">
								  <a class="btn btn-sm btn-info pull-left settle-btn" href="/settle/${loanInvest.productType}/${loanInvest.id}">
									  <i class="fa fa-check"></i>
									  通过并结算
								  </a>
							  </div>
								  </cm:securityTag>
		                </div>
							  
		              </div>
						  </div>
		            </c:forEach>
		          </div>
		        </div>
		      </div>
           </div>
		</div>
	</div>
</div>

<div id="popMasker" class="modal hide fade">
  <div class="modal-header">
    <!--<button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="$('#rechargePanel').get(0).reset();">&times;</button>-->
    <h3><i class='icon-rocket'></i> <span id="maskerTitle">正在处理请求</span></h3>
  </div>
  <div class="modal-body relative">
    <div class="text-center">
      <div class="text-center grey">
        <h1><i class='icon-cog icon-spin'></i> 请稍后....</h1>
      </div>
    </div>
  </div>
</div>

<%@include file="../common/foot.jspf" %>

<script type="text/javascript">
  $('.settle-btn').click(function() {
    $('#popMasker').modal('show');
  });
  $('.cancel-btn').click(function() {
    $('#popMasker').modal('show');
  });
	// 选项卡
	$('.tab-content .tab-pane:gt(0)').hide();
	var li_tab = $('.nav-tabs li');	
	li_tab.click(function(){
		//alert(1);
		$(this).addClass('active').siblings().removeClass('active');
		
		$('.tab-content .tab-pane').eq(li_tab.index(this)).show().siblings().hide();
	});
	 var url=window.location.search;
	 var urlParams=url.split('=')[1];
	
	 $('.Settle_btn a').each(function(){
		 $('.Settle_btn a').removeClass('btn-sky');
	 });
	 
	if(urlParams=='UPLAN'){
		$('.Settle_btn a:eq(1)').addClass('btn-sky');
	}else if(urlParams=='BBT'){
		$('.Settle_btn a:eq(2)').addClass('btn-sky');

	}else{
		$('.Settle_btn a:eq(0)').addClass('btn-sky');

	}
</script>
</body>
</html>

<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/18
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>用户列表 系统测试平台</title>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
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
                    <li class="active">系统管理</li>
                    <li class="active">用户管理</li>
                    <li class="active">用户列表</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                        用户列表
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
                <div class="well">
                    <div class="table-toolbar">
                   <%--  <cm:securityTag privilegeString="USER_ADD"> --%>
                        <a id="createUser" onclick="showSingleUser()" href="javascript:void(0);" class="btn btn-default">
                            <i class="fa fa-plus"></i> 增加用户
                        </a>
                    <%--     </cm:securityTag> --%>
                        
                        <cm:securityTag privilegeString="USER_DOWNLOAD">
                        <a  class="btn btn-small "
                           data-toggle="modal"
                           href="/user/download">
                            <i class="fa fa-download"></i>下载列表
                        </a>
                        </cm:securityTag>
                    </div>
                    <table class="table table-hover" id="userList" aria-describedby="simpledatatable_info">
                        <thead id="list_th" class="bordered-blue">
                        <tr>
                            <th class="hidden-480">登录名</th>
                            <th>姓名</th>
                            <th>身份证号码</th>
                            <th><i class="fa fa-mobile bigger-120"></i> 手机号码</th>
                            <th><i class="fa fa-email bigger-110"></i> 电子邮箱</th>
                            <th><i class="fa fa-clock-o hidden-phone"></i> 上次登录</th>
                            <th><i class="fa fa-clock-o hidden-phone"></i> 注册时间</th>
                            <th><i class="fa fa-user hidden-phone"></i> 推荐人</th>
                            <th><i class="fa fa-exchange hidden-phone"></i> 来源</th>
                            <th><i class="fa fa-cog"></i> 操作</th>
                        </tr>
                        </thead>
                        <tbody >

                        </tbody>
                    </table>
                </div>



            </div>
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>
<!--用户信息模板-->
<script id="singleUser-template" type="text/x-handlebars-template">
        <div class="row">
            <div class="col-md-12">
                <ul class="nav nav-pills" id="userType">
                    <li data-type=per style="cursor:pointer" class="active">
                        <a data-toggle="tab">
                            个人用户
                        </a>
                    </li>
                    <li data-type=en style="cursor:pointer">
                        <a data-toggle="tab">
                            企业用户
                        </a>
                    </li>
                </ul>
                <form id="userForm" class="form-horizontal" action="/user/create" method="POST">
                    <!--个人用户-->
                    <div id="perInfo">
                        <input type="hidden"
                               name="enterprise"
                               value="false"/>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="loginName">用户登录名:</label>
                            <div class="controls col-lg-6">
                                <input id="loginName" class="form-control"
                                       type="text"
                                       name="loginName"
                                       placeholder=""
                                       value="{{loginName}}"/>
                                <input id="userId"
                                       type="hidden"
                                       name="userId"
                                       value="{{userId}}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="name">用户姓名:</label>
                            <div class="controls col-lg-6">
                                <input id="name" class="form-control"
                                       type="text"
                                       name="userName"
                                       data-bv-notempty="true"
                                       data-bv-notempty-message="请输入用户姓名"
                                       placeholder=""
                                       value="{{userName}}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="IdNumber">用户身份证号:</label>
                            <div class="controls col-lg-6">
                                <input id="IdNumber" class="form-control"
                                       type="text"
                                       name="idNumber"
                                       placeholder=""
                                       value="{{idNumber}}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="userMobile">用户手机号:</label>
                            <div class="controls col-lg-6">
                                <input id="userMobile" class="form-control"
                                       type="text"
                                       name="userMobile"
                                       placeholder=""
                                       value="{{userMobile}}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="employeeId">电子邮箱:</label>

                            <div class="controls col-lg-6">
                                <input id="employeeId" class="form-control"
                                       type="text"
                                       name="email"
                                       value="{{email}}"/>
                            </div>
                        </div>
                    </div>
                </form>
                <form id="enUserForm" class="form-horizontal" action="/user/create" method="POST">
                    <!--企业用户-->
                    <div id="enInfo" style="display: none">
                        <input type="hidden"
                               name="enterprise"
                               value="true"/>
                        <input id="enUserId"
                               type="hidden"
                               name="userId"
                               value="{{userId}}"/>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="enLoginName">登录名(企业简称):</label>
                            <div class="controls col-lg-6">
                                <input id="enLoginName" class="form-control"
                                       type="text"
                                       name="loginName"
                                       placeholder=""
                                       value="{{loginName}}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="enUserName">企业名称(全称):</label>
                            <div class="controls col-lg-6">
                                <input id="enUserName" class="form-control"
                                       type="text"
                                       name="userName"
                                       data-bv-notempty="true"
                                       data-bv-notempty-message="请输入企业名称(全称)"
                                       placeholder=""
                                       value="{{userName}}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="enLicenseNo">营业执照编号:</label>
                            <div class="controls col-lg-6">
                                <input id="enLicenseNo" class="form-control"
                                       type="text"
                                       name="enLicenseNo"
                                       data-bv-notempty="true"
                                       data-bv-notempty-message="请输入营业执照编号"
                                       placeholder=""
                                       value="{{enLicenseNo}}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="enIdNumber">法人身份证号:</label>
                            <div class="controls col-lg-6">
                                <input id="enIdNumber" class="form-control"
                                       type="text"
                                       name="idNumber"
                                       placeholder=""
                                       value="{{idNumber}}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="enUserMobile">法人手机号:</label>
                            <div class="controls col-lg-6">
                                <input id="enUserMobile" class="form-control"
                                       type="text"
                                       name="userMobile"
                                       value="{{userMobile}}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="bankName">银行类型:</label>
                            <div class="controls col-lg-6">
                                <select id="bankName" name="bankName">
                                    <option value="ICBC">中国工商银行</option>
                                    <option value="ABC">中国农业银行</option>
                                    <option value="BOC">中国银行</option>
                                    <option value="CCB">中国建设银行</option>
                                    <option value="COMM">交通银行</option>
                                    <option value="CMB">招商银行</option>
                                    <option value="CEB">中国光大银行</option>
                                    <option value="HXB">华夏银行</option>
                                    <option value="CMSB">民生银行</option>
                                    <option value="SPDB">浦发银行</option>
                                    <option value="CGB">广发银行</option>
                                    <option value="CNCB">中信银行</option>
                                    <option value="PAB">平安银行</option>
                                    <option value="PSBC">邮政储蓄</option>
                                    <option value="CIB">兴业银行</option>
                                    <option value="BCCB">北京银行</option>
                                    <option value="BOS">上海银行</option>
                                    <option value="NBCB">宁波银行</option>
                                    <option value="GCB">广州银行</option>
                                    <option value="HZCB">杭州银行</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="cardNo">公司银行卡号:</label>
                            <div class="controls col-lg-6">
                                <input id="cardNo" class="form-control"
                                       type="text"
                                       name="cardNo"
                                       data-bv-notempty="true"
                                       data-bv-notempty-message="请输入公司银行卡号"
                                       value="{{cardNo}}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-4" for="enEmail">企业邮箱:</label>
                            <div class="controls col-lg-6">
                                <input id="enEmail" class="form-control"
                                       type="text"
                                       name="email"
                                       value="{{email}}"/>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="form-group">
                    <label class="control-label col-lg-4"></label>
                    <div class="controls col-lg-6">
                        <button id="saveBtn" class="btn btn-primary" onclick="editOrAdd()">保存记录</button>
                        <button type="reset" class="btn">重置</button>
                    </div>
                </div>
            </div>
        </div>


</script>
<script id="editUser" type="text/x-handlebars-template">
<cm:securityTag privilegeString="USER_ALTER">
    <div class="btn-group btn-group-justified" style="width: 75px">
        <a class="btn btn-xs btn-info"  title="编辑" onclick="showSingleUser(true,'/user/edit/?id={{userId}}')"><i class="fa fa-edit"></i>&nbsp;</a>
        {{#if isEnabled}}
            <a class="btn btn-danger btn-xs ban" title="禁用" onclick="showConfirm('确定要禁用 【{{loginname}}】 么？','/user/disable/{{userId}}')"><i class="fa fa-ban"></i>&nbsp;</a>
        {{else}}
            <a class="btn btn-success btn-xs ban" title="启用" onclick="showConfirm('确定要启用 【{{loginname}}】 么？','/user/enable/{{userId}}')"><i class="fa fa-check"></i>&nbsp;</a>
        {{/if}}

		{{#if referralLoginName}}
            
        {{else}}
            <a class="btn btn-xs btn-yellow"  title="补充推荐人" onclick="showRecommend('{{userId}}')"><i class="fa fa-crosshairs"></i>&nbsp;</a>
        {{/if}}
		 
    </div>
</cm:securityTag>
</script>
<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/customerBootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/bbtTool.js"></script>

<script>
   
    var source = {};
    <c:forEach var="s" items="${Source}">
    source['${s}'] = '${s.key}';
    </c:forEach>

</script>


<!--推荐人信息模板-->
<script id="recommend-template" type="text/x-handlebars-template">
    <form id="recommendForm" class="form-horizontal" action="/user/saveRerralInfoForUser" method="POST">
        <div class="row">
            <div class="col-md-12">                
                <div class="form-group">
                    <label class="control-label col-lg-4" for="referralUserMobile">推荐人手机号:</label>
                    <div class="controls col-lg-6">
                        <input id="referralUserMobile" class="form-control"
                               type="text"
                               name="referralUserMobile"
                               placeholder=""
                               value="{{referralUserMobile}}"/>
	
						<input type="hidden" name="userId" value="{{userId}}" />
                    </div>
                </div>
				<div class="form-group">
                    <label class="control-label col-lg-4"></label>
                    <div class="controls col-lg-6">
                        <span id="recommendUserMobileMessage" class="red"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-4"></label>
                    <div class="controls col-lg-6">
                        <button type="submit" class="btn btn-primary">保存</button>
                    </div>
                </div>
            </div>
        </div>

    </form>
</script>

<script src="/assets/js/user/userList.js"></script>
</body>
</html>
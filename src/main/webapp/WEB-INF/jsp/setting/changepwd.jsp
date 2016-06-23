<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/25
  Time: 12:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>修改密码 千金所测试平台</title>
    <meta name="description" content="千金所测试平台管理系统" />
    <%@include file="../common/head.jspf" %>
    <%--<link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />--%>
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
                    <li class="active">系统设置</li>
                </ul>
            </div>
            <!-- /Page Breadcrumb -->
            <!-- Page Header -->
            <div class="page-header position-relative">
                <div class="header-title">
                    <h1>
                       修改密码
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
            <!-- Page Header -->
             <div id="page-body" class="clearfix page-body">
            <div class="space-6"></div>

            <div class="row-fluid">
                <form class="form-horizontal changePwdF" method="POST" action="/setting/changepwd">
                    <div class="tabbable">
                        <ul class="nav nav-tabs padding-16">
                            <li class="active">
                                <a data-toggle="tab" href="#edit-password">
                                    <i class="blue fa fa-key"></i>  修改密码
                                </a>
                            </li>
                        </ul>

                        <div class="tab-content profile-edit-tab-content">

                            <div id="edit-password" class="tab-pane in active">
                               <div class="form-horizontal">

                                <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right" for="pwd">原有密码</label>

                                    <div class="col-sm-4">
                                        <input type="password"
                                               id="pwd"
                                               name="pwd"
                                               autocomplete="off"

                                               class="form-control"
                                               VALUE=""
                                               />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right" for="newPwd">新密码</label>

                                    <div class="col-sm-4">
                                        <input type="password"
                                               id="newPwd"
                                               name="newPwd"
                                               autocomplete="off"
                                               class="form-control"
                                               />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label no-padding-right" for="pwdConfirm">确认密码</label>
                                    <div class="col-sm-4">                                 
                                        <input type="password" id="pwdConfirm" name="pwdConfirm"
                                               autocomplete="off"
                                                class="form-control"
                                               />
                                    </div>
                                </div>

                                <div class="form-group">
                                	<label class="col-sm-2 control-label no-padding-right" for=""></label>

                                    <div class="col-sm-4">
                                    	<button class="btn btn-info" type="submit">
                                        	<i class="fa fa-check"></i> 保存
                                    	</button>
                                    	&nbsp; &nbsp;
                                    	<button class="btn" type="reset">
                                        	<i class="fa fa-refresh"></i>  重置
                                    	</button>
                                    </div>
            
                                </div>

							</div>

                            </div>

                        </div>

                    </div>


                </form>
            </div>
        

           
            <!-- /Page Body -->
        </div>
        <!-- /Page Content -->
    </div>
</div>

</div>
<%@include file="../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>

<script type="text/javascript">
    $('.changePwdF').bootstrapValidator({
        excluded: [':disabled'],
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        submitHandler: function (validator, form, submitButton) {
            console.log(form);
            validator.defaultSubmit();
        },
        fields: {
            pwd: {
                validators: {
                    notEmpty: {
                        message: '原有密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        message: '原有密码不少于6位'
                    }
                }
            },
            newPwd: {
                validators: {
                    notEmpty: {
                        message: '新密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        message: '新密码不少于6位'
                    }
                }
            },
            pwdConfirm: {
                validators: {
                    notEmpty: {
                        message: '确认密码不能为空'
                    },
                    stringLength: {
                        min: 6,
                        message: '用户密码不少于6位'
                    },
                    identical: {
                        field: 'newPwd',
                        message: '两次输入的密码不一致'
                    }
                }
            }
        }
    });
</script>
<c:if test="${messages!= null}">
    <script type="text/javascript">
        if ('${messages[0]}'.length) {
            Notify(${messages[1]}, 'top-right', '5000', 'danger', 'fa-check', false);
            /*$.gritter.add({
                // (string | mandatory) the heading of the notification
                title: '${messages[0]}',
                // (string | mandatory) the text inside the notification
                text: '${messages[1]}',
                time: 3000,
                fade_out_speed: 1000
            });*/
        }
    </script>
</c:if>
</body>
</html>

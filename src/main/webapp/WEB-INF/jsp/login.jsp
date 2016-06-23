
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
	<title>登录</title>
    <%@include file="common/head.jspf" %>

</head>
<body>
<div class="login-container animated fadeInDown">
    <div class="loginbox bg-white">
        <form id="loginForm" class="loginform" action="${pageContext.request.contextPath}/login.do" method="POST">

        <div class="loginbox-title">员工登录</div>
            <div class=""></div><br/>
        <div class="loginbox-textbox form-group">
            <input name="loginName" type="text" class="form-control" placeholder="员工登录名" />
            ${errors}
        </div>
        <div class="loginbox-textbox form-group">
            <input name="password"  class="form-control" type="password" placeholder="登录密码" />
        </div>
       <%-- <div class="loginbox-textbox">
            <input type="text" class="form-control" placeholder="验证码" />
        </div>--%>
       <%-- <div class="loginbox-forgot">
            <a href="">Forgot Password?</a>
        </div>--%>
        <div class="loginbox-submit">
            <button type="submit" class="btn btn-primary btn-block">登录</button>
        </div>
        <%--<div class="loginbox-signup">
            <a href="register.html">Sign Up With Email</a>
        </div>--%>
       </form>
    </div>
    <div class="logobox">
    </div>
</div>
<%@include file="/common/foot.jspf" %>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<!-- <script>

    $('#loginForm').validate({
        /* 设置验证规则 */
        rules: {
            username: {
                required: true,
                remote: {
                    //验证用户名是否存在
                    type: "POST",
                    url: "/login/queryUname",
                    data: {
                        uname: function () {
                            return $("#username").val();
                        }
                    }
                }
            },
            pwd: {
                required: true,
                minlength: 5,
                maxlength: 20
            }
        },
        /* 设置错误信息 */
        messages: {
            username: {
                required: "请输入您的手机号/用户名",
                remote: "手机号/用户名不存在"
            },
            mobilePhone:{
                required: "请输入您的手机号码",
                minlength: "请输入正确的手机",
                maxlength: "请输入正确的手机",
                remote: "该手机号码已经存在"
            },
            pwd: {
                required: "请输入您的密码",
                minlength: "密码长度在6-20个字符之间",
                maxlength: "密码长度在6-20个字符之间"
            },
            validateCode:{
                required: "请填写验证码.",
                remote: "验证码不正确."
            }
        },

        /* 设置验证触发事件 */
        focusInvalid: false,
        onkeyup: false,

        /* 设置错误信息提示DOM */
        errorPlacement: function(error, element) {
            error.appendTo( element.parent().next());
        }
    });
</script> -->
</body>
</html>

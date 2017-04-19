<%--
  Created by IntelliJ IDEA.
  User: meng
  Date: 2015/6/18
  Time: 15:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" %>
<div class="widget">
    <div class="widget-header bordered-bottom bordered-sky">
        <span class="widget-caption">员工记录</span>
        <div class="widget-buttons">

            <a href="#" data-toggle="dispose">
                <i class="fa fa-times"></i>
            </a>
        </div>
    </div><!--Widget Header-->
    <div class="widget-body">
        <form id="employeeForm" class="form-horizontal" action="/employee/create" method="POST">
            <input type="hidden" name="empId" value="${employee.id}"/>
            <div class="control-group">
                <label class="control-label" for="loginName">员工登录名:</label>
                <div class="controls">
                    <input id="loginName"
                           type="text"
                           name="loginName"
                           required
                           data-validation-required-message="请输入员工登录名"
                           minlength="3"
                           data-validation-minlength-message="登录名最少3位字母/数字"
                           data-validation-ajax-ajax="employee/checkLoginName"
                           placeholder="lijianguo"
                           value="${employee.loginName}"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">员工姓名:</label>
                <div class="controls">
                    <input id="name"
                           type="text"
                           name="name"
                           required
                           data-validation-required-message="请输入员工姓名"
                           placeholder="李建国"
                           value="${employee.name}"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="IdNumber">员工身份证号:</label>
                <div class="controls">
                    <input id="IdNumber"
                           type="text"
                           name="idNumber"
                           required
                           data-validation-required-message="请输入员工身份证号"
                           pattern="[1-9][0-9]{16}[0-9xX]"
                           data-validation-pattern-message="身份证号码格式不正确"
                           placeholder="110105198304299999"
                           value="${employee.idNumber}"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="mobile">员工手机号:</label>
                <div class="controls">
                    <input id="mobile"
                           type="text"
                           name="mobile"
                           required
                           data-validation-required-message="请输入员工手机号"
                           pattern="1\d{10}"
                           data-validation-pattern-message="请输入有效的11位数字手机号码"
                           placeholder="13800138000"
                           value="${employee.mobile}"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="employeeId">员工唯一号:</label>
                <div class="controls">
                    <input id="employeeId"
                           type="text"
                           name="employeeId"
                           data-validation-ajax-ajax="/employee/checkEmployeeId"
                           placeholder="0001"
                           value="${employee.employeeId}"/>
                </div>
            </div>
            <div class="form-actions">
                <input type="submit" class="btn btn-primary" value="保存记录"></input>
                <input type="reset" class="btn" value="重置"></input>
            </div>
        </form>
    </div><!--Widget Body-->
</div>
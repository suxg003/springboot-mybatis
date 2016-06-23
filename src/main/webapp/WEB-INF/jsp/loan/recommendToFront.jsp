<%--
  Created by IntelliJ IDEA.
  User: lxl
  Date: 15/7/6
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="$('#loanForm').get(0).reset();">&times;</button>
  <h3>推荐标详情</h3>
</div>
<div class="modal-body">
  <div class="row-fluid">
    <form id="loanForm" class="form-horizontal" action="" method="POST" novalidate>
      <input type="hidden" name="loanid" value="${rmbLoan.loanId}"/>
      <input type="hidden" name="iconUrl" id="iconUrl"/>
      <div class="control-group">
        <label class="control-label" for="loanTitle">标题:</label>
        <div class="controls">
          <input id="loanTitle"
                 type="text"
                 name="loanTitle"
                 placeholder=""
                 required
                 data-validation-required-message="请输入标的名称"
                 pattern="[a-zA-Z0-9_\u4e00-\u9fb9]*"
                 value="${rmbLoan.loanTitle}" />
        </div>
      </div>

      <div class="control-group">
        <label class="control-label" for="loanType">类型:</label>
        <div class="controls">
          <select id="loanType" name="loanRecommendType" class="selectpicker">
            <option value="">全部类型</option>
            <c:forEach var="type" items="${loanRecommendTypes}">
              <option value="${type}">${type.key}</option>
            </c:forEach>
          </select>
        </div>
      </div>
      <div class="control-group">
        <%--@declare id="cbcontainer"--%><label class="control-label" for="cbcontainer">图片列表</label>
        <div class="controls">
          <div class="row-fluid cbcontainer">
            <ul class="ace-thumbnails"></ul>
            <div id="uploadImageBtn">
              <i class="icon-plus-sign"></i> 上传图片
            </div>
            <%--@javascript create form for imageUpload--%>
          </div>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label"></label>
        <input type="button" id="recommendConfirm" class="btn btn-primary" value="确认推荐" />
      </div>
    </form>
  </div>
</div>

<%@include file="../common/foot.jspf" %>
<script src="js/moment.min.js"></script>
<script src="js/main.js"></script>
<!-- jquery dataTables -->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script src="/assets/js/loan/recommendToFront.js"></script>


<script type="text/template" id="cbLiTemplate">
  <li>
    <a href="link1" target="_blank" data-rel="colorbox">
      <img alt="150x150" src="link2" />
    </a>
    <div class="imageInfo">
      <button class="btn btn-light btn-mini copyUrlBtn" data-clipboard-text="link3"><i class="icon-copy hidden"></i></button>
    </div>
  </li>
</script>

<link rel="stylesheet" href="/assets/css/referral.css" />
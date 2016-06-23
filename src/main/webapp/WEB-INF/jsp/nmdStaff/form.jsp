<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>发布新</title>
    <%@include file="../common/head.jspf" %>
    <link rel="stylesheet" href="/assets/css/uplan/newPlan.css"/>
    <link rel="stylesheet" href="/assets/css/dataTables.bootstrap.css"/>

</head>
<body class="navbar-fixed">
<%@include file="../common/navbar.jspf" %>
	<form id="inputForm" action="" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label">名称:</label>
			<div class="controls">
				<input path="name" htmlEscape="false" maxlength="200" class="required"/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form>
<%@include file="../common/foot.jspf" %>
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
<script type="text/javascript" src="/assets/js/uplan/uplanManager/newPlan.js"></script>

</body>
</html>

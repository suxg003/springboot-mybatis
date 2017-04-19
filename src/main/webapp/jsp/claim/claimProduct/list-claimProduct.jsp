<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="cm" uri="/WEB-INF/tld/cm.tld" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>系统测试平台</title>
    <meta name="description" content="系统测试平台管理系统" />
    <%@include file="../../common/head.jspf" %>
    <link href="/assets/css/dataTables.bootstrap.css" rel="stylesheet" />
</head>
<body>
<%@include file="../../common/navbar.jspf" %>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>名称</th><th>备注</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="claimProduct">
			<tr>
				<td><a href="claimProduct/form?id=${claimProduct.id}">${claimProduct.name}</a></td>
				<td>${claimProduct.remarks}</td>
				<td>
    				<a href="claimProduct/form?id=${claimProduct.id}">修改</a>
					<a href="claimProduct/delete?id=${claimProduct.id}" onclick="return confirm('确认要删除该记录吗？', this.href)">删除</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
<%@include file="../../common/foot.jspf" %>
<!--Page Related Scripts-->
<script src="/assets/js/datatable/jquery.dataTables.min.js"></script>
<script src="/assets/js/datatable/ZeroClipboard.js"></script>
<script src="/assets/js/datatable/dataTables.tableTools.min.js"></script>
<script src="/assets/js/datatable/dataTables.bootstrap.min.js"></script>
<script src="/assets/js/datatable/datatables-init.js"></script>
<script src="/assets/js/handlebars/handlebars.min.js"></script>
<script src="/assets/js/validation/bootstrapValidator.js" type="text/javascript"></script>
<script src="/assets/js/bootbox/bootbox.js"></script>
<script src="/assets/js/amountFormat.js"></script>
<script src="/assets/js/bbtTool.js"></script>
<script src="/assets/js/uplan/uplanManager/planList.js" type="text/javascript"></script>
</body>
</html>

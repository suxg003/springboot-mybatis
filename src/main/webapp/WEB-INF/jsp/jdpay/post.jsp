<%@page contentType="text/html" pageEncoding="GBK"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=GBK">
        <title>����ת�������֧��ҳ��</title>
        <link rel="stylesheet" href="../css/font-awesome.min.css" />
        <link rel="stylesheet" href="../css/payment.css" />

        <script>
            function submit() {
                document.getElementById("form").submit()
            }
        </script>

        <style type="text/css">
            body {
                padding-top: 200px;
                text-align: center; 
                font-family: "Microsoft Yahei";
            }
        </style>
    </head>
    <body onload="submit()">
        <div class="subText"><i class="icon-rocket"></i> ����ת�������֧��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="mainText dark-grey"><i class='icon-cog icon-spin'></i> ���Ժ򡣡���</div>
        <div class="logo"><img src="../img/logo.png" alt="" /></div>

        <form id="form" action="${url}" method="POST">
            <c:forEach var="entry" items="${it}">
                <input type="hidden" name="${entry.key}" value="${entry.value}"/>
            </c:forEach>
        </form>

    </body>
</html>

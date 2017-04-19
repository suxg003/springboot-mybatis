<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="MobilePayPlatform"  content="${response}"/>
        <title>${action}结果 - ${appBean.client.title}</title>
        <link rel="stylesheet" href="../css/font-awesome.min.css" />
        <link rel="stylesheet" href="../css/payment.css" />
    </head>
    <body id="page-payment-payresult">
        <div class="mainText"><i class='icon-ok-sign'></i> ${action}${result}</div>
        <div class="subText"><i class="icon-reply"></i> 本页面将在 <span id="countText"></span> 秒后自动关闭 <a class="btn btn-small btn-primary" href="javascript:window.open('', '_self', ''); window.close();">立即关闭</a></div>
        <script type="text/javascript">
            var count = 5;
            document.getElementById("countText").innerHTML = count;
            var timer = setInterval(function() {
                count = count - 1;
                document.getElementById("countText").innerHTML = count;
                if (count === 0) {
                    window.open('', '_self', '');
                    if(typeof android === 'undefined'){
                        window.close();
                    }else{
                        android.success();
                    }
                }
            }, 1000);
        </script>
    </body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>连连支付测试</title>
</head>
<body>
	<!-- 支付测试   -->
	<h1>支付测试</h1>
	<form action="/llpay/authpay">
		用户id：<input type="text" id="user_id" name="user_id"><br>
		金额：<input type="text" id="money_order" name="money_order"><br>
		卡号：<input type="text" id="card_no" name="card_no"><br>
		<input type="submit" id="chongzhi" value="连连支付提交">
	</form>
	
	<h1>订单查询测试</h1>
	<form action="/llpay/orderQuery">
		订单号：<input type="text" id="no_order" name="no_order"><br>
		订单时间：<input type="text" id="dt_order" name="dt_order"><br>
		<input type="submit" id="orderQuery" value="提交">
	</form>
	
	<h1>卡bin查询测试</h1>
	<form action="/llpay/bankCardQuery">
		卡号：<input type="text" id="card_no" name="card_no"><br>
		<input type="submit" id="bankCardQuery" value="提交">
	</form>
	
	<h1>用户签约信息查询测试</h1>
	<form action="/llpay/userBankCard">
		用户id：<input type="text" id="user_id" name="user_id"><br>
		<input type="submit" id="userBankCard" value="提交">
	</form>
	
	<h1>用户解约测试</h1>
	<form action="/llpay/bankCardUnbind">
		用户id：<input type="text" id="user_id" name="user_id"><br>
		签约号：<input type="text" id="no_agree" name="no_agree"><br>
		<input type="submit" id="bankCardUnbind" value="提交">
	</form>
	
	<h1>京东网银支付测试</h1>
	<form action="/jdpay/pay">
		金额：<input type="text" id="v_amount" name="v_amount"><br>
		<input type="submit" id="zhifu" value="京东支付提交">
	</form>
</body>
</html>
<%
/* -----------------------------------------------------------------------------
 * Project Title	: 모니터링(PL/APL자동상환) - 팝업창
 * File Name		: realtime_aplpay.jsp
 * Programmer		: 
 * First Write		: 2004.12.08
 * Last Update		: 2004.12.08
 * R&D         		: CI
 * ---------------------------------------------------------------------------*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>

<jsp:useBean id="repayment1" 	class="anyframe.data.DataSet" scope="request"/>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>

<body>
<center>
    <table width="520">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
			<td><img src="/img/common/bu_cir01.gif"> <b>자동상환 신청(증권번호:<%=repayment1.getText("policy_no")+")"%></b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
					<col width=30%><col width=35%><col width=35%> 
					<tr> 
						<th>구분</th>
						<th>상환약정금액</th>
						<th>상환개시일</th>
					</tr>
					<tr> 
						<td><%=repayment1.getText("opt2_name")%></td>
						<td><%=Util.addComma(anyframe.util.StringFormater.removeZero(repayment1.getText("pay_amt")))%></td>
<%
						String pay_date = "";
						pay_date = repayment1.getText("pay_date").trim();
						if(pay_date.length() > 7)
						{
							pay_date = pay_date.substring(0,4) +"."+ pay_date.substring(4,6) +"."+ pay_date.substring(6,8);
						}
%>						
						<td><%=pay_date%></td>
					</tr>
				</table></td>
		</tr>
		<tr> 
			
      <td align="right"><a href="javascript:window.close();" onFocus="blur()"><img src="/img/common/btn_ok.gif" hspace="10"></a></td>
		</tr>
	</table>
</center>
</body>
</html>

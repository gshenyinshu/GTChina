<%
/* -----------------------------------------------------------------------------
 * Project Title	: 모니터링(SNC특약부가) - 팝업창
 * File Name		: realtime_SNC.jsp
 * Programmer		: 
 * First Write		: 2007.06.20
 * Last Update		: 2007.06.20
 * R&D         		: CI
 * ---------------------------------------------------------------------------*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>

<jsp:useBean id="billingfre1" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="billingfre2" 	class="anyframe.data.DataSet" scope="request"/>
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
			<td><img src="/img/common/bu_cir01.gif"> <b>SNC부가(증권번호:<%=billingfre2.getText("policy_no")+")"%></b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
					<col width=30%><col width=35%><col width=35%> 
					<tr> 
						<th>구분</th>
						<th>변경후</th>
						<th>변경전</th>
					</tr>
					<tr> 
						<td>납입주기</td>
						<td><%=billingfre2.getText("mode").trim()%></td>
						<td><%=billingfre1.getText("mode").trim()%></td>
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

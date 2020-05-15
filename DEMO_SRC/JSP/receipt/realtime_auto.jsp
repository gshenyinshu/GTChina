<%
/* -----------------------------------------------------------------------------
 * Project Title	: 모니터링(자동이체관련) - 팝업창
 * File Name		: realtime_auto.jsp
 * Programmer		: 
 * First Write		: 2004.12.08
 * Last Update		: 2004.12.08
 * R&D         		: CI
 * ---------------------------------------------------------------------------*/
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>

<jsp:useBean id="account1" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="account2" 	class="anyframe.data.DataSet" scope="request"/>

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
			<td><img src="/img/common/bu_cir01.gif"> <b>자동이체관련(증권번호:<%=account2.getText("policy_no")+")"%></b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
					<col width=%><col width=40%><col width=40%>   
					<tr> 
						<th>구분</th>
						<th>변경후</th>
						<th>변경전</th>
					</tr>
					<tr> 
						<td>계좌</td>
						<td><%=account2.getText("bank_name")%>&nbsp<%=account2.getText("account_code")%></td>
						<td><%=account1.getText("bank_name")%>&nbsp<%=account1.getText("account_code")%></td>
					</tr>
					<tr> 
						<td>예금주</td>
						<td><%=account2.getText("account_name")%></td>
						<td><%=account1.getText("account_name")%></td>
					</tr>
					<tr> 
						<td>이체일</td>
						<td><%=account2.getText("fb_day")%></td>
						<td><%=account1.getText("fb_day")%></td>
					</tr>
					<tr>
						<td>그룹빌링</td>
						<td><%=account2.getText("group_yn")%></td>
						<td><%=account1.getText("group_yn")%></td>
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

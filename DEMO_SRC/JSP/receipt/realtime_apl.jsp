<%
/* -----------------------------------------------------------------------------
 * Project Title	: ����͸�(APL��û�� ����) - �˾�â
 * File Name		: realtime_apl.jsp
 * Programmer		: 
 * First Write		: 2004.12.08
 * Last Update		: 2004.12.08
 * R&D         		: CI
 * ---------------------------------------------------------------------------*/
%>
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<jsp:useBean id="aplin1" 	class="anyframe.data.DataSet" scope="request"/>

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
			<td><img src="/img/common/bu_cir01.gif"> <b>APL��û/����(���ǹ�ȣ:<%=aplin1.getText("policy_no")+")"%></b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
					<col width=30%><col width=35%><col width=35%> 
					<tr> 
						<th>����</th>
						<th>������</th>
						<th>������</th>
					</tr>
					<tr> 
						<td>APL��û����</td>
						<td><%=aplin1.getText("nf_opt").trim()%></td>
<%
						String nf_opt1 = "";
						String nf_mes = "";
						nf_opt1 = aplin1.getText("nf_opt1").trim();
						if(nf_opt1.equals("4"))
							nf_mes = "����";
						else if(nf_opt1.equals("9"))	
							nf_mes = "��û";
							
%>						
						
						<td><%=nf_mes%></td>
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

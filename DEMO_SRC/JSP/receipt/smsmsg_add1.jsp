
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>

<jsp:useBean id="smsupt" 	class="anyframe.data.DataSet" scope="request"/>
<%
	String      smsgubun   	 = request.getParameter("smsgubun")	== null ? "        " : request.getParameter("smsgubun");
	String      seq_no   	 = request.getParameter("seq_no")	== null ? "        " : request.getParameter("seq_no");
	String srvc_name ="";
	String call_back = "";
	String send_msg = "";
	String send_err  = "";
	int cnt = smsupt.getCount("seq_no");
	if(cnt > 0)
	{
		srvc_name = smsupt.getText("srvc_name",0);
		call_back = smsupt.getText("call_back",0);
		send_msg = smsupt.getText("send_msg",0);
		send_err = smsupt.getText("send_err",0);
	}
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<script language="JavaScript">
<!--
	function goSave()
	{
		form = document.smsForm;
		form.action = "smsmsg_add1.do";
		
		var temp = '<%=smsgubun%>';
		if(temp == "U")
		{
			form.smsgubun.value = "UW";	
		}
		else
		{
			form.smsgubun.value = "I";
		}
		form.cpflag.value = 'P';		
		form.submit();	
		opener.winreflash();	
		window.close();
	}
-->
</script>

<body>
<form name="smsForm"  method="post">
<input type="hidden" name="smsgubun" value="">
<input type="hidden" name="cpflag"  value="">
<input type="hidden" name="seq_no"  value="<%=seq_no%>">
<center>
    <table width="600">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
			<td><img src="/img/common/bu_cir01.gif"> <b>SMS ����</b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td height="284"><table width="100%" class="adm_table">
					<col width=25%><col width=> 
					<tr> 
						<th>��&nbsp;&nbsp;��</th>
						<th>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</th>
					</tr>
					<tr> 
						<td>�� �� ��</td>
						<td><div align="center">
<%
						if(smsgubun.equals("U"))
						{
%>						
						<input type="text" name="srvc_name"  value="<%=srvc_name%>"   size="40" style="background-color:white; border-width:0; text-align:center;border-color:black; border-style:solid;" readonly> 
<%
						} 
						else
						{
%>						
						<input name="srvc_name" type="text" size="40" maxlength="80" value="<%=srvc_name%>" >
<%
						}
%>
						</div></td>
					</tr>
					
					<tr> 
						<td>�� �� ��</td>
						<td>��Ƽ�����̹�</td>
					</tr>
					<tr> 
						<td>ȸ����ȭ</td>
						<td><input type="text" name="call_back"  value="15883374"   size="40" style="background-color:white; border-width:0; text-align:center;border-color:black; border-style:solid;" readonly></td>
					</tr>
					<tr> 
						<td>�߼۸޼���</td>
						<td><div align="left"><input name="send_msg" type="text" size="80" maxlength="80" value="<%=send_msg%>"></div></td>
					</tr>
					<tr>
						<td>�����޼���</td>
						<td><div align="left"><input name="send_err" type="text" size="80" maxlength="80" value="<%=send_err%>"></div></td>
					</tr>											
				</table>
	          <div align="right">
	            <a href="javascript:goSave();" onFocus="blur()"><img src="/img/common/btn_ok.gif" hspace="10"></a>
				</div>
	            <div align="left"></div>
	          <font color="#0000FF">(��뿹) <br>
	          {��}���� ����� {$$$}���� ���� ���εǾ����ϴ� [{����}]</font><br>
	          </div>
          </td>
		</tr>
	</table>
</center>
</form>
</body>
</html>

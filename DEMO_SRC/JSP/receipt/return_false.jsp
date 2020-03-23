
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>

<jsp:useBean id="returnval" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="policy_apln_no" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="id" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="id1" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="process" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="errmsg" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="message" 	class="java.lang.String" scope="request"/>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<%
	policy_apln_no = request.getParameter("policy_apln_no");	
%>
<script language="javascript">
<!--	
	

	
	function goMssage()
	{
		form = document.returnForm;
		opener = opener.document.paymentForm;
		form.errmsg.value = form.message.value;
		form.process.value = "S";
		form.action = "return_false.do";		
		form.submit();	
		//opener.submit();		
		//setValue(opener.errmsg,eval("form.message.value")); 
		//opener.rsltname.value ="반송";
		window.close();		
	}
	
		
//-->
</script>
<body>
<form name="returnForm"  method="post">
<input type="hidden" name="policy_apln_no" value="<%=policy_apln_no%>">
<input type="hidden" name="id1" value="<%=id1%>">
<input type="hidden" name="errmsg" value="<%=errmsg%>">
<input type="hidden" name="process" value="<%=process%>">
<center>
    <table width="400">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
			<td><img src="/img/common/bu_cir01.gif"> <b>SMS/이메일 발송처리</b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
					<tr class="adm16"> 
						<td colspan="2"><font class="font10">* 사유입력</font>	
							<textarea name="message" style="height: 70px;" class="box10">
							
							</textarea>							
						</td>
					</tr>
				</table></td>
		</tr>
		<tr> 
			<td align="right"><a href="javascript:goMssage()"><img src="/img/common/btn_ok.gif" hspace="10"></a><a href="javascript:window.close();" onFocus="blur()"><img src="/img/common/btn_cancel.gif"></a></td>
		</tr>
	</table>
</center>
</body>
</body>
</html>

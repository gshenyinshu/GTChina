<%
/* -----------------------------------------------------------------------------
 * Project Title		: ���Ѱ��� - �˾�â
 * File Name		: auth_pop.jsp
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

<%
	
	String flag		= request.getParameter("flag") 	== null ? ""  : request.getParameter("flag");		
	String category	= request.getParameter("category") 	== null ? ""  : request.getParameter("category");		
%>	


<html>
<head>
<title>ī�װ��� ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<script language="javascript">
<!--
	function goWrite()
	{
		form = document.categoryForm;	
		
		if(form.category.value.length > 15)
		{
			alert("ī�װ����� 15�ڸ��� �������� �����ϴ�.");
			form.category.focus();
			form.category.select();
			return;
		} 
		else if(form.category.value.length == 0)
		{
			alert("ī�װ����� �Է��ϼ���.");
			form.category.focus();
			form.category.select();
			return;
		} 
		else
		{
			if(confirm("ī�װ��� "+form.category.value+"�� �Է��Ͻðڽ��ϱ�?")) {				
				
				form.chkyn.value = "Y";
				form.flag.value="I";						
				form.submit();				
				window.close();
			}	
		}	
	}
//-->
</script>

<body>
<form name="categoryForm" method="post" action="new_category.do">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="chkyn" >
<center>
    <table width="600">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
			
        <td><img src="/img/common/bu_cir01.gif"> <b>ī�װ� ����</b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
            <col width=12%>
            <col width=12%>
            <col width=38%>
            <col width=38%>
            <tr> 
              <th colspan="2">&nbsp;</th>
            </tr>
            <tr> 
              <td width="35%"  bgcolor="#F3F3F3">ī�װ���</td>
              <td width="65%"><div align="left"> <input name="category" type="text" size="30" maxlength="30" ></div></td>
            </tr>
          </table></td>
		</tr>
		<tr><!--<td align="right"><a href="javascript:self.close()"><img src="/img/common/btn_ok.gif" hspace="10"><img src="/img/common/btn_cancel.gif"></a></td>-->
      
        <td align="right"> 
          <a href="javascript:goWrite()" onFocus="blur()"><img src="/img/common/btn_save.gif" width="49" height="19" hspace="10"></a> 
        </td>
		</tr>
	</table>
</center>
</form>
</body>
</html>
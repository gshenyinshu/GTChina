<%
/* -----------------------------------------------------------------------------
 * Project Title		: 권한관리 - 팝업창
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
	String id		= request.getParameter("id") 	== null ? ""  : request.getParameter("id");		
	String c_id	 	= request.getParameter("c_id") 	== null ? ""  : request.getParameter("c_id");	
	String return_cause =  request.getParameter("return_cause") 	== null ? ""  : request.getParameter("return_cause");	
%>	

<jsp:useBean id="catedesc" class="anyframe.data.DataSet" scope="request"/>		
<jsp:useBean id="searcon" class="anyframe.data.DataSet" scope="request"/>		

<%
	if(flag.equals("U"))
	{
		int count = searcon.getCount("c_id");
		if(count == 1)
		{
			c_id = searcon.getText("c_id");
			return_cause = searcon.getText("return_cause");
			id = searcon.getText("id");
		}
		
		//out.println("c_id==>"+c_id);
		//out.println("return_cause==>"+return_cause);
	}
%>

<html>
<head>
<title>반송사유관리</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<script language="javascript">
<!--
	function goWrite()
	{
		form = document.returnForm;		
		form.chkyn.value = "Y";
		form.flag.value="I";		
		form.submit();				
		opener.document.form.flag.value = "I";		
		opener.document.form.submit();								
		opener.winreflash();				
		window.close();
	}
	
	function goUpdate()
	{
	/*
		form = document.returnForm;				
		document.returnForm.chkyn.value = "Y";		
		document.returnForm.flag.value="U";
		document.returnForm.submit();
		opener.document.form.flag.value = "U";
		opener.document.form.submit();
		opener.winreflash();		
		window.close();
	*/
	
		form = document.returnForm;		
		form.chkyn.value = "Y";
		form.flag.value="U";		
		form.submit();				
		opener.document.form.flag.value = "U";		
		opener.document.form.submit();								
		opener.winreflash();				
		window.close();
		
	}	
//-->
</script>

<body>
<form name="returnForm" method="post" action="return_newpop.do">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="chkyn" >
<input type="hidden" name="id" value="<%=id%>" >
<center>
    <table width="600">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
      		<td><img src="/img/common/bu_cir01.gif"> <b>반송사유 관리</b></td>
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
            <th colspan="2">반송사유 등록</th>
          </tr>
          <tr> 
            <td bgcolor="F3F3F3">카테고리명</td>
            <td><div align="left">
<%
				int cnt = catedesc.getCount("c_id");
%>                
                <select name="c_id">
<%
				for(int i=0;i<cnt;i++)
				{
%>
					<option value="<%= catedesc.getText("c_id",i) %>"<% if(catedesc.getText("c_id",i).equals(c_id)){ %> selected <% } %>><%=catedesc.getText("cate_desc",i)%></option>
<%			
				}
%>                
                </select>
              </div></td>
          </tr>
          <tr> 
            <td width="35%"  bgcolor="#F3F3F3">반송사유</td>
            <td width="65%"><div align="left">
                <textarea name="return_cause" rows="" cols="" style="width:370px;height:75px"><%= return_cause%></textarea>
			</div></td>
          </tr>
        </table></td>
		</tr>
		<tr><!--<td align="right"><a href="javascript:self.close()"><img src="/img/common/btn_ok.gif" hspace="10" onFocus="blur()"><img src="/img/common/btn_cancel.gif"></a></td>-->
      <td align="right">
<%
	if(flag.equals("I"))
	{
%>      
      	<a href="javascript:goWrite()" onFocus="blur()"><img src="/img/common/btn_save.gif" width="49" height="19" hspace="10"></a>
<%
	} 
	else if(flag.equals("U"))
	{
%>
		<a href="javascript:goUpdate()" onFocus="blur()"><img src="/img/common/btn_changes.gif" width="38" height="18" hspace="10"></a>
<%	
	}
%>      
      </td>
		</tr>
	</table>
</center>
</form>
</body>
</html>
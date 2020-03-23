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
	String category	= request.getParameter("category") 	== null ? ""  : request.getParameter("category");		
%>	


<html>
<head>
<title>카테고리명 등록</title>
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
			alert("카테고리명은 15자리를 넘을수가 없습니다.");
			form.category.focus();
			form.category.select();
			return;
		} 
		else if(form.category.value.length == 0)
		{
			alert("카테고리명을 입력하세요.");
			form.category.focus();
			form.category.select();
			return;
		} 
		else
		{
			if(confirm("카테고리명 "+form.category.value+"을 입력하시겠습니까?")) {				
				
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
			
        <td><img src="/img/common/bu_cir01.gif"> <b>카테고리 관리</b></td>
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
              <td width="35%"  bgcolor="#F3F3F3">카테고리명</td>
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
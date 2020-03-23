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

<jsp:useBean id="selcontent" class="anyframe.data.DataSet" scope="request"/>		
<jsp:useBean id="indate" class="java.lang.String" scope="request"/>
<jsp:useBean id="seq_no" class="java.lang.String" scope="request"/>
<jsp:useBean id="srvc_gubun" class="java.lang.String" scope="request"/>
<jsp:useBean id="status_code" class="java.lang.String" scope="request"/>

<html>
<head>
<title>사유</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<script language="javascript">
<!--
	
//-->
</script>

<body>
<%
	String srvc_name1 = "";	
	
	if(status_code.equals("3"))
	{
		srvc_name1 = "반송";		
	}
	else
	{
		srvc_name1 = "실패";
	}
%>
<form name="returnForm" method="post" action="return_content.do">
<input type="hidden" name="indate" value="<%=indate%>" >
<input type="hidden" name="seq_no" value="<%=seq_no%>" >
<input type="hidden" name="srvc_gubun" value="<%=srvc_gubun%>" >
<input type="hidden" name="status_code" value="<%=status_code%>" >
<center>
    <table width="600">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
      		
        <td><img src="/img/common/bu_cir01.gif"> <b><%=srvc_name1%>사유</b></td>
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
<%
	int cnt = selcontent.getCount("srvc_cd");	
%>
           
            <tr> 
              <th colspan="2"><%=srvc_name1%>사유 메세지</th>
            </tr>
            <tr> 
              <td bgcolor="F3F3F3">업무명</td>
              <td><div align="center"><b><%=selcontent.getText("srvc_cd")%></b></div></td>
            </tr>
            <tr> 
              <td bgcolor="F3F3F3">증권번호(주민번호)</td>
<%
		String srvc_name = "";
		if(selcontent.getText("srvc_code").equals("A"))
		{
			srvc_name = selcontent.getText("ssn");
		}
		else
		{
			srvc_name = selcontent.getText("policy");
		}
%>              
              <td><div align="center"><%=srvc_name%></div></td>
            </tr>
            <tr> 
              <td bgcolor="F3F3F3">상 태</td>
              <td><div align="center"><%=srvc_name1%></div></td>
            </tr>
            <tr> 
              <td width="24%" bgcolor="F3F3F3"><%=srvc_name1%> 내역</td>
              <td width="76%"> <div align="left"><%=selcontent.getText("err_msg")%></div></td>
            </tr>
          </table></td>
		</tr>
		<tr><!--<td align="right"><a href="javascript:self.close()"><img src="/img/common/btn_ok.gif" hspace="10" onFocus="blur()"><img src="/img/common/btn_cancel.gif"></a></td>-->
        <td align="right"> <a href="javascript:self.close()"><img src="/img/common/btn_ok.gif" width="49" height="19" hspace="10"></a> 
        </td>
		</tr>
	</table>
</center>
</form>
</body>
</html>
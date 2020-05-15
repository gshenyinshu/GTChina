
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>

<jsp:useBean id="displayall" 	class="anyframe.data.DataSet" scope="request"/>

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
			
      <td><img src="/img/common/bu_cir01.gif"> <b>변경내역</b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
          <col width=10%>
          <col width=20%>
          <col width=20%>
          <col width=20%>
          <col width=30%>
          <tr> 
            <th width="7%">순서</th>
            <th width="15%">증권번호</th>
            <th width="26%">변경전</th>
            <th width="28%">변경후</th>
            <th width="24%">처리자</th>
          </tr>
<%
	int cnt = displayall.getCount("policy_no");
	int count = 0;
	
	if(cnt == 0 || cnt == 1)
	{
%>
          <tr> 
            <td colspan="5">해당하는 자료가 없습니다.</td>
          </tr>

<%	
	}
	else
	{
		for(int i=0;i<cnt;i++)
		{
			if(i%2==0)
				count++;
%>          
          <tr> 
            <td>
<%
		if(i%2==0) 
		{
%>           
		<%=count%> 
<%
		}
		else
		{
%>		
		&nbsp;
<%
		}
%>		
            </td>
            <td><%=displayall.getText("policy_no",0)%></td>
            <td><%=displayall.getText("rslt_name",i)%></td>
            <td><%=displayall.getText("rslt_name",i+1)%></td>
            <td><%=displayall.getText("emp_nm",i+1)%></td>
          </tr>
<%
			i=i+1;
		}
	}	
%>          
        </table></td>
		</tr>
		<tr> 
			
      <td align="right"><a href="javascript:window.close();" onFocus="blur()"><img src="/img/common/btn_ok.gif" hspace="10"></a></td>
		</tr>
	</table>
</center>
</body>
</html>

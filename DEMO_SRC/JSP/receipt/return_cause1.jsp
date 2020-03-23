
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>

<jsp:useBean id="selcate" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="catedescp" class="anyframe.data.DataSet" scope="request"/>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>

<%
	String indate		= request.getParameter("indate")    == null ? "" : request.getParameter("indate");
	String seq_no		= request.getParameter("seq_no")    == null ? "" : request.getParameter("seq_no");
	String srvc_gubun	= request.getParameter("srvc_gubun")    == null ? "" : request.getParameter("srvc_gubun");
	String flag		= request.getParameter("flag")    == null ? "" : request.getParameter("flag");
	String chkyn		= request.getParameter("chkyn")    == null ? "" : request.getParameter("chkyn");
	String c_id		= request.getParameter("c_id")    == null ? "" : request.getParameter("c_id");
%>

<script language="javascript">
<!--	

	function ReLoadWindow(cd)
	{
		document.returnForm1.flag.value = "P";
		document.returnForm1.c_id.value =  cd;
		document.returnForm1.action = "return_cause1.do";
		document.returnForm1.submit();
	}
	
	function goMessage(cd)
	{
		form = document.returnForm1;
		opener = opener.document.returnForm;
		opener.message.value = cd;
		window.close();
	}
	
	/*
	function goErrSave(val)
	{
		form = document.returnForm;
		opener = opener.document.paymentForm;
		form.errmsg.value = val;
		form.process.value = "S";
		form.action = "return_tbl.do";		
		form.submit();	
		opener.submit();		
		setValue(opener.errmsg,eval("form.message.value")); 
		opener.rsltname.value ="반송";
		window.close();		
	}
	*/
	
	function setValue(id,val) {
		id.value = val;
	}		
		
//-->
</script>
<body>
<form name="returnForm1"  method="post">
<input type="hidden" name="indate" value="<%=indate%>">
<input type="hidden" name="seq_no" value="<%=seq_no%>">
<input type="hidden" name="srvc_gubun" value="<%=srvc_gubun%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="c_id" value="<%=c_id%>">
<input type="hidden" name="chkyn" value="<%=chkyn%>">

<center>
    <table width="400">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
			
      <td><img src="/img/common/bu_cir01.gif"> <b>반송카테고리 선택</b></td>
		</tr>
		<tr> 
			<td height="7"></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
					<tr class="adm21"> 
						<th>반송</th>
						<td>
<%
				int cnt = selcate.getCount("c_id");								
%>                		
              		  			
              		  			<select name="cateid"  style="width:200pt" onChange="ReLoadWindow(this.value)">
<%
				for(int i=0;i<cnt;i++)
				{
%>
								
								
								
								<option value="<%= selcate.getText("c_id",i) %>"<% if(selcate.getText("c_id",i).equals(c_id)){ %> selected <% } %>><%=selcate.getText("cate_desc",i)%></option>

<%			
				}
%>                              		  			
		                			</select>
						</td>
					</tr>
					<tr class="adm16"> 
						
            <td colspan="2"><font class="font10">* 반송카테고리사유</font> 
            
            
<%
				out.println("<br>");
				out.println("<br>");
				int count = catedescp.getCount("id");
				for(int j=0;j<count;j++)
				{
%>              			
			<div align="left"><a href="javascript:goMessage('<%=catedescp.getText("return_cause",j)%>');">
<%
			out.println(j+1 + "." +catedescp.getText("return_cause",j));
			out.println("<br>");
			out.println("<br>");
%>
		</a></div>
<%			
			
		}
%>              
						</td>
					</tr>
				</table></td>
		</tr>
		<tr> 
			<td align="right"><a href="javascript:window.close();" onFocus="blur()"><img src="/img/common/btn_cancel.gif"></a></td>
		</tr>
	</table>
</center>
</body>
</body>
</html>

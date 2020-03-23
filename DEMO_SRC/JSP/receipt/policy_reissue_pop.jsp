<%
/**
 * Description : 보험증권재발행 - 화면출력
 * File        : /receipt/policy_reissue_pop.jsp
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : jung-hun Park
 * First Write : 2005.04.12
 * update date : 2005.04.
 * update desc :
 */
%>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, 
					java.io.*, gtone.changeminer.common.utility.Util, gtone.changeminer.common.utility.ToolString, gtone.changeminer.receipt.form.*, anyframe.jsp.HtmlUtil" %>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>

<jsp:useBean id="policyReissue_list" 	class="java.util.List" scope="request"/>

<HTML>
<HEAD>
<TITLE></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common_pop.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>

<style type="text/css">
	@media print {
	div.noprint {display: none;}
	}
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--
	var da = (document.all) ? 1 : 0
	var pr = (window.print) ? 1 : 0
	var mac = (navigator.userAgent.indexOf("Mac") != -1);
	
	function printPage() 
	{
	    if (pr) // NS4, IE5
	        window.print()
	    else if (da && !mac) // IE4 (Windows)
	        vbPrintPage()
	    else // 다른 부라우저
	        alert("죄송합니다. 이 브라우저는 이 기능을 지원하지 않습니다!");
	    return false;
	}
	
	if (da && !pr && !mac) with (document)
	{
		writeln('<OBJECT ID="WB" WIDTH="0" HEIGHT="0" CLASSID="clsid:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>');
		writeln('<' + 'SCRIPT LANGUAGE="VBScript">');
		writeln('Sub window_onunload');
		writeln(' On Error Resume Next');
		writeln(' Set WB = nothing');
		writeln('End Sub');
		writeln('Sub vbPrintPage');
		writeln(' OLECMDID_PRINT = 6');
		writeln(' OLECMDEXECOPT_DONTPROMPTUSER = 2');
		writeln(' OLECMDEXECOPT_PROMPTUSER = 1');
		writeln(' On Error Resume Next');
		writeln(' WB.ExecWB OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER');
		writeln('End Sub');
		writeln('<' + '/SCRIPT>');
	}
	
	function printWindow()
	{
		factory.printing.header = ""
		factory.printing.footer = ""
		factory.printing.portrait = true
		factory.printing.leftMargin = 11.0
		factory.printing.topMargin = 17.0
		factory.printing.rightMargin = 1.0
		factory.printing.bottomMargin = 1.0
		//factory.printing.Print(false, window)
	
		printPage();
	}
	
	
	function winClose()
	{
		opener.winRefresh()
		
		this.close();
	}
	
	function openerRe()
	{
		opener.winRefresh()
	}

// -->
</SCRIPT>
</HEAD>

<body onload="javascript:openerRe()">
<object id=factory style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="http://www.meadroid.com/scriptx/ScriptX.cab#Version=6,1,429,14"></object>
<table width="714" border="0" cellspacing="0" cellpadding="0">
  <tr>
<%
	int cnt = policyReissue_list.size();//조회결과 사이즈
	int tot = 0;//리스트가 2개이상이면 밑으로 내려가기

	for(int i=0;i<cnt;i++)
	{
		PolicyReissueEntity entity = (PolicyReissueEntity)policyReissue_list.get(i);
		
		String policy = entity.policy;
			   policy = policy.substring(0,7)+"***";
		String name = entity.name;
		String post = entity.post;
			   post = post.substring(0,3)+"-"+post.substring(3,6);
		String addr1 = entity.addr1;
		String addr2 = entity.addr2;
		String addr3 = entity.addr3;
		String addr4 = entity.addr4;
%>
    <td width="347">
      <table width="345" border="0">
        <tr> 
          <td width="245" align="left"><%=policy%></td>
          <td width="5">&nbsp;</td>
          <td width="90" align="right">&nbsp;</td>
          <td width="5">&nbsp;</td>
        </tr>
        <tr> 
          <td height="50" align="left" valign="top"><%=Util.doubleTrim(ToolString.fullTohalf(addr1.trim()))%> <%=Util.doubleTrim(ToolString.fullTohalf(addr2.trim()))%></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td height="2">&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td height="22" align="left"><font size="3"><b><%=name%></b></font> 귀하</td>
          <td>&nbsp;</td>
          <td align="right"><%=post%>&nbsp;&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
    
    <td width="30">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<%
		tot ++;

	    if( tot%2 == 0 )
	    {
        	out.println("</tr>");
	        
	        if( tot <= 14 )
	        {
	        	out.println("<TR><TD colspan=3  height=18></TD></TR>");
	        	out.println("<tr>");
	        }
	        else
	        {
	        	out.println("<TR><TD colspan=3  height=15></TD></TR>");
	        }
    	}

	}//end-for
%>      
  </tr>

 
  
<!--단추-->
<%
	if( tot < 16 )
	{
%>  
  <TR><TD colspan=3  height="13"></TD></TR>		
<%
	}
%>    
  <TR align="right"> 
  	<TD colspan="3"> 
  		<div class="noprint">
			<table>
		  		<tr align="right"> 
		    		<td height="30" colspan="3">
			    		<A HREF="#" onClick="return printWindow()" onFocus="blur()"><img src="/img/common/btn_print.gif" border="0"></a>
						&nbsp;&nbsp;
						<!--<A HREF="#" onClick="javascript:self.close()" onFocus="blur()"><img src="/img/common/btn_cancel.gif"  border="0"></a>-->
						<A HREF="#" onClick="javascript:winClose()" onFocus="blur()"><img src="/img/common/btn_close.gif"  border="0"></a>
						&nbsp;
		    		</td>
				</tr>		
			</table>
		</div>
    </TD>
  </TR>
<!--단추-->

</table>
</body>
</html>
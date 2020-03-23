
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>

<%
	String indate		= request.getParameter("indate")    == null ? "" : request.getParameter("indate");
	String seq_no		= request.getParameter("seq_no")    == null ? "" : request.getParameter("seq_no");
	String srvc_gubun	= request.getParameter("srvc_gubun")    == null ? "" : request.getParameter("srvc_gubun");
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<script language="javascript">
<!--	

	function goReturn1(cd1,cd2,cd3)
	{
		var path = "";
		path = "/receipt/return_cause1.do?indate="+cd1+"&seq_no="+cd2+"&srvc_gubun="+cd3+"&flag=S";
		window.open(path, '반송선택', 'left=400,top=350,Width=430,Height=280, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	
	}		
		
		
	function goSave()
	{
		var cate_desc = document.returnForm.message.value;
		document.returnForm.cate_desc.value = cate_desc;
		document.returnForm.flag.value = "I";
		
		document.returnForm.chkyn.value = "Y";
		document.returnForm.submit();
		/*
		window.close();		
		form = document.returnForm;		
		form.chkyn.value = "Y";
		form.flag.value="I";		
		form.submit();				
		*/
		opener.document.form.searchgubun.value = "S";				
		opener.winreflash();				
		window.close();		
		
		
		
	}		
//-->
</script>
<body>
<form name="returnForm"  method="post">
<input type="hidden" name="indate" value="<%=indate%>">
<input type="hidden" name="seq_no" value="<%=seq_no%>">
<input type="hidden" name="srvc_gubun" value="<%=srvc_gubun%>">
<input type="hidden" name="cate_desc" >
<input type="hidden" name="chkyn">
<input type="hidden" name="flag">
<center>
    <table width="400">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
			<td><img src="/img/common/bu_cir01.gif"> <b>반송처리</b></td>
		</tr>
		<tr> 
			<td><div align="right"><a href="javascript:goReturn1('<%=indate%>','<%=seq_no%>','<%=srvc_gubun%>');"><img src="/img/common/btn_return_save02.gif" width="110" height="19"></div></td>
		</tr>
		<tr> 
			<td><table width="100%" class="adm_table">
          <tr class="adm21"> 
            <th>반송사유</th>
          </tr>
          <tr class="adm16"> 
            <td><font class="font10">* 기타선택시 사유입력</font> 
              <%
						
							
%>
              <textarea name="message" style="height: 70px;" class="box10"></textarea>	
            </td>
          </tr>
        </table></td>
		</tr>
		<tr> 
			
      <td align="right"><a href="javascript:goSave()"><img src="/img/common/btn_ok.gif" hspace="10" border="0"></a></td>
		</tr>
	</table>
</center>
</body>
</body>
</html>

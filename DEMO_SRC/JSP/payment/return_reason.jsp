
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<jsp:useBean id="returnreason" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="policy_apln_no" class="java.lang.String" scope="request"/>	
	
<html>
<head>
<title>반송 사유</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>

<body>
<form name="returnForm"  method="post">
<input type="hidden" name="policy_apln_no" value ="<%=policy_apln_no%>">
<center>
    <table width="300">
		<tr> 
			<td height="14"></td>
		</tr>
		<tr> 
			
      <td><img src="/img/common/bu_cir01.gif"> <b>반송사유</b></td>
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
            <th>반송사유</th>
          </tr>
          <tr> 
            <td><form name="form1" method="post" action="">
            
                <textarea name="message" style="height: 50px; width:300px;" ><%=returnreason.getText("err_msg")%></textarea>							
              </form></td>
          </tr>
        </table></td>
		</tr>
		<tr>
			<td align="right"><a href="javascript:self.close()" onFocus="blur()"><img src="/img/common/btn_ok.gif" hspace="10"></a></td>
		</tr>
	</table>
</center>
</form>
</body>
</html>

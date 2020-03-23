<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<jsp:useBean    id="form"      			class="gtone.changeminer.receipt.form.LoginManForm" scope="request"/>    
<jsp:useBean 	id="logininfo" 			class="anyframe.data.DataSet" scope="request"/>

<html>
<head>
<META HTTP-EQUIV= 'Content-Type' CONTENT='text/html; charset=euc-kr'>
<%
	//세션에서 값가져오기
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd 	= sessionManager.getString(Constant.SESSION_LEVEL);
	String auth_cd2 	= sessionManager.getString(Constant.SESSION_LEVEL2);
	String emp_no 	= sessionManager.getString(Constant.SESSION_USERID);
	
	String login_sts 		= logininfo.getText("login_sts");
	String login_close_msg 	= logininfo.getText("login_close_msg");
%>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>

<script language="javascript">
	function sts_check(){	
		var form = document.form;
		form.save_sts.value='N';
		var login_sts = '<%=login_sts%>';
		
		login_sts_check(login_sts);

	}
	
	function login_sts_check(login_sts){	
		var form = document.form;
		if(login_sts=='N')	form.login_close_msg.disabled=true;
		else 				form.login_close_msg.disabled=false;		
	}
	
	function sts_change(){	
		var form = document.form;
		if(form.login_sts[0].checked==true){
			form.login_close_msg.disabled=false;
			form.login_close_msg.value=form.close_msg.value;
		}
		
		if(confirm("현재 상태로 변경하시겠습니까?")){		
			form.save_sts.value='Y';
			form.emp_no.value='<%=emp_no%>';
			form.action = "login_manager.do";
			form.submit();
		}		
	}
</script>
<body onLoad="javascript:sts_check();">

<form name="form" method="post"  action="login_manager.do">
<input type="hidden" name="save_sts">
<input type="hidden" name="emp_no" value="<%=emp_no%>">
<input type="hidden" name="close_msg" value="<%=login_close_msg%>">

<table width="100%" height="100%">
	<tr> 
		<td height=71><table width="100%" background="/img/common/logo_bg.gif">
				<tr> 
					<td><img src="/img/common/logo.gif"></td>
					<td align="right"><img src="/img/common/logo_end.gif"></td>
				</tr>
			</table></td>
	</tr>
	<tr> 
		<td><table width=100% height="100%">
				<col width=200> 
				<tr> 					
					<td align="center" class="menu">
						<!--DropDown 삽입 : S-->
						<jsp:include page="/common/dropDown.jsp" flush="true">
						<jsp:param name="menu_mode" value="3"/>
						</jsp:include>
						<!--DropDown 삽입 : E-->
					</td>
					<td class="contents"><table width="100%">
                <tr> 
					<td><img src="/img/common/title_03.gif"></td>
                </tr>
                <tr> 
                  <td height="10" background="/img/common/title_bg.gif"></td>
                </tr>
                <tr> 
                  <td height="14"></td>
                </tr>
                <tr> 
                  <td> <table width="100%">
                      <tr> 
                        <td><img src="/img/common/bu_cir01.gif"> <b>로그인관리</b></td>
                        <td align="right">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td><table width="500" height="134" class="adm_table">
					<col width=30%>
					<col width=70%>
					  <tr> 
						<th>로그인상태</th>
						<td>
                        	<input type="radio" onFocus="this.blur()" name="login_sts" value="N" <% if(login_sts.equals("N")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="login_sts_check(this.value)">로그인가능&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        	<input type="radio" onFocus="this.blur()" name="login_sts" value="Y" <% if(login_sts.equals("Y")){ %> checked <%}%> style="border-width:0px; border-style:solid;" onClick="login_sts_check(this.value)">로그인불가
                        </td>
					  </tr>
					  <tr> 
						<th>로그인불가 안내메세지</th>
						<td>
							<textarea name="login_close_msg" cols="50" rows="5"style="overflow=hidden"><%=login_close_msg%></textarea>
                        </td>
					  </tr>
				  </table></td>
				 </tr>
                <tr> 
                  <td><table width="500">
					<div align="right"><a href="javascript:sts_change();" onFocus="blur()"><img src="/img/common/btn_changes.gif" width="38" height="18" ></a></div>
				   </table></td>
                </tr>
				</table></td>
               </tr>
			</table></td>
	</tr>
	<tr> 
		<td height="56" background="/img/common/copy_bg.gif"><img src="/img/common/copy.gif"></td>
	</tr>
</table>
</form>
</body>
</html>


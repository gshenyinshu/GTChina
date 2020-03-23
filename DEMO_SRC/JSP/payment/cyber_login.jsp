<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
</head>
<script language="javascript">
<!--
	function goLogin()
	{
		form = document.loginForm;
		var id = form.id.value;
		var pw = form.pw.value;
		if(id.length == 0)
		{
			alert("아이디를 입력하세요");
			form.id.focus();
			return;
		}	
		else if(pw.length ==0) 
		{
			alert("패스워드를 입력하세요");
			form.pw.focus();
			return;
		}	
		else
		{
			form.checkyn.value = "Y";
			form.submit();
		}
	}

function nextfocus(val,form,e,obj)
{
	if(e.keyCode == 13){
		if(obj.name == "id"){
			form.pw.focus();
		}
		else if(obj.name=="pw")
		{
			form.checkyn.value="Y";
			form.submit();	
		}
	}
}	
//-->
</script>
<body>
<form name="loginForm"  method="post">
<input type="hidden" name="checkyn">
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
					<td class="contents"><table width="100%">
							<tr> 
								<td><img src="/img/common/title_login.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="/img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="24"></td>
							</tr>
							<tr> 
								<td style="padding-left: 10px;"><table align="center">
										<tr> 
											<td style="border: solid 1 DCE0E9; padding: 1px; background: #F3F7FA;"><table width="100%">
													<tr>
														<td width="210"><img src="/img/common/login_img.gif"></td>
														<td width="380"><table>
																<col width="85"><col width="140"><col width="">
																<tr height="21"> 
																	<td><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><font color="344D6C">아이디</font></b></td>
																	<td><input type="text" name="id" style="border: solid 1 #C0CED9; width: 130px;"  tabindex="1"  onkeydown="nextfocus(this.value,this.form,event,this)"></td>
																	<td rowspan="2"><a href="javascript:goLogin();"><img src="/img/common/btn_login.gif" border="0"  tabindex="3"></td>
																</tr>
																<tr height="21"> 
																	<td><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><font color="344D6C">패스워드</font></b></td>
																	<td><input type="password" name="pw" style="border: solid 1 #C0CED9; width: 130px;" tabindex="2"  onkeydown="nextfocus(this.value,this.form,event,this)"></td>
																</tr>
															</table>
															<img src="/img/common/login_text.gif" vspace="20"></td>
													</tr>
												</table></td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td height="50">&nbsp;</td>
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

<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager,gtone.changeminer.common.utility.Utility" %>

<%
	//세션에서 값가져오기
	SessionManager sessionManager = new SessionManager(request);
	String emp_no = sessionManager.getString(Constant.SESSION_USERID);
	   

	
	//System.out.println("#############################process_login_first.jsp ===> emp_no : "+ emp_no);

  
	String islogin = "";
	if( emp_no.equals("") || emp_no.equals("null") )
	{
		islogin = "N";
	}
%>	
   



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language="javascript">
<!--
<%
//out.println("#############################process_login_first.jsp ===> emp_no : "+ emp_no);
//out.println("#############################process_login_first.jsp ===> islogin : "+ islogin);
//로그인여부 체크
	if( islogin.equals("Y") )
	
	{
	
%>	

		document.location.href="/payment/admin_main.do";
<%

	}
	
	%>
	
	

	
-->	
</script>
<script language='javascript' src='../../common/js/menu_on.js'></script>

</head>

<body>
<table width="100%" height="100%">
	<tr> 
		<td height=71><table width="100%" background="../../img/common/logo_bg.gif">
				<tr>
					<td><img src="../../img/common/logo.gif"></td>
					<td align="right"><img src="../../img/common/logo_end.gif"></td>
				</tr>
			</table></td>
	</tr>
	<tr> 
		<td><table width=100% height="100%">
				<col width=200> 
				<tr> 
					<td align="center" class="menu"><img src="../../img/common/menu_in.gif"> 
						<table width="100%">
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">지급처리</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">수납처리</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">기타</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">일마감</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">반송관리</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">모니터링</a></td>
							</tr>
						</table></td>
					<td class="contents"><table width="100%">
							<tr> 
								<td><img src="../../img/common/title_login.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="../../img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="24"></td>
							</tr>
							<tr> 
								<td style="padding-left: 10px;"><table>
										<tr> 
											<td style="border: solid 1 DCE0E9; padding: 1px; background: #F3F7FA;"><table width="100%">
													<tr>
														<td width="210"><img src="../../img/common/login_img.gif"></td>
														<td width="380"><table>
																<col width="85"><col width="140"><col width="">
																<tr height="21"> 
																	<td><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#"><font color="344D6C">아이디</font></a></b></td>
																	<td><input type="text" name="id" style="border: solid 1 #C0CED9; width: 130px;"></td>
																	<td rowspan="2"><img src="../../img/common/btn_login.gif"></td>
																</tr>
																<tr height="21"> 
																	<td><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#"><font color="344D6C">패스워드</font></a></b></td>
																	<td><input type="text" name="pw" style="border: solid 1 #C0CED9; width: 130px;"></td>
																</tr>
															</table>
															<img src="../../img/common/login_text.gif" vspace="20"></td>
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
		<td height="56" background="../../img/common/copy_bg.gif"><img src="../../img/common/copy.gif"></td>
	</tr>
</table>
</body>
</html>

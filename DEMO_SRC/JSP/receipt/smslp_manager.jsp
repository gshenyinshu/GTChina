<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>
<jsp:useBean id="smslp" class="anyframe.data.DataSet" scope="request"/>

<%
	//세션에서 가져오기
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
	//String emp_no = sessionManager.getString(Constant.SESSION_USERID);
	//String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>
</head>
<script language="javascript">
<!--
	function gosmsAdd()
	{
		var path = "";
		path = "/receipt/smsmsg_add1.do";
		
		window.open(path, 'SMS', 'left=400,top=150,Width=630,Height=320, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');	
	}	
	
	function winreflash()
	{
		document.form.action = "smslp_manager.do";
		document.form.submit();
	}
	
	function goUpdate(cd, seq_no)		
	{
		var path = "";
		path = "/receipt/smsmsg_add1.do?smsgubun="+cd+"&seq_no="+seq_no;
		
		window.open(path, 'SMS', 'left=400,top=150,Width=630,Height=330, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');	
		
	}
//-->
</script>	
<body>
<form name="form" method="post">
<input type="hidden" name="seq_no" value="">
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
                        <td><img src="/img/common/bu_cir01.gif"> 
                          <b>SMS관리 (LP)</b></td>
                        <td align="right">
<%
						//2005-10-10. 05-C-138. 이위혁. 결재권한세분화
						//if( auth_cd.equals("20") || auth_cd.equals("30") )
						if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
						{
%>
                        	<a href="javascript:gosmsAdd()" onFocus="blur()"><img src="/img/common/btn_add.gif" hspace="10"></a>
<%
						}
%>                        	
                        	<a href="/receipt/smscustomer_manager.do" onFocus="blur()"><img src="/img/common/btn_customer.gif"></a></td>
                      </tr>
                    </table></td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td><table width="100%" class="adm_table">
                      <col width="10%">
                      <col width="40%">
                      <col width="40%">
                      <col width="5%">
                      <tr> 
                        <th>업무명</th>
                        <th>발송내용(정상)</th>
                        <th>발송내용(실패)</th>
                        <th>변경</th>
                      </tr>
                      <%
			int cnt = smslp.getCount("srvc_name");
			if(cnt == 0)
			{
%>
                      <tr> 
                        <td colspan="4">해당하는 정보가 없습니다.</td>
                      </tr>
                      <%			
			}
			else
			{
				for(int i=0;i<cnt;i++)
				{
%>
                      <tr class="adm01"> 
                        <td><div align="left"><%=smslp.getText("srvc_name",i)%></div></td>
                        <td><div align="left"><%=smslp.getText("send_msg",i)%></div></td>
                        <td><div align="left"><%=smslp.getText("send_err",i)%></div></td>
                        <td>
<% 
						//2005-10-10. 05-C-138. 이위혁. 결재권한세분화
						//if( auth_cd.equals("20") || auth_cd.equals("30") )
						if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
						{
%>                        
                        	<a href="javascript:goUpdate('U','<%=smslp.getText("seq_no",i)%>')" onFocus="blur()"><img src="/img/common/btn_replace.gif"></a>
<%
						}
%>                        	
                        </td>
                      </tr>
                      <%
				}
			}	
%>
                    </table></td>
                </tr>
                <tr> 
                  <td align="center">&nbsp;</td>
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

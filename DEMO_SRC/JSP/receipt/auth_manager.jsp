<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<jsp:useBean id="authval" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
<jsp:useBean id="current" class="java.lang.String" scope="request"/>

<%
	String flag = request.getParameter("flag") == null? "" : request.getParameter("flag");

	//세션에서 가져오기
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
	String auth_cd2 = sessionManager.getString(Constant.SESSION_LEVEL2);
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


	function openit(oform,obox)
	{
		var temp = "width=190,height=232,left="+(screen.width/2-110)+",top="+(screen.height/2-80);
		window.open("../common/calen1.jsp?oform="+oform+"&obox="+obox,"datewindow",temp);
	}

	function goPage(num)
	{
		document.form.current.value = num;
		document.form.method="get" ;
		document.form.submit();
	}

	function goDetail(cd1, cd2,cd3,cd4,cd5,cd6,cd7,cd8,cd9,cd10,cd11,cd12)
	{
		var path = "";
		path = "/receipt/auth_pop.do?emp_no="+cd1+"&pwd="+cd2+"&emp_nm="+cd3+"&auth_cd="+cd4+"&team_nm="+cd5+"&old_pwd="+cd6+"&chg_pwd_dt="+cd7+"&hand_phone="+cd8+"&hand_phone_yn="+cd9+"&email="+cd10+"&email_yn="+cd11+"&auth_cd2="+cd12+"&flag=U";

		window.open(path, '권한관리', 'left=400,top=350,Width=700,Height=380, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	}

	function goWrite()
	{
		var path = "";
		path = "/receipt/auth_pop.do?flag=I";
		window.open(path, '권한관리', 'left=400,top=350,Width=700,Height=380, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	}

	function goDel(cd1)
	{
		if(confirm("위 사번을 삭제하시겠습니까?"))
		{
			document.form.flag.value = "D";
			document.form.emp_no.value = cd1;
			document.form.action = "auth_manager.do";
			document.form.submit();
		}
	}

	function winreflash()
	{

		document.form.action = "auth_manager.do";
		document.form.flag.value = " ";
		document.form.submit();

		window.location.reload();
	}

//-->
</script>
<body  <%if(flag.equals("I") || flag.equals("U")){%>javascript:winreflash();<%}%>>
<form name="form" method="post" >
<input type="hidden" name="current" value="<%=current%>">
<input type="hidden" name="flag">
<input type="hidden" name="emp_no" >
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
						<jsp:param name="menu_mode" value=""/>
						</jsp:include>
						<!--DropDown 삽입 : E-->
					</td>
					<td class="contents"><table width="100%">
                <tr>
                  <td><img src="/img/common/title_04.gif"></td>
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
                        <td><img src="/img/common/bu_cir01.gif"> <b>권한관리</b></td>
                        <td align="right">&nbsp;</td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td><table width="100%" class="adm_table">
                      <tr>
                        <th width="5%">N</th>
                        <th width="8%">ID</th>
                        <th width="10%">이름</th>
                        <th width="13%"> 권한</th>
                        <th width="13%">팀</th>
                        <th width="10%">최종 패스워드<br>변경일</th>
                        <th width="11%">핸드폰</th>
                        <th width="5%">수신여부</th>
                        <th width="14%">이메일</th>
                        <th width="5%">수신여부</th>
                        <th width="3%">수정</th>
                        <th width="3%">삭제</th>
                      </tr>
<%
			int cnt = authval.getCount("emp_no");

			if(cnt == 0)
			{
%>
                      <tr class="adm01">
                        <td colspan="8">해당하는 자료가 없습니다.</td>
                      </tr>
<%
			}
			else
			{
				int row = 0;
				row = Integer.parseInt(totalCount) - (Integer.parseInt(current) -1 )*20;
				for(int i=0;i<cnt;i++)
				{
%>
                      <tr align="center" bgcolor="<%= ( i % 2 == 0 ) ? "#FFFFFF" : "#F8F8F8" %>">
                        <td><%=row%></a></td>
                        <td><%=authval.getText("emp_no",i)%></td>
                        <td><%=authval.getText("emp_nm",i)%></td>
                        <td><%=authval.getText("auth_name",i)%></td>
                        <td><%=authval.getText("team_nm",i)%></td>
                        <td><%=authval.getText("chg_pwd_dt",i)%></td>
                        <td><%=authval.getText("hand_phone",i)%></td>
                        <td><%="Y".equals(authval.getText("hand_phone_yn",i))?"허용":"거부"%></td>
                        <td><%=authval.getText("email",i)%></td>
                        <td><%="Y".equals(authval.getText("email_yn",i))?"허용":"거부"%></td>

                        <td>
                        	<a href="javascript:goDetail('<%=authval.getText("emp_no",i)%>','<%=authval.getText("pwd",i)%>','<%=authval.getText("emp_nm",i)%>','<%=authval.getText("auth_cd",i)%>','<%=authval.getText("team_nm",i)%>','<%=authval.getText("old_pwd",i)%>','<%=authval.getText("chg_pwd_dt",i)%>','<%=authval.getText("hand_phone",i)%>','<%=authval.getText("hand_phone_yn",i)%>','<%=authval.getText("email",i)%>','<%=authval.getText("email_yn",i)%>','<%=authval.getText("auth_cd2",i)%>');" onFocus="blur()"><img src="/img/common/btn_changes.gif" width="38" height="18" hspace="10"></a>
                        </td>
                        <td>
<%
					if( auth_cd.equals("40") )
					{
%>
                        	<a href="javascript:goDel('<%=authval.getText("emp_no",i)%>');" onFocus="blur()"><img src="/img/common/btn_del.gif" width="38" height="18" border="0"></a>
<%
					}
%>
                        </td>
                      </tr>
<%
					row = row - 1;
				}
			}
%>
                    </table></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td align="center"><table>
                      <tr>
                        <td width="26"></td>
                        <td width="45">
                        <td align="center"> <jsp:include page="/common/include/paging.jsp" flush="true">
                          <jsp:param name="total" value="<%= totalCount %>"/>
                          <jsp:param name="cpage" value="<%= current %>"/>
                          </jsp:include> </td>
                        <td width="30"></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td height="50"><div align="right">
<%
					if( auth_cd.equals("40") )
					{
%>
                      <a href="javascript:goWrite();" onFocus="blur()"><img src="/img/common/btn_user_save.gif" border="0"></a>
<%
					}
%>
                    &nbsp;&nbsp;</div></td>
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

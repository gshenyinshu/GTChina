<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<jsp:useBean id="returnval" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
<jsp:useBean id="current" class="java.lang.String" scope="request"/>
<jsp:useBean id="flag" class="java.lang.String" scope="request"/>
<jsp:useBean id="c_id" class="java.lang.String" scope="request"/>
<jsp:useBean id="id" class="java.lang.String" scope="request"/>
<jsp:useBean id="gubun" class="java.lang.String" scope="request"/>

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

	function goDetail(cd1, cd2)
	{
		var path = "";
		path = "/receipt/return_newpop.do?c_id="+cd1+"&id="+cd2+"&flag=U";
		
		window.open(path, '반송관리', 'left=400,top=350,Width=700,Height=300, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	}	

	function goCategory()
	{
		var path = "";
		path = "/receipt/new_category.do";
		
		window.open(path, '카테고리관리', 'left=400,top=350,Width=700,Height=180, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	}	
		
	function goWrite()
	{
		var path = "";
		path = "/receipt/return_newpop.do?flag=I";
		window.open(path, '반송관리', 'left=400,top=350,Width=700,Height=220, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	}	

	function goDel(cd1, cd2)
	{		
		if(confirm("위 반송사유를 삭제하시겠습니까?")) {
			document.form.flag.value = "D";			
			document.form.c_id.value = cd1;
			document.form.id.value = cd2;
			document.form.action = "return_manager.do";
			document.form.submit();	
		}	
	}	
	
	function winreflash()
	{
		document.form.action = "return_manager.do";	
		document.form.flag.value = "S";			
		document.form.submit();
	}		
	
//-->
</script>
<body <%if( flag.equals("I") || flag.equals("U") ){%>onload="javascript:winreflash()"<%}%> >

<form name="form" method="post" >
<input type="hidden" name="current" value="<%=current%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="c_id" value="<%=c_id%>">
<input type="hidden" name="id"  value="<%=id%>">
<input type="hidden" name="gubun"  value="<%=gubun%>">
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
						<jsp:param name="menu_mode" value="5"/>
						</jsp:include>
						<!--DropDown 삽입 : E-->
					</td>
					<td class="contents"><table width="100%">
                <tr> 
                  <td><img src="/img/common/title_05.gif"></td>
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
                        <td><img src="/img/common/bu_cir01.gif"> <b>반송사유관리</b></td>
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
                        <th width="10%">N</th>
                        <th width="16%">카테고리명</th>
                        <th width="60%">반송사유</th>
                        <th width="7%">수정</th>
                        <th width="7%">삭제</th>
                      </tr>
                      <%
			int cnt = returnval.getCount("c_id");
			
			if(cnt == 0) 
			{
%>
                      <tr class="adm01"> 
                        <td colspan="5">해당하는 자료가 없습니다.</td>
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
                        <td><%=row%></td>
                        <td><%=returnval.getText("cate_desc",i)%></td>
                        <td><%=returnval.getText("return_cause",i)%></td>
                        <td>
<%
						//2005-10-10. 05-C-138. 이위혁. 결재권한세분화
						//if( auth_cd.equals("20") || auth_cd.equals("30") )
						if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
						{
%>    
                        	<a href="javascript:goDetail('<%=returnval.getText("c_id",i)%>','<%=returnval.getText("id",i)%>');" onFocus="blur()"><img src="/img/common/btn_changes.gif" width="38" height="18" hspace="10"></a>
<%
						}
%>
                        </td>
                        <td>
<%
						//2005-10-10. 05-C-138. 이위혁. 결재권한세분화
						//if( auth_cd.equals("20") || auth_cd.equals("30") )
						if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
						{
%>    
                        	<a href="javascript:goDel('<%=returnval.getText("c_id",i)%>', '<%=returnval.getText("id",i)%>');" onFocus="blur()"><img src="/img/common/btn_del.gif" width="38" height="18" border="0"></a>
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
				//2005-10-10. 05-C-138. 이위혁. 결재권한세분화
				//if( auth_cd.equals("20") || auth_cd.equals("30") )
				if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
				{
%>
                  	<a href="javascript:goCategory();" onFocus="blur()"><img src="/img/common/btn_return_save02.gif" width="110" height="19"></a>&nbsp;&nbsp;
                  	<a href="javascript:goWrite();" onFocus="blur()"><img src="/img/common/btn_return_save01.gif" width="110" height="19" border="0"></a>&nbsp;&nbsp;
<%
				}
%>                  	
                  </div></td>
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

<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<jsp:useBean id="totalCount" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="output" class="anyframe.data.DataSet" scope="request"/>

<jsp:useBean    id="form"      class="gtone.changeminer.receipt.form.MemberForm" scope="request"/>                

<%
	//세션에서 값가져오기
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);

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

	function goSearch()
	{
		document.form.current.value = 1;
		document.form.submit();
	}
	
	function goPage(num) 
	{
		document.form.current.value = num;
		document.form.submit();
	}	
		
	function member_etc(ssn){
		
		//alert(ssn);
/*		function passwdInit_func(ssn){
		//패스워드 초기화만 할때...
		document.form.init_ssn.value = ssn;
		document.form.ready.value = "yes";
		document.form.target ="passwd";
		document.form.method = "post";
		document.form.action = "/receipt/passwd_init.jsp";
		document.form.submit();
*/
		document.form.init_ssn.value = ssn;
		document.form.ready.value = "yes";
		
		var popup = window.open("about:blank", "MemberWindow", "width=442, height=250, status=no, toolbar=no, menubar=no, location=no, resizable=no, scrollbars=no");
		
		document.form.target ="MemberWindow";
		document.form.method = "post";
		document.form.action = "/receipt/member_list.do?run=member_etc";
		document.form.submit();
		document.form.target = "";
				
	}
	
	
	
//-->
</script>
<body>

<form name="form" method="post"  action="member_list.do?run=list">
<input type="hidden" name="current" value="<%=form.getCurrent()%>">
<input type="hidden" name="init_ssn" value="">
<input type="hidden" name="ready" value="">



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
								<td><table width="100%">
										<tr> 
											<td><img src="/img/common/bu_cir01.gif"> 
												<b>웹회원관리</b></td>
											<td align="right"></td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 								
						                <td><table width="100%" class="adm_table">
						                    <col width=12%>
						                    <col width=25%>
						                    <col width=>
						                    <col width=>
						                    <col width=>
						                    <col width=>
						                    <col width=25%>
						                    <tr> 
						                      <th rowspan="2">검색조건</th> 
						                      <th>검색항목</th>
						                      <th>검색입력</th>
						                    </tr>
						                    
						                    <tr class="adm11"> 
						                      <td>
											  <select name="searchType">
						                          <option value="username"  <% if(form.getSearchType().equals("username")){ %> selected <% } %>>고객명</option>
												  <option value="ssn"  <% if(form.getSearchType().equals("ssn")){ %> selected <% } %>>주민번호</option>
						                          <option value="userid"  <% if(form.getSearchType().equals("userid")){ %> selected <% } %>>아이디</option>
					                          </select></td>
						                      <td><input type="text" name="keyword" class="box04" value="<%=form.getKeyword()%>"> 
						                        <a href="javascript:goSearch();" onFocus="blur()"><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a></td>
						                    </tr>
						                  </table></td>
								</tr>
								<tr> 
									<td>&nbsp;</td>
								</tr>
								<tr> 
									<td><table width="100%" class="adm_table">
								                    <tr> 
								                      <th>No</th>
								                      <th>주민등록번호</th>
								                      <th>고객명</th>
								                      <th>아이디</th>
								                      <th>패스워드</th>
								                      <th>초기화</th>
								                    </tr>

<%
											int cnt = output.getCount("ssn");
											
											if(cnt == 0)
											{
%>
								                    <tr class="adm01"> 
								                      <td colspan="6">해당하는 자료가 없습니다.</td>
								                    </tr>										
<%											
											}
											
											else
											{
												int row = 0;
												//out.println(form.getCurrent() -1);
												
												row = Integer.parseInt(totalCount.getText("count")) - (form.getCurrent() -1 )*20;														
											
												for(int i=0;i<cnt;i++)
												{
%>								                    
								                    
								                    <tr align="center" bgcolor="<%= ( i % 2 == 0 ) ? "#FFFFFF" : "#F8F8F8" %>">
								                      <td><%=row%></td>
								                      <td><%=output.getText("ssn",i)%></td>
								                      <td><%=output.getText("userName",i)%></td>
								                      <td><%=output.getText("userID",i)%></td>
								                      <td><%=output.getText("password",i)%></td>
								                      <td><input type="button" name="init_button" value="초기화" onClick="member_etc('<%=output.getText("ssn",i)%>');"></td>
								                    </tr>
<%
												row = row - 1;
												}
											}
											String temp = totalCount.getText("count").toString(); 
											
											//out.println("총개수"+temp);
%>
								                  </table></td>
									</tr>
										<td align="center"><table>
										<tr> 
											<td width="26"></td>
											<td width="45"> <td align="center">
												<jsp:include page="/common/include/paging.jsp" flush="true">
													<jsp:param name="total" value="<%= temp %>"/>
													<jsp:param name="cpage" value="<%= form.getCurrent() %>"/>
												</jsp:include>
											</td>
											<td width="30"></td>
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
<div id="cal" style="position:absolute; z-index:1; 
                     left:192px; top:195px; width:193px;  height:195px; 
                     visibility:hidden"> 
    <iframe name='dalFrame' 
            id='dalFrame' 
            src="/common/cal.jsp?setDate=form.fromdate&divName=cal" 
            width="183" 
            height="175" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"></iframe>
</div>
<div id="cal1" style="position:absolute; z-index:1; 
                     left:192px; top:195px; width:193px;  height:195px; 
                     visibility:hidden"> 
            <iframe id='dalFrame1' 
            src="/common/cal.jsp?setDate=form.todate&divName=cal1" 
            width="183" 
            height="175" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"> </iframe>
</div>

    <iframe name='passwd' 
            id='passwd' 
            src="/receipt/passwd_init.jsp" 
            width="500" 
            height="500" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"></iframe>

</form>

</body>
</html>

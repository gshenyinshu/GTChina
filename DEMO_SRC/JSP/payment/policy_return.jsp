<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>
<jsp:useBean id="policyreturn" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
<jsp:useBean id="current" class="java.lang.String" scope="request"/>
<jsp:useBean id="key" class="java.lang.String" scope="request"/>
<jsp:useBean id="search" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate2" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate2" class="java.lang.String" scope="request"/>
<jsp:useBean id="rslt" class="java.lang.String" scope="request"/>
<jsp:useBean id="searchgubun" class="java.lang.String" scope="request"/>
<jsp:useBean id="modeind" class="java.lang.String" scope="request"/>
<jsp:useBean id="srvc_ind" class="java.lang.String" scope="request"/>
<%
	String linkpage = "";
	String srvc_code = "";
	
	
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
<script language="javascript">
<!--
	function goSearch()
	{
		document.form.current.value = 1;
		document.form.method="get" ;	
		document.form.searchgubun.value = "S";
		document.form.submit();
	}

	function goDetail(cd1)
	{
		var path = "";
		path = "/payment/return_reason.do?policy_apln_no="+cd1;		
		window.open(path, '반송사유', 'left=400,top=350,Width=300,Height=195, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');

	}
	
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
	
//-->
</script>
</head>

<body>
<form name="form" method="post"  action="policy_return.do">
<input type="hidden" name="searchgubun" value="<%=searchgubun%>">
<input type="hidden" name="current" value="<%=current%>">

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
								<td>
									<table width="100%">
										<tr> 
											<td><img src="/img/common/bu_cir01.gif"> 
												<b>반송처리화면</b></td>
											<td align="right">&nbsp;</td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 								
					                <td><table width="100%" class="adm_table">
					                    <col width=12%>
					                    <col width=20%>
					                    <col width=>
					                    <col width=>
					                    <col width=>
					                    <col width=>
					                    <col width=25%>
					                    <tr> 
					                      <th width="8%" rowspan="2">검색조건</th>
					                      <th width="18%">접수일자</th>
					                      <th width="21%">반송일자</th>
					                      <th width="13%">업무분류</th>
					                      <th width="9%">세부검색</th>
					                      <th width="31%">검색입력</th>
					                    </tr>
					                    <tr class="adm11"> 
					                      <td><input type="text" name="fromdate" class="box01" size="8" maxlength="8" style="text-align:center" value="<%=fromdate%>" readonly> 
					                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  > 
					                        - 
					                        <input type="text" name="todate" class="box01" size="8" maxlength="8" style="text-align:center" value = "<%=todate%>" readonly> 
					                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal1');"  > 
					                      </td>
					                      <td><input type="text" name="fromdate2" class="box01" size="8" maxlength="8" style="text-align:center" value="<%=fromdate2%>" readonly> 
					                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal2');"  > 
					                        - 
					                        <input type="text" name="todate2" class="box01" size="8" maxlength="8" style="text-align:center" value = "<%=todate2%>" readonly> 
					                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal3');"  > 
					                      </td>
					                      <td><select name="srvc_ind"  size="1" style="width:115px;" >
					                      	<option value="0"  <% if(srvc_ind.equals("1")){ %> selected <% } %>>전 체</option>				      
					                      	<option value="1"  <% if(srvc_ind.equals("1")){ %> selected <% } %>>약관대출</option>				      
					                      	<option value="2"  <% if(srvc_ind.equals("2")){ %> selected <% } %>>약관대출상환</option>				      
					                      	<option value="3"  <% if(srvc_ind.equals("3")){ %> selected <% } %>>APL납부상환</option>				      
					                      	<option value="4"  <% if(srvc_ind.equals("4")){ %> selected <% } %>>배당금</option>				      
					                      	<option value="5"  <% if(srvc_ind.equals("5")){ %> selected <% } %>>휴면보험금</option>				      
					                      	<option value="6"  <% if(srvc_ind.equals("6")){ %> selected <% } %>>보험료수납</option>				      
					                      	<option value="7"  <% if(srvc_ind.equals("7")){ %> selected <% } %>>배당금상계</option>				      
					                        </select></td>
					                      <td><select name="search" size="1" style="width:80px;">
					                          <option value="1"  <% if(search.equals("1")){ %> selected <% } %>>증권번호</option>
					                          <option value="2"  <% if(search.equals("2")){ %> selected <% } %>>계약자</option>
					                          <option value="3"  <% if(search.equals("3")){ %> selected <% } %>>주민번호</option>
					                        </select></td>
					                      <td><input type="text" name="key" class="box03" value="<%=key%>" > 
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
				                        <th>N</th>
				                        <th>접수일자</th>
				                        <th>접수시간</th>
				                        <th>증권번호</th>
				                        <th>계약자</th>
				                        <th>업무명</th>
				                        <th>신청금액</th>
				                        
				                        <th>반송일자</th>
				                        <th>반송시간</th>
				                        <th>처리자</th>
				                        <th>담당LP</th>
				                      </tr>
<%
							int cnt = policyreturn.getCount("policy_apln_no");							
							if(cnt == 0)
							{
%>
				                      <tr class="adm01"> 
				                        <td colspan="11">해당하는 자료가 없습니다.</td>
				                      </tr>
<%							
							}
							else
							{
								int row = 0;
								row = Integer.parseInt(totalCount) - (Integer.parseInt(current) -1 )*20;								
								for(int i=0;i<cnt;i++)
								{
									String apln_date = "";//접수일
									String apln_time = "";//접수시간
									String prdate = "";//처리일
									String prtime = "";//처리시간								
									
									apln_date = policyreturn.getText("apln_dt",i).trim().substring(0,10);
									apln_time = policyreturn.getText("apln_dt",i).trim().substring(11,16);
							
									linkpage = "return_detail.do";								
%>				                      
				                      <tr align="center" bgcolor="<%= ( i % 2 == 0 ) ? "#FFFFFF" : "#F8F8F8" %>"> 
							   			<td><%=row%></td>
				                        <td><%=apln_date%></td>
				                        <td><%=apln_time%></td>
<%
									if( auth_cd.equals("20") || auth_cd.equals("30") )
									//2005-10-10. 05-C-138. 이위혁. 결재권한 세분화
                                                                        //if(auth_cd.equals("20") || auth_cd.equals("30"))
                                                                        if(auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33"))
									{
%>
				                        <td><a href="javascript:goDetail('<%=policyreturn.getText("policy_apln_no",i)%>');"><%=policyreturn.getText("policy_no",i)%></a></td>
				                        <td><a href="javascript:goDetail('<%=policyreturn.getText("policy_apln_no",i)%>');"><%=policyreturn.getText("payor_nm",i)%></a></td>
				                        <td><a href="javascript:goDetail('<%=policyreturn.getText("policy_apln_no",i)%>');"><%=policyreturn.getText("srvc_name",i)%></a></td>
				                        <td><a href="javascript:goDetail('<%=policyreturn.getText("policy_apln_no",i)%>');"><%=Util.addComma(policyreturn.getText("apln_amt",i))%></a></td>
<%
									}else{
%>
 							   <td><%=policyreturn.getText("policy_no",i)%></td>
				                        <td><%=policyreturn.getText("payor_nm",i)%></td>
				                        <td><%=policyreturn.getText("srvc_name",i)%></td>
				                        <td><%=Util.addComma(policyreturn.getText("apln_amt",i))%></td>
<%
									}
%>

				                        <td><%=policyreturn.getText("proc_dt",i)%></td>								                        
				                        <td><%=policyreturn.getText("proc_tm",i)%></td>
				                        <td><%=policyreturn.getText("emp_nm",i)%></td>
				                        <td><%=policyreturn.getText("lpname",i)%></td>
				                      </tr>
<%
								row = row - 1;
								}
							}
%>				                      
									</table></td>
							</tr>
							<tr> 
								<td align="center"><table>
										<tr> 
											<td width="26"></td>
											<td width="45"> <td align="center">
												<jsp:include page="/common/include/paging.jsp" flush="true">
													<jsp:param name="total" value="<%= totalCount %>"/>
													<jsp:param name="cpage" value="<%= current %>"/>
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
            
<div id="cal2" style="position:absolute; z-index:1; 
                     left:192px; top:195px; width:193px;  height:195px; 
                     visibility:hidden"> 
            <iframe id='dalFrame2' 
            src="/common/cal.jsp?setDate=form.fromdate2&divName=cal2" 
            width="183" 
            height="175" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"> </iframe>
            
</div>

<div id="cal3" style="position:absolute; z-index:1; 
                     left:192px; top:195px; width:193px;  height:195px; 
                     visibility:hidden"> 
            <iframe id='dalFrame3' 
            src="/common/cal.jsp?setDate=form.todate2&divName=cal3" 
            width="183" 
            height="175" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"> </iframe>
            
</div>
</form>
</body>
</html>

<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<%
	String srvc_code = "";
	String linkpage = "";
	
 
	
	//세션에서 가져오기
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
	//String emp_no = sessionManager.getString(Constant.SESSION_USERID);
	//String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
%>
<jsp:useBean id="policyindiv" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
<jsp:useBean id="current" class="java.lang.String" scope="request"/>
<jsp:useBean id="key" class="java.lang.String" scope="request"/>
<jsp:useBean id="search" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" class="java.lang.String" scope="request"/>
<jsp:useBean id="rslt" class="java.lang.String" scope="request"/>
<jsp:useBean id="searchgubun" class="java.lang.String" scope="request"/>
<jsp:useBean id="modeind" class="java.lang.String" scope="request"/>
<jsp:useBean id="srvc_ind" class="java.lang.String" scope="request"/>
<jsp:useBean id="status" class="java.lang.String" scope="request"/>
<jsp:useBean id="menu_mode" class="java.lang.String" scope="request"/>
<%




	
	if(menu_mode.equals("")){
	
		menu_mode = "6";
	
	
	}



	if(current.length() == 0 || current.equals("0"))
	{
		current = "1";
	}
	
	if(status.trim().length() == 0)
	{
		status = " ";
	}
	
	
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='/common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>

</head>
<script language="javascript">
<!--
	function goSearch()
	{
		document.form.current.value = 1;
		document.form.searchgubun.value = "S";
		document.form.submit();
	}

	function goDetail(cd1, cd2, cd3, cd4, deathResult)
	{
		if ( deathResult == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ( deathResult == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ( deathResult == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}	

		var path = "";
		path = "/receipt/"+cd1+"?indate="+cd2+"&seq_no="+cd3+"&srvc_cd="+cd4;
		
		if(cd4 == "A")
		{
			window.open(path, '모니터링', 'left=400,top=350,Width=700,Height=540, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
		} 
		else if(cd4 == "B" || cd4 == "C" || cd4 == "D")
		{
			window.open(path, '모니터링', 'left=400,top=350,Width=525,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
		} 
		else
		{
			window.open(path, '모니터링', 'left=400,top=350,Width=525,Height=170, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
		}
	}
	
	
	function goHost(cd1, cd2, cd3, cd4, deathResult)
	{
		if ( deathResult == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ( deathResult == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ( deathResult == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}	

		document.form.searchgubun.value = "H";
		document.form.indate.value = cd1;
		document.form.seq_no.value = cd2;
		document.form.srvc_gubun.value = cd3;
		document.form.process_mode.value = cd4;
		document.form.submit();		
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
	
	function ReLoadWindow(val)
	{				
		var srvc_value = '<%=srvc_ind%>';	
		var searchgubun = '<%=searchgubun%>';
		
		if(val == "") val = "1";
				
		if(val == "1")
		{
		
		
			if( '8' == '<%=menu_mode%>' && 'B'== srvc_value ){
			
				
				var AddOption0 = new Option("자동이체변경", "B");
				document.forms[0].srvc_ind.length  = 1;
				document.forms[0].srvc_ind.options[0] = AddOption0;					

			
			}else if('8' == '<%=menu_mode%>' && 'C'=='<%=srvc_ind%>'){
			
				var AddOption0 = new Option("자동이체해지", "C");
				document.forms[0].srvc_ind.length  = 1;
				document.forms[0].srvc_ind.options[0] = AddOption0;		
			
			}else if('9' == '<%=menu_mode%>' && 'I'=='<%=srvc_ind%>'){
			
				var AddOption0 = new Option("APL신청", "I");
				document.forms[0].srvc_ind.length  = 1;
				document.forms[0].srvc_ind.options[0] = AddOption0;					
			
			}else if('9' == '<%=menu_mode%>' && 'J'=='<%=srvc_ind%>'){
			
				var AddOption0 = new Option("APL해지", "J");
				document.forms[0].srvc_ind.length  = 1;
				document.forms[0].srvc_ind.options[0] = AddOption0;					
			
			}else{
			
	
			
				var AddOption0 = new Option("전 체" ,"Z");
				var AddOption = new Option("고객정보변경" ,"A");
				//var AddOption1 = new Option("자동이체변경", "B");
				//var AddOption2 = new Option("자동이체해지", "C")
				//var AddOption3 = new Option("그룹빌링신청","D");
				//var AddOption4 = new Option("약대자동상환","E");
				//var AddOption5 = new Option("APL자동상환","F");
				var AddOption1 = new Option("납주변경","G");
				//var AddOption8 = new Option("APL신청","I");
				//var AddOption9 = new Option("APL해지","J");
				

				
				document.forms[0].srvc_ind.length  = 3;
				document.forms[0].srvc_ind.options[0] = AddOption0;			
				//document.forms[0].srvc_ind.options[1] = AddOption;			
				//document.forms[0].srvc_ind.options[2] = AddOption3;			
				//document.forms[0].srvc_ind.options[3] = AddOption4;			
				//document.forms[0].srvc_ind.options[4] = AddOption5;			
				document.forms[0].srvc_ind.options[1] = AddOption;			
				document.forms[0].srvc_ind.options[2] = AddOption1;			
				//document.forms[0].srvc_ind.options[7] = AddOption6;			
				//document.forms[0].srvc_ind.options[8] = AddOption8;			
				//document.forms[0].srvc_ind.options[9] = AddOption9;			
				
				if(srvc_value == "Z") document.forms[0].srvc_ind.options[0].selected = true;
				if(srvc_value == "A") document.forms[0].srvc_ind.options[1].selected = true;
				//if(srvc_value == "B") document.forms[0].srvc_ind.options[2].selected = true;
				//if(srvc_value == "C") document.forms[0].srvc_ind.options[3].selected = true;
				//if(srvc_value == "D") document.forms[0].srvc_ind.options[2].selected = true;
				//if(srvc_value == "E") document.forms[0].srvc_ind.options[3].selected = true;
				//if(srvc_value == "F") document.forms[0].srvc_ind.options[4].selected = true;
				if(srvc_value == "G") document.forms[0].srvc_ind.options[2].selected = true;			
				//if(srvc_value == "I") document.forms[0].srvc_ind.options[8].selected = true;
				//if(srvc_value == "J") document.forms[0].srvc_ind.options[9].selected = true;
				
			
			
			}
			
					

		}
		else if(val == "2")
		{
			var AddOption = new Option("증명서", "1");
			
			document.forms[0].srvc_ind.length  = 1;
			document.forms[0].srvc_ind.options[0] = AddOption;					
			
			if(srvc_value == "1") document.forms[0].srvc_ind.options[0].selected = true;
		}
		else if(val == "3")
		{
			var AddOption = new Option("부활문의", "2");
			
			document.forms[0].srvc_ind.length  = 1;
			document.forms[0].srvc_ind.options[0] = AddOption;					
			
			if(srvc_value == "2") document.forms[0].srvc_ind.options[0].selected = true;
		}
	}
	
	function goAllChange()
	{
	
		document.form.action ="/receipt/policy_change.do";
		document.form.submit();
	}

	function goChange(indate, seq_no, row, srvc_gubun, cnt, deathResult)
	{
		if ( deathResult == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ( deathResult == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ( deathResult == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}	

		document.form.indate.value = indate;
		document.form.seq_no.value = seq_no;
		document.form.searchgubun.value = "C";
		document.form.srvc_gubun.value = srvc_gubun;
		if(cnt == 1)
		{
			document.form.rtnflag.value = document.form.chgstatus.value;
		}
		else
		{
			document.form.rtnflag.value = document.form.chgstatus[row].value;
		}
		document.form.submit();	
	}
	
	
	function goReturn(cd1,cd2,cd3,deathResult)
	{
		if ( deathResult == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ( deathResult == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ( deathResult == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}	

		var path = "";
		path = "/receipt/return_cause.do?indate="+cd1+"&seq_no="+cd2+"&srvc_gubun="+cd3+"&flag=S";
		window.open(path, '반송사유', 'left=400,top=350,Width=430,Height=280, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	
	}

	function goContent(cd1,cd2, cd3, cd4, deathResult)
	{
		if ( deathResult == "1") {
			if(!confirm("생명보험 협회로부터 계약자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ( deathResult == "2") {
			if(!confirm("생명보험 협회로부터 피보험자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}
		if ( deathResult == "3") {
			if(!confirm("생명보험 협회로부터 수익자 사망으로 등록된 계약 입니다. \n 지점 확인 후 처리 바랍니다. \n\n 처리하시겠습니까?"))  {
				return;
			}
		}	

		var path = "";
		path = "/receipt/return_content.do?indate="+cd1+"&seq_no="+cd2+"&srvc_gubun="+cd3+"&status_code="+cd4;
		window.open(path, '사유', 'left=400,top=350,Width=630,Height=280, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
	
	}	
	
	function winreflash()
	{
		document.form.action = "policy_indiv.do";	
		document.form.searchgubun.value = "S";			
		document.form.submit();
	}			
//-->
</script>
<body onLoad="javascript:ReLoadWindow('<%=modeind%>');">

<form name="form" method="post"  action="policy_indiv.do">
<input type="hidden" name="searchgubun" value="<%=searchgubun%>">
<input type="hidden" name="current" value="<%=current%>">
<input type="hidden" name="indate">
<input type="hidden" name="seq_no">
<input type="hidden" name="srvc_gubun">
<input type="hidden" name="process_mode">
<input type="hidden" name="rtnflag">
<input type="hidden" name="menu_mode" value="<%=menu_mode%>">
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
						<jsp:param name="menu_mode" value="<%=menu_mode%>"/>
						</jsp:include>
						<!--DropDown 삽입 : E-->
					</td>
							<td class="contents"><table width="100%">
							<tr> 								
                  						<td><img src="/img/common/title_06.gif"></td>
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
					                        
					                        <b>개별처리(
					                        <%if(srvc_ind.equals("B")){%>
					                        
					                        자동이체변경
					                        <%}else if(srvc_ind.equals("C")){ %>
					                        자동이체해지
					                        <%}else if(srvc_ind.equals("I")){ %>
					                        
					                        APL신청
					                        
					                        <%}else if(srvc_ind.equals("J")){ %>
					                        APL해지
					                         <%}else{ %>
					                        계약 및 고객정보변경
					                        
					                        <%} %>
					                        )</b></td>
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
				                        <th width="13%">업무분류</th>
				                        <th width="9%">상태</th>
				                        <th width="9%">세부검색</th>
				                        <th width="22%">검색입력</th>
				                      </tr>
				                      <tr class="adm11"> 
				                        <td><input type="text" name="fromdate" class="box01" size="8" maxlength="8" style="text-align:center" value="<%=fromdate%>" readonly> 
				                          <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  > 
				                          - 
				                          <input type="text" name="todate" class="box01" size="8" maxlength="8" style="text-align:center" value = "<%=todate%>" readonly> 
				                          <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal1');"  > 
				                        </td>
				                        <td><div align="center"><select name="srvc_ind"  size="1" style="width:115px;" >
				                          </select></div></td>
				                        <td><div align="center"><select name="status" size="1" style="width:80px;">
				                           <option value="T"  <% if(status.equals("T")){ %> selected <% } %>>전체</option>
				                            <option value="R"  <% if(status.equals("R")){ %> selected <% } %>>접수</option>
				                            <option value="0"  <% if(status.equals("0")){ %> selected <% } %>>즉시처리</option>
				                            <option value="1"  <% if(status.equals("1")){ %> selected <% } %>>일괄처리</option>
				                            <option value="2"  <% if(status.equals("2")){ %> selected <% } %>>실패</option>
				                            <option value="3"  <% if(status.equals("3")){ %> selected <% } %>>반송</option>
				                          </select></div></td>
				                        <td><div align="center"><select name="search" size="1" style="width:80px;">
				                            <option value="1"  <% if(search.equals("1")){ %> selected <% } %>>증권번호</option>
				                            <option value="2"  <% if(search.equals("2")){ %> selected <% } %>>계약자</option>
				                            <option value="3"  <% if(search.equals("3")){ %> selected <% } %>>주민번호</option>
				                          </select></div></td>
				                        <td><input type="text" name="key" class="box03" value="<%=key%>"> 
				                          <a href="javascript:goSearch();" onFocus="blur()"><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a>
				                         &nbsp;<a href="javascript:goExcel();" ><img src="/img/common/btn_excel.gif" align="absmiddle" border="0"></a>
				                         </td>
				                      </tr>
				                    </table></td>
									</tr>
									<tr> 
										<td>&nbsp;</td>
									</tr>
									<tr> 
										<td>
										 <div id="excelDiv"><!-- excel 2단계 -->
										<table width="100%" class="adm_table">
						                      <tr> 
						                        <th width="3%">N</th>
						                        <th width="7%">접수일자</th>
						                        <th width="6%">접수시간</th>
						                        <th width="10%">증권번호</th>
						                        <th width="6%">계약자</th>
						                        <th width="10%">업무명</th>
						                        <th width="6%">상태</th>
						                        <th width="6%">내역</th>
						                        <th width="7%">개별처리</th>
						                        <th width="7%">상태</th>
						                        <th width="6%">변경</th>
						                        <th width="9%">반송</th>
						                        <th width="9%">반송(실패)사유</th>
						                        <th width="8%">구분</th>
						                      </tr>
<%
										int cnt = policyindiv.getCount("seq_no");
										if(cnt == 0) 
										{
%>
						                      <tr class="adm01"> 
						                        <td colspan="14">해당하는 자료가 없습니다.</td>
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
<%
												String indate = "";//접수일
												String intime = "";//접수시간
												String prdate = "";//처리일
												String prtime = "";//처리시간
												indate = policyindiv.getText("indate",i).trim();
												intime = policyindiv.getText("intime",i).trim();
												prdate = policyindiv.getText("prdate",i).trim();
												prtime = policyindiv.getText("prtime",i).trim();
												
												if(indate.length() > 7)
													indate = indate.substring(0,4) +"."+ indate.substring(4,6) +"."+ indate.substring(6,8);
												if(intime.length() > 5)
													intime = intime.substring(0,2) +":"+	intime.substring(2,4) +":"+ intime.substring(4,6);
												if(prdate.length() > 7)
													prdate = prdate.substring(0,4) +"."+ prdate.substring(4,6) +"."+ prdate.substring(6,8);
												if(prtime.length() > 5)
													prtime = prtime.substring(0,2) +":"+	prtime.substring(2,4) +":"+ prtime.substring(4,6);
												
												srvc_code = policyindiv.getText("srvc_code",i).trim();
											

												linkpage = "realtime_client.do";
%>
						                        <td><%=indate%></td>
						                        <td><%=intime%></td>
<%
												if(srvc_code.equals("A"))
												{	
													String ssn = policyindiv.getText("ssn",i).trim();
													if( ssn.length()>0 )  ssn = ssn.substring(0,6)+"-"+ssn.substring(6);
%>
										        <td><%=ssn%></td>
<%
													}
													else
													{
%>
            									<td><%=policyindiv.getText("policy",i).trim()%></td>
<%
													}
%>
						                        <td><%=policyindiv.getText("owner",i).trim()%></td>
						                        <td><%=policyindiv.getText("srvc_cd",i).trim()%></td>
						                        <td><%=policyindiv.getText("status",i).trim()%></td>
						                        <td>
<%
													if(srvc_code.equals("D"))
													{	
%>								                        
													&nbsp;
<%
													}
													else
													{	
%>												
							                        <a href="javascript:goDetail('<%=linkpage%>', '<%=policyindiv.getText("indate",i).trim()%>', '<%=policyindiv.getText("seq_no",i).trim()%>','<%=srvc_code%>','<%=policyindiv.getText("deathResult",i)%>')" onFocus="blur()">
							                        <img src="/img/common/btn_inquiry.gif" width="38" height="18" border="0"></a>
<%
													}
%>										                        
						                        </td>
						                        <td width="4%">
<%
													//out.println(policyindiv.getText("status_code",i));
													if(policyindiv.getText("status_code",i).equals(" "))
													{	
														//2005-10-10. 05-C-138. 이위혁. 결재권한세분화
														//if( auth_cd.equals("20") || auth_cd.equals("30") )
														if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
														{
%>										                        
										        	<a href="javascript:goHost('<%=policyindiv.getText("indate",i).trim()%>', '<%=policyindiv.getText("seq_no",i).trim()%>','<%=srvc_code%>','<%=policyindiv.getText("process_mode",i)%>', '<%=policyindiv.getText("deathResult",i)%>')" onFocus="blur()"><img src="/img/common/btn_apply.gif" width="49" height="19" border="0"></a>
<%
														}
													}
													else
													{
%>
													&nbsp;
<%													
													}
%>										                        
										        </td>
												<td><select name="chgstatus">
					                      			<option value=""  selected>접수</option>
					                      			<option value="0">즉시처리</option>
					                      			<option value="1">일괄처리</option>
					                      			<option value="2">실패</option>
					                      			<option value="3">반송</option>
					                        		</select></td>										                        
							                       <td>
<%
												//2005-10-10. 05-C-138. 이위혁. 결재권한세분화
												//if( auth_cd.equals("20") || auth_cd.equals("30") )
												if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
												{
%>							                       
							                       <a href="javascript:goChange('<%=policyindiv.getText("indate",i)%>', '<%=policyindiv.getText("seq_no",i)%>','<%=i%>','<%=policyindiv.getText("srvc_code",i)%>','<%=cnt%>','<%=policyindiv.getText("deathResult",i)%>')"><img src="/img/common/btn_changes.gif" border="0"></a>
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
							                       <a href="javascript:goReturn('<%=policyindiv.getText("indate",i).trim()%>', '<%=policyindiv.getText("seq_no",i).trim()%>','<%=srvc_code%>','<%=policyindiv.getText("deathResult",i)%>');"><img src="/img/common/btn_return.gif" width="40" height="18" border="0"></a>
<%
												}
%>							                       
							                       </td>
							                       <td>
<%													
													if(policyindiv.getText("status_code",i).equals("3") || policyindiv.getText("status_code",i).equals("2"))
													{	
%>										                        
										        	<a href="javascript:goContent('<%=policyindiv.getText("indate",i).trim()%>', '<%=policyindiv.getText("seq_no",i).trim()%>','<%=srvc_code%>', '<%=policyindiv.getText("status_code",i)%>', '<%=policyindiv.getText("deathResult",i)%>')" onFocus="blur()">
<%
													if(policyindiv.getText("status_code",i).equals("3"))
													{
%>										        	
										        	<img src="/img/common/btn_return2.gif" width="62" height="18" border="0">
<%
													}
													else if(policyindiv.getText("status_code",i).equals("2"))
													{
%>
													<img src="/img/common/btn_return3.gif" width="62" height="18" border="0">	
<%													
													}
%>										        	
										        	</a>
<%
													}
													else
													{
%>
													&nbsp;
<%													
													}
%>										                        
							                       </td>
<%
												String process_mode = "";//구분
												       process_mode = policyindiv.getText("process_mode",i).trim();
												if( process_mode.equals("R") )
												{
													process_mode = "실시간";
												}
												else
												{
													process_mode = "관리자";
												}
%>							                       
							                       <td><%=process_mode%></td>
							                      </tr>
<%
													row = row - 1;
												}
											}
%>
									          </table>
									          </div>
									          </td>
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

<!-- excel 을 보내기위한 target frame-->
<iframe src="" name="excelFrame" width="0" height="0" frameborder="0" ></iframe>



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
</form>
<!-- excel 1단계 -->
<form name="excelform" method="post">
<input type="hidden" name="excel">
</form>
<!-- excel 1단계 -->

</body>
</html>

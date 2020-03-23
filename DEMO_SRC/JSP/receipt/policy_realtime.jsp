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
%>
<jsp:useBean id="policyreal" class="anyframe.data.DataSet" scope="request"/>
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
		document.form.method="get" ;	
		document.form.searchgubun.value = "S";
		document.form.submit();
	}

	function goDetail(cd1, cd2, cd3, cd4)
	{
		var path = "";
		path = "/receipt/"+cd1+"?indate="+cd2+"&seq_no="+cd3+"&srvc_cd="+cd4;
		
		if(cd4 == "A")
		{
			window.open(path, '모니터링', 'left=400,top=350,Width=700,Height=510, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
		} 
		else if(cd4 == "B" || cd4 == "C" || cd4 == "D")
		{
			window.open(path, '모니터링', 'left=400,top=350,Width=525,Height=210, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
		} 
		else if(cd4 == "N")
		{
			window.open(path, '모니터링', 'left=400,top=350,Width=700,Height=210, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
		}
		else
		{
			window.open(path, '모니터링', 'left=400,top=350,Width=525,Height=140, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');
		}
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
			var AddOption0 = new Option("전 체" ,"Z");
			var AddOption = new Option("고객정보변경" ,"A");
			var AddOption1 = new Option("자동이체변경", "B");
			var AddOption2 = new Option("자동이체해지", "C")
			//var AddOption3 = new Option("그룹빌링신청","D");
			//var AddOption4 = new Option("약대자동상환","E");
			//var AddOption5 = new Option("APL자동상환","F");
			var AddOption3 = new Option("납주변경","G");
			var AddOption4 = new Option("APL신청","I");
			var AddOption5 = new Option("APL해지","J");
			
			//20070620 추가 업무 화면 추가로 인하여. 추가되는 항목..
			var AddOption6 = new Option("SNC특부신청","K");
			var AddOption7 = new Option("LNB특부신청","L");
			var AddOption8 = new Option("FNB특부신청","M");
			var AddOption9 = new Option("동의철회/수신거부","N");
			


			
			document.forms[0].srvc_ind.length  = 11;
			
			document.forms[0].srvc_ind.options[0] = AddOption0;			
			document.forms[0].srvc_ind.options[1] = AddOption;			
			document.forms[0].srvc_ind.options[2] = AddOption1;			
			document.forms[0].srvc_ind.options[3] = AddOption2;			
			//document.forms[0].srvc_ind.options[4] = AddOption3;			
			//document.forms[0].srvc_ind.options[5] = AddOption4;			
			//document.forms[0].srvc_ind.options[6] = AddOption5;			
			document.forms[0].srvc_ind.options[4] = AddOption3;			
			document.forms[0].srvc_ind.options[5] = AddOption4;			
			document.forms[0].srvc_ind.options[6] = AddOption5;			
			
			document.forms[0].srvc_ind.options[7] = AddOption6;		
			document.forms[0].srvc_ind.options[8] = AddOption7;		
			document.forms[0].srvc_ind.options[9] = AddOption8;		

			document.forms[0].srvc_ind.options[10] = AddOption9;		
						
			if(srvc_value == "Z") document.forms[0].srvc_ind.options[0].selected = true;
			if(srvc_value == "A") document.forms[0].srvc_ind.options[1].selected = true;
			if(srvc_value == "B") document.forms[0].srvc_ind.options[2].selected = true;
			if(srvc_value == "C") document.forms[0].srvc_ind.options[3].selected = true;
			//if(srvc_value == "D") document.forms[0].srvc_ind.options[4].selected = true;
			//if(srvc_value == "E") document.forms[0].srvc_ind.options[5].selected = true;
			//if(srvc_value == "F") document.forms[0].srvc_ind.options[6].selected = true;
			if(srvc_value == "G") document.forms[0].srvc_ind.options[4].selected = true;			
			if(srvc_value == "I") document.forms[0].srvc_ind.options[5].selected = true;
			if(srvc_value == "J") document.forms[0].srvc_ind.options[6].selected = true;
			
			if(srvc_value == "K") document.forms[0].srvc_ind.options[7].selected = true;
			if(srvc_value == "L") document.forms[0].srvc_ind.options[8].selected = true;
			if(srvc_value == "M") document.forms[0].srvc_ind.options[9].selected = true;
			
			if(srvc_value == "N") document.forms[0].srvc_ind.options[10].selected = true;
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
	
//-->
</script>
<body onLoad="javascript:ReLoadWindow('<%=modeind%>');">
<form name="form" method="post"  action="policy_realtime.do">
<input type="hidden" name="searchgubun" value="<%=searchgubun%>">
<input type="hidden" name="current" value="<%=current%>">
<input type="hidden" name="modeind" value="1">
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
						<jsp:param name="menu_mode" value="6"/>
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
                        					<td><img src="/img/common/bu_cir01.gif"> <b>모니터링(일반)</b></td>
											
                        						<td align="right">
<%
									//2005-10-10. 05-C-138. 이위혁. 결재권한세분화
									//if(auth_cd.equals("20") || auth_cd.equals("30"))
									if(auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33"))
									{
%>                        						
                        						<!--<a href="javascript:goAllChange()" onFocus="blur()"><img src="/img/common/btn_batchprocess.gif" ></a>-->
<%
									}
%>                        						
                        						</td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
								<td><table width="100%" class="adm_table">
										<col width=12%><col width=20%><col width=><col width=><col width=><col width=><col width=25%> 
										<tr> 
											<th width="8%" rowspan="2">검색조건</th>
											<th width="18%">접수일자</th>											
							                <th width="21%">처리일자</th>
							                <th width="9%">상태값</th>
							                <th width="13%">업무분류</th>											
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
					                        <td><input type="text" name="fromdate2" class="box01" size="8" maxlength="8" style="text-align:center" value="<%=fromdate2%>" readonly> 
					                          <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal2');"  > 
					                          - 
					                          <input type="text" name="todate2" class="box01" size="8" maxlength="8" style="text-align:center"  value = "<%=todate2%>" readonly> 
					                          <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal3');"  > 
					                        </td>
					                        <td>
					                        <select name="rslt">
					                           <option value="A"  <% if(rslt.equals("A")){ %> selected <% } %>>전체</option>
					                           <option value=" "  <% if(rslt.equals(" ")){ %> selected <% } %>>접수</option>
				                               <option value="0"  <% if(rslt.equals("0")){ %> selected <% } %>>즉시처리</option>
				                               <option value="1"  <% if(rslt.equals("1")){ %> selected <% } %>>일괄처리</option>
				                               <option value="2"  <% if(rslt.equals("2")){ %> selected <% } %>>실패</option>
				                               <option value="3"  <% if(rslt.equals("3")){ %> selected <% } %>>반송</option>
								    </select>
					                           </td>
					                        <td><select name="srvc_ind"  size="1" style="width:115px;" >
					                          </select></td>
											<td><select name="search" size="1" style="width:80px;">
													<option value="1"  <% if(search.equals("1")){ %> selected <% } %>>증권번호</option>
													<option value="2"  <% if(search.equals("2")){ %> selected <% } %>>계약자</option>
												</select></td>
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
					                        <th>N</th>
					                        <th>접수일자</th>
					                        <th>접수시간</th>
					                        <th>증권번호</th>
					                        <th>계약자</th>
					                        <th>업무명</th>
					                        <th>상태</th>
					                        <th>내역</th>					                        
					                        <th>처리일자</th>
					                        <th>처리시간</th>
					                      </tr>
					                     
<%
										int cnt = policyreal.getCount("seq_no");
										if(cnt == 0) 
										{
%>
					                      <tr class="adm01"> 
					                        <td colspan="10">해당하는 자료가 없습니다.</td>
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
											indate = policyreal.getText("indate",i).trim();
											intime = policyreal.getText("intime",i).trim();
											prdate = policyreal.getText("prdate",i).trim();
											prtime = policyreal.getText("prtime",i).trim();
											
											if(indate.length() > 7)
												indate = indate.substring(0,4) +"."+ indate.substring(4,6) +"."+ indate.substring(6,8);
											if(intime.length() > 5)
												intime = intime.substring(0,2) +":"+	intime.substring(2,4) +":"+ intime.substring(4,6);
											if(prdate.length() > 7)
												prdate = prdate.substring(0,4) +"."+ prdate.substring(4,6) +"."+ prdate.substring(6,8);
											if(prtime.length() > 5)
												prtime = prtime.substring(0,2) +":"+	prtime.substring(2,4) +":"+ prtime.substring(4,6);
											
											srvc_code = policyreal.getText("srvc_code",i).trim();
											

											linkpage = "realtime_client.do";
%>								                        
								                        <td><%=indate%></td>
								                        <td><%=intime%></td>
<%
													if(srvc_code.equals("A") || srvc_code.equals("N"))
													{	
														String ssn = policyreal.getText("ssn",i).trim();
														if( ssn.length()>0 )  ssn = ssn.substring(0,6)+"-"+ssn.substring(6);
%>								                        
								                        <td><%=ssn%></td>
<%
													}else{
%>								                        
								                        <td><%=policyreal.getText("policy",i).trim()%></td>
<%
													}
%>								                        
								                        
								                        <td><%=policyreal.getText("owner",i).trim()%></td>
								                        <td><%=policyreal.getText("srvc_cd",i).trim()%></td>
								                        <td><%=policyreal.getText("status",i).trim()%></td>
								                        
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
								                        <a href="javascript:goDetail('<%=linkpage%>', '<%=policyreal.getText("indate",i).trim()%>', '<%=policyreal.getText("seq_no",i).trim()%>','<%=srvc_code%>')" onFocus="blur()">
								                        <img src="/img/common/btn_inquiry.gif" width="38" height="18" border="0"></a>
<%
												}
%>								                        
								                        </td>
								                        
								                        <td><%=prdate%></td>
								                        <td><%=prtime%></td>
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
									</table>

								</td>
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
<!-- excel 1단계 -->
<form name="excelform" method="post">
<input type="hidden" name="excel">
</form>
<!-- excel 1단계 -->

</body>
</html>

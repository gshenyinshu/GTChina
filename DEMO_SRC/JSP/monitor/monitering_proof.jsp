<%
/**
 * Description : 모니터링(증명서우편발급)
 * File        : /monitor/monitering_proof.jsp
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : 
 * First Write : 
 * update date : 
 * update desc :
 */
%>

<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util, gtone.changeminer.common.utility.ToolString" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<jsp:useBean id="monitor" class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="totalCount" class="java.lang.String" scope="request"/>
<jsp:useBean id="current" class="java.lang.String" scope="request"/>
<jsp:useBean id="key" class="java.lang.String" scope="request"/>
<jsp:useBean id="search" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate2" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate2" class="java.lang.String" scope="request"/>
<jsp:useBean id="searchgubun" class="java.lang.String" scope="request"/>
<jsp:useBean id="modeind" class="java.lang.String" scope="request"/>
<jsp:useBean id="srvc_ind" class="java.lang.String" scope="request"/>
<jsp:useBean id="auth_cd" class="java.lang.String" scope="request"/>
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
	
	function goPage(num) 
	{
		document.form.current.value = num;
		document.form.method="get" ;
		document.form.submit();
	}	
	
	
	//일괄처리
	function goAllChange() 
	{
		document.form.searchgubun.value = "C";
		document.form.submit();
	}		
//-->
</script>
</head>
<body>
<form name="form" method="post"  action="monitering_proof.do">
<input type="hidden" name="searchgubun" value="<%=searchgubun%>">
<input type="hidden" name="current" value="<%=current%>">
<table width="100%" height="100%">
	<tr> 
		<td height=71>
			<table width="100%" background="/img/common/logo_bg.gif">
				<tr> 
					<td><img src="/img/common/logo.gif"></td>
					<td align="right"><img src="/img/common/logo_end.gif"></td>
				</tr>
			</table>
		</td>
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
					<td class="contents">
						<table width="100%">
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
                      						<td><img src="/img/common/bu_cir01.gif"> <b>모니터링(증명서우편발급)</b></td>
					                        <td align="right">
<%
												if(auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33"))
												{
%>											
												<a href="javascript:goAllChange()" onFocus="blur()"><img src="/img/common/btn_batchprocess.gif" ></a>
<%
												}
%>												
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
				                <td>
				                <table width="100%" class="adm_table">
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
				                      <th width="21%">처리일자</th>
				                      <th width="9%">대분류</th>
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
				                        <input type="text" name="todate2" class="box01" size="8" maxlength="8" style="text-align:center" value = "<%=todate2%>" readonly> 
				                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal3');"  > 
				                      </td>
				                      <td><select name="modeind"  size="1" style="width:80px;" onChange="ReLoadWindow(this.value)">
				                          <option value="1"   selected>증명서</option>
				                        </select> </td>
				                      <td><select name="srvc_ind"  size="1" style="width:150px;" >
				                      	<option value="2"  <% if(srvc_ind.equals("2")){ %> selected <% } %>>소득공제납입증명</option>
				                        </select></td>
				                      <td><select name="search" size="1" style="width:80px;">
				                          <option value="1"  <% if(search.equals("1")){ %> selected <% } %>>주민번호</option>
				                          <option value="2"  <% if(search.equals("2")){ %> selected <% } %>>계약자</option>
				                          <option value="3"  <% if(search.equals("3")){ %> selected <% } %>>신청년도</option>
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
				                        <th width="5%">N</th>
				                        <th width="8%">접수일자</th>
										<th width="8%">접수시간</th>
				                        <th width="10%">주민번호</th>
										<th width="7%">신청년도</th>
				                        <th width="7%">계약자</th>
				                        <th width="7%">수령처</th>
				                        <th width="35%">주소</th>
				                        <th width="5%">상태</th>
				                        <th width="8%">처리일자</th>
				                      </tr>
<%
										int cnt = monitor.getCount("indate");
										if(cnt == 0)
										{
%>
				                      <tr class="adm01"> 
				                        <td colspan="9">해당하는 자료가 없습니다.</td>
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
										String indate =  "";//접수일
											   indate = monitor.getText("indate",i).trim();	
											   if( indate.length() > 7 ) indate = indate.substring(0,4) +"."+ indate.substring(4,6) +"."+ indate.substring(6,8);
										
										
										String intime  = "";//접수시간
											   intime = monitor.getText("intime",i).trim();	
											   if( intime.length() > 5 ) intime = intime.substring(0,2) +":"+ intime.substring(2,4) +":"+ intime.substring(4,6);										
										
										
										String prdate = "";//처리일
											   prdate = monitor.getText("prdate",i).trim();	
											   if( prdate.length() > 7 ) prdate = prdate.substring(0,4) +"."+ prdate.substring(4,6) +"."+ prdate.substring(6,8);
										
										
										String prtime = "";//처리시간
											   prtime = monitor.getText("prtime",i).trim();	
											   if( prtime.length() > 5 ) prtime = prtime.substring(0,2) +":"+ prtime.substring(2,4) +":"+ prtime.substring(4,6);											;										
											

										String jumin_no = "";//주민번호
											   jumin_no = monitor.getText("ssn",i).trim();
											   if( jumin_no.length() > 0 ) jumin_no = jumin_no.substring(0,6)+"-"+jumin_no.substring(6);
%>
				                        <td><%=indate%></td>
										<td><%=intime%></td>
				                        <td><%=jumin_no%></td>
				                        <td><%=monitor.getText("inyear",i).trim()%>년</td>
				                        <td><%=monitor.getText("name",i).trim()%></td>
				                        <td><%=monitor.getText("subcode",i)%></td>
				                        <td><%=Util.doubleTrim(ToolString.fullTohalf(monitor.getText("addr1",i).trim()))%>&nbsp;<%=Util.doubleTrim(ToolString.fullTohalf(monitor.getText("addr2",i).trim()))%>&nbsp;<%=Util.doubleTrim(ToolString.fullTohalf(monitor.getText("addr3",i).trim()))%>&nbsp;<%=Util.doubleTrim(ToolString.fullTohalf(monitor.getText("addr4",i).trim()))%></td>
										<td><%=monitor.getText("pms",i).trim()%></td>
										<td><%=prdate%></td>
				                      </tr>
<%
												row = row -1;
											}
										}
%>
                    				</table>
                  				</div>
                  				</td>
							</tr>
							<tr> 
								<td align="center">
									<table>
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
						</table>
					</td>
				</tr>
			</table>
		</td>
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

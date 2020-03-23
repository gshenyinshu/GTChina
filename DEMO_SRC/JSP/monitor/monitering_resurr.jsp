<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*,, gtone.changeminer.common.utility.Util" %>
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
	
	function goPage(num) 
	{
		document.form.current.value = num;
		document.form.method="get" ;
		document.form.submit();
	}		
//-->
</script>
<body>
<form name="form" method="post"  action="monitering_resurr.do">
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
			</table></td>
	</tr>
	<tr> 
		<td>
			<table width=100% height="100%">
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
                      								<td><img src="/img/common/bu_cir01.gif"> <b>모니터링(부활문의)</b></td>
											
                        <td align="right">&nbsp;</td>
										</tr>
									</table></td>
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
						                      <th width="21%">해지일자</th>
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
						                          <option value="1"   selected>부활</option>
						                        </select> </td>
						                      <td><select name="srvc_ind"  size="1" style="width:115px;" >
						                      	<option value="1"  selected>부활문의</option>
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
								                      <th>담당LP</th>
								                      <th>해지일자</th>
								                      <th>납방보험료</th>
								                      <th>부활보험료합계</th>
								                      <!--
								                      <th>LP수신</th>
								                      <th>SM수신</th>-->
								                    </tr>
<%
											int cnt = monitor.getCount("policy_no");
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
												String indate = "";//접수일
												String intime = "";//접수시간
												String lapsedate = "";//해지일
												
												indate 	= monitor.getText("indate",i).trim();
												intime 	= monitor.getText("intime",i).trim();											
												lapsedate = monitor.getText("lapsedate",i).trim();
												
												
												if(indate.length() > 7)
													indate = indate.substring(0,4) +"."+ indate.substring(4,6) +"."+ indate.substring(6,8);
												if(intime.length() > 5)
													intime = intime.substring(0,2) +":"+	intime.substring(2,4) +":"+ intime.substring(4,6);
												if(lapsedate.length() > 7)
													lapsedate = lapsedate.substring(0,4) +"."+ lapsedate.substring(4,6) +"."+ lapsedate.substring(6,8);
%>									                      
								                      <td><%=indate%></td>
								                      <td><%=intime%></td>
								                      <td><%=monitor.getText("policy_no",i).trim()%></td>
								                      <td><%=monitor.getText("owner",i).trim()%></td>
								                      <td><%=monitor.getText("svclp",i).trim()%></td>
								                      <td><%=lapsedate%></td>
								                      <td><div align="right"><%=Util.addComma(monitor.getText("modprem",i).trim())%>원</div></td>
								                      <td><div align="right"><%=Util.addComma(monitor.getText("totprm",i).trim())%>원</div></td>
								                      <!--<td><%=monitor.getText("lprecv",i).trim()%></td>
								                      <td><%=monitor.getText("smrecv",i).trim()%></td>-->
								                    </tr>
<%
													row = row -1;
												}
											}
%>								                    
                  								</table>
										</div><!-- excel 3단계 -->
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

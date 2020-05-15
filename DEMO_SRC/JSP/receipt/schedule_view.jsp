<%
/**
 * Title       : My 일정관리
 * Description : My 일정관리 보기화면
 * Action      : /mypage/schedule_view.do
 * File        : /mypage/schedule_view.jsp
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : Sang-Mi Lee
 * First Write : 
 * 
 * update date : 
 * update desc :
 */
%>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.jsp.HtmlUtil"%>

<jsp:useBean    id="calendar" 
                class="String[][]" 
                scope="request"/>
<jsp:useBean    id="today" 
                class="int[]" 
                scope="request"/>
<jsp:useBean    id="form"     
                class="gtone.changeminer.receipt.form.ScheduleForm" 
                scope="request"/>
<html>
<head>
	<title></title>
    <script language="javascript" src="/common/js/schedule.js"></script>
    <script language="javascript" src="/common/js/common.js"></script>
	<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
	<script language='javascript' src='../../common/js/menu_on.js'></script>    
<script language="javascript">
<!-- 
	
	function goDetail(cd, cd1)
	{
		var date = cd.substring(0,6);
		var day  =  "";
		var allday =  "";
		var url = "";
		
		if(cd1.length == 1)
		{
			day = "0"+ cd1;			
		}
		else
		{
			day = cd1;
		}
				
		allday = date + day;
				
		url = "/receipt/schedulepop.do?allday="+allday;
		//2006.05.22 김보영 height 520->540
		window.open(url,'WORKINGDAY관리','width=510,height=540,left=,top=,scrollbars=no,resizable=no');		
	}
	
//-->
</script>    
</head>
<body>
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
					<jsp:include page="/common/dropDown.jsp" flush="true"></jsp:include>
					<!--DropDown 삽입 : E-->
				</td>
			    <td><table width="100%" height="449">
			        <tr> 
						<td width="20">&nbsp;</td>
						<td colspan="2"><img src="/img/common/title_07.gif"></td>
					</tr>
					<tr> 
						<td></td>
						<td height="10" background="/img/common/title_bg.gif" colspan="2"></td>
					</tr>
					<tr> 
						<td></td>
						<td height="14" colspan="2"></td>
					</tr>
					<tr> 
						<td></td>
						<td colspan="2">
							<table width="100%">
								<tr> 
									<td><img src="/img/common/bu_cir01.gif"> 
										<b>WORKINGDAY관리</b></td>
									<td align="right"></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr> 
						<td colspan="3" height="20">&nbsp;</td><!--타이틀과 달력과의 간격-->
					</tr>
			        <tr> 
                		<td rowspan="3" ><table width="100%" height="100%">
		                    <tr> 
		                      <td valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		                    </tr>
		                    <tr>
		                      <td></td>
		                    </tr>
		                    <tr> 
		                      <td valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		                    </tr>
		                  </table></td>
			          	<td width="100%" height="367" bgcolor="FCFEF9">
			          	<table width="100%">
			              <tr> 
			                <td><table width="100%" height=37>
			                    <form name='scheduleForm' method="post">
			                      <input type=hidden  name='run'          value='view'>
			                      <input type=hidden  name='forward'      value=''>
			                      <input type=hidden  name='method'       value='view'>
			                      <input type=hidden  name='is'           value='<%=form.getIs()%>'>
			                      <input type=hidden  name='scheduleDate' value='<%=form.getScheduleDate()%>'>
			                      <input type=hidden  name='scheduleType' >
			                      <input type=hidden  name='viewType'     value='sameType'>
			                      <tr> 
			                        <td><a href="javascript:void(0);"><img onClick="schedule_search_page('/receipt/schedule.do','-1');return false;" src="/img/common/paging_btn_prev.gif" hspace="10" align="absmiddle" border="0"></a> 
			                          <select name="year" size="1" onChange="schedule_search_page('/receipt/schedule.do',null);return false ;">
			                            <%for(int i=0 ; i<10 ; i++){
										//2006.03.22 유섭교 0600069 Cyberadmin 기능개선
										%>
										
			                            <!--option value=<%=today[0]+i%> <%=form.getYear()==today[0]+i?"selected":""%>><%=today[0]+i%></option-->
										<option value=<%=2005+i%> <%=form.getYear()==2005+i?"selected":""%>><%=2005+i%></option>
			                            <%}%>
			                          </select>
			                          년 
			                          <select name="month" size="1" onChange="schedule_search_page('/receipt/schedule.do',null);return false ;">
			                            <%for( int i=1 ; i<=12 ; i++ ){%>
			                            <option value=<%=i<10?("0"+i):(""+i)%> <%=form.getMonth()+1==i?"selected":""%>><%=i<10?("0"+i):(""+i)%></option>
			                            <%}%>
			                          </select>
			                          월 <a  href="javascript:void(0);"><img src="/img/common/paging_btn_next.gif" border="0"
			                                onClick="schedule_search_page('/receipt/schedule.do','+1');return false;"
			                                hspace="10" 
			                                align="absmiddle"></a></td>
			                        <td class=btn01> 
			                          <!--<a href="javascript:schedule_day_create();"><img src="/img/common/mypage/my_btn_write02.gif" hspace="10" border="0"></a>-->
			                        </td>
			                      </tr>
			                    </form>
			                  </table></td>
			              </tr>
			              <tr> 
			                <td><img src="/img/common/mypage/diary_table_title.gif"></td>
			              </tr>
			            </table>
			            <table width="100%" >
<%
						if(calendar.length>0)
						{
						    String temp = null ;
						    String str  = null ;
						    int    k    = 0 ;
						    int    oldk = 0 ;
						    String date = "";
						    String day = "";
						    String allday  = "";
						
						    for( int i=0; i<calendar.length ; i++ )
						    {                 
						        out.println("<tr valign='top'>");
						
						        for(int j=0 ; j<7 ; j++)
						        {
						            out.println("<td height='61'>");
						            //오늘날짜랑 같으면 다른색
						            if( calendar[i][j]!=null 
						                && today[0]==form.getYear()
						                && today[1]==form.getMonth()
						                && today[2]==Integer.parseInt(calendar[i][j]) ){
						                out.println("<table border=1 cellpadding=0 cellspacing=0 width='100%'><tr><td style='border:0' width='20' valign=top style='padding:2 3px'><div style='color:#11731A;font-weight:bold;'>");
						            }else {
						                out.println("<table border=1 cellpadding=0 cellspacing=0 width='100%'><tr><td style='border:0' width='20' valign=top style='padding:2 3px'>");
						            }
						            out.println("<font style='font-size:11px;'>");
						                        
						            str = "<a href=\"javascript:goDetail('"+form.getScheduleDate()+"', '"+calendar[i][j]+"');\"onFocus='blur()' >";
							     	  
						            out.println(str+"<br>");
						            if(j==0){
						                out.println("<font color='#FF0000'>"+(calendar[i][j]!=null?calendar[i][j]:"")+"</font>");
						            }else if(j==6){
						                out.println("<font color='#0000FF'>"+(calendar[i][j]!=null?calendar[i][j]:"")+"</font>");
						            }else{
						                out.println( (calendar[i][j]!=null?calendar[i][j]:"") ) ;
						            }
						            out.println("</font>");
						            out.println("</b>");
						
						            //오늘날짜랑 같으면 다른색
						            if( calendar[i][j]!=null && today[2]==Integer.parseInt(calendar[i][j]) ){
						                out.println("</div></td><td style='border:0'>");
						            }else {
						                out.println("</td><td style='border:0'>");          
						            }
						            out.println("</td></tr></table></td>");  
						        }
						        out.println("</tr>");
						    }
						}
%>
			            </table></td>
			          <td rowspan="2" >
			          	<table width="626" height="100%">
			              <tr> 
		                      <td valign="top">&nbsp;</td>
			              </tr>
			              <tr> 
			                <td></td>
			              </tr>
			              <tr> 
                      		<td valign="bottom">&nbsp;</td>
			              </tr>
			            </table></td>
			        </tr>
			        <tr> 
			          <td height="170"></td><!--달력과 아래공간과의 간격-->
			        </tr>
			      </table></td>
			  </tr>
			  <tr> 
			    <td class=list00></td>
			  </tr>
		</table></td>
	</tr>
	<tr> 
		<td height="56" background="/img/common/copy_bg.gif"><img src="/img/common/copy.gif"></td>
	</tr>
</table>
</body>
</html>


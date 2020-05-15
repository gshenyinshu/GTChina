<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.jsp.HtmlUtil"%>
<jsp:useBean    id="view"  class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean    id="contract" class="java.util.HashMap"    scope="request"/>
<jsp:useBean    id="allday"  class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean    id="calendar"  class="String[][]" 	           scope="request"/>
<jsp:useBean    id="today"       class="int[]"                 scope="request"/>
<jsp:useBean    id="form"    class="gtone.changeminer.return.form.ScheduleForm"   scope="request"/>
<%
    if(form.getIs()==-1)form.setIs(view.getCount("subject"));
%>
<html>
<head>
	<title></title>
    <script language="javascript" src="/common/js/schedule.js"></script>
    <script language="javascript" src="/common/js/common.js"></script>
</head>
<body>
<div id="content" style="display:none">
    <!-- body flash && location bar -->
				<div align="left" style="POSITION: absolute;HEIGHT: 0px; LEFT: 221px; TOP:123px; VISIBILITY: visible; WIDTH: 170px;z-index:0">
				<table border="0" cellpadding="0" cellspacing="0" width="647">
					<tr align="right" valign="top">
						<td height="127" id='LocationBar'></td>
					</tr>
					<tr>	
                      <td><img src="/img/mypage/mypage_title05.gif"></td>
					</tr>
				</table>
				</div>
    <!-- //body flash && location bar -->

    <!-- contents -->
  <table width=626>
    <tr> 
      <td height=20></td>
    </tr>
    <tr> 
      <td><table width="100%" height="584">
          <tr> 
            <td colspan="3"><img src="/img/mypage/diary_top.jpg"></td>
          </tr>
          <tr> 
			<td rowspan="2" background="/img/mypage/diary_left02.gif"><table width="100%" height="100%">
					<tr>
						<td valign="top"><img src="/img/mypage/diary_left.gif"></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td valign="bottom"><img src="/img/mypage/diary_left03.gif"></td>
					</tr>
				</table></td>
            <td height="367" bgcolor="FCFEF9"><table width="100%">
                <tr> 
                  <td><table width="100%" height=37>
<form name='scheduleForm' method="post">
<input type=hidden  name='run'          value=''>
<input type=hidden  name='forward'      value=''>
<input type=hidden  name='method'       value='view'>
<input type=hidden  name='is'           value='<%=form.getIs()%>'>
<input type=hidden  name='scheduleDate' value='<%=form.getScheduleDate()%>'>
<input type=hidden  name='scheduleType' >
<input type=hidden  name='viewType'     value='sameType'>
                      <tr> 
                        <td><a href="javascript:void(0);"><img onClick="schedule_search_page('/return/schedule.do','-1');return false;" src="/img/common/paging_btn_prev.gif" hspace="10" align="absmiddle"></a> 
<select name="year" size="1" 
        onchange="schedule_search_page('/return/schedule.do',null);return false ;">
<%for(int i=0 ; i<3 ; i++){%>
    <option value=<%=today[0]+i%> <%=form.getYear()==today[0]+i?"selected":""%>><%=today[0]+i%></option>
<%}%>
</select>
                          년 
                          <select name="month" size="1" onchange="schedule_search_page('/return/schedule.do',null);return false ;">
                            <%for( int i=1 ; i<=12 ; i++ ){%>
                            <option value=<%=i<10?("0"+i):(""+i)%> <%=form.getMonth()+1==i?"selected":""%>><%=i<10?("0"+i):(""+i)%></option>
                            <%}%>
                          </select>
                          월 <a  href="javascript:void(0);"><img src="/img/common/paging_btn_next.gif" 
                                onClick="schedule_search_page('/return/schedule.do','+1');return false;"
                                hspace="10" 
                                align="absmiddle"></a></td>
                        <td class=btn01><a href="javascript:schedule_day_create();"><img src="/img/mypage/my_btn_write02.gif" hspace="10"></a><a href="javascript:void(0)" onclick='schedule_memo();return false;'><img src="/img/mypage/my_btn_write03.gif"></a></td>
                      </tr>
</form>
                    </table></td>
                </tr>
                <tr>  
                  <td><img src="/img/mypage/diary_table_title.gif"></td>
                </tr>
              </table>
              <table width="100%" class=mytable02>
                <col width=80>
                <col width=80>
                <col width=80>
                <col width=80>
                <col width=80>
                <col width=80>
                <col width=80>
<%if(calendar.length>0){
    String temp = null ;
    String str  = null ;
    int    k    = 0 ;
    int    oldk = 0 ;
    int    cnt  = allday.getCount("day");

    for( int i=0; i<calendar.length ; i++ ){                 
        out.println("<tr valign='top'>");

        for(int j=0 ; j<7 ; j++){
            out.println("<td height='61'>");
            //오늘날짜랑 같으면 다른색
            if( calendar[i][j]!=null 
                && today[0]==form.getYear()
                && today[1]==form.getMonth()
                && today[2]==Integer.parseInt(calendar[i][j]) ){
                out.println("<table border=0 cellpadding=0 cellspacing=0 width='100%'><tr><td style='border:0' width='20' valign=top style='padding:2 3px'><div style='color:#11731A;font-weight:bold;'>");
            }else {
                out.println("<table border=0 cellpadding=0 cellspacing=0 width='100%'><tr><td style='border:0' width='20' valign=top style='padding:2 3px'>");
            }
            out.println("<font style='font-size:11px;'>");
            
            if(j==0){
                out.println("<font color='#FF0000'>"+(calendar[i][j]!=null?calendar[i][j]:"")+"</font>");
            }else if(j==6){
                out.println("<font color='#0000FF'>"+(calendar[i][j]!=null?calendar[i][j]:"")+"</font>");
            }else{
                out.println( (calendar[i][j]!=null?calendar[i][j]:"") ) ;
            }
            out.println("</font>");

            //오늘날짜랑 같으면 다른색
            if( calendar[i][j]!=null && today[2]==Integer.parseInt(calendar[i][j]) ){
                out.println("</div></td><td style='border:0'>");
            }else {
                out.println("</td><td style='border:0'>");          
            }
            
            //오늘 스케줄이 있는지 체크 있으면 해당 스케줄 보여주기
            for( k=oldk ; k<cnt ; k++){
                if( calendar[i][j]!=null 
                    && allday.getInt("day",k )==Integer.parseInt(calendar[i][j])){
                    str = allday.getText("scheduleType",k ) ;

                    if( str.equals("0") )      str = " &nbsp;<a href=\"javascript:setScheduleType('"+allday.getText("scheduleDate",k )+"',"+str+");schedule_blank('schedule_day_view',492,440);\"><font style='color:#92C4F7;font-size:8pt'>■</font><font style='font-size:8pt'>["+allday.getText("count",k )+"]</font></a>" ;
                    else if( str.equals("1") ) str = " &nbsp;<a href=\"javascript:setScheduleType('"+allday.getText("scheduleDate",k )+"',"+str+");schedule_blank('schedule_day_view',492,440);\"><font style='color:#FBDE90;font-size:8pt'>■</font><font style='font-size:8pt'>["+allday.getText("count",k )+"]</font></a>" ;
                    else if( str.equals("2") ) str = " &nbsp;<a href=\"javascript:setScheduleType('"+allday.getText("scheduleDate",k )+"',"+str+");schedule_blank('schedule_day_view',492,440);\"><font style='color:#CDEDA4;font-size:8pt'>■</font><font style='font-size:8pt'>["+allday.getText("count",k )+"]</font></a>" ;
                    else if( str.equals("3") ) str = " &nbsp;<a href=\"javascript:setScheduleType('"+allday.getText("scheduleDate",k )+"',"+str+");schedule_blank('schedule_day_view',492,440);\"><font style='color:#BDA2E7;font-size:8pt'>■</font><font style='font-size:8pt'>["+allday.getText("count",k )+"]</font></a>" ;

                     oldk = k ;
                    out.println(str+"<br>");
                }
            }

            //계약보험일 조회
            temp = ""+calendar[i][j] ;
            temp = (temp.length()==1)?"0"+temp:temp ;
            if( contract.get(temp)!=null ){
                str = form.getScheduleDate().substring(0,6)+temp ;
                str = " &nbsp;<a href=\"javascript:setScheduleType('"+str+"',4);schedule_blank('schedule_day_view',476,440);\"><font style='color:#F896A3;font-size:8pt'>■</font"
                    + " ><font style='font-size:8pt'>["+contract.get(temp)+"]</font></a>" ;
                out.println(str+"<br>");
            }
            out.println("</td></tr></table></td>");  

        }
        out.println("</tr>");
    }
}%>

              </table></td>
			<td rowspan="2" background="/img/mypage/diary_right02.gif"><table width="100%" height="100%">
					<tr>
						<td valign="top"><img src="/img/mypage/diary_right.gif"></td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td valign="bottom"><img src="/img/mypage/diary_right03.gif"></td>
					</tr>
				</table></td>
          </tr>
          <tr> 
            <td height="54"><img src="/img/mypage/diary_bottom.gif"></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td class=list02> 
        <table width=100% height="110">
          <col width=110>
          <tr>
            <td align="right" valign='top'><img src="/img/mypage/diary_text_monthly.gif" hspace="10"></td>
            <td><table width="470" height=100% class=mytable02>
                <tr>
                  <td width="470" height=100% valign="top" style="padding:10px">
                  <%=HtmlUtil.translateNewline(view.getText("contents"))%></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td class=list00></td>
    </tr>
  </table>
    <!-- //contents -->

    <!-- banner -->
    <!-- //banner -->
</div>
<jsp:include page="/common/layout/Default.jsp" flush="true">
    <jsp:param name="menuId" value="PHMP0600"/>
    <jsp:param name="banner" value="N"/>
</jsp:include>
</body>
</html>

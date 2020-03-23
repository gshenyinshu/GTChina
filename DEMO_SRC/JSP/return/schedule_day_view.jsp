<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<jsp:useBean    id="list"     
                class="anyframe.data.DataSet" 
                scope="request"/>
<jsp:useBean    id="form"     
                class="gtone.home.mypage.form.ScheduleForm" 
                scope="request"/>
<%
    int    cnt   = 0 ;
    String dummy = null ;
%>
<html>
<head>
<META HTTP-EQUIV= 'Content-Type' CONTENT='text/html; charset=euc-kr'>
<title></title>
    <script language="javascript" src="/common/js/mypage/schedule.js"></script>
    <LINK HREF='/common/css/common.css ' TYPE='text/css' REL='STYLESHEET'>
</head>
<body class=popup onLoad="alertMSG( '<%=form.getBeforerun()%>' , <%=form.getStatus()%> )">
  <table width=476 class=popup height=100%>
<form name='scheduleForm'>
    <input type='hidden' name='forward'       value='schedule_day_view'>
    <input type='hidden' name='insertDate'    value=''>
    <input type='hidden' name='run'    value=''>
    <input type='hidden' name='scheduleType'  value='<%=form.getScheduleType()%>'>
    <input type='hidden' name='scheduleDate'  value='<%=form.getScheduleDate()%>'>
    <input type='hidden' name='viewType'      value='onlyOne'>
    <tr>
      <td class=top><img src="/img/mypage/popup_title01.gif"></td>
    </tr>
    <tr > 
      <td class=padd10 valign='top'><table width="100%" height=100% class=pop01>
          <tr>
            <td class=padd20 valign='top'><table width="100%" height=100%>
                <tr>
                  <td><table width="100%">
                      <tr>
                        <td class=poptitle01>확인하기</td>
                        <td class=btn02><!--img src="/img/mypage/btn_modify.gif" vspace="5"--></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td valign='top' height=100%><table width=100% class=mytable01>
                      <col width=30%>
                      <tr> 
<%
    cnt   = list.getCount("scheduleDate") ;
    dummy = form.getScheduleDate();
%>
                        <td class=my01 >날짜</td>
                        <td class=my12> 
                            <%=dummy.substring(0,4)%>년 <%=dummy.substring(4,6)%>월 
                            <%=dummy.substring(6,8)%>일</td>
                      </tr>
                      <tr> 
                        <td valign="top" class=my01>스케줄내용</td>
                        <td class=my10 valign=top>
                        <table border=0 width=100% style='border:0'>
<%for(int i=0 ; i<cnt ; i++){
    if( !form.getScheduleType().equals("4") ){
        dummy = list.getText("insertDate",i) ;
        dummy = dummy.substring(0,4)
                +"/"+dummy.substring(4,6)
                +"/"+dummy.substring(6,8);

%>
                        <tr >
                            <td style='height:18' style='border:0'><font style='color:#92C4F7;'>* 작성일 : <%=dummy%></font></td>
                        <%    dummy = list.getText("insertDate",i) ;%>
                            <td style='height:18'align='right' style='border:0'>
                                <img src="/img/mypage/my_btn_modify.gif" style='cursor:hand' 
                                    onClick='setDeleteDay( 0,"<%=list.getText("scheduleDate",i)%>",
                                                           "<%=list.getText("insertDate",i)%>" );' 
                                                           align="absmiddle">|
                                <img src="/img/mypage/my_btn_delete.gif" style='cursor:hand' 
                                    onClick='setDeleteDay( 1,
                                                           "<%=list.getText("scheduleDate",i)%>",
                                                           "<%=list.getText("insertDate",i)%>" );' align="absmiddle"></td>
                            </td>
                         </tr>
                         <tr>
                            <td colspan=2 style='border:0'>
                            &nbsp;&nbsp;&nbsp;<%=list.getText("contents",i)%>
                            </td>
                        </tr>
<%  }else{%>
                         <tr>
                            <td colspan=2 style='border:0'>
                            &nbsp;&nbsp;&nbsp;* <%=list.getText("plcyno",i)%> (<%=list.getText("plnname",i)%>)의<br>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;보험료납입일입니다.
                            </td>
                        </tr>
<%  }
}%>                          </table>  
                        </td>
                      </tr>
                      <tr> 
                        <td class=my01>스케줄분류</td>
                        <td class=my10>
<%
    dummy = form.getScheduleType() ;
    if( dummy.equals("0") )      out.println("약속");
    else if( dummy.equals("1") ) out.println("업무");
    else if( dummy.equals("2") ) out.println("기념일");
    else if( dummy.equals("3") ) out.println("기타");
    else if( dummy.equals("4") ) out.println("보험료납입일");
%></td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td class=popbtn><a href='javascript:window.close()'><img src="/img/mypage/my_btn_close.gif" vspace="10"></a></td>
    </tr>
</form>
  </table>
  <!-- //contents -->
  <!-- banner -->
  <!-- //banner -->
</body>
</html>


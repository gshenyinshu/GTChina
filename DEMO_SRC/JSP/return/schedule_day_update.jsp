<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<jsp:useBean    id="list"     
                class="anyframe.data.DataSet" 
                scope="request"/>
<jsp:useBean    id="form"     
                class="gtone.home.mypage.form.ScheduleForm" 
                scope="request"/>
<%
    String dummy = null ;
%>
<html>
<head>
<META HTTP-EQUIV= 'Content-Type' CONTENT='text/html; charset=euc-kr'>
<title></title>
    <script language="javascript" src="/common/js/mypage/schedule.js"></script>
    <script language="javascript" src="/common/js/common.js"></script>
    <LINK HREF='/common/css/common.css ' TYPE='text/css' REL='STYLESHEET'>
</head>
<body class=popup> 
  <table width=476 class=popup>
<form name='scheduleForm'>
    <input type='hidden' name='forward'       value='schedule_day_view'>
    <input type='hidden' name='insertDate'    value='<%=form.getInsertDate()%>'>
    <input type='hidden' name='scheduleDate'  value='<%=form.getScheduleDate()%>'>
    <input type='hidden' name='viewType'      value='sameType'>
    <input type='hidden' name='run'>

    <tr>
      <td class=top><img src="/img/mypage/popup_title02.gif"></td>
    </tr>
    <tr> 
      <td class=padd10><table width="100%" class=pop01>
          <tr>
            <td class=padd20><table width="100%">
                <tr>
                  <td class=poptitle01>수정하기</td>
                </tr>
                <tr>
                  <td><table width=100% class=mytable01>
                      <col width=30%>
                      <tr> 
<%
    dummy = form.getScheduleDate();
%>
                        <td class=my01>날짜</td>
                        <td class=my12> 
                            <%=dummy.substring(0,4)%>년 <%=dummy.substring(4,6)%>월 
                            <%=dummy.substring(6,8)%>일</td>
                      </tr>
                      <tr> 
                        <td valign="top" class=my01>스케줄내용</td>
                        <td class=my12><textarea name="contents" style="width:100%; height:200px;" class=box><%=list.getText("contents")%></textarea>
                          <div class=poplist01>스케줄내용은 한글 127자까지 입력 가능합니다.</div>
                        </td>
                      </tr>
                      <tr> 
                        <td class=my01>스케줄분류</td>
                        <td class=my12><select name="scheduleType" size="1">
                            <option value=0  <%=form.getScheduleType().equals("0")?"selected":""%>>약속</option>
                            <option value=1  <%=form.getScheduleType().equals("1")?"selected":""%>>업무</option>
                            <option value=2  <%=form.getScheduleType().equals("2")?"selected":""%>>기념일</option>
                            <option value=3  <%=form.getScheduleType().equals("3")?"selected":""%>>기타</option>
                          </select></td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td class=popbtn2><img src="/img/mypage/my_btn_close.gif" hspace="20" vspace="10" 
                            onClick='window.close()' style='cursor;hand;'>
                        <img src="/img/mypage/my_btn_write04.gif" vspace="10"
                            onClick='schedule_day_update_process();' style='cursor:hand;'></td>
    </tr>
</form>
  </table>
  <!-- //contents -->
  <!-- banner -->
  <!-- //banner -->
</div>
</body>
</html>


<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<jsp:useBean    id="view"     
                class="anyframe.data.DataSet" 
                scope="request"/>

<jsp:useBean    id="form"     
                class="gtone.home.mypage.form.ScheduleForm" 
                scope="request"/>
<html>
<head>
<META HTTP-EQUIV= 'Content-Type' CONTENT='text/html; charset=euc-kr'>
<title></title>
    <script language="javascript" src="/common/js/mypage/schedule.js"></script>
    <script language="javascript" src="/common/js/common.js"></script>
    <LINK HREF='/common/css/common.css ' TYPE='text/css' REL='STYLESHEET'>
</head>
<body class=popup  onLoad='viewMSG(<%=form.getStatus()%>);'>
  <table width=476 class=popup>
    <tr>
      <td class=top><img src="/img/mypage/popup_title03.gif"></td>
    </tr>
    <tr> 
      <td class=padd10><table width="100%" class=pop01>
          <tr>
            <td class=padd20><table width="100%">
                <tr>
                  <td class=poptitle01>입력하기</td>
                </tr>
                <tr>
                  <td><table width=100% class=mytable01 style="margin-bottom:0px;">
<form name='scheduleForm' method='post'>
<input type='hidden' name='scheduleDate' value="<%=form.getScheduleDate()%>">
<input type='hidden' name='run'>
<input type='hidden' name='is' value="<%=form.getIs()%>">
                      <col width=30%>
                      <tr> 
                        <td class=my01>제목</td>
                        <td class=my12><input type=text name=subject class=box03 value='<%=view.getText("subject")%>'></td>
                      </tr>
                      <tr> 
                        <td valign="top" class=my01>스케줄내용</td>
                        <td class=my12><textarea name="contents" style="width:100%; height:200px;" class=box><%=view.getText("contents")%></textarea></td>
                      </tr>
</form>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td class=popbtn2>
        <a href='javascript:void(0);' onClick='window.close();'>        <img src="/img/mypage/my_btn_close.gif" hspace="20" vspace="10"></a>
         <img src="/img/mypage/my_btn_write04.gif" vspace="10" style='cursor:hand;' onClick='schedule_memo_write();return false;'></td>
    </tr>
  </table>
  <!-- //contents -->
  <!-- banner -->
  <!-- //banner -->
</div>
</body>
</html>


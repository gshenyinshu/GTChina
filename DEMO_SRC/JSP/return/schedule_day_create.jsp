<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.util.DateTime"%>
<jsp:useBean    id="form"     
                class="gtone.home.mypage.form.ScheduleForm" 
                scope="request"/>
<%
//���ϳ�¥
// -----------------------------------------------------------------------------
//    ����
// -----------------------------------------------------------------------------
    int year  = 0 ;
    int month = 0 ;
    int day   = 0 ;
    String dummy = null ;
// -----------------------------------------------------------------------------
//    ���ʱ�ȭ
// -----------------------------------------------------------------------------
    dummy = DateTime.getShortDateString() ;
    year  = Integer.parseInt(dummy.substring(0,4)) ;
    month = Integer.parseInt(dummy.substring(4,6)) ;
    day   = Integer.parseInt(dummy.substring(6,8)) ;
%>
<html>
<head>
<META HTTP-EQUIV= 'Content-Type' CONTENT='text/html; charset=euc-kr'>
<title></title>
    <script language="javascript" src="/common/js/mypage/schedule.js"></script>
    <script language="javascript" src="/common/js/common.js"></script>
    <script>
        var dayCreateRst = <%=form.getStatus()%> ;
        if(dayCreateRst){
            schedule_day_create_MSG( dayCreateRst );
        }
    </script>
    <LINK HREF='/common/css/common.css ' TYPE='text/css' REL='STYLESHEET'>
</head>
<body class=popup>
  <table width=476 class=popup>
<form name='scheduleForm'>
<input type='hidden' name='scheduleDate'>
<input type='hidden' name='forward'>
<input type='hidden'    name='run'>
    <tr>
      <td class=top><img src="/img/mypage/popup_title02.gif"></td>
    </tr>
    <tr> 
      <td class=padd10><table width="100%" class=pop01>
          <tr>
            <td class=padd20><table width="100%">
                <tr>
                  <td class=poptitle01>�Է��ϱ�</td>
                </tr>
                <tr>
                  <td><table width=100% class=mytable01>
                      <col width=30%>
                      <tr> 
                        <td class=my01>��¥</td>
                        <td class=my12><select name="year" size="1">
                            <option value='<%=year%>'selected><%=year%></option>
                            <option value='<%=year+1%>'><%=year+1%></option>
                            <option value='<%=year+2%>'><%=year+2%></option>
                          </select>��
                          <select name="month" size="1">
                            <%for( int i=1 ; i<=12 ; i++ ){%>
                            <option value='<%=i<10?("0"+i):(""+i)%>' <%=month==i?"selected":""%>><%=i<10?("0"+i):(""+i)%></option>
                            <%}%>
                          </select>��
                          <select name="day" size="1">
                            <%for( int i=1 ; i<=31 ; i++ ){%>
                            <option value='<%=i<10?("0"+i):(""+i)%>' <%=day==i?"selected":""%>><%=i<10?("0"+i):(""+i)%></option>
                            <%}%>
                          </select>��</td>
                      </tr>
                      <tr> 
                        <td valign="top" class=my01>�����ٳ���</td>
                        <td class=my12><textarea 
                                            name="contents" 
                                            style="width:100%; height:200px;" 
                                            class="box"></textarea>
                          <div class=poplist01>�����ٳ����� �ѱ� 127�ڱ��� �Է� �����մϴ�.</div>
                        </td>
                      </tr>
                      <tr> 
                        <td class=my01>�����ٺз�</td>
                        <td class=my12><select name="scheduleType" size="1">
                            <option value=-1 selected>����</option>
                            <option value=0>���</option>
                            <option value=1>����</option>
                            <option value=2>�����</option>
                            <option value=3>��Ÿ</option>
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
                            onClick='window.close()' class='hand'>
                        <img src="/img/mypage/my_btn_write04.gif" vspace="10"
                            onClick='schedule_day_create_process();return false;' class='hand'></td>
    </tr>
</form>
  </table>
  <!-- //contents -->
  <!-- banner -->
  <!-- //banner -->
</div>
</body>
</html>


<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.jsp.HtmlUtil"%>
<jsp:useBean    id="view"     
                class="anyframe.data.DataSet" 
                scope="request"/>
<!--������ ������-->
<jsp:useBean    id="contract"     
                class="java.util.HashMap" 
                scope="request"/>
<jsp:useBean    id="allday"     
                class="anyframe.data.DataSet" 
                scope="request"/>
<jsp:useBean    id="calendar" 
                class="String[][]" 
                scope="request"/>
<jsp:useBean    id="today" 
                class="int[]" 
                scope="request"/>
<jsp:useBean    id="form"     
                class="gtone.home.mypage.form.ScheduleForm" 
                scope="request"/>
<html>
<head>
	<title></title>
    <script language="javascript" src="/common/js/mypage/schedule.js"></script>
    <script language="javascript" src="/common/js/common.js"></script>
    <link rel="stylesheet" type="text/css" href="/common/css/common.css" />
    <script>
/* -----------------------------------------------------------------------------
Function : reSize()
Param	 : iframe size������ ��ũ��Ʈ
----------------------------------------------------------------------------- */
	function reSize() {
			try{
                var parentPage = document.body ;
                var thisPage   = parent.document.all["schedule"];
				thisPage.style.height = parentPage.scrollHeight ;
			}catch(e){
            }
	}
	function init_iframe() {
			reSize();
			setTimeout('init_iframe()',100);
	}
	init_iframe();
    </script>
</head>
<body class=popup>
<table width=100% cellspacing="5" bgcolor="FFFFFF" style="border:solid 1 FFFFFF;">

    <form name='scheduleForm'>
    <input type='hidden' name='forward'      >
    <input type='hidden' name='run'          >
    <input type='hidden' name='scheduleType' >
    <input type='hidden' name='is'           >
    <input type='hidden' name='scheduleDate' value='<%=form.getScheduleDate()%>'>
    <input type='hidden' name='viewType'     value='sameDay'>
    <input type='hidden' name='year' value='<%=form.getYear()%>'>
    <input type='hidden' name='month'value='<%=form.getMonth()+1%>'>

                      <tr align="center"> 
                        <td height="30" colspan="7">
                          <img src='/img/common/bu_tri06.gif'
                               class='hand'
                               onClick="schedule_search_main('/mypage/schedule.do','-1');return false ;">
                          <B><%=form.getYear()%>Ҵ <%=form.getMonth()+1%>��</B> 
                          <img src='/img/common/bu_tri07.gif'
                               class='hand'
                               onClick="schedule_search_main('/mypage/schedule.do','+1');return false ;"></a></td>
                      </tr>
                      <tr align="center"> 
                        <td><font color="#FF0000">��</font></td>
                        <td>��</td>
                        <td>ȭ</td>
                        <td>��</td>
                        <td>��</td>
                        <td>��</td>
                        <td><font color="#0000FF">��</font></td>
                      </tr>
<%if(calendar.length>0){

    String getDay = "" ;//dataset���� ������ ��¥
    String temp = null ;
    String str  = null ;
    int    k    = 0 ;
    int    oldk = 0 ;
    int    cnt  = allday.getCount("day");
    boolean rst = false ;

    for( int i=0; i<calendar.length ; i++ ){                 
        out.println("<tr align='center'>");

        for(int j=0 ; j<7 ; j++){
            rst = false ;
            //���Ͽ� �ش� �������� �ִ��� �˻�
            for( k=oldk ; k<cnt ; k++){
                if( calendar[i][j]!=null 
                    && allday.getInt("day",k )==Integer.parseInt(calendar[i][j])){
                    rst = true ;
                    getDay = allday.getText("scheduleDate",k ) ;
                    str = allday.getText("scheduleType",k ) ;
                    oldk = k ;
                }
            }

            //��ຸ���� ��ȸ
            if( !rst ){                
                temp = ""+calendar[i][j] ;
                temp = (temp.length()==1)?"0"+temp:temp ;
                if( contract.get(temp)!=null ) rst = true ;
                temp = form.getScheduleDate().substring(0,6)+temp ;
                str  = "4" ;
                getDay = temp ;
            }

            //�����ٵ����� �ִ��� üũ
            if(rst)
                out.println("<td class=date01 style='text-align:center;'><a href=\"javascript:setScheduleType('"+getDay+"',"+str+");schedule_blank('schedule_day_view_main',492,440,'yes');\">");  
            else 
                out.println("<td style='text-align:center;'>"); 

            //���ó�¥�� ������ �ٸ���
            str = (calendar[i][j]!=null?calendar[i][j]:"");
            if( calendar[i][j]!=null && today[2]==Integer.parseInt(calendar[i][j]) ){
                str = "<b>"+str+"</b>" ;
            }

            if(j==0){
                out.println("<font color='#FF0000'>"+str+"</font>");
            }else if(j==6){
                out.println("<font color='#0000FF'>"+str+"</font>");
            }else{
                out.println( str ) ;
            }

            //�����ٵ����� �ִ��� üũ
            if(rst)
                out.println("</a></td>");  
            else 
                out.println("</td>"); 
        }
        out.println("</tr>");
    }
}%>

                      <tr align="center"> 
                        <td colspan="7"><!-- img src="/img/mypage/main_text_sch.gif" --></td>
                      </tr>
    </form>
                    </table>
</body>
</html>
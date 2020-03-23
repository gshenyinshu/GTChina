<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.util.DateTime"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager" %>

<jsp:useBean id="form"  class="gtone.changeminer.receipt.form.ScheduleForm"   scope="request"/>
<jsp:useBean id="workingday" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="allday" class="java.lang.String" scope="request"/>

<jsp:useBean id="work_start_hour" class="java.lang.String" scope="request"/>
<jsp:useBean id="work_start_minute" class="java.lang.String" scope="request"/>
<jsp:useBean id="work_end_hour" class="java.lang.String" scope="request"/>
<jsp:useBean id="work_end_minute" class="java.lang.String" scope="request"/>
<jsp:useBean id="work_start_hour2" class="java.lang.String" scope="request"/>
<jsp:useBean id="work_start_minute2" class="java.lang.String" scope="request"/>
<jsp:useBean id="work_end_hour2" class="java.lang.String" scope="request"/>
<jsp:useBean id="work_end_minute2" class="java.lang.String" scope="request"/>

<jsp:useBean id="close_start_hour" class="java.lang.String" scope="request"/>
<jsp:useBean id="close_start_minute" class="java.lang.String" scope="request"/>
<jsp:useBean id="close_end_hour" class="java.lang.String" scope="request"/>
<jsp:useBean id="close_end_minute" class="java.lang.String" scope="request"/>
<jsp:useBean id="process" class="java.lang.String" scope="request"/>
<jsp:useBean id="closing" class="java.lang.String" scope="request"/>
<jsp:useBean id="billing" class="java.lang.String" scope="request"/>
<jsp:useBean id="sixclose" class="java.lang.String" scope="request"/>
<jsp:useBean id="aplclose" class="java.lang.String" scope="request"/>
<jsp:useBean id="work_gubun" class="java.lang.String" scope="request"/>
<jsp:useBean id="delay_auto_close" class="java.lang.String" scope="request"/>
<jsp:useBean id="pl_repay_day" class="java.lang.String" scope="request"/>
<jsp:useBean id="delay_pay_close" class="java.lang.String" scope="request"/>


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
    
    int cnt = workingday.getCount("eff_date");
    String hour1 = "";
    String hour2 = "";
    String hour3 = "";
    String hour4 = "";
    
    String time1 = "";
    String time2 = "";
    String time3 = "";
    String time4 = "";
    
        
    //�ǽð���ȯ�������۽ú�
    String work_start_hour1  = "";
    String work_start_minute1  = "";
    //�ǽð���ȯ��������ú�
    String work_end_hour1  = "";
    String work_end_minute1  = "";
    //��������û���۽ú�
    String work_start_hour3  = "";
    String work_start_minute3  = "";
    //��������û����ú�
    String work_end_hour3  = "";
    String work_end_minute3  = "";
    //�������۽ú�
    String close_start_hour1  = "";
    String close_start_minute1  = "";
    //��������ú�
    String close_end_hour1  = "";
    String close_end_minute1  = "";
    
    
    closing 	= workingday.getText("closing");//������ ����� ���� �Ұ���
    closing 	= workingday.getText("closing");//������ ����� ���� �Ұ���
    billing    	= workingday.getText("billing");//���� �������� ��
    sixclose    = workingday.getText("sixclose");//������ ����� 8�ñ��� ����������
    aplclose    = workingday.getText("aplclose");//������ APL�Ұ���
    work_gubun    = workingday.getText("work_gubun");//���ϱ���
    delay_auto_close = workingday.getText("delay_auto_close");//������ �ڵ���ü�Ұ���
    pl_repay_day     = workingday.getText("pl_repay_day");//�����ڵ���ȯ��
    delay_pay_close  = workingday.getText("delay_pay_close");//2006.05.22 �躸�� : ������(��/��) �����޼��ɺҰ���
    
    
    if(workingday.getText("work_start_time").length() == 4)
    {
    	work_start_hour1 = workingday.getText("work_start_time").substring(0,2);
    	work_start_minute1 = workingday.getText("work_start_time").substring(2,4);
    }
    
    if(workingday.getText("work_end_time").length() == 4)
    {
    	work_end_hour1 = workingday.getText("work_end_time").substring(0,2);
    	work_end_minute1 = workingday.getText("work_end_time").substring(2,4);
    }
    
    if(workingday.getText("work_start_time2").length() == 4)
    {
    	work_start_hour3 = workingday.getText("work_start_time2").substring(0,2);
    	work_start_minute3 = workingday.getText("work_start_time2").substring(2,4);
    }
    
    if(workingday.getText("work_end_time2").length() == 4)
    {
    	work_end_hour3 = workingday.getText("work_end_time2").substring(0,2);
    	work_end_minute3 = workingday.getText("work_end_time2").substring(2,4);
    }
    
    if(workingday.getText("close_start_time").length() == 4)
    {
    	close_start_hour1 = workingday.getText("close_start_time").substring(0,2);
    	close_start_minute1 = workingday.getText("close_start_time").substring(2,4);
    }
    
    if(workingday.getText("close_end_time").length() == 4)
    {
    	close_end_hour1 = workingday.getText("close_end_time").substring(0,2);
    	close_end_minute1 = workingday.getText("close_end_time").substring(2,4);
    }

	
	//���ǿ��� ��������
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
	//String emp_no = sessionManager.getString(Constant.SESSION_USERID);
	//String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
%>
<html>
<head>
<META HTTP-EQUIV= 'Content-Type' CONTENT='text/html; charset=euc-kr'>
<title></title>
    <script language="javascript" src="/common/js/schedule.js"></script>
    <script language="javascript" src="/common/js/common1.js"></script>
    <script language="javascript" src="/common/js/common.js"></script>
    <script>

        var dayCreateRst = <%=form.getStatus()%> ;
        if(dayCreateRst){
            schedule_day_create_MSG( dayCreateRst );
        }
    </script>
<script language="javascript">
<!-- 
	
	function goMod()
	{
		var form = document.scheduleForm;
		form.process.value = "Y";
		form.action = "schedulepop.do"
		//alert(document.scheduleForm.work_gubun_check_val.value + "::"+document.scheduleForm.work_gubun_temp.value);
		
		form.submit();		
		window.close();
	}

function work_gubun_check(val){
	document.scheduleForm.work_gubun_check_val.value = val;	
}	
//-->
</script>        
    
    <LINK HREF='/common/css/common1.css ' TYPE='text/css' REL='STYLESHEET'>
</head>
<body class=popup>
<form name='scheduleForm'>
<input type='hidden' name='scheduleDate'>
<input type='hidden' name='forward'>
<input type='hidden' name='run'>
<input type='hidden' name='process'>
<input type="hidden" name="allday" value="<%=allday%>">

<table width=500 class=popup>
    <tr> 
      <td class=padd10><table width=485 class=pop01>
          <tr>
            <td class=padd20><table width="100%">
                <tr>
                  <td class=poptitle01>WORKINGDAY ����</td>
                </tr>
                <tr>
                  <td><table width=100% class=mytable01>
                      <col width=50%>
                      <tr> 
                        <td valign="top" class=my01>WORKINGDAY ����</td>
<%
						String eff_date = "";
						if(allday.length() == 8)
						eff_date = allday.substring(0,4) + "�� "+ allday.substring(4,6) + "�� " + allday.substring(6) + "��";
%>                        
                        <td class=my12 class="adm_table"><%=eff_date%></td>
                      </tr>
                      <tr> 
                        <td valign="top" class=my01>���� ����</td>
                        <td class=my12 class="adm_table">
                        	<input type="radio" onfocus="this.blur()" onclick="work_gubun_check(this.value);" name="work_gubun" value="0" <% if(work_gubun.equals("0")){ %> checked <%}%> >�ٹ���&nbsp;
                        	<input type="radio" onfocus="this.blur()" onclick="work_gubun_check(this.value);" name="work_gubun" value="1" <% if(work_gubun.equals("1")){ %> checked <%}%> >��ٹ���&nbsp;
                        	<input type="radio" onfocus="this.blur()" onclick="work_gubun_check(this.value);" name="work_gubun" value="2" <% if(work_gubun.equals("2")){ %> checked <%}%> >��������
                        	<input type="hidden" name="work_gubun_temp" value="<%=work_gubun%>">
                        	<input type="hidden" name="work_gubun_check_val" value="">
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" class=my05>�ǽð� ��ȯ���� ����</td>
                        <td class=my12>                       
                        <select name="work_start_hour" style="width:40px;">
<%
					for(int i =0;i<24;i++)
					{
						if(i < 10)
						{
							hour1 = "0" + Integer.toString(i);
						}
						else
						{
							hour1 = Integer.toString(i);
						}
%>                  
							<option value="<%=hour1%>"  <% if(hour1.equals(work_start_hour1)){ %> selected <% } %>><%=hour1%></option>				      
<%
					}	
%>			
                        </select>��
                        <select name="work_start_minute" style="width:40px;">
<%
					for(int i =0;i<60;i++)
					{
						if(i < 10)
						{
							time1 = "0" + Integer.toString(i);
						}
						else
						{
							time1 = Integer.toString(i);
						}
%>                  
							<option value="<%=time1%>"  <% if(time1.equals(work_start_minute1)){ %> selected <% } %>><%=time1%></option>				      
<%
					}	
%>                        
                        </select>��
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" class=my05>�ǽð� ��ȯ���� ����</td>
                        <td class=my12>
                        <select name="work_end_hour" style="width:40px;">
<%
					for(int i =0;i<24;i++)
					{
						if(i < 10)
						{
							hour2 = "0" + Integer.toString(i);
						}
						else
						{
							hour2 = Integer.toString(i);
						}
%>                  
							<option value="<%=hour2%>"  <% if(hour2.equals(work_end_hour1)){ %> selected <% } %>><%=hour2%></option>				      
<%
					}	
%>			                        
                        </select>��
                        <select name="work_end_minute" style="width:40px;">
<%
					for(int i =0;i<60;i++)
					{
						if(i < 10)
						{
							time2 = "0" + Integer.toString(i);
						}
						else
						{
							time2 = Integer.toString(i);
						}
%>                  
							<option value="<%=time2%>"  <% if(time2.equals(work_end_minute1)){ %> selected <% } %>><%=time2%></option>				      
<%
					}	
%>                        
                        
                        </select>��
                        </td>
                      </tr> 
                      <tr> 
                        <td valign="top" class=my01>�ǽð� ����������� ���� ����</td>
                        <td class=my12>                       
                        <select name="work_start_hour2" style="width:40px;">
<%
					for(int i =0;i<24;i++)
					{
						if(i < 10)
						{
							hour1 = "0" + Integer.toString(i);
						}
						else
						{
							hour1 = Integer.toString(i);
						}
%>                  
							<option value="<%=hour1%>"  <% if(hour1.equals(work_start_hour3)){ %> selected <% } %>><%=hour1%></option>				      
<%
					}	
%>			
                        </select>��
                        <select name="work_start_minute2" style="width:40px;">
<%
					for(int i =0;i<60;i++)
					{
						if(i < 10)
						{
							time1 = "0" + Integer.toString(i);
						}
						else
						{
							time1 = Integer.toString(i);
						}
%>                  
							<option value="<%=time1%>"  <% if(time1.equals(work_start_minute3)){ %> selected <% } %>><%=time1%></option>				      
<%
					}	
%>                        
                        </select>��
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" class=my01>�ǽð� ����������� ���� ����</td>
                        <td class=my12>
                        <select name="work_end_hour2" style="width:40px;">
<%
					for(int i =0;i<24;i++)
					{
						if(i < 10)
						{
							hour2 = "0" + Integer.toString(i);
						}
						else
						{
							hour2 = Integer.toString(i);
						}
%>                  
							<option value="<%=hour2%>"  <% if(hour2.equals(work_end_hour3)){ %> selected <% } %>><%=hour2%></option>				      
<%
					}	
%>			                        
                        </select>��
                        <select name="work_end_minute2" style="width:40px;">
<%
					for(int i =0;i<60;i++)
					{
						if(i < 10)
						{
							time2 = "0" + Integer.toString(i);
						}
						else
						{
							time2 = Integer.toString(i);
						}
%>                  
							<option value="<%=time2%>"  <% if(time2.equals(work_end_minute3)){ %> selected <% } %>><%=time2%></option>				      
<%
					}	
%>                        
                        
                        </select>��
                        </td>
                      </tr>                      
                      <tr> 
                        <td valign="top" class=my01>���� ���۽ð�</td>
                        <td class=my12>
                        <select name="close_start_hour" style="width:40px;" disabled>
<%
					for(int i =0;i<24;i++)
					{
						if(i < 10)
						{
							hour3 = "0" + Integer.toString(i);
						}
						else
						{
							hour3 = Integer.toString(i);
						}
%>                  
							<option value="<%=hour3%>"  <% if(hour3.equals(close_start_hour1)){ %> selected <% } %>><%=hour3%></option>				      
<%
					}	
%>                        
                        </select>��
                        <select name="close_start_minute" style="width:40px;" disabled>
<%
					for(int i =0;i<60;i++)
					{
						if(i < 10)
						{
							time3 = "0" + Integer.toString(i);
						}
						else
						{
							time3 = Integer.toString(i);
						}
%>                  
							<option value="<%=time3%>"  <% if(time3.equals(close_start_minute1)){ %> selected <% } %>><%=time3%></option>				      
<%
					}	
%>                                        
                        </select>��
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top" class=my01>���� ����ð�</td>
                        <td class=my12>
                        <select name="close_end_hour" style="width:40px;" disabled>
<%
					for(int i =0;i<24;i++)
					{
						if(i < 10)
						{
							hour4 = "0" + Integer.toString(i);
						}
						else
						{
							hour4 = Integer.toString(i);
						}
%>                  
							<option value="<%=hour4%>"  <% if(hour4.equals(close_end_hour1)){ %> selected <% } %>><%=hour4%></option>				      
<%
					}	
%>                                                
                        </select>��
                        <select name="close_end_minute" style="width:40px;" disabled>
<%
					for(int i =0;i<60;i++)
					{
						if(i < 10)
						{
							time4 = "0" + Integer.toString(i);
						}
						else
						{
							time4 = Integer.toString(i);
						}
%>                  
							<option value="<%=time4%>"  <% if(time4.equals(close_end_minute1)){ %> selected <% } %>><%=time4%></option>				      
<%
					}	
%>                                        
                        </select>��
                        </td>
                      </tr>
 					<tr> 
                        <td valign="top" class=my01>������ ����� ���� �Ұ���</td>
                        <td class=my12>                       
                        <input type="checkbox" name="closing" value = "Y"  <%if(closing.equals("Y")){%>checked<%}%> onFocus="this.blur()"> 
                        </td>
                    </tr>	 
 					<tr> 
                        <td valign="top" class=my01>���� �������� ��</td>
                        <td class=my12>                       
                        <input type="checkbox" name="billing" value = "Y"  <%if(billing.equals("Y")){%>checked<%}%> onFocus="this.blur()"> 
                        </td>
                    </tr>	 
 					<tr> 
                        <td valign="top" class=my05>������ �����8�ñ��� ����������</td>
                        <td class=my12>                       
                        <input type="checkbox" name="sixclose" value = "Y"  <%if(sixclose.equals("Y")){%>checked<%}%> onFocus="this.blur()"> 
                        </td>
                    </tr>	 
 					<tr> 
                        <td valign="top" class=my01>������ APL �����Ұ���</td>
                        <td class=my12>                       
                        <input type="checkbox" name="aplclose" value = "Y"  <%if(aplclose.equals("Y")){%>checked<%}%> onFocus="this.blur()"> 
                        </td>
                    </tr>	
                    <tr> 
                        <td valign="top" class=my01>������ �ڵ���ü�Ұ���</td>
                        <td class=my12> 
                        <input type="checkbox" name="delay_auto_close" value = "Y"  <%if(delay_auto_close.equals("Y")){%>checked<%}%> onFocus="this.blur()"> 
                        </td>
                    </tr>
                    <tr> 
                        <td valign="top" class=my01>�����ڵ���ȯ��</td>
                        <td class=my12>                       
                        <input type="checkbox" name="pl_repay_day" value = "Y"  <%if(pl_repay_day.equals("Y")){%>checked<%}%> onFocus="this.blur()"> 
                        </td>
                    </tr> 
                    
                    
                    <!--2006.05.22 �躸�� : 0601081 -->
                    <tr> 
                        <td valign="top" class=my01>������(��/��) �����޼��� �Ұ���</td>
                        <td class=my12>                       
                        <input type="checkbox" name="delay_pay_close" value = "Y"  <%if(delay_pay_close.equals("Y")){%>checked<%}%> onFocus="this.blur()"> 
                        </td>
                    </tr> 
                    
                    
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td class=popbtn2>
      	<img src="/img/common/mypage/my_btn_close.gif" hspace="10" vspace="10" onClick='window.close()' class='hand'>
<%
	//2005-10-10. 05-C-138. ������. ������Ѽ���ȭ
	//if( auth_cd.equals("20") || auth_cd.equals("30") )
	if( auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33") )
	{
%>        
        <a href="javascript:goMod();"><img src="/img/common/mypage/btn_mod.gif" vspace="10"  class='hand'></a>
<%
	}
%>
       </td>
    </tr>
  </table>
  <!-- //contents -->
  <!-- banner -->
  <!-- //banner -->
</form>
</body>
</html>


<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import = "java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager,gtone.changeminer.common.utility.Utility" %>
<%
/**
 * Description : ����͸�(��������߱�)
 * File        : /payment/admin_main.jsp
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : 
 * First Write : 
 * update date : 
 * update desc :
 */
%>
<%
//2006.03.22 ������ 0600069 Cyberadmin ��ɰ���
	SessionManager sessionManager = new SessionManager(request);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
	String auth_cd2 = sessionManager.getString(Constant.SESSION_LEVEL2);
		//���� üũ�� ���Ͽ� ���ڷ� ����.
	int auth_cd_num = 0;
	if(auth_cd.length() !=0 ){
		auth_cd_num = Integer.parseInt(auth_cd);
	}
	
	
        String tempStr = "";
        if (auth_cd.equals("31")) {
                //tempStr = "&fromamt=-1&toamt=2000000";
				tempStr = "&fromamt=&toamt=2000000";
        } else if (auth_cd.equals("32") || auth_cd.equals("33")) {
                //tempStr = "&fromamt=2000000&toamt=10000000";
				tempStr = "&fromamt=&toamt=10000000";
        }
		//tempStr = "&fromamt=-1&toamt=10000000";
		String sunap = "&fromamt=&toamt=";
		
	String fromdate2before = Utility.addDay(-2);//�������� 2����
	String fromdate = Utility.addDay(-1);//�������� �Ϸ���
	String todate = Utility.addDay(0);//���� ������
	
	String todaydate = todate;
	String toYear = todaydate.substring(0,4);
	String toDay = todaydate.substring(4,6);	
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
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
						<!--DropDown ���� : S-->
						<jsp:include page="/common/dropDown.jsp" flush="true">
							<jsp:param name="menu_mode" value="0"/>
						</jsp:include>
						<!--DropDown ���� : E-->
					</td>
					<td class="contents">
						<table width="100%">
							<tr> 
								<td><img src="/img/common/title_map.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="/img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="24"></td>
							</tr>
							<tr> 
								<td><table>
                    <tr> 
                      <td rowspan="7" valign="top"><img src="/img/common/map_img.jpg" hspace="10"></td>
                      <td>
                      
                      <% if(auth_cd.equals("20")&&auth_cd2.equals("11")){ 
                      
                      
                      }else{%> <!-- �����̰� B�ΰ�� �޴� ������ ���� -->
                      
                      <table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title01.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_view.do?searchgubun=S&current=1&fromdate=<%=fromdate2before%>&todate=<%=todate%>&modeind=1&srvc_ind=1&rslt=T&search=1&key=<%=tempStr%>" onFocus="blur()">�����������</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_view.do?searchgubun=S%A4t=1&fromdate=<%=fromdate%>&todate=<%=todate%>&modeind=1&srvc_ind=4&rslt=T&search=1&key=<%=tempStr%>" onFocus="blur()">��������</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_view.do?searchgubun=S&current=1&fromdate=<%=fromdate%>&todate=<%=todate%>&modeind=1&srvc_ind=5&rslt=T&search=1&key=<%=tempStr%>" onFocus="blur()">�޸麸�������</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_view.do?searchgubun=S%A4t=1&fromdate=<%=fromdate%>&todate=<%=todate%>&modeind=1&srvc_ind=7&rslt=T&search=1&key=<%=tempStr%>" onFocus="blur()">���ݻ��</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table>
                        <%}%>
                        
                        </td>
                      <td style="padding: 0 10px;">
                      
                      <% if(auth_cd.equals("20")&&auth_cd2.equals("00")){ 
                      }else{%> <!-- �����̰� A�ΰ�� �޴� ������ ���� -->
                      <table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title02.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_view.do?modeind=2&srvc_ind=6&searchgubun=S<%=sunap%>&fromdate=<%=fromdate%>&todate=<%=todate%>" onFocus="blur()">��������</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_view.do?modeind=2&srvc_ind=8&searchgubun=S<%=sunap%>&fromdate=<%=fromdate%>&todate=<%=todate%>" onFocus="blur()">�߰���������</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_view.do?searchgubun=S&current=1&fromdate=<%=fromdate%>&todate=<%=todate%>&modeind=2&srvc_ind=2&rslt=T&search=1&key=<%=sunap%>" onFocus="blur()">��������ȯ</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_view.do?searchgubun=S&current=1&fromdate=<%=fromdate%>&todate=<%=todate%>&modeind=2&srvc_ind=3&rslt=T&search=1&key=<%=sunap%>" onFocus="blur()">APL��ȯ</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table>
                        <% } %>
                        
                        </td>
                      <td><table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title03.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/status_chg_list.do?searchgubun=S&current=1&fromdate=&todate=&rslt=T&search=1&key=" onFocus="blur()">ó�����º���</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><%if(auth_cd_num>=31){ %><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/smslp_manager.do" onFocus="blur()">SMS����</a></b><%}%></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><%if(auth_cd_num>=31){ %><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/member_list.do?run=list" onFocus="blur()">��ȸ������</a></b><%}%></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><%if(auth_cd_num>=31){ %><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/login_manager.do" onFocus="blur()">�α��ΰ���</a></b><%}%></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><%if(auth_cd_num>=31){ %><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/inout_manager.do" onFocus="blur()">����ݰ���</a></b><%}%></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr height="22"> 
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td>
                      <% if(auth_cd.equals("20")&&auth_cd2.equals("00")){ 
                      }else{%> <!-- �����̰� A�ΰ�� �޴� ������ ���� -->
                      <table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title11.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><a href="/receipt/policy_indiv.do?menu_mode=8&srvc_ind=B" onFocus="blur()"><b>�ڵ���ü����</b></a> 
                            </td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><a href="/receipt/policy_indiv.do?menu_mode=8&srvc_ind=C" onFocus="blur()"><b>�ڵ���ü����</b></a> 
                            </td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table>
                        <% } %>
                        </td>
                      <td style="padding: 0 10px;">
                      
                      <% if(auth_cd.equals("20")&&auth_cd2.equals("11")){ 
                      }else{%> <!-- �����̰� B�ΰ�� �޴� ������ ���� -->
                      <table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title12.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><a href="/receipt/policy_indiv.do?menu_mode=9&srvc_ind=I" onFocus="blur()"><b>APL��û</b></a> 
                            </td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                       
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><a href="/receipt/policy_indiv.do?menu_mode=9&srvc_ind=J" onFocus="blur()"><b>APL����</b></a> 
                            </td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table>
                        <% } %>
                        </td>
                      <td><table class="map">
                          <tr> 
                            <td></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"></a> 
                            </td>
                          </tr>
                          <tr> 
                            <td height="5" ></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr height="22"> 
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td><table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title04.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/report/pay_proc_report.do" onFocus="blur()">���޳�������</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><a href="/report/rec_proc_report.do" onFocus="blur()"><b>������������</b></a>                             </td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          
                          <tr> 
                            <td height="22">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td><img src="/img/common/map_title10.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/withdrawal/withdrawal.do" onFocus="blur()">û�� öȸ</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table></td>
                      <td style="padding: 0 10px;">
                       <table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title05.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
						  <tr> 
                            <td height="22"><a href="/receipt/return_manager.do" onFocus="blur()"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b>�ݼۻ�������</b></a> 
                            </td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/payment/policy_return.do?searchgubun=S&fromdate=&todate=&fromdate2=&todate2=&srvc_ind=0&search=1&key=" onFocus="blur()">�ݼ�ó������Ʈ</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22">&nbsp;</td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"></td>
                          </tr>
                        
                          <tr> 
                            <td height="22"><IMG src="../img/common/map_title13.gif"></td>
                          </tr>
                           <tr> 
                            <td height="8"></td>
                          </tr>
                        
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/withdrawal/sms_log_list.do?fromDate1=<%=toYear%>&fromDate2=<%=toDay%>" onFocus="blur()">SMS�߼��̷�</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table></td>
                      <td>
                      	<table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title06.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_realtime.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=Z&search=1&key=" onFocus="blur()">����͸�(�Ϲ�)</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/monitor/monitering_proof.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=1&search=1&key=" onFocus="blur()">����͸�(��������߱�)</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/monitor/monitering_proof_search.do?searchgubun=S&current=1&fromdate=&todate=&useind=&modeind=&srvc_ind=&search=1&key=" onFocus="blur()">����͸�(����ȭ����ȸ)</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/monitor/monitering_proof_print.do?searchgubun=S&current=1&fromdate=&todate=&useind=&modeind=&srvc_ind=&search=1&key=" onFocus="blur()">����͸�(����ȭ�����)</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
						  <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_reissue.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&search=1&key="  onFocus="blur()">����͸�(�������������)</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/monitor/monitering_resurr.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=1&search=1&key=" onFocus="blur()">����͸�(��Ȱ)</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="/receipt/policy_indiv.do" onFocus="blur()">����ó��-���װ���������</a></b></td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr height="22"> 
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr> 
                      <td><%if(auth_cd_num>=31){ %><table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title07.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><a href="/receipt/schedule.do?run=view" onFocus="blur()"><b>WORKINGDAY����</b></a> 
                            </td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table><%}%></td>
                      <td style="padding: 0 10px;"><table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title08.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><a href="/receipt/auth_manager.do" onFocus="blur()"><b>���Ѱ���</b></a> 
                            </td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table></td>
                      <td><table class="map">
                          <tr> 
                            <td><img src="/img/common/map_title09.gif"></td>
                          </tr>
                          <tr> 
                            <td height="8"></td>
                          </tr>
                          <tr> 
                            <td height="22"><img src="/img/common/bu_sq01.gif" hspace="7" align="absmiddle"><a href="/common/cyber_index.do?run=list" onFocus="blur()"><b>Cyber Index</b></a> 
                            </td>
                          </tr>
                          <tr> 
                            <td height="5" background="/img/common/line.gif"></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table></td>
					</tr>
					<tr> 
						<td height="50">&nbsp;</td>
					</tr>
				</table></td>
			</tr>
		</table></td>
	</tr>
	<tr> 
		<td height="56" background="/img/common/copy_bg.gif"><img src="/img/common/copy.gif"></td>
	</tr>
</table>
</body>
</html>


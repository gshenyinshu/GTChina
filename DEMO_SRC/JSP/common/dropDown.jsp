<%
/**
 * Title       : DropDown
 * Description : ������ȭ���� ����ȭ��
 * File        : /common/dropDown.jsp
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : jung-hun Park
 * First Write : 2005.02.14
 * update date : 
 * update desc :
 *///
%>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import = "gtone.changeminer.common.constant.*,gtone.changeminer.common.manager.SessionManager,gtone.changeminer.common.utility.Utility" %>

<!--�α��� üũ : S --->            
<%@ include file = "/payment/process_login_first.jsp" %> 
<!--�α��� üũ : E--->
 
<%
	//�ش��������� ������ �ޱ�
	String menu_mode = request.getParameter("menu_mode") == null? "" : request.getParameter("menu_mode");
	//���ǿ��� ��������
	
	String emp_nm = sessionManager.getString(Constant.SESSION_USERNAME);
	String auth_cd = sessionManager.getString(Constant.SESSION_LEVEL);
	String auth_cd2 = sessionManager.getString(Constant.SESSION_LEVEL2);
	
	//���� üũ�� ���Ͽ� ���ڷ� ����.
	int auth_cd_num = 0;
	if(auth_cd.length() !=0 ){
		auth_cd_num = Integer.parseInt(auth_cd);
	}
	
	//20070620 ���� ���� �߰�...(�޴����� ȭ������ ��ũ�� �������� ȭ�鿡 ���� ��� ó�� �ϱ� ����.. ȭ���̸�... 
	//���� ���ٽÿ��� �������� �ٽÿ����� �Ѵ�.)
	//�޴��� ������ �ʰ� ����� �����ϴ�. 
	//ȭ�麰 ���� üũ�� ���ѷ��� �߰�... 
	//request�� üũ���ο� üũ�� �Ѵٸ�... ������ ���ϰ� �ƴ϶�� ������ ���....

	String menu_num = request.getParameter("menu_num") == null? "" : request.getParameter("menu_num");

	String auth_check_yn = "N"; //�⺻�� 
	int auth_param = 0;
	
	if(menu_num.equals("101")){ 	//�����������  
	}else if(menu_num.equals("102")){ 	//��������     
	}else if(menu_num.equals("103")){ 	//�޸麸�������     
	}else if(menu_num.equals("104")){ 	//���ݻ������
	}else if(menu_num.equals("201")){ 	//��������     
	}else if(menu_num.equals("202")){ 	//�߰���������     
	}else if(menu_num.equals("203")){ 	//��������ȯ     
	}else if(menu_num.equals("204")){ 	//APL��ȯ
	}else if(menu_num.equals("401")){ 	//APL��û    
	}else if(menu_num.equals("402")){ 	//APL����
	}else if(menu_num.equals("501")){ 	//ó�����º���
	}else if(menu_num.equals("502")){ 	//SMS����
		auth_check_yn = "Y";
		auth_param 	= 31;
	}else if(menu_num.equals("503")){ 	//��ȸ������
		auth_check_yn = "Y";
		auth_param 	= 31;	
	}else if(menu_num.equals("504")){ 	//�α��ΰ���
		auth_check_yn = "Y";
		auth_param 	= 31;	
	}else if(menu_num.equals("505")){ 	//����ݰ���
		auth_check_yn = "Y";
		auth_param 	= 31;
	}else if(menu_num.equals("601")){ 	//���޳�������
	}else if(menu_num.equals("602")){ 	//������������
	}else if(menu_num.equals("701")){ 	//�ݼۻ�������
	}else if(menu_num.equals("702")){ 	//�ݼ�ó������Ʈ
	}else if(menu_num.equals("801")){ 	//����͸�(�Ϲ�)
	}else if(menu_num.equals("802")){ 	//����͸�(��������߱�)
	}else if(menu_num.equals("803")){ 	//����͸�(����ȭ����ȸ)
	}else if(menu_num.equals("804")){ 	//����͸�(����ȭ�����)
	}else if(menu_num.equals("805")){ 	//����͸�(�������������)
	}else if(menu_num.equals("806")){ 	//����͸�(��Ȱ)
	}else if(menu_num.equals("807")){ 	//����ó��
	}else if(menu_num.equals("901")){ 	//��÷�ϱ�
		auth_check_yn = "Y";
		auth_param 	= 31;	
	}else if(menu_num.equals("902")){ 	//����ڷ�
		auth_check_yn = "Y";
		auth_param 	= 31;	
	}else if(menu_num.equals("1001")){ 	//WORKINGDAY����
		auth_check_yn = "Y";
		auth_param 	= 31;
	}else if(menu_num.equals("1101")){ 	//���Ѱ���
	}else if(menu_num.equals("1201")){ 	//Cyber Index
	}else if(menu_num.equals("1301")){ 	//û�� öȸ
	}else if(menu_num.equals("1401")){ 	//SMS�߼��̷�
	}
	
	
	String fromdate2before = Utility.addDay(-2);//�������� 2����
	String fromdate = Utility.addDay(-1);//�������� �Ϸ���
	String todate = Utility.addDay(0);//���� ������
	
	String todaydate = todate;
	String toYear = todaydate.substring(0,4);
	String toDay = todaydate.substring(4,6);
	
	

	//2006.03.22 ������ 0600069 Cyberadmin ��ɰ���
	
	String tempStr = "";
	String tempUser = "";
	if (auth_cd.equals("31")) {
		//tempStr = "&fromamt=-1&toamt=2000000";
		tempStr = "&fromamt=&toamt=2000000";
		tempUser = "1��������";
	} else if (auth_cd.equals("32")) {
		//tempStr = "&fromamt=2000000&toamt=10000000";
		tempStr = "&fromamt=&toamt=10000000";
		tempUser = "2��������";
	} else if (auth_cd.equals("33")) {
		//tempStr = "&fromamt=2000000&toamt=10000000";
		tempStr = "&fromamt=&toamt=10000000";
		tempUser = "3��������";
	} else if (auth_cd.equals("40")) {
		tempUser = "Admin";
	} else if (auth_cd.equals("20")) {
		tempUser = "����";
	} else if (auth_cd.equals("10")) {
		tempUser = "��ȸ";
	} else if (auth_cd.equals("90")) {
		tempUser = "û��öȸ������";
	}
	
	String sunap = "&fromamt=&toamt=";
	
	//tempStr = "&fromamt=-1&toamt=10000000";
%>
<br><b>[ <%=emp_nm%> ]</b>�Բ���<br>�α����ϼ̽��ϴ�.
<br><b>(<%=tempUser%>)</b>
<br><br>
<script language="javascript">
<!--  
<%  //����üũ�� Y�϶� �Ķ����� ���� �����ڿ�.. ������ �ڵ� �� ������ üũ...
	if(auth_check_yn.equals("Y")){

		if(auth_param>auth_cd_num){
%>		
			alert("���� ������ ���� �������Դϴ�.");		
			location.href="/payment/admin_main.do";
<%		
		}
		

	}
%>


	try{
	
		var menuidTemp = parent.TopFrame.frameHidden.menuidTemp.value;
		
	}catch(e){   
	
		alert("�ùٸ� ������ �ƴմϴ�.");
		location.href = "/index.jsp";
		
	}


//-->
</script>
<script language='javascript' src='../../common/js/menu_on.js'></script>


	
<img src="../../img/common/menu_side.gif" width="155" height="64" border="0" usemap="#Map"> 
<map name="Map">
  <area shape="rect" coords="1,9,160,30" href="/payment/admin_main.do" onFocus="blur();">
  <area shape="rect" coords="0,36,160,57" href="javascript:goLink('logout')" onFocus="blur();">
</map>

<table width="100%">

<!--����ó�� : S-->
<% if(auth_cd.equals("20")&&auth_cd2.equals("11")){ %> <!-- �����̰� B�ΰ�� �޴� ������ ���� -->
<tr id=subMenuBlock1 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th></th>
	</tr>

<% }else{ %>
	<tr> 
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(1,'#')" onFocus="blur()">����ó��</a></td>
	</tr>
	<tr id=subMenuBlock1 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">

			<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=1&srvc_ind=1&searchgubun=S<%=tempStr%>&fromdate=<%=fromdate2before%>&todate=<%=todate%>','101')" onFocus="blur()">�����������</a></div>
			<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
			<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=1&srvc_ind=4&searchgubun=S<%=tempStr%>&fromdate=<%=fromdate%>&todate=<%=todate%>','102')" onFocus="blur()">��������</a></div>
			<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
			<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=1&srvc_ind=5&searchgubun=S<%=tempStr%>&fromdate=<%=fromdate%>&todate=<%=todate%>','103')" onFocus="blur()">�޸麸�������</a></div>
			<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
			<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=1&srvc_ind=7&searchgubun=S<%=tempStr%>&fromdate=<%=fromdate%>&todate=<%=todate%>','104')" onFocus="blur()">���ݻ������</a></div></th>
			</th>
	</tr>
<%}%>

<!--����ó�� : S-->
<% if(auth_cd.equals("20")&&auth_cd2.equals("00")){ %> <!-- �����̰� A�ΰ�� �޴� ������ ���� -->
<tr id=subMenuBlock2 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th></th>
	</tr>

<% }else{ %>
	<tr> 
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(2,'#')" onFocus="blur()">����ó��</a></td>
	</tr>
	<tr id=subMenuBlock2 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=2&srvc_ind=6&searchgubun=S<%=sunap%>&fromdate=<%=fromdate%>&todate=<%=todate%>','201')" onFocus="blur()">��������</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_view.do?modeind=2&srvc_ind=8&searchgubun=S<%=sunap%>&fromdate=<%=fromdate%>&todate=<%=todate%>','202')" onFocus="blur()">�߰���������</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_view.do?searchgubun=S&current=1&fromdate=<%=fromdate%>&todate=<%=todate%>&modeind=2&srvc_ind=2&rslt=T&search=1&key=<%=sunap%>','203')" onFocus="blur()">��������ȯ</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_view.do?searchgubun=S&current=1&fromdate=<%=fromdate%>&todate=<%=todate%>&modeind=2&srvc_ind=3&rslt=T&search=1&key=<%=sunap%>','204')" onFocus="blur()">APL��ȯ</a></div>
				</th>
	</tr>
<% } %>
	
<!-- �ڵ���üó�� : S--><!-- �߰� 2007.05.23-->
<% if(auth_cd.equals("20")&&auth_cd2.equals("00")){ %> <!-- �����̰� A�ΰ�� �޴� ������ ���� -->
<tr id=subMenuBlock8 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th></th>
	</tr>

<% }else{ %>
	<tr> 
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(8,'#')" onFocus="blur()">�ڵ���üó��</a></td>
	</tr>
	<tr id=subMenuBlock8 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_indiv.do?menu_mode=8&srvc_ind=B','301')" onFocus="blur()">�ڵ���ü����</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_indiv.do?menu_mode=8&srvc_ind=C','302')" onFocus="blur()">�ڵ���ü����</a></div>
				</th>
	</tr>
<% } %>

<!-- ��ຯ��ó�� : S--><!-- �߰� 2007.05.23-->
<% if(auth_cd.equals("20")&&auth_cd2.equals("11")){ %> <!-- �����̰� B�ΰ�� �޴� ������ ���� -->
<tr id=subMenuBlock9 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th></th>
	</tr>

<% }else{ %>
	<tr> 
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(9,'#')" onFocus="blur()">��ຯ��ó��</a></td>
	</tr>
	<tr id=subMenuBlock9 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_indiv.do?menu_mode=9&srvc_ind=I','401')" onFocus="blur()">APL��û</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_indiv.do?menu_mode=9&srvc_ind=J','402')" onFocus="blur()">APL����</a></div>
				</th>
	</tr>
	
<%}%>
<!--��Ÿ : S-->
	<tr>  
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(3,'#')" onFocus="blur()">��Ÿ</a></td>
	</tr>
	<tr id=subMenuBlock3 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'>  
		<th>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/status_chg_list.do?searchgubun=S&current=1&fromdate=&todate=&rslt=T&search=1&key=','501')" onFocus="blur()">ó�����º���</a></div>
				
				<%if(auth_cd_num>=31){ %>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/smslp_manager.do','502')" onFocus="blur()">SMS����</a></div>   
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/member_list.do?run=list','503')" onFocus="blur()">��ȸ������</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/login_manager.do','504')" onFocus="blur()">�α��ΰ���</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/inout_manager.do','505')" onFocus="blur()">����ݰ���</a></div>
				<%}%>
				</th>
	</tr>
	

<!--�ϸ��� : S-->		
	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(4,'#')" onFocus="blur()">�ϸ���</a></td>
	</tr>
	<tr id=subMenuBlock4 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/report/pay_proc_report.do','601')" onFocus="blur()">���޳�������</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/report/rec_proc_report.do','602')" onFocus="blur()">������������</a></div>
				
				</th>
	</tr>
	

<!--�ݼ۰��� : S-->
	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(5,'#')" onFocus="blur()">�ݼ۰���</a></td>
	</tr>
	<tr id=subMenuBlock5 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 	
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/return_manager.do','701')" onFocus="blur()">�ݼۻ�������</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/payment/policy_return.do?searchgubun=S&fromdate=&todate=&fromdate2=&todate2=&srvc_ind=0&search=1&key=','702')" onFocus="blur()">�ݼ�ó������Ʈ</a></div>
				</th>
	</tr>
	
	
<!--��Ƽ�͸� : S-->
	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(6,'#')" onFocus="blur()">����͸�</a></td>
	</tr>
	<tr id=subMenuBlock6 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 	
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_realtime.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=Z&search=1&key=&rslt=A','801')" onFocus="blur()">����͸�(�Ϲ�)</a></div>
				
<!--��Ī����:����͸�(����)->����͸�(��������߱�)-->				
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/monitor/monitering_proof.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=1&search=1&key=','802')" onFocus="blur()">����͸�<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(��������߱�)</a></div>
				
<!--�߰�:����͸�(����ȭ����ȸ)-->				
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/monitor/monitering_proof_search.do?searchgubun=S&current=1&fromdate=&todate=&useind=&modeind=&srvc_ind=&search=1&key=','803')" onFocus="blur()">����͸�<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(����ȭ����ȸ)</a></div>
				
<!--�߰�:����͸�(����ȭ�����)-->				
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/monitor/monitering_proof_print.do?searchgubun=S&current=1&fromdate=&todate=&useind=&modeind=&srvc_ind=&search=1&key=','804')" onFocus="blur()">����͸�<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(����ȭ�����)</a></div>
				
<!--�޴�����:��Ÿ->����͸�///��Ī����:�������������->����͸�(�������������)-->					
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_reissue.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&search=1&key=','805')" onFocus="blur()">����͸�<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(�������������)</a></div>
				
				
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/monitor/monitering_resurr.do?searchgubun=S&current=1&fromdate=&todate=&fromdate2=&todate2=&modeind=1&srvc_ind=1&search=1&key=','806')" onFocus="blur()">����͸�(��Ȱ)</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/receipt/policy_indiv.do','807')" onFocus="blur()">����ó��</a></div>
				</th>
	</tr>
	<%if(auth_cd_num>=31){ %>
	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(7,'#')" onFocus="blur()">���̹������̺�Ʈ</a></td>
	</tr>
	<tr id=subMenuBlock7 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 	
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/common/event/event_prize.do?run=list','901')" onFocus="blur()">��÷�ϱ�</a></div>
				<div class="mn"><img src="../../img/common/menu02.gif" hspace="8">
				<a href="javascript:goPageAction('/common/event/event_stat.do?run=list','902')" onFocus="blur()">����ڷ�</a></div>
				</th>
	</tr>
	<%}else{%>
	<tr id=subMenuBlock7 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 	
		<th></th>
	</tr>

	<%}%>

	
	
	

	
	
	
	<%if(auth_cd_num>=31){ %>
	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:goPageAction('/receipt/schedule.do?run=view','1001')" onFocus="blur()">WORKINGDAY����</a></td>
	</tr>		
	<%}%>
		
<!--WORKINGDAY���� : S-->

	<tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:goPageAction('/receipt/auth_manager.do','1101')" onFocus="blur()">���Ѱ���</a></td>
	</tr>
	

<!--Cyber Index : S-->
	<tr>
		<td>
			<img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:goPageAction('/common/cyber_index.do?run=list','1201')" onFocus="blur()">Cyber Index</a>
		</td>
	</tr>
<!--Event : S-->

<!--û�� öȸ : S-->
	<tr>
		<td>
			<img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:goPageAction('/withdrawal/withdrawal.do','1301')" onFocus="blur()">û�� öȸ</a>
		</td>
	</tr>
	
<!--SMS�߼��̷� : S-->
	<tr>
		<td>
			<img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:goPageAction('/withdrawal/sms_log_list.do?fromDate1=<%=toYear%>&fromDate2=<%=toDay%>','1401')" onFocus="blur()">SMS�߼��̷�</a>
		</td>
	</tr>	
	
	
	<!-- �����ظ޴� ����ٰ� �ߴ� 2006.06.14 tr>
		<td><img src="../../img/common/menu01.gif" hspace="8"><a href="javascript:choiceMenu(8,'#')" onFocus="blur()">Cyber Index</a></td>
	</tr>							
	<tr id=subMenuBlock7 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'>
		<th>
		<div class="mn">
			<img src="../../img/common/menu02.gif" hspace="8"><a href="/common/cyber_index.do?run=list" onFocus="blur()">Cyber Index</a>
		</div>
		<div class="mn">
			<img src="../../img/common/menu02.gif" hspace="8"><a href="javascript:" onFocus="blur()">�����ذ���</a>
		</div>
		</th>		
	</tr-->							

	<!--<tr>
		<td><img src="../../img/common/menu01.gif" hspace="7"><a href="javascript:choiceMenu(7,'#')" onFocus="blur()">WORKINGDAY����</a></td>
	</tr>							
	<tr id=subMenuBlock7 style='BORDER-RIGHT: 0px; BORDER-TOP: 0px; MARGIN-LEFT: DISPLAY: none; 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px'> 
		<th><div class="mn"><img src="../../img/common/menu02.gif" hspace="7">
				<a href="/receipt/schedule.do?run=view" onFocus="blur()">WORKINGDAY����</a></div>
				</th>
	</tr>-->
</table>


<SCRIPT language=javascript>
<!--




	function choiceMenu(intChoiceMenu)
	{
		var thisForm = self.document.forms[0];
		for(var idxLoop=1; idxLoop<10; idxLoop++){
			var objSubMenuBlock = eval('document.all.subMenuBlock'+idxLoop);
			var objMainMenuImg = eval('document.all.Image'+idxLoop);
			
			if (intChoiceMenu == idxLoop)
			{
				if (objSubMenuBlock.style.display == 'block')
				{ 
					objSubMenuBlock.style.display = 'none'; 
				}
				else
				{
					objSubMenuBlock.style.display = 'block';
				}
			}
			else
			{
				objSubMenuBlock.style.display = 'none'; 
			}
		}
	}
	
	var menu_mode = "<%=menu_mode%>";
	if( menu_mode == "1" )
	{
		choiceMenu(1,'#');
	}
	else if( menu_mode == "2" )
	{
		choiceMenu(2,'#');
	}
	else if( menu_mode == "3" )
	{
		choiceMenu(3,'#');
	}
	else if( menu_mode == "4" )
	{
		choiceMenu(4,'#');
	}
	else if( menu_mode == "5" )
	{
		choiceMenu(5,'#');
	}
	else if( menu_mode == "6" )
	{
		choiceMenu(6,'#');
	}
	
	else if( menu_mode == "7" )
	{
		choiceMenu(7,'#');
	}
	else if( menu_mode == "8" )
	{
		choiceMenu(8,'#');
	}
	else if( menu_mode == "9" )
	{
		choiceMenu(9,'#');
	}
	else
	{
		choiceMenu(0,'#');
	}

	


//-->
</SCRIPT>


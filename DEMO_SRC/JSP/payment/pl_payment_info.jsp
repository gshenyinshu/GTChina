<%@ page import = "gtone.changeminer.common.constant.*, gtone.changeminer.common.manager.SessionManager, java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util, gtone.changeminer.common.utility.Utility" %>

<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<!--PAYMENT SCREEN-->
<jsp:useBean id="checkopt" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="workinginfo" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="otherSystemStatus" 	class="anyframe.data.DataSet" scope="request"/>

<!---->
<jsp:useBean id="plpaymentinfo" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="plpayment" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="plpaymentApln" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="userinfo" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="payment" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="policy" class="java.lang.String" scope="request"/>
<jsp:useBean id="policy_apln_no" class="java.lang.String" scope="request"/>
<jsp:useBean id="ssn" class="java.lang.String" scope="request"/>

<jsp:useBean id="sbkcda" class="java.lang.String" scope="request"/>
<jsp:useBean id="sbknoa" class="java.lang.String" scope="request"/>
<jsp:useBean id="pyrna" class="java.lang.String" scope="request"/>
<jsp:useBean id="bankconf" 	class="anyframe.data.DataSet" scope="request"/>

<jsp:useBean id="opt1" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="regdate" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="cash" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="indate" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bnkclt" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bnkcode" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="bnkacct" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="process" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="approval" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="recognize" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="trans" 	class="anyframe.util.StringFormater" scope="request"/>
<jsp:useBean id="plancd" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="working2after" 	class="java.lang.String" scope="request"/>

<!-- 2006.12.27 ������  0602294 ���̹� ������ ȭ�� ���� -->
<jsp:useBean id="current" class="java.lang.String" scope="request"/>
<jsp:useBean id="key" class="java.lang.String" scope="request"/>
<jsp:useBean id="search" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate" class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" class="java.lang.String" scope="request"/>
<jsp:useBean id="rslt" class="java.lang.String" scope="request"/>
<jsp:useBean id="searchgubun" class="java.lang.String" scope="request"/>
<jsp:useBean id="modeind" class="java.lang.String" scope="request"/>
<jsp:useBean id="srvc_ind" class="java.lang.String" scope="request"/>
<jsp:useBean id="fromamt" class="java.lang.String" scope="request"/>
<jsp:useBean id="toamt" class="java.lang.String" scope="request"/>

<!-- 20080201 : �躸�� : PO���� METHOD�����ͼ� �Ͻó� ���� : METHOD=P -->
<jsp:useBean id="contractDetail" class="anyframe.data.DataSet" scope="request"/>

<!-- 20080325 : ������ : ����ڰ��� �߰� -->
<jsp:useBean id="deathResult" 	class="java.lang.String" scope="request"/>

<%
try {
	String	deptcd 	 = request.getParameter("deptcd")	== null ? "INT" : request.getParameter("deptcd");
	String	init	 	 = request.getParameter("init")	== null ? "     " : request.getParameter("init");
	String 	bnkyn		= request.getParameter("bnkyn")	== null ? "": request.getParameter("bnkyn");

	
    // ��ǰ�ڵ��� ���ڸ� ���ڸ��� �ڸ�.
    if("".equals(Util.nvl(plancd)) == false) {
        plancd = plancd.substring(0,2);
    }
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript">
<!--
	function goReturn(cd)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}


		var path = "";
		path = "/receipt/return_tbl.do?policy_apln_no="+cd;

		window.open(path, '�ݼ�', 'left=400,top=150,Width=450,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');

	}


	function returnFalseMsg(cd){
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}


		var path = "";
		path = "/receipt/return_false.do?policy_apln_no="+cd;

		window.open(path, '���и޼���', 'left=400,top=150,Width=450,Height=240, toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=no, menubar=no, location=no, resizable=no');


	}


	function bankconfc(cd1, cd2, cd3)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}


		form = document.paymentForm;
		form.sbkcda.value = cd1;
		form.sbknoa.value = cd2;
		form.pyrna.value = cd3;
		//form.action = "pl_payment_info.do";
		form.submit();
	}

	function getLoan()
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}


		form = document.paymentForm;
		form.process.value = "L";
		form.submit();
	}

	function goProcess(cd1, cd2, cd3, cd4, cd5, cd6, cd7)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}


<%
SessionManager sessionManager = new SessionManager(request);
String emp_no = sessionManager.getString(Constant.SESSION_USERID);
%>
		var recon_id = "<%=payment.getText("recon_id")%>";
		var cur_id = "<%=emp_no%>";

		if (recon_id == cur_id) {
			alert("���� �����û���� ������ ó���� �� �����ϴ�.");
			return;
		}
		var act_amt = <%=payment.getText("apln_amt",0).trim()%>-0;
		var auth_cd = "<%=payment.getText("auth_cd")%>";
		if (act_amt > 10000000) {
			alert("���� ���ѿ� ���� �ʴ� �ݾ��Դϴ�.");
			return;
		} else if (act_amt > 2000000 && auth_cd != "32" && auth_cd != "33") {
			alert("���� ���ѿ� ���� �ʴ� �ݾ��Դϴ�.");
			return;
		}
		form = document.paymentForm;
		form.opt1.value = cd1;//�����ڵ� L1
		form.policy.value = cd2;//���ǹ�ȣ
		form.regdate.value = cd3;//��������
		form.indate.value = cd3;
		form.cash.value = cd4;//�ݾ�
		form.bnkclt.value = cd5;//�������ֹ�
		form.bnkcode.value = cd6;//�����ڵ�
		form.bnkacct.value =  cd7;//���¹�ȣ


		//if(form.process.value == "L")
		//{
			if (confirm('���� ó�� �Դϴ�.\n\n���� ó���� �Ͻðڽ��ϱ�?'))
			{
				form.process.value = "Y";
				//form.action = "pl_payment_info.do";
				form.submit();
			}
			else
			{
				return;
			}
		//}
	}


	function goRecogn(cd,cd1, cd2, cd3, cd4, cd5, cd6, cd7)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}


		form = document.paymentForm;
		var Time = new Date();

		var bankon = '<%=payment.getText("bank_conf_yn")%>';


		//20060601 �躸�� 0601081 ����/��ȿ(��/��)üũ�߰�
		//20060601 �躸�� 0601081 workingday�� ����/��ȿ(��/��)üũ�߰�

		var selopt  	= '<%=checkopt.getText("selopt")%>';	//��ȿ�ɼ� - ��ȿ������ 0:��������, 2:���׿ϳ�
		var advcnt 	= '<%=checkopt.getText("advcnt")%>';	//2:������
		var aplclose	= '<%=workinginfo.getText("aplclose")%>';   //Y:������ APL �Ұ���
		var delayclose	= '<%=workinginfo.getText("delay_pay_close")%>';  //Y:������(��/��) �����޼��ɺҰ���
		
		//20080201 : �躸�� : PO���� METHOD�����ͼ� �Ͻó� ���� : METHOD=P
		var method =  '<%=contractDetail.getText("method")%>';  //Y:������(��/��) �����޼��ɺҰ���


		//test
		//selopt='0';
		//advcnt='2';
		//aplclose='Y';
		//delayclose='Y';
		//alert("��ȿ�ɼ�0,2 : "+selopt+" / ������2 : "+advcnt+" / �����ǺҰ��� : "+aplclose+" / ������(��/��)�Ұ��� : "+delayclose);

		//������ APL �Ұ����� ���, ��� �������� ó���Ұ�
		if(aplclose == 'Y'){
			if(advcnt == '2' && method !='P'){
<%
    // 0800133 : �����ϰ�� �������ΰ�쿡 �޼����� �����ְ� ��� �����Ҽ� ����.
    if(("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd)) == false) { 
%>
				alert("������ ���� �������Դϴ�.\n������ ������ APL �Ұ����̹Ƿ� ��� ���� ó���� �� �����ϴ�.");
				return;
<%
    }else {
%>
				alert("������ ���� �������Դϴ�.\n������ ������ APL �Ұ����̹Ƿ� ��� ���� Ȯ���� ó�� �ٶ��ϴ�.");
<%
    }
%>
			}
		}

		//������(��/��) �����޼��ɺҰ����� ���, �������̸鼭 ��ȿ������ ���׿ϳ��� ���������� ���̸� ó�� �Ұ�
		if(delayclose == 'Y'){
			if(selopt == '0' || selopt == '2'){
				if(advcnt == '2' && method !='P'){
<%
    // 0800133 : �����ϰ�� �������ΰ�쿡 �޼����� �����ְ� ��� �����Ҽ� ����.
    if(("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd)) == false) { 
%>
					alert("������ ���� ���׿ϳ�/���������� �������Դϴ�.\n������ ������(���׿ϳ�/��������) �����޼��� �Ұ����̹Ƿ� ��� ���� ó���� �� �����ϴ�.");
					return;
<%
    }else {
%>
					alert("������ ���� ���׿ϳ�/���������� �������Դϴ�.\n������ ������(���׿ϳ�/��������) �����޼��� �Ұ����̹Ƿ� ��� ���� Ȯ���� ó�� �ٶ��ϴ�.");
<%
    }
%>
				}
			}
		}

		if(bankon == 'N')
		{
			alert("������ Ȯ���� ���� �ʾҽ��ϴ�. ������ Ȯ���� �Ͻð� �����û�� �ϼ���");
			return;
		}
		else
		{
			//if(form.process.value == "L")
			//{
				if (confirm('���� ��û�� �Ͻðڽ��ϱ�?'))
				{
					form.process.value = "R";
					form.opt1.value = cd1;//�����ڵ� L1
					form.policy.value = cd2;//���ǹ�ȣ
					form.regdate.value = cd3;//��������
					form.indate.value = cd3;
					form.cash.value = cd4;//�ݾ�
					form.bnkclt.value = cd5;//�������ֹ�
					form.bnkcode.value = cd6;//�����ڵ�
					form.bnkacct.value =  cd7;//���¹�ȣ

					form.action = "pl_payment_info.do";
					form.submit();

				}
				else
				{
					return;
				}
			//}
			//else
			//{
			//	alert("ó���� ��ȸ�� �Ͻð� ���縦 ��û�ϼ���.");
			//	return;
			//}
		}
	}



	function goTimeout(cd)
	{

		if(cd != 'A')
			setTimeout("goDisable()", 1000 * 5);
		else
			setTimeout("goDisable1()", 1000 * 5);
	}

	function goDisable()
	{
		document.getElementById("btn2").disabled = true;
	}

	function goDisable1()
	{
		document.getElementById("btn1").disabled = true;
	}

	function goProcess1(cd1, cd2, cd3, cd4, cd5, cd6, cd7,cd8)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}


		var act_amt = <%=payment.getText("act_amt",0).trim()%>-0;
		var auth_cd = "<%=payment.getText("auth_cd")%>";
		if (act_amt > 1000 && auth_cd != "33") {
			alert("1000���� �ʰ��ݾ׿� ���Ͽ� ��������� �����ϴ�.");
			return;
		} else if (act_amt > 200 && auth_cd != "32" && auth_cd != "31") {
			alert("200���� �ʰ��ݾ׿� ���Ͽ� ��������� �����ϴ�.");
			return;
		}
		form = document.paymentForm;
		form.opt1.value = cd1;//�����ڵ� L1
		form.policy.value = cd2;//���ǹ�ȣ
		form.regdate.value = cd3;//��������
		form.indate.value = cd3;
		form.cash.value = cd4;//�ݾ�
		form.bnkclt.value = cd5;//�������ֹ�
		form.bnkcode.value = cd6;//�����ڵ�
		form.bnkacct.value =  cd7;//���¹�ȣ
		form.sndseq.value = cd8;//���۹�ȣ

		//if(form.process.value == "L")
		//{
			if (confirm('���� ó�� �Դϴ�.\n\n���� ó���� �Ͻðڽ��ϱ�?'))
			{
				form.process.value = "K";
				form.action = "pl_payment_info.do";
				form.submit();
			}
			else
			{
				return;
			}
		//}
	}

	function getResult(cd1, cd2, cd3, cd4, cd5, cd6, cd7,cd8)
	{
		if ("<%=deathResult%>" == "1") {
			if(!confirm("������ ��ȸ�κ��� ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "2") {
			if(!confirm("������ ��ȸ�κ��� �Ǻ����� ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}
		if ("<%=deathResult%>" == "3") {
			if(!confirm("������ ��ȸ�κ��� ������ ������� ��ϵ� ��� �Դϴ�. \n ���� Ȯ�� �� ���� �ٶ��ϴ�. \n\n ó���Ͻðڽ��ϱ�?"))  {
				return;
			}
		}


		form = document.paymentForm;
		form.opt1.value = cd1;//�����ڵ� L1
		form.policy.value = cd2;//���ǹ�ȣ
		form.regdate.value = cd3;//��������
		form.indate.value = cd3;
		form.cash.value = cd4;//�ݾ�
		form.bnkclt.value = cd5;//�������ֹ�
		form.bnkcode.value = cd6;//�����ڵ�
		form.bnkacct.value =  cd7;//���¹�ȣ
		form.sndseq.value = cd8;//���۹�ȣ


		if (confirm('�������Դϴ�.\n\n�����ȸ�� �а��� �Ͻðڽ��ϱ�?'))
		{
			form.process.value = "K";
			form.action = "pl_payment_info.do";
			form.submit();
		}
		else
		{
			return;
		}

	}


	function init(){

		//parent.heightControl( "act_frame1", "600", document.getElementById('otable').offsetHeight );
<%
    if(payment.getText("rslt").trim().equals("0") == false
    && ("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd))) {
%>
        var varMessage     = "";
        varMessage += "<%=otherSystemStatus.getText("capsil_message"    )%>";
        varMessage += "<%=otherSystemStatus.getText("image_message"     )%>";
        varMessage += "<%=otherSystemStatus.getText("callcenter_message")%>";

        if(varMessage != "") {
            alert(varMessage.replace(/\<br>/g,"\n"));
        }
<%
    }
%>
	}

	function windowClose(){


		window.opener.goSuccess();
		self.close();
	}

//-->
</script>

</head>

<body onload="init();<%if( process.equals("L") ){%>goTimeout('<%=payment.getText("rslt")%>')<%}%>" >
<table width="980">
<tr>
<td colspan="2" height="10"></td>
</tr>
<tr>
<td width="10"></td>
<td>
<form name="paymentForm"  method="post">
<input type="hidden" name="policy" value="<%=policy%>">
<input type="hidden" name="deptcd" value="<%=deptcd%>">
<input type="hidden" name="init" value="<%=init%>">
<input type="hidden" name="ssn" value="<%=ssn%>">
<input type="hidden" name="policy_apln_no" value="<%=policy_apln_no%>">

<input type="hidden" name="sbkcda" value="<%=sbkcda%>">
<input type="hidden" name="sbknoa" value="<%=sbknoa%>">
<input type="hidden" name="pyrna"  value="<%=pyrna%>">

<input type="hidden" name="opt1"  value="<%=opt1%>">
<input type="hidden" name="regdate"  value="<%=regdate%>">
<input type="hidden" name="cash"  value="<%=cash%>">
<input type="hidden" name="indate"  value="<%=indate%>">
<input type="hidden" name="bnkclt"  value="<%=bnkclt%>">
<input type="hidden" name="bnkcode"  value="<%=bnkcode%>">
<input type="hidden" name="bnkacct"  value="<%=bnkacct%>">
<input type="hidden" name="process"  value="<%=process%>">
<input type="hidden" name="returnurl"  value="/payment/pl_payment_info.do">
<input type="hidden" name="bnkyn"  value="<%=bnkyn%>">
<input type="hidden" name="sndseq">

<!-- �ߺ���û ����. saveToken �̿� -->
<INPUT type="hidden" name="org.apache.struts.taglib.html.TOKEN" value="<%=session.getAttribute("org.apache.struts.action.TOKEN")%>" >

<!--table width="100%" height="100%">
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
						<!--jsp:include page="/common/dropDown.jsp" flush="true">
						<jsp:param name="menu_mode" value="1"/>
						</jsp:include>
						<!--DropDown ���� : E-->
					<!--/td>
							<td class="contents"-->

<!-- �α��� ���θ� ���� üũ�Ѵ�. ����    : ��ȭ���� ����Ʈȭ�� ������ ���鼭.. �α��ο��� üũ�� ���� ����ȭ�鿡�� üũ�Ѵ�.-->
<%

	String islogin = "";
	if( emp_no.equals("") || emp_no.equals("null") )
	{
		islogin = "N";
	}
%>


<script language="javascript">

<%
	if( islogin.equals("N"))
	{
%>
		opener.location.href="/payment/cyber_login.do";
		self.close();
<%
	}
	%>
</script>
<!-- �α��� ���θ� ���� üũ�Ѵ�. ��-->

							<table width="100%" id="otable">
							<tr>
								<td><img src="/img/common/title_01.gif"></td>
							</tr>
							<tr>
								<td height="10" background="/img/common/title_bg.gif"></td>
							</tr>
							<tr>
								<td height="14"></td>
							</tr>
							<tr>
								<td> <table width="100%">
										<tr>
											<td><img src="/img/common/bu_cir01.gif">
												<b>�����������</b> </td>
											<td align="right">
											<!-- 2006.12.27 ������  0602294 ���̹� ������ ȭ�� ���� -->
<!--a href="/receipt/policy_view.do?searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">

											<img src="/img/common/btn_list.gif" hspace="10" border="0"></a-->

											<a href="javascript:windowClose();"><img src="/img/common/btn_close.gif" hspace="10" border="0"></a>
											</td>
										</tr>
									</table></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td><table width="100%">
										<tr>
											<td width=250 valign="top" style="padding-right: 10px;"><table width="100%" class="adm_table">
<%
													String bcashvl = "";//����ؾ�ȯ�ޱ�
													String refnprm = "";//�̰�������
													String val_pua = "";//�߰��ϳ�����
													String acu_div = "";//�ѹ�翹ġ��
													String acc_div = "";//��ġ������
													String pdffund = "";//PDF
													String acrdpdf = "";//PDF����
													String tot_amt = "";//���޾�
													String pl_prin = "";//��������
													String pl_int  = "";//��������
													String apl_amt = "";//apl�����
													String ard_apl = "";//apl��������
													String red_amt = "";//������
													String act_amt = "";//�����޾�

													bcashvl = plpaymentinfo.getText("bcashvl",0).trim();
													refnprm = plpaymentinfo.getText("refnprm",0).trim();
													val_pua = plpaymentinfo.getText("val_pua",0).trim();
													acu_div = plpaymentinfo.getText("acu_div",0).trim();
													acc_div = plpaymentinfo.getText("acc_div",0).trim();
													pdffund = plpaymentinfo.getText("pdffund",0).trim();
													acrdpdf = plpaymentinfo.getText("acrdpdf",0).trim();
													tot_amt = plpaymentinfo.getText("tot_amt",0).trim();
													pl_prin = plpaymentinfo.getText("pl_prin",0).trim();
													pl_int = plpaymentinfo.getText("pl_int",0).trim();
													apl_amt = plpaymentinfo.getText("apl_amt",0).trim();
													ard_apl = plpaymentinfo.getText("ard_apl",0).trim();
													red_amt = plpaymentinfo.getText("red_amt",0).trim();
													act_amt = plpaymentinfo.getText("act_amt",0).trim();

													String banknm1 = "";
													String bankcd1 = "";
													String banknm2 = "";
													String bankcd2 = "";
%>
													<tr class="adm15">
														<th>����ؾ�ȯ�ޱ�</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(bcashvl)%>"></td>
													</tr>
													<tr class="adm15">
														<th>�̰�������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(refnprm)%>"></td>
													</tr>
													<tr class="adm15">
														<th>�߰��ϳ�����</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(val_pua)%>"></td>
													</tr>
													<tr class="adm15">
														<th>�ѹ�翹ġ��</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acu_div)%>"></td>
													</tr>
													<tr class="adm15">
														<th>��ġ������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acc_div)%>"></td>
													</tr>
													<tr class="adm15">
														<th>PDF</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pdffund)%>"></td>
													</tr>
													<tr class="adm15">
														<th>PDF����</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(acrdpdf)%>"></td>
													</tr>
													<tr class="adm15">
														<th>���޾�</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(tot_amt)%>"></td>
													</tr>
													<tr class="adm15">
														<th>��������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pl_prin)%>"></td>
													</tr>
													<tr class="adm15">
														<th>��������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(pl_int)%>"></td>
													</tr>
													<tr class="adm15">
														<th>APL�����</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(apl_amt)%>"></td>
													</tr>
													<tr class="adm15">
														<th>APL��������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(ard_apl)%>"></td>
													</tr>
													<tr class="adm15">
														<th>������</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(red_amt)%>"></td>
													</tr>
													<tr class="adm15">
														<th>�����޾�</th>
														<td><input type="text" name="textfield" class="box03"  style="text-align:right" readonly value="<%=Util.addComma(act_amt)%>"></td>
													</tr>
												</table></td>
											<td><table width="100%">
													<tr>
														<td height="40" valign="top"><table width="100%">
																<tr>
																	<td background="/img/edit/subtitle_bg.gif">
																		<table height="31" class="subtitle">
																			<tr>
																				<td class="subleft"><a href="pl_payment_search.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">�����ȸ</a></td>
																				<td class="select">���⺻����</td>
																				<td><a href="pl_payment_list.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">������⳻��</a></td>
																				<th>|</th>
																				<td><a href="pl_payment_paidup.do?policy_apln_no=<%=policy_apln_no%>&ssn=<%=ssn%>&policy=<%=policy%>&searchgubun=<%=searchgubun%>&current=<%=current%>&fromdate=<%=fromdate%>&todate=<%=todate%>&fromamt=<%=fromamt%>&toamt=<%=toamt%>&modeind=<%=modeind%>&srvc_ind=<%=srvc_ind%>&rslt=<%=rslt%>&search=<%=search%>&key=<%=key%>" onFocus="blur()">�����ޱݳ���</a></td>
																			</tr>
																		</table></td>
																	<td class="subright"></td>
																</tr>
															</table></td>
													</tr>
													<tr>
														<td><table width="100%" class="adm_table">
																<col width=15%><col width=> <col width=15%><col width=> <col width=15%><col width=>
																<tr class="adm11">
																	<th height="33">���ǹ�ȣ</th>
																	<td><%=userinfo.getText("plyno")%></td>
																	<th>��ǰ��</th>
																	<td><%=userinfo.getText("plnname")%></td>
																	<th>�����</th>
<%
																	String issdatet = userinfo.getText("issdate").trim();
																	if(issdatet.length() >7)
																	{
																		issdatet = issdatet.substring(0,4) +"."+ issdatet.substring(4,6) +"."+ issdatet.substring(6,8);
																	}
%>
																	<td><%=issdatet%></td>
																</tr>
																<tr class="adm11">
																	<th>�����</th>
																	<td><%=userinfo.getText("ownna")%></td>
																	<th>�Ǻ�����</th>
																	<td><%=userinfo.getText("insna")%></td>
<%
																	//����� issdte, ����Ⱓ insprd
																	//20060607 ����üũ
																	String issdate = "";
																	if(userinfo.getText("issdate").length() >3){
																		issdate = userinfo.getText("issdate").substring(0,4).trim();
																	}

																	String insprd = "";
																	//20060607 ����üũ
																	if(userinfo.getText("issdate").length() >7){
																		insprd = Integer.toString( Integer.parseInt(issdate) + Integer.parseInt(userinfo.getText("insprd").trim()) );
																		insprd = insprd +"."+ userinfo.getText("issdate").substring(4,6)+"."+userinfo.getText("issdate").substring(6,8);
																	}

%>
																	<th>����Ⱓ</th>
																	<td><%=insprd%></td>
																</tr>
																<tr class="adm11">
																	<th>���ԱⰣ</th>
<%
																	//����� issdte, ���ԱⰣ pydprd
																	//20060607 ����üũ
																	String cissdate = "";
																	if(userinfo.getText("issdate").length() >3){
																		cissdate = userinfo.getText("issdate").substring(0,4).trim();
																	}

																	String pydprd = "";
																	//20060607 ����üũ
																	if(userinfo.getText("issdate").length() >7){
																		pydprd = Integer.toString(Integer.parseInt(cissdate) + Integer.parseInt(userinfo.getText("pydprd").trim()));
																		pydprd = pydprd +"."+ userinfo.getText("issdate").substring(4,6)+"."+userinfo.getText("issdate").substring(6,8);
																	}
%>

																	<td><%=pydprd%></td>
																	<th>�����ֱ�</th>
<%
																	String modx = userinfo.getText("modx");
																	if(modx.equals("01"))
																	{
																		modx = "����";
																	}
																	else if(modx.equals("03"))
																	{
																		modx = "3������";
																	}
																	else if(modx.equals("06"))
																	{
																		modx = "6������";
																	}
																	else if(modx.equals("12"))
																	{
																		modx = "����";
																	}
																	else
																	{
																		modx = "";
																	}
%>
																	<td><%=modx%></td>
																	<th>���Թ��</th>

<%
																	String method = userinfo.getText("method");
																	if(method.equals("D"))
																	{
																		method = "�ڵ���ü";
																	}
																	else if(method.equals("G"))
																	{
																		method = "��������";
																	}
																	else if(method.equals("F"))
																	{
																		method = "���γ���";
																	}
																	else if(method.equals("E"))
																	{
																		method = "�湮����";
																	} else
																	{
																		method = "��Ÿ";
																	}
%>
																	<td><%=method%></td>
																</tr>
																<tr class="adm12">
																	<th>�����</th>
																	<td align="right"><%=Util.addComma(userinfo.getText("modprem").trim())%></td>
																	<th>������/Ƚ��</th>
<%
																	String lstpdat = userinfo.getText("lstpdat").trim();
																	if(lstpdat.length() >= 6)
																		lstpdat = userinfo.getText("lstpdat").trim().substring(0,4) + "." + userinfo.getText("lstpdat").trim().substring(4,6);
%>
																	<td class="le"><%=lstpdat%>/<%=userinfo.getText("pdcnt").trim()%></td>
																	<th>�ⳳ�Ժ����</th>
																	<td><%=Util.addComma(userinfo.getText("accprem").trim())%></td>
																</tr>
																<tr class="adm12">
																	<th>���������</th>
                                    												<td><%=Util.addComma(userinfo.getText("pdf").trim())%>                                     												</td>
																	<th>��ȿ����</th>
<%
																	String nfopt = userinfo.getText("nfopt").trim();

																	if(nfopt.equals("Y") || nfopt.equals("y"))
																	{
																		nfopt = "��û";
																	}
																	else if(nfopt.equals("N") || nfopt.equals("n"))
																	{
																		nfopt = "�̽�û";
																	}
																	else
																	{
																		nfopt = "��Ÿ";
																	}
%>
																	<td class="le"><%=nfopt%></td>
																	<th>���ⳳ��</th>
<%
																	String ptd = userinfo.getText("ptd").trim();
																	if(ptd.length() >= 8)
																		ptd = ptd.substring(0,4) + "." + ptd.substring(4,6) +"." + ptd.substring(6,8);
%>
																	<td class="le"><%=ptd%></td>
																</tr>
																<tr class="adm11">
																	<th>�ݵ�����</th>
																	<td><%=userinfo.getText("fund").trim()%></td>
																	<th>���з�</th>
																	<td>N</td>
																	<th>���LP</th>
																	<td><%=userinfo.getText("svclpname").trim()%></td>
																</tr>
															</table></td>
													</tr>
													<tr>
														<td>&nbsp;</td>
													</tr>
													<tr>
														<td><img src="/img/common/bu_cir02.gif">
															<b>�ڵ���ü ����</b></td>
													</tr>
													<tr>
														<td><table width="100%" class="adm_table">
																<col width=20%><col width=30%><col width=20%><col width=30%>
																<tr class="adm11">
																	<th>������</th>
																	<td><%=userinfo.getText("payna").trim()%></td>
																	<th>��ü��</th>
<%
																	String fbsday = userinfo.getText("fbsday").trim();
																	if(fbsday.equals("30") || fbsday.equals("31"))
																	{
																		fbsday = "��";
																	}
%>
																	<td><%=fbsday%>��</td>
																</tr>
																<tr class="adm11">
																	<th>����</th>
																	<%	banknm2 = userinfo.getText("bank_name").trim();
																		bankcd2 = userinfo.getText("bank_cd").trim();
																	//2006.10.04 : �躸�� : �ѱ���Ƽ����(27, 53->27), �츮����(83, 20->20), ��������(21, 26->88), ����(11~17)
																	if(bankcd2.equals("53")){
																		bankcd2 = "27";
																		banknm2 = "�ѱ���Ƽ����";
																	}else if(bankcd2.equals("83")){
																		bankcd2 = "20";
																		banknm2 = "�츮����";
																	}else if(bankcd2.equals("21")||bankcd2.equals("26")){
																		bankcd2 = "88";
																		banknm2 = "��������";
																	}else if(bankcd1.equals("11")||bankcd1.equals("12")||bankcd1.equals("13")||bankcd1.equals("14")||bankcd1.equals("15")||bankcd1.equals("16")||bankcd1.equals("17")){
																		banknm1 = "����";
																	}
																	/*else if(bankcd2.equals("04")){
																		bankcd2 = "04";
																		banknm2 = "����������";
																	}*/
																	%>
																	<td><%=banknm2%></td>
																	<th>���¹�ȣ</th>
																	<td><%=userinfo.getText("bankacc").trim()%></td>
																</tr>
															</table></td>
													</tr>
													<tr>
														<td height="5" background="/img/common/line.gif"></td>
													</tr>
													<tr>
														<td>&nbsp;</td>
													</tr>
													<tr>
														<td><img src="/img/common/bu_cir02.gif">
															<b>����û��������</b></td>
													</tr>
													<tr>
														<td><table width="100%" class="adm_table">
																<col width=20%><col width=30%><col width=20%><col width=30%>
																<tr class="adm21">
																	<th>��û����</th>
																	<td><%=payment.getText("apln_dt").trim()%> </td>
																	<th>����</th>
																	<%	banknm1 = payment.getText("bank_name").trim();
																		bankcd1 = payment.getText("bank_cd").trim();
																	//2006.10.04 : �躸�� : �ѱ���Ƽ����(27, 53->27), �츮����(83, 20->20), ��������(21, 26->88), ����(11~17)
																	if(bankcd1.equals("53")){
																		bankcd1 = "27";
																		banknm1 = "�ѱ���Ƽ����";
																	}else if(bankcd1.equals("83")){
																		bankcd1 = "20";
																		banknm1 = "�츮����";
																	}else if(bankcd1.equals("21")||bankcd1.equals("26")){
																		bankcd1 = "88";
																		banknm1 = "��������";
																	}else if(bankcd1.equals("11")||bankcd1.equals("12")||bankcd1.equals("13")||bankcd1.equals("14")||bankcd1.equals("15")||bankcd1.equals("16")||bankcd1.equals("17")){
																		banknm1 = "����";
																	}
																	/*else if(bankcd1.equals("04")){
																		bankcd1 = "04";
																		banknm1 = "����������";
																	}*/
																	%>
																	<td><%=banknm1%></td>
																</tr>
																<tr class="adm21">
																	<th>��û����</th>
																	<td><%=payment.getText("pay_cd").trim()%></td>
																	<th>������</th>
																	<td><%=payment.getText("acct_nm").trim()%></td>
																</tr>
																<tr class="adm21">
																	<th>��û�ݾ�</th>
																	<td class="adm21"><%=Util.addComma(payment.getText("apln_amt"))%></td>
																	<th>���¹�ȣ </th>
																	<td><%=payment.getText("acct_no").trim()%></td>
																</tr>
																<tr class="adm21">
																	<th>����ó</th>
<%
																	String payor_phone = "";
																	payor_phone =  payment.getText("payor_phone").trim();
																	if(payor_phone.substring(0,2).equals("01"))
																	{

																		payor_phone = Util.to_Cell(payor_phone);
																	}
																	else
																	{
																		payor_phone = Util.toTel(payor_phone);
																	}
%>
																	<td><%=payor_phone%></td>
																	<th>E-Mail</th>
																	<td><%=payment.getText("payor_email").trim()%></td>
																</tr>
																<tr class="adm21">
																	<th>����</th>
<%
																	String rsltname = "";
																	rsltname = payment.getText("rslt").trim();
																	if(rsltname.equals("0"))
																	{
																		rsltname = "����";
																	}
																	else if(rsltname.equals("1"))
																	{
																		rsltname = "�ݼ�";
																	}
																	else if(rsltname.equals("2"))
																	{
																		rsltname = "����";
																	}
																	else if(rsltname.equals("3"))
																	{
																		rsltname = "����";
																	}
																	else if(rsltname.equals("A"))
																	{
																		rsltname = "ó����";
																	}
																	else
																	{
																		rsltname = "����";
																	}
%>
																	<td><input type="text" name="rsltname"  value="<%=rsltname%>" size="14" maxlength="10"  style="background-color:white; border-width:0; border-color:black; border-style:solid;" readonly >
																	</td>
																	<th><a href="javascript:bankconfc('<%=bankcd1%>','<%=payment.getText("acct_no")%>','<%=payment.getText("payor_ssn")%>');" onFocus="blur()"><u>������Ȯ��</u></a></th>
<%
																	String bankconfc = "N";
																	String wbbank = "";
																	wbbank = payment.getText("bank_conf_yn");
																	if(bnkyn.equals("0") || wbbank.equals("Y"))
																	{
																		bankconfc = "Ȯ��";
																	}
																	else
																	{
																		bankconfc = "��Ȯ��";
																	}%>
																	<td><%=bankconfc%></td>															</tr>
															</table></td>
													</tr>
													<tr>
														<td align="right">
<%
                                                String strAplnDt = Util.nvl(Utility.replaceStr(payment.getText("apln_dt").trim(), ".", ""), "0");
                                                if("".equals(strAplnDt)) strAplnDt = "0";
												//2005-10-10. 05-C-138. ������. ������� ����ȭ
                                                                                                //if(payment.getText("auth_cd").equals("20") || payment.getText("auth_cd").equals("30"))
                                                                                                if(payment.getText("auth_cd").equals("20") || payment.getText("auth_cd").equals("30") || payment.getText("auth_cd").equals("31") || payment.getText("auth_cd").equals("32") || payment.getText("auth_cd").equals("33"))
												{

															if(payment.getText("rslt").trim().equals("") || payment.getText("rslt").equals("A"))
															{
%>
														<!--a href="javascript:getLoan()" onFocus="blur()"><img src="/img/common/btn_inquirys.gif" border="0"></a-->
														<a href="javascript:goReturn('<%=payment.getText("policy_apln_no")%>');" onFocus="blur()"><img src="/img/common/btn_return.gif" hspace="10"></a>
<%
															}
															else if(payment.getText("rslt").trim().equals("3"))
															{
                                                                // ���״����̰� D+2������ �̳����� ������ ����.
                                                                if(("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd)) &&
                                                                    Integer.parseInt(working2after) > Integer.parseInt(Utility.getToday("yyyyMMdd")) && Integer.parseInt(strAplnDt) > 20080102) {
                                                                    // ��ư ������ ����.
                                                                }else {
%>
														<a href="javascript:getResult('L1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>','<%=payment.getText("sending_num")%>')" onFocus="blur()"><img src="/img/common/btn_sbun.gif" border="0"></a>
<%
                                                                }
%>
														<a href="javascript:goReturn('<%=payment.getText("policy_apln_no")%>');" onFocus="blur()"><img src="/img/common/btn_return.gif" hspace="10"></a>
<%
															}
															else if(payment.getText("rslt").trim().equals("2"))
															{
%>
														<a href="javascript:returnFalseMsg('<%=payment.getText("policy_apln_no")%>');" onFocus="blur()"><img src="/img/common/btn_sms_email_send.gif" hspace="10"></a>

														<a href="javascript:goReturn('<%=payment.getText("policy_apln_no")%>');" onFocus="blur()"><img src="/img/common/btn_return.gif" hspace="10"></a>
<%
															}


													/***************** �����Ⱑ�ɱݾ�>=��û�ݾ� : �����û �� ���ν� - S *********************/
													int loanval    = 0;//�����ϱ��� �����Ⱑ�ɱݾ� 70%
													int loanval80  = 0;//ó���ϱ��� �����Ⱑ�ɱݾ� 80%
													int loanval100 = 0;//ó���ϱ��� �����Ⱑ�ɱݾ� 100%
													// �����ϱ���
													for(int i=0;i<plpaymentApln.getCount("rid_nam");i++)
													{
														loanval   = loanval  + Integer.parseInt(plpaymentApln.getText("loanval",i).trim());
													}
													// ó���ϱ���
													for(int i=0;i<plpayment.getCount("rid_nam");i++)
													{
														loanval80   = loanval80  + Integer.parseInt(plpayment.getText("loanval80" ,i).trim());
														loanval100  = loanval100 + Integer.parseInt(plpayment.getText("loanval100",i).trim());
													}
													int amt1 = loanval;//�����ϱ��� �����Ⱑ�ɱݾ� 70%
													int amt2 = loanval80;//ó���ϱ��� �����Ⱑ�ɱݾ� 80%
													int amt3 = Integer.parseInt(payment.getText("apln_amt"));//��û�ݾ�
													int amt4 = loanval100;//ó���ϱ��� �����Ⱑ�ɱݾ� 100%

													// ���״����ϰ�� �ݾ�üũ�� ���� ����.
													if( amt1 >= amt3 || ("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd)))
													{
                                                        // ���״����̰� D+2������ �̳����� ������ ����.
                                                        if(("51".equals(plancd) || "53".equals(plancd) || "54".equals(plancd) || "55".equals(plancd) || "56".equals(plancd)) 
                                                        && Integer.parseInt(strAplnDt) > 20080102
                                                        && (Integer.parseInt(working2after) > Integer.parseInt(Utility.getToday("yyyyMMdd")) || amt1 < amt3 || amt2 < amt3)) {
                                                            // 0800133 �Ⱥ��� : �����ϰ�� ����ó���� �Ҽ� �ֵ��� ó�� M018SP1 -> M018SP5 �� �����Ҽ��ֵ��� ������.
                                                            // ������ ���� 2������ ������ ��� ���ι�ư�� �Ⱥ��̴� ��� ����ó�� �Ҽ� ����.
                                                            if(Integer.parseInt(working2after) <= Integer.parseInt(Utility.getToday("yyyyMMdd"))
                                                            && (payment.getText("auth_cd").trim().equals("30") || payment.getText("auth_cd").trim().equals("31") || payment.getText("auth_cd").trim().equals("32") || payment.getText("auth_cd").trim().equals("33"))
                                                            && payment.getText("rslt").trim().equals("A")) {
                                                                // ��û�ݾ��� ó���ϱ��� �����Ⱑ�ɱݾ� 100%���� ���ų� �۾ƾ� ����ó�� �Ҽ� ����.
                                                                if(amt3 <= amt4) {
%>
																<img src="/img/common/btn_constraint.gif"  style="cursor: hand;" id="btn1" onClick="goProcess('L1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')">
																<input type="hidden" name="variable_div" value="Y">
<%
                                                                }
                                                            // ������ ���� 2������ ������ ��� ���ι�ư�� �Ⱥ��̴� ��� ����ó�� �Ҽ� ����.
                                                            } else if(Integer.parseInt(working2after) <= Integer.parseInt(Utility.getToday("yyyyMMdd"))
                                                                   && (payment.getText("auth_cd").trim().equals("30") || payment.getText("auth_cd").trim().equals("31") || payment.getText("auth_cd").trim().equals("32") || payment.getText("auth_cd").trim().equals("33"))
                                                                   && payment.getText("rslt").trim().equals("2") == false
                                                                   && payment.getText("rslt").trim().equals("1") == false
                                                                   && payment.getText("rslt").trim().equals("0") == false
                                                                   && payment.getText("rslt").trim().equals("3") == false
                                                                   && payment.getText("rslt").trim().equals("A") == false) {
%>
																<img src="/img/common/btn_money.gif"  style="cursor: hand;" id="btn2" onClick="javascript:goRecogn('<%=payment.getText("policy_apln_no")%>','L1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')">
<%
                                                            // ��ư ������ ����.
                                                            } else {
%>
													&nbsp;
<%
                                                            }
                                                        }else {
															//����
															//2005-10-10. 05-C-138. ������. ������� ����ȭ
															//if((payment.getText("auth_cd").trim().equals("30") && payment.getText("rslt").trim().equals("A")))
															if((payment.getText("auth_cd").trim().equals("30") || payment.getText("auth_cd").trim().equals("31") || payment.getText("auth_cd").trim().equals("32") || payment.getText("auth_cd").trim().equals("33")) && payment.getText("rslt").trim().equals("A"))
															{
%>
															<img src="/img/common/btn_recognize.gif"  style="cursor: hand;" id="btn1" onClick="goProcess('L1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')">
<%
															}
															//�����û
															else if(payment.getText("rslt").trim().equals("2") || payment.getText("rslt").equals("1") || payment.getText("rslt").equals("0") || payment.getText("rslt").equals("3"))
															{
%>
																&nbsp;
<%
															}
															else if(!payment.getText("rslt").trim().equals("A"))
															{
%>
															<img src="/img/common/btn_money.gif"  style="cursor: hand;" id="btn2" onClick="javascript:goRecogn('<%=payment.getText("policy_apln_no")%>','L1','<%=payment.getText("policy_no")%>','<%=payment.getText("indate").trim()%>','<%=trans.fillZero(payment.getText("apln_amt"),11)%>','<%=payment.getText("payor_ssn")%>','<%=bankcd1%>','<%=payment.getText("acct_no").trim()%>')">
<%
															}
														}
													}
													/***************** �����Ⱑ�ɱݾ�>=��û�ݾ� : �����û �� ���ν� - E *********************/
												}
												else
												{
%>
													&nbsp;
<%
												}
%>														</td>
												</tr>
													<tr>
														<td height="10"></td>
													</tr>
													<tr>
														<td height="5" background="/img/common/line.gif"></td>
													</tr>
													<tr>
														<td>&nbsp;</td>
													</tr>
													<tr>
														<td><table width="100%" class="adm_table">
																<col width=20%><col width=>
																<tr class="adm16">
																	<th>ó�����</th>
<%
																String errmsg1 = "";
																if(process.equals("Y"))
																{
																	errmsg1 = approval.getText("errmsg1").trim() + "- " + approval.getText("errmsg2").trim();
																}

																//WB_PAYMENT���� err_msg�� ������
																if(errmsg1.length() == 0)
																{
																	errmsg1 = payment.getText("err_msg");
																}
%>

																	<td><input name="errmsg" type="text" class="box10" value="<%=errmsg1%>"></td>
																</tr>
															</table></td>
													</tr>
												</table></td>
										</tr>
									</table></td>
							</tr>
							<tr>
								<td height="50">&nbsp;</td>
							</tr>
						</table><!--/td>
				</tr>
			</table></td>
	</tr>
	<tr>
		<td height="56" background="/img/common/copy_bg.gif"><img src="/img/common/copy.gif"></td>
	</tr>
</table-->
</form>
</td>
</tr>
</table>
</body>
</html>
<%
	} catch (Exception e) {
		System.err.println(e.toString());
		e.printStackTrace();
	}
%>
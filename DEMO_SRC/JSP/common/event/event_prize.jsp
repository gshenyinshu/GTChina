<%@ page import = "gtone.changeminer.common.constant.*, gtone.changeminer.common.manager.SessionManager, java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%
	String prudomain = gtone.changeminer.common.utility.Variable.get("pruhome.url");
%>
<jsp:useBean id="trans" 	class="anyframe.util.StringFormater" scope="request"/>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript">
<!--
function select(applyweek) {
	var f = document.eventForm;
	if (confirm("�ѹ� ��÷�ϰ� ���� ����ϱⰡ �Ұ����մϴ�. ���� ��÷�Ͻðڽ��ϱ�?")) {
		f.applyweek.value = applyweek;
		f.action = '/common/event/event_prize.do?run=select';
		f.submit();
	}
}
function view(applyweek) {
	var f = document.eventForm;
	f.applyweek.value = applyweek;
	window.open("http://www.gtone.co.kr/customer/pruevent_cyber2007_luckywpop.jsp?applyweek="+applyweek,'SmallBox','toolbar=no,location=yew,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width=600,height=500');	


}
//-->
</script>
</head>
<%
String[] weekTerm = {"","7�� 9�� ~ 7�� 15�ϱ���","7�� 16�� ~ 7�� 22�ϱ���","7�� 23�� ~ 7�� 29�ϱ���","7�� 30�� ~ 8�� 5�ϱ���","8�� 7�� ~ 8�� 12�ϱ���","8�� 13�� ~ 8�� 19�ϱ���","8�� 20�� ~ 8�� 26�ϱ���","8�� 27�� ~ 9�� 2�ϱ���","9�� 3�� ~ 9�� 9�ϱ���","9�� 10�� ~ 9�� 16�ϱ���"};
%>
<body>
<form name="eventForm"  method="post">
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
						<jsp:param name="menu_mode" value="7"/>
						</jsp:include>
						<!--DropDown ���� : E-->
					</td>
							<td class="contents"><table width="100%">
							<tr> 
							<td><b><font size='3' color='red'>������ �̿ܿ��� ���� �ǵ帮�� ������. ����!!</font></b></td>
							</tr>
							</table>
							<table width="100%">
							<tr> 
								<td><!--img src="/img/common/title_07.gif"-->���̹� �̺�Ʈ</td>
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
												<b>��÷�ϱ�</b> </td>
											<td align="right"></td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
								<td>
									<table width="100%" class="adm_table">
                                                                      <tr>
                                                                        <th width="10%">�����ְ�</th>
                                                                        <th width="60%">�Ⱓ</th>
                                                                        <th width="15%">��÷�ϱ�</th>
                                                                        <th width="15%">�������</th>
                                                                      </tr>
<%
	for (int i=1;i<=10;i++) {
%>
                                                                   <tr class="adm01">
									<td><%=i+"����"%></td>
									<td><%=weekTerm[i]%></td>
                                                                        <td><b><a href="javascript:select('<%=i%>')">select</a></b></td>
									<td><b><a href="javascript:view('<%=i%>')">view</a></b></td>
                                                                      </tr>
<%
	}
%>

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
<input type='hidden' name='applyweek'>
</form>
</body>
</html>



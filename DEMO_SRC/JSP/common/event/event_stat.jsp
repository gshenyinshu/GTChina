<%@ page import = "gtone.changeminer.common.constant.*, gtone.changeminer.common.manager.SessionManager, java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<jsp:useBean id="applystat" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="fromdate" 	class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" 	class="java.lang.String" scope="request"/>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='/common/js/menu_on.js'></script>
<script language='javascript' src='/common/js/common.js'></script>
<script language="javascript">
<!--
function select() {
	var f = document.form;
	f.action = '/common/event/event_stat.do?run=list';
	f.submit();
}
//-->
</script>
</head>
<%
String[] weekTerm = {"","7�� 7�� ~ 7�� 13�ϱ���","7�� 14�� ~ 7�� 20�ϱ���","7�� 21�� ~ 7�� 27�ϱ���","7�� 28�� ~ 8�� 3�ϱ���","8�� 4�� ~ 8�� 10�ϱ���","8�� 11�� ~ 8�� 17�ϱ���","8�� 18�� ~ 8�� 24�ϱ���","8�� 25�� ~ 8�� 31�ϱ���","9�� 1�� ~ 9�� 7�ϱ���","9�� 8�� ~ 9�� 14�ϱ���","9�� 15�� ~ 9�� 21�ϱ���","9�� 22�� ~ 9�� 28�ϱ���"};
%>
<body>
<form name="form"  method="post">
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
												<b>����ڷ�</b> </td>
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
                                                                                <tr class="adm11">
                                                                                        <td><input type="text" name="fromdate" class="box02" size="8" maxlength="10" style="text-align:center" value="<%=fromdate%>" readonly>                                                                    
                                                                                                <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  >
                                                                                                -
                                                                                                <input type="text" name="todate" class="box02" size="8" maxlength="10" style="text-align:center" value = "<%=todate%>" readonly>
                                                                                                <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal1');"  >
                                                                                        </td>
                                                                                        <td><a href="javascript:select();" onFocus="blur()"><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a>
                                                                                        </td>

									</table>
								</td>
							</tr> 

							<tr> 
								<td>
									<table width="100%" class="adm_table">
                                                                      <tr>
                                                                        <th width="50%">������</th>
                                                                        <th width="50%">�̺�Ʈ ������Ȳ</th>
                                                                      </tr>
<%
	int totCnt = 0;
	String applydateStr = "";
	for (int i=0;i<applystat.getCount("applydate");i++) {
%>
                                                                   <tr class="adm01">
<%
totCnt+=Integer.parseInt(applystat.getText("applycnt",i).trim());
applydateStr= applystat.getText("applydate",i).trim();
if (applydateStr.length() == 8) {
	applydateStr = applydateStr.substring(0,4) + "��" + applydateStr.substring(4,6) + "��" + applydateStr.substring(6,8) + "��";
}
%>
									<td><%=applydateStr%></td>
									<td><%=applystat.getText("applycnt",i)%>&nbsp;��</td>
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
<div id="cal" style="position:absolute; z-index:1;
                     left:192px; top:195px; width:193px;  height:195px;
                     visibility:hidden">
    <iframe name='dalFrame'
            id='dalFrame'
            src="/common/cal.jsp?setDate=form.fromdate&divName=cal"
            width="183"
            height="175"
            marginwidth="0"
            marginheight="0"
            topmargin="0"
            frameborder="0"
            scrolling="no"></iframe>
</div>
<div id="cal1" style="position:absolute; z-index:1;
                     left:192px; top:195px; width:193px;  height:195px;
                     visibility:hidden">
            <iframe id='dalFrame1'
            src="/common/cal.jsp?setDate=form.todate&divName=cal1"
            width="183"
            height="175"
            marginwidth="0"
            marginheight="0"
            topmargin="0"
            frameborder="0"
            scrolling="no"> </iframe>
</div>
</form>
</body>
</html>


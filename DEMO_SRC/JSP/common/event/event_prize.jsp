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
	if (confirm("한번 추첨하고 나면 취소하기가 불가능합니다. 정말 추첨하시겠습니까?")) {
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
String[] weekTerm = {"","7월 9일 ~ 7월 15일까지","7월 16일 ~ 7월 22일까지","7월 23일 ~ 7월 29일까지","7월 30일 ~ 8월 5일까지","8월 7일 ~ 8월 12일까지","8월 13일 ~ 8월 19일까지","8월 20일 ~ 8월 26일까지","8월 27일 ~ 9월 2일까지","9월 3일 ~ 9월 9일까지","9월 10일 ~ 9월 16일까지"};
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
						<!--DropDown 삽입 : S-->
						<jsp:include page="/common/dropDown.jsp" flush="true">
						<jsp:param name="menu_mode" value="7"/>
						</jsp:include>
						<!--DropDown 삽입 : E-->
					</td>
							<td class="contents"><table width="100%">
							<tr> 
							<td><b><font size='3' color='red'>문석찬 이외에는 절대 건드리지 마세요. 위험!!</font></b></td>
							</tr>
							</table>
							<table width="100%">
							<tr> 
								<td><!--img src="/img/common/title_07.gif"-->사이버 이벤트</td>
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
												<b>추첨하기</b> </td>
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
                                                                        <th width="10%">응모주간</th>
                                                                        <th width="60%">기간</th>
                                                                        <th width="15%">추첨하기</th>
                                                                        <th width="15%">결과보기</th>
                                                                      </tr>
<%
	for (int i=1;i<=10;i++) {
%>
                                                                   <tr class="adm01">
									<td><%=i+"주차"%></td>
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



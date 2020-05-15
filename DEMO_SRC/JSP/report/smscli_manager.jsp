<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="file:///D|/cyber-admin/cyber_admin/common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='file:///D|/cyber-admin/cyber_admin/common/js/menu_on.js'></script>
</head>

<body>
<table width="100%" height="100%">
	<tr> 
		<td height=71><table width="100%" background="file:///D|/cyber-admin/cyber_admin/img/common/logo_bg.gif">
				<tr> 
					<td><img src="file:///D|/cyber-admin/cyber_admin/img/common/logo.gif"></td>
					<td align="right"><img src="file:///D|/cyber-admin/cyber_admin/img/common/logo_end.gif"></td>
				</tr>
			</table></td>
	</tr>
	<tr> 
		<td><table width=100% height="100%">
				<col width=200> 
				<tr> 
					<td align="center" class="menu">
						<!--DropDown 삽입 : S-->
						<jsp:include page="/common/dropDown.jsp" flush="true"></jsp:include>
						<!--DropDown 삽입 : E-->
					</td>
					<td class="contents"><table width="100%">
							<tr> 
								<td><img src="file:///D|/cyber-admin/cyber_admin/img/common/title_06.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="file:///D|/cyber-admin/cyber_admin/img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="14"></td>
							</tr>
							<tr> 
								<td> <table width="100%">
										<tr> 
											
                      <td><img src="file:///D|/cyber-admin/cyber_admin/img/common/bu_cir01.gif"> 
                        <b>SMS관리 (고객)</b></td>
											
                      <td align="right"><a href="#"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_add.gif" hspace="10"></a><a href="javascript:history.go(-1);"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_back.gif" hspace="10"></a><a href="#"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_lp.gif" width="49" height="19"></a></td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
								<td><table width="100%" class="adm_table">
										<col width=30><col width=100><col width=100><col width=><col width=70><col width=50> 
										<tr> 
											<th>발송</th>
											<th>업무명</th>
											<th>발송자</th>
											<th colspan="2">발송내용</th>
											<th>삭제</th>
										</tr>
										<tr class="adm01"> 
											<td><input type="checkbox" name="checkbox" value="checkbox" class="radio"></td>
											<td>고객정보변경</td>
											<td>지티원사이버</td>
											<td>XXX님께서 고객정보변경 [증번, 계약자명]</td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_replace.gif"></a></td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_del.gif"></a></td>
										</tr>
										<tr class="adm02"> 
											<td><input type="checkbox" name="checkbox" value="checkbox" class="radio"></td>
											<td>APL신청</td>
											<td>지티원사이버</td>
											<td>XXX님께서 자동대출납입 신청 [증번, 계약자명]</td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_replace.gif"></a></td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_del.gif"></a></td>
										</tr>
										<tr class="adm01"> 
											<td><input type="checkbox" name="checkbox" value="checkbox" class="radio"></td>
											<td>APL해지</td>
											<td>지티원사이버</td>
											<td>XXX님께서 고객정보변경 [증번, 계약자명]</td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_replace.gif"></a></td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_del.gif"></a></td>
										</tr>
										<tr class="adm02"> 
											<td><input type="checkbox" name="checkbox" value="checkbox" class="radio"></td>
											<td>납입주기변경</td>
											<td>지티원사이버</td>
											<td>XXX님께서 자동대출납입 신청 [증번, 계약자명]</td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_replace.gif"></a></td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_del.gif"></a></td>
										</tr>
										<tr class="adm01"> 
											<td><input type="checkbox" name="checkbox" value="checkbox" class="radio"></td>
											<td>2004/06/20</td>
											<td>지티원사이버</td>
											<td>XXX님께서 고객정보변경 [증번, 계약자명]</td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_replace.gif"></a></td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_del.gif"></a></td>
										</tr>
										<tr class="adm02"> 
											<td><input type="checkbox" name="checkbox" value="checkbox" class="radio"></td>
											<td>2004/06/20</td>
											<td>지티원사이버</td>
											<td>XXX님께서 자동대출납입 신청 [증번, 계약자명]</td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_replace.gif"></a></td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_del.gif"></a></td>
										</tr>
										<tr class="adm01"> 
											<td><input type="checkbox" name="checkbox" value="checkbox" class="radio"></td>
											<td>2004/06/20</td>
											<td>지티원사이버</td>
											<td>XXX님께서 고객정보변경 [증번, 계약자명]</td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_replace.gif"></a></td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_del.gif"></a></td>
										</tr>
										<tr class="adm02"> 
											<td><input type="checkbox" name="checkbox" value="checkbox" class="radio"></td>
											<td>2004/06/20</td>
											<td>지티원사이버</td>
											<td>XXX님께서 자동대출납입 신청 [증번, 계약자명]</td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_replace.gif"></a></td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_del.gif"></a></td>
										</tr>
										<tr class="adm01"> 
											<td><input type="checkbox" name="checkbox" value="checkbox" class="radio"></td>
											<td>2004/06/20</td>
											<td>지티원사이버</td>
											<td>XXX님께서 고객정보변경 [증번, 계약자명]</td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_replace.gif"></a></td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_del.gif"></a></td>
										</tr>
										<tr class="adm02"> 
											<td><input type="checkbox" name="checkbox" value="checkbox" class="radio"></td>
											<td>2004/06/20</td>
											<td>지티원사이버</td>
											<td>XXX님께서 자동대출납입 신청 [증번, 계약자명]</td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_replace.gif"></a></td>
											<td><a href="file:///D|/cyber-admin/cyber_admin/html/edit/ca_02.htm"><img src="file:///D|/cyber-admin/cyber_admin/img/common/btn_del.gif"></a></td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td align="center"><table>
										<tr> 
											<td width="26"></td>
											<td width="45"> <a href="#"><img src="file:///D|/cyber-admin/cyber_admin/img/common/paging_btn_prev.gif" alt="" border="0" align="absmiddle"></a></td>
											<td class="ce5"> | <span class="or01">1</span> 
												| <a href="javascript:goPage( '2' )" class="pg">2</a> 
												| <a href="javascript:goPage( '3' )" class="pg">3</a> 
												| <a href="javascript:goPage( '4' )" class="pg">4</a> 
												| <a href="javascript:goPage( '5' )" class="pg">5</a> 
												| <a href="javascript:goPage( '6' )" class="pg">6</a> 
												| <a href="javascript:goPage( '7' )" class="pg">7</a> 
												| <a href="javascript:goPage( '8' )" class="pg">8</a> 
												| <a href="javascript:goPage( '9' )" class="pg">9</a> 
												| <a href="javascript:goPage( '10' )" class="pg">10</a> 
												| </td>
											<td width="50" align="right"> <a href="#"><img src="file:///D|/cyber-admin/cyber_admin/img/common/paging_btn_next.gif" alt="" border="0" align="absmiddle"></a> 
											</td>
											<td width="30"></td>
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
		<td height="56" background="file:///D|/cyber-admin/cyber_admin/img/common/copy_bg.gif"><img src="file:///D|/cyber-admin/cyber_admin/img/common/copy.gif"></td>
	</tr>
</table>
</body>
</html>

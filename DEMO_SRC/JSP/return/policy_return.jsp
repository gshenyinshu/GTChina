<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
		<td height=71><table width="100%" background="../../img/common/logo_bg.gif">
				<tr> 
					<td><img src="../../img/common/logo.gif"></td>
					<td align="right"><img src="../../img/common/logo_end.gif"></td>
				</tr>
			</table></td>
	</tr>
	<tr> 
		<td><table width=100% height="100%">
				<col width=200> 
				<tr> 
					<td align="center" class="menu">
						<!--DropDown ���� : S-->
						<jsp:include page="/common/dropDown.jsp" flush="true"></jsp:include>
						<!--DropDown ���� : E-->
					</td>
					<td class="contents"><table width="100%">
							<tr> 
								<td><img src="../../img/common/title_05.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="../../img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="14"></td>
							</tr>
							<tr> 
								<td>
									<table width="100%">
										<tr> 
											<td><img src="../../img/common/bu_cir01.gif"> 
												<b>����ó�� �⺻ȭ��</b></td>
											<td align="right"><a href="javascript:history.go(-1);" onFocus="blur()"><img src="../../img/common/btn_back.gif" hspace="10"></a><a href="ca_02.htm" onFocus="blur()"><img src="../../img/common/btn_cord.gif"></a></td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
								<td><table width="100%" class="adm_table">
										<col width=10%><col width=25%><col width=25%><col width=><col width=><col width=> 
										<tr> 
											<th rowspan="2">�˻�����</th>
											<th>��������</th>
											<th>�ݼ�����</th>
											<th>�����з�</th>
											<th>���ΰ˻��׸�</th>
											<th>�˻��Է�</th>
										</tr>
										<tr class="adm11"> 
											<td><input type="text" name="textfield" class="box02"> 
												<img src="../../img/common/btn_cal.gif" align="absmiddle"> 
												- 
												<input type="text" name="textfield" class="box02"> 
												<img src="../../img/common/btn_cal.gif" align="absmiddle"> 
											</td>
											<td><input type="text" name="textfield" class="box02"> 
												<img src="../../img/common/btn_cal.gif" align="absmiddle"> 
												- 
												<input type="text" name="textfield" class="box02"> 
												<img src="../../img/common/btn_cal.gif" align="absmiddle"> 
											</td>
											<td><select name="select">
													<option selected>�������</option>
												</select></td>
											<td><select name="select">
													<option selected>��ü</option>
													<option>���ǹ�ȣ</option>
													<option>���̵�</option>
													<option>ó������</option>
													<option>ó����</option>
												</select></td>
											<td><input type="text" name="textfield" class="box04"> 
												<img src="../../img/common/btn_inquiry.gif" align="absmiddle"></td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
								<td><table width="100%" class="adm_table">
										<tr> 
											<th rowspan="2">N</th>
											<th rowspan="2">��������</th>
											<th rowspan="2">�����ð�</th>
											<th rowspan="2">���ǹ�ȣ</th>
											<th rowspan="2">�����</th>
											<th rowspan="2">������</th>
											<th rowspan="2">��û�ݾ�</th>
											<th rowspan="2">����</th>
											<th colspan="2" class="th2">�̸���</th>
											<th colspan="2" class="th2">SMS</th>
											<th rowspan="2">�ݼ�����</th>
											<th rowspan="2">�ݼ۽ð�</th>
											<th rowspan="2">ó����</th>
											<th rowspan="2">���LP</th>
											<th rowspan="2">����ID</th>
										</tr>
										<tr> 
											<th class="th2">����</th>
											<th class="th2">LP</th>
											<th class="th2">����</th>
											<th class="th2">LP</th>
										</tr>
										<tr class="adm01"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td>1</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>���ó���</td>
											<td>ȫ�浿</td>
											<td>abcdefg1234</td>
										</tr>
										<tr class="adm02"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td>1</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>���ó���</td>
											<td>ȫ�浿</td>
											<td>abcdefg1234</td>
										</tr>
										<tr class="adm01"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td>1</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>���ó���</td>
											<td>ȫ�浿</td>
											<td>abcdefg1234</td>
										</tr>
										<tr class="adm02"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td>2</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>���ó���</td>
											<td>ȫ�浿</td>
											<td>abcdefg1234</td>
										</tr>
										<tr class="adm01"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td>2</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>���ó���</td>
											<td>ȫ�浿</td>
											<td>abcdefg1234</td>
										</tr>
										<tr class="adm02"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td>3</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>���ó���</td>
											<td>ȫ�浿</td>
											<td>abcdefg1234</td>
										</tr>
										<tr class="adm01"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td>3</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>���ó���</td>
											<td>ȫ�浿</td>
											<td>abcdefg1234</td>
										</tr>
										<tr class="adm02"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td>3</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>���ó���</td>
											<td>ȫ�浿</td>
											<td>abcdefg1234</td>
										</tr>
										<tr class="adm01"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td>4</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>���ó���</td>
											<td>ȫ�浿</td>
											<td>abcdefg1234</td>
										</tr>
										<tr class="adm02"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td>1</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>�߼�</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>���ó���</td>
											<td>ȫ�浿</td>
											<td>abcdefg1234</td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td align="center"><table>
										<tr> 
											<td width="26"></td>
											<td width="45"> <a href="#" onFocus="blur()"><img src="../../img/common/paging_btn_prev.gif" alt="" border="0" align="absmiddle"></a></td>
											<td class="ce5"> | <span class="or01">1</span> 
												| <a href="javascript:goPage( '2' )" class="pg" onFocus="blur()">2</a> 
												| <a href="javascript:goPage( '3' )" class="pg" onFocus="blur()">3</a> 
												| <a href="javascript:goPage( '4' )" class="pg" onFocus="blur()">4</a> 
												| <a href="javascript:goPage( '5' )" class="pg" onFocus="blur()">5</a> 
												| <a href="javascript:goPage( '6' )" class="pg" onFocus="blur()">6</a> 
												| <a href="javascript:goPage( '7' )" class="pg" onFocus="blur()">7</a> 
												| <a href="javascript:goPage( '8' )" class="pg" onFocus="blur()">8</a> 
												| <a href="javascript:goPage( '9' )" class="pg" onFocus="blur()">9</a> 
												| <a href="javascript:goPage( '10' )" class="pg" onFocus="blur()">10</a> 
												| </td>
											<td width="50" align="right"> <a href="#" onFocus="blur()"><img src="../../img/common/paging_btn_next.gif" alt="" border="0" align="absmiddle"></a> 
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
		<td height="56" background="../../img/common/copy_bg.gif"><img src="../../img/common/copy.gif"></td>
	</tr>
</table>
</body>
</html>

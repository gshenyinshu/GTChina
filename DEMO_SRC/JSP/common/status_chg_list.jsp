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
					<td align="center" class="menu"><img src="../../img/common/menu_in.gif"> 
						<table width="100%">
							<tr> 
								<td><img src="../../img/common/menu01_on.gif" hspace="7">����ó��</td>
							</tr>
							<tr> 
								<th><div class="mn"><img src="../../img/common/menu02_on.gif" hspace="7">�����������</div>
									<div class="mn"><img src="../../img/common/menu02.gif" hspace="7"><a href="#">��������</a></div>
									<div class="mn"><img src="../../img/common/menu02.gif" hspace="7"><a href="#">�޸麸�������</a></div></th>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">����ó��</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">��Ÿ</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">�ϸ���</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">�ݼ۰���</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">����͸�</a></td>
							</tr>
						</table></td>
					<td class="contents"><table width="100%">
							<tr> 
								<td><img src="../../img/common/title_01.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="../../img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="14"></td>
							</tr>
							<tr> 
								<td><table width="100%">
										<tr> 
											<td><img src="../../img/common/bu_cir01.gif"> 
												<b>���º���</b></td>
											<td align="right"><a href="javascript:history.go(-1);"><img src="../../img/common/btn_back.gif"></a></td>
										</tr>
									</table></td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
								<td><table width="100%" class="adm_table">
										<col width=12%><col width=25%><col width=><col width=><col width=><col width=><col width=25%> 
										<tr> 
											<th rowspan="2">�˻�����</th>
											<th>��������</th>
											<th>������з�</th>
											<th>�����Һз�</th>
											<th>����</th>
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
											<td><select name="select">
													<option selected>����ó��</option>
												</select></td>
											<td><select name="select">
													<option selected>�������</option>
												</select></td>
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
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
											<th>N</th>
											<th>��������</th>
											<th>�����ð�</th>
											<th>���ǹ�ȣ</th>
											<th>�����</th>
											<th>������</th>
											<th>��û�ݾ�</th>
											<th>����</th>
											<th>����</th>
											<th>����</th>
											<th>ó������</th>
											<th>ó���ð�</th>
											<th>ó����</th>
											<th>���LP</th>
											<th>��ID</th>
										</tr>
										<tr class="adm01"> 
											<td>12345</td>
											<td>2004/06/20</td>
											<td>16:44:17</td>
											<td>1234567890</td>
											<td>���ó���</td>
											<td>�������</td>
											<td>123456789011</td>
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
												</select></td>
											<td><img src="../../img/common/btn_changes.gif"></td>
											<td><img src="../../img/common/btn_history.gif"></td>
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
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
												</select></td>
											<td><img src="../../img/common/btn_changes.gif"></td>
											<td><img src="../../img/common/btn_history.gif"></td>
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
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
												</select></td>
											<td><img src="../../img/common/btn_changes.gif"></td>
											<td><img src="../../img/common/btn_history.gif"></td>
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
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
												</select></td>
											<td><img src="../../img/common/btn_changes.gif"></td>
											<td><img src="../../img/common/btn_history.gif"></td>
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
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
												</select></td>
											<td><img src="../../img/common/btn_changes.gif"></td>
											<td><img src="../../img/common/btn_history.gif"></td>
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
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
												</select></td>
											<td><img src="../../img/common/btn_changes.gif"></td>
											<td><img src="../../img/common/btn_history.gif"></td>
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
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
												</select></td>
											<td><img src="../../img/common/btn_changes.gif"></td>
											<td><img src="../../img/common/btn_history.gif"></td>
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
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
												</select></td>
											<td><img src="../../img/common/btn_changes.gif"></td>
											<td><img src="../../img/common/btn_history.gif"></td>
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
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
												</select></td>
											<td><img src="../../img/common/btn_changes.gif"></td>
											<td><img src="../../img/common/btn_history.gif"></td>
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
											<td><select name="select">
													<option selected>����</option>
													<option>����</option>
													<option>����</option>
													<option>����</option>
													<option>�ݼ�</option>
													<option>����</option>
													<option>ó����</option>
												</select></td>
											<td><img src="../../img/common/btn_changes.gif"></td>
											<td><img src="../../img/common/btn_history.gif"></td>
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
											<td width="45"> <a href="#"><img src="../../img/common/paging_btn_prev.gif" alt="" border="0" align="absmiddle"></a></td>
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
											<td width="50" align="right"> <a href="#"><img src="../../img/common/paging_btn_next.gif" alt="" border="0" align="absmiddle"></a> 
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

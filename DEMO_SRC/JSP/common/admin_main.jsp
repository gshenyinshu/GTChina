<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>���̹�������</title>
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
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">����ó��</a></td>
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
								<td><img src="../../img/common/title_map.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="../../img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="24"></td>
							</tr>
							<tr> 
								<td><table>
										<tr> 
											<td rowspan="3"><img src="../../img/common/map_img.jpg" hspace="10"></td>
											<td><table class="map">
													<tr> 
														<td><img src="../../img/common/map_title01.gif"></td>
													</tr>
													<tr> 
														<td height="8"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">�����������</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">��������</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">�޸麸�������</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
												</table></td>
											<td style="padding: 0 10px;"><table class="map">
													<tr> 
														<td><img src="../../img/common/map_title02.gif"></td>
													</tr>
													<tr> 
														<td height="8"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">��������</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">��������ȯ</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">APL��ȯ</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
												</table></td>
											<td><table class="map">
													<tr> 
														<td><img src="../../img/common/map_title03.gif"></td>
													</tr>
													<tr> 
														<td height="8"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">�������� 
															�����</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">ó�����º���</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">SMS����</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
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
														<td><img src="../../img/common/map_title04.gif"></td>
													</tr>
													<tr> 
														<td height="8"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">�ϸ���</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22">&nbsp;</td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22">&nbsp;</td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
												</table></td>
											<td style="padding: 0 10px;"><table class="map">
													<tr> 
														<td><img src="../../img/common/map_title05.gif"></td>
													</tr>
													<tr> 
														<td height="8"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">�ݼ�ó������Ʈ</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22">&nbsp;</td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22">&nbsp;</td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
												</table></td>
											<td><table class="map">
													<tr> 
														<td><img src="../../img/common/map_title06.gif"></td>
													</tr>
													<tr> 
														<td height="8"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">����͸�(�Ϲ�)</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">����͸�(����)</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">����͸�(��Ȱ)</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
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
		<td height="56" background="../../img/common/copy_bg.gif"><img src="../../img/common/copy.gif"></td>
	</tr>
</table>
</body>
</html>

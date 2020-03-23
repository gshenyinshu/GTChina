<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>사이버고객센터</title>
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
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">지급처리</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">수납처리</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">기타</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">일마감</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">반송관리</a></td>
							</tr>
							<tr> 
								<td><img src="../../img/common/menu01.gif" hspace="7"><a href="#">모니터링</a></td>
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
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">약관대출지급</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">배당금지급</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">휴면보험금지급</a></b></td>
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
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">보험료수납</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">약관대출상환</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">APL상환</a></b></td>
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
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">보험증권 
															재발행</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">처리상태변경</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">SMS관리</a></b></td>
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
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">일마감</a></b></td>
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
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">반송처리리스트</a></b></td>
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
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">모니터링(일반)</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">모니터링(증명서)</a></b></td>
													</tr>
													<tr> 
														<td height="5" background="../../img/common/line.gif"></td>
													</tr>
													<tr> 
														<td height="22"><img src="../../img/common/bu_sq01.gif" hspace="7" align="absmiddle"><b><a href="#">모니터링(부활)</a></b></td>
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

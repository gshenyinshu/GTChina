<%
/**
 * Description : �������������
 * File        : /receipt/policy_reissue.jsp
 * Copyright   : Copyright (c) 2004 CyberImagination
 * @author     : jung-hun Park
 * First Write : 2005.01.24
 * update date : 2005.04.
 * update desc :
 */
%>
<%@ page import = "java.sql.*, javax.sql.*, javax.naming.*,java.util.*,java.lang.*, java.text.*, java.io.*, gtone.changeminer.common.utility.Util, gtone.changeminer.common.utility.ToolString" %>
<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page import="anyframe.data.DataSet, anyframe.log.*"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>

<jsp:useBean id="policyReissue_list" 	class="anyframe.data.DataSet" scope="request"/>
<jsp:useBean id="totalCount" 			class="java.lang.String" scope="request"/>
<jsp:useBean id="current" 				class="java.lang.String" scope="request"/>
<jsp:useBean id="key" 					class="java.lang.String" scope="request"/>
<jsp:useBean id="search" 				class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate" 				class="java.lang.String" scope="request"/>
<jsp:useBean id="todate" 				class="java.lang.String" scope="request"/>
<jsp:useBean id="fromdate2" 			class="java.lang.String" scope="request"/>
<jsp:useBean id="todate2" 				class="java.lang.String" scope="request"/>
<jsp:useBean id="searchgubun" 			class="java.lang.String" scope="request"/>
<jsp:useBean id="srvc_ind" 				class="java.lang.String" scope="request"/>
<jsp:useBean id="auth_cd" 				class="java.lang.String" scope="request"/>
<jsp:useBean id="chk_code" 				class="java.lang.String" scope="request"/><!--üũ�ڽ�:������ ������-->


<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script language='javascript' src='../../common/js/menu_on.js'></script>
<script language="javascript" src="/common/js/common.js"></script>
<script language="javascript">
<!--
	//��ȸ
	function goSearch()
	{
		form = document.policyForm;
		
		form.current.value = 1;
		form.method="get" ;	
		form.searchgubun.value = "S";
		form.submit();
	}
	
	function goPage(num) 
	{
		form = document.policyForm;
		
		form.current.value = num;
		form.method="get";
		form.submit();
	}		
	
	function goReset() 
	{
		form = document.policyForm;
				
		form.reset();
		
		form.fromdate.value = "";
		form.todate.value = "";
		form.fromdate2.value = "";
		form.todate2.value = "";
		form.key.value = "";
		
		//form.method="get";
		form.submit();
	}		
	

	//�ϰ�ó��
	function goAllChange()    
	{
		<%
			String rtn0 =  policyReissue_list.getText("rtn0").trim(); 
			
			//out.println("".equals(rtn0));
			//out.println("==========="):
			
			if("".equals(rtn0) ){
				rtn0="0";
			}
		%>
		//������ 2006.03.23 PSR CyberAdmin ��ɰ��� PSR
		if(<%= rtn0 %> > 0 ){
			form = document.policyForm;
					
			form.searchgubun.value = "C";
			
			form.method="get";
			form.submit();
		}else{
			alert("�� �̻� ó���� ���� �����ϴ�.");
		}
	}		

	
	//���º���(�߼�,�ݼ�)
	function goChange()
	{
		form	= document.policyForm;
		
		var cnt = 0;	
		var chk_str="";
		
		if( form.chkTogle1.length == undefined )
		{
			var num = form.chkTogle1.value;//�ش� üũ�ڽ��� ��
			form.chk_code.value = num;
			cnt++;
		}
		else
		{
			if(form.chkTogle1.length > 0) 
			{
				for(i=0; i<form.chkTogle1.length; i++) 
				{
					var ele =  form.chkTogle1[i];
					if(ele.checked) 
					{
						if(chk_str=="")
	        			{	
	        				chk_str = ele.value;
	        			}			
	        			else
	        			{		
	        				chk_str=chk_str + "/" + ele.value;
	        			}
						cnt++;
					}
				}
				form.chk_code.value = chk_str;
			}
			else 
			{
				if(form.chkTogle1.checked) 
				{
					cnt++;
				}
			}
		}

		if(cnt == 0)
		{
			alert("������ ���ǹ�ȣ�� �����ϴ�. \n\n�ش������ �����Ͻð� 'Label ����'��ư�� �����ּ���.  ");
			return;
		}
		else
		{
			searchWin = window.open('about:blank', 'Label_print', 'left=0,top=0,Width=775,Height=600,toolbar=no, fullscreen=no, directories=no, status=no, scrollbars=yes, menubar=no, location=no, resizable=yes');
			searchWin.focus();
			
			form.searchgubun.value = "P";
			form.target = "Label_print";
			form.action = "/receipt/policy_reissue_pop.do";
			form.submit();
			
			//window.location.reload();
		}
	}

	
	//checkbox ��ü ����
	function revcheck(theform)
	{
		for( var i=0; i<document.policyForm.elements.length; i++) 
		{
			var ele = document.policyForm.elements[i];
			if(ele.name == 'chkTogle1')
				ele.checked = !ele.checked;
		}
		return;
	}
	
	
	//�˾�â���� �ݱ��Ҷ� 
	function winRefresh()
	{
		window.location.reload();
	}
//-->
</script>
</head>

<body <%if(searchgubun.equals("S")){%>javascript:winRefresh()<%}%>>
<form name="policyForm"  method="post" action="policy_reissue.do">
<input type="hidden" name="searchgubun" value="<%=searchgubun%>">
<input type="hidden" name="current" value="<%=current%>">
<input type="hidden" name="auth_cd" value="<%=auth_cd%>">
<input type="hidden" name="chk_code" value="<%=chk_code%>"><!--üũ�� ����-->
<input type="hidden" name="rtn">

<table width="100%" height="100%">
	<tr> 
		<td height=71>
			<table width="100%" background="/img/common/logo_bg.gif">
				<tr> 
					<td><img src="/img/common/logo.gif"></td>
					<td align="right"><img src="/img/common/logo_end.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr> 
		<td>
			<table width=100% height="100%">
				<col width=200> 
				<tr> 					
      				<td align="center" class="menu">
						<!--DropDown ���� : S-->
						<jsp:include page="/common/dropDown.jsp" flush="true">
						<jsp:param name="menu_mode" value="6"/>
						</jsp:include>
						<!--DropDown ���� : E-->
					</td>
					<td class="contents">
						<table width="1060">
							<tr> 
								<td><img src="/img/common/title_03.gif"></td>
							</tr>
							<tr> 
								<td height="10" background="/img/common/title_bg.gif"></td>
							</tr>
							<tr> 
								<td height="14"></td>
							</tr>
							<tr> 
								<td>
									<table width="100%">
										<tr> 											
                      						<td><img src="/img/common/bu_cir01.gif"> <b>����͸�(�������������)</b></td>
											<td align="right">
<%
												//2005-10-10. 05-C-138. ������. ������Ѽ���ȭ
												//if(auth_cd.equals("20") || auth_cd.equals("30"))
												if(auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33"))
												{
%>											
												<!--<a href="javascript:goAllChange()" onFocus="blur()"><img src="/img/common/btn_batchprocess.gif" ></a>-->
<%
												}
%>												
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
				                <td>
				                  <table width="1060" class="adm_table">
				                    <col width=12%>
				                    <col width=20%>
				                    <col width=>
				                    <col width=>
				                    <col width=>
				                    <col width=25%>
				                    <tr> 
				                      <th width="80" rowspan="2">�˻�����</th>
				                      <th width="160">��������</th> 
				                      <th width="160">ó������</th>
				                      <th width="80">��������</th>
				                      <th width="80">���ΰ˻�</th>
				                      <th width="">�˻��Է�</th>
				                    </tr>
				                    <tr class="adm11"> 
				                      <td><input type="text" name="fromdate" class="box01" size="8" maxlength="8" style="text-align:center" value="<%=fromdate%>" readonly> 
				                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal');"  > 
				                        - 
				                        <input type="text" name="todate" class="box01" size="8" maxlength="8" style="text-align:center" value = "<%=todate%>" readonly> 
				                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal1');"  > 
				                      </td>
				                      <td><input type="text" name="fromdate2" class="box01" size="8" maxlength="8" style="text-align:center" value="<%=fromdate2%>" readonly> 
				                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal2');"  > 
				                        - 
				                        <input type="text" name="todate2" class="box01" size="8" maxlength="8" style="text-align:center" value = "<%=todate2%>" readonly> 
				                        <img src="/img/common/btn_cal.gif" align="absmiddle" onClick="showDiv('cal3');"  > 
				                      </td>
				                      <td><select name="srvc_ind"  size="1" style="width:100px;" >
				                      	<option value="all"  <% if(srvc_ind.equals("all")){ %> selected <% } %>>��ü</option>
				                      	<option value="0"  <% if(srvc_ind.equals("0")){ %> selected <% } %>>����</option>
				                      	<option value="1"  <% if(srvc_ind.equals("1")){ %> selected <% } %>>���ó��</option>
				                      	<option value="2"  <% if(srvc_ind.equals("2")){ %> selected <% } %>>�߼�</option>
				                      	<option value="3"  <% if(srvc_ind.equals("3")){ %> selected <% } %>>�ݼ�</option>
				                        </select></td>
				                      <td><select name="search" size="1" style="width:130px;">
				                          <option value="1"  <% if(search.equals("1")){ %> selected <% } %>>���ǹ�ȣ</option>
				                          <option value="2"  <% if(search.equals("2")){ %> selected <% } %>>�����</option>
				                          <option value="3"  <% if(search.equals("3")){ %> selected <% } %>>���̺�</option>
				                        </select></td>
				                      <td><input type="text" name="key" class="box03" value="<%=key%>" onKeyDown="if(event.keyCode == 13){ comment_input.focus(); }">
				                        <a href="javascript:goSearch();" onFocus="blur()" id="comment_input" ><img src="/img/common/btn_inquiry.gif" align="absmiddle" border="0"></a>
				                        &nbsp;
				                        <a href="javascript:goReset();" onFocus="blur()"><img src="/img/common/btn_reset.gif" align="absmiddle" border="0"></a>
				                        </td>
				                    </tr>
				                  </table>
				                </td>							
							</tr>
							<tr> 
								<td>&nbsp;</td>
							</tr>
							<tr> 
								<td>
									<table width="100%" class="adm_table">
<%
								int cnt = policyReissue_list.getCount("indate");
%>
					                    <tr> 
					                      <th>����<input type="checkbox" onFocus="this.blur()" style="border: 0; background: #85A5E2; font-weight: normal; color: #FFFFFF; " class="hidden" name="chkTogle"  onClick="javascript:revcheck(this.form)"  <%if( cnt == 0 ){%>disabled<%}%> ></th>
					                      <th>N</th>
					                      <th>��������</th>
					                      <th>�����ð�</th>
					                      <th>���ǹ�ȣ</th>
					                      <th>�����</th>
					                      <th>����</th>
					                      <th>���̺�</th>
					                      <th>�����ȣ</th>
					                      <th>�ּ�</th>
					                      <!--<th>ó������</th>-->
					                      <!--<th>ó���ð�</th>-->
					                      <!--<th>ó����</th>-->
					                    </tr>
<%
								if(cnt == 0)
								{
%>
					                    <tr class="adm01"> 
					                      <td colspan="10">�ش��ϴ� ���������������� �����ϴ�.</td>
					                    </tr>		
<%											
								}
								else
								{
									int row = 0;
									row = Integer.parseInt(totalCount) - (Integer.parseInt(current) -1 )*16;
									
									int check_i =0;
									
									for(int i=0;i<cnt;i++)
									{
%>							                    
					                    <tr align="center" bgcolor="<%= ( i % 2 == 0 ) ? "#FFFFFF" : "#F8F8F8" %>"> 
											<td><input type="checkbox" style="border: 0" onFocus="this.blur()" name="chkTogle1" value="<%=policyReissue_list.getText("policy", check_i).trim()%><%=policyReissue_list.getText("indate",check_i).trim()%><%=policyReissue_list.getText("subcode", check_i).trim()%>"  ></td>				                      
<%											
										check_i++;
%>
					                      <td><%=row%></td>
<%
										String indate =  "";//������
										String intime  = "";//�����ð�
										String prdate = "";//ó����
										String prtime = "";//ó���ð�
										String lpname = "";//ó����
										String label_yn = "";//�� ������
										
										indate = policyReissue_list.getText("indate",i).trim();	
										intime = policyReissue_list.getText("intime",i).trim();	
										prdate = policyReissue_list.getText("prdate",i).trim();	
										prtime = policyReissue_list.getText("prtime",i).trim();	
										//lpname = policyReissue_list.getText("lpname",i).trim();//ó����
										label_yn = policyReissue_list.getText("label_yn",i).trim();//�� ������
										
										if(indate.length() > 7)
											indate = indate.substring(0,4) +"."+ indate.substring(4,6) +"."+ indate.substring(6,8);
										if(intime.length() > 5)
											intime = intime.substring(0,2) +":"+	intime.substring(2,4) +":"+ intime.substring(4,6);
										if(prdate.length() > 7)
											prdate = prdate.substring(0,4) +"."+ prdate.substring(4,6) +"."+ prdate.substring(6,8);
										if(prtime.length() > 5)
											prtime = prtime.substring(0,2) +":"+	prtime.substring(2,4) +":"+ prtime.substring(4,6);											;										
										
										
										//�����ȣ
										String zipcode = policyReissue_list.getText("post",i).trim();
										if( zipcode.length()>0 ) zipcode = policyReissue_list.getText("post",i).substring(0,3)+"-"+policyReissue_list.getText("post",i).substring(3,6);
										
										//�ּ�
										String address = Util.doubleTrim(ToolString.fullTohalf(policyReissue_list.getText("addr1",i).trim())) + " " + Util.doubleTrim(ToolString.fullTohalf(policyReissue_list.getText("addr2",i).trim()));
%>							                      
					                      <td><%=indate%></td>
					                      <td><%=intime%></td>
					                      <td><%=policyReissue_list.getText("policy",i).trim()%></td>
					                      <td><%=policyReissue_list.getText("name",i).trim()%></td>
					                      <td><%=policyReissue_list.getText("rtn",i).trim()%></td>
					                      <td><%=label_yn%></td>
					                      <td><%=zipcode%></td>
					                      <td align="left">&nbsp;<%=address%></td>
					                      <%--<td><%=prdate%></td>--%>
					                      <%--<td><%=prtime%></td>--%>
					                      <%--<td><%=lpname%></td>--%>
					                    </tr>
<%
										row = row -1;
									}
								}
%>							                    

          							</table>
          							<table width="400" class="adm_table" align="center">
						                <tr> 
						                  <th width="15%">�ѰǼ�</th>
						                  <td width="20%"><div align="center"><%=policyReissue_list.getText("tot_cnt").trim()%>��</div></td>
						                  <th width="15%">����</th>
						                  <td width="20%"><div align="center"><%=policyReissue_list.getText("rtn0").trim()%>��</div></td>
						                  <th width="15%">ó��</th>
						                  <td width="20%"><div align="center"><%=policyReissue_list.getText("rtn1").trim()%>��</div></td>
						                </tr>
									</table>	
          						</td>
						
							<tr> 
								<td align="center">
									<table>
										<tr> 
											<td width="26"></td>
											<td width="45"> <td align="center">
												<jsp:include page="/common/include/paging_1.jsp" flush="true">
													<jsp:param name="total" value="<%= totalCount %>"/>
													<jsp:param name="cpage" value="<%= current %>"/>
												</jsp:include>
											</td>
											<td width="30"></td>
										</tr>
									</table>
								</td>
							</tr>
<%
						//2005-10-10. 05-C-138. ������. ������Ѽ���ȭ
						//if(auth_cd.equals("20") || auth_cd.equals("30"))
						if(auth_cd.equals("20") || auth_cd.equals("30") || auth_cd.equals("31") || auth_cd.equals("32") || auth_cd.equals("33"))
						{
%>
							<tr align="left">
								<td>
									<!--<a href="javascript:goChange(2);" onFocus="blur()"><img src="/img/common/btn_send1.gif" align="absmiddle" border="0"></a>
									<a href="javascript:goChange(3);" onFocus="blur()"><img src="/img/common/btn_send2.gif" align="absmiddle" border="0"></a>-->
									<a href="javascript:goAllChange()" onFocus="blur()"><img src="/img/common/btn_batchprocess.gif" ></a>
									&nbsp;
									<a href="javascript:goChange();" onFocus="blur()"><img src="/img/common/btn_print_1.gif" align="absmiddle" border="0"></a>
								</td>
							</tr>
<%
						}	
%>							
							<tr> 
								<td height="50">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
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
            src="/common/cal.jsp?setDate=policyForm.fromdate&divName=cal" 
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
            src="/common/cal.jsp?setDate=policyForm.todate&divName=cal1" 
            width="183" 
            height="175" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"> </iframe>
</div>            
            
<div id="cal2" style="position:absolute; z-index:1; 
                     left:192px; top:195px; width:193px;  height:195px; 
                     visibility:hidden"> 
            <iframe id='dalFrame2' 
            src="/common/cal.jsp?setDate=policyForm.fromdate2&divName=cal2" 
            width="183" 
            height="175" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"> </iframe>
            
</div>

<div id="cal3" style="position:absolute; z-index:1; 
                     left:192px; top:195px; width:193px;  height:195px; 
                     visibility:hidden"> 
            <iframe id='dalFrame3' 
            src="/common/cal.jsp?setDate=policyForm.todate2&divName=cal3" 
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


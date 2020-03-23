<%@ page language="java" contentType="text/html;charset=euc-kr"%>

<jsp:useBean id="ssn"		class="java.lang.String" 		scope="request"/>
<jsp:useBean id="output"		class="anyframe.data.DataSet" 		scope="request"/>
<jsp:useBean id="output2"		class="anyframe.data.DataSet" 		scope="request"/>



<html>
<head>
<title>상세정보</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../common/css/common.css" rel="stylesheet" type="text/css">
<script>

	
	function passwdInit_func(ssn){
		//패스워드 초기화만 할때...
		//alert(ssn);
		document.form.init_ssn.value = ssn;
		document.form.ready.value = "yes";
		document.form.target ="passwd";
		document.form.method = "post";
		document.form.action = "/receipt/passwd_init.jsp";
		document.form.submit();
		//self.close();
	}
</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name='form'>
<input type="hidden" name="init_ssn" value="">
<input type="hidden" name="ready" value="">

<table width="100%" class="adm_table">
	<col width=12%>
	<col width=25%>
	<col width=>
	<col width=>
	<col width=>
	<col width=>
	<col width=25%>
	<tr> 
	<th>구분</th>
	<th>이메일</th>
	</tr>
	<tr class="adm11"> 
	  <td><div align="center"><%=output.getText("gubun")%></div></td>
	  <td><div align="center"><%=output2.getText("email")%></div></td>
	</tr>
	<tr>
	  <td colspan="2">
	  	<input type="button" name="init_button" value="초기화" onClick="passwdInit_func('<%=ssn%>');">
	  </td>
	</tr>
</table>

    <iframe name='passwd' 
            id='passwd' 
            src="/receipt/passwd_init.jsp" 
            width="500" 
            height="500" 
            marginwidth="0" 
            marginheight="0" 
            topmargin="0" 
            frameborder="0" 
            scrolling="no"></iframe>
</form>
</body>
</html>
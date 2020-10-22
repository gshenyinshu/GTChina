<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#box2 {
		float: left;
		width: 20%;
		padding: 10px;
		display: inline;
		border: 1px solid orange;
		margin-bottom:10px;	
	}
	
	#box3 {
		float: right;
		width: 75%;
		padding: 10px;
		display: inline;
		border: 1px solid lime;
		margin-bottom:10px;	
	}
	
	.hint {
		font-size: 22px;
		font-weight: bold;
	}
</style>
<link href="../css/main.css" rel="stylesheet" type="text/css" />
<script src="../js/webtoolkit.base64.js"></script>
<script src="../js/jquery-1.7.1.js"></script>

<script type="text/javascript">
	  $(document).ready(function(){
	       $("#labs div").hide();
	       $("#div${param.no}").show();
	     
	       $('.menu').css('cursor','pointer').click(function() {
	          /*
	         $('#result').html('');
	         $('.hint').hide();
	         $('#div'+$(this).attr('no')).show();
	         */         
	         location.href = "/openeg/test/test.do?no="+$(this).attr('no');
	       });
	     });
	 function postPopUp(formName){ 
		 fm=document.getElementById(formName);
		 window.open("","viewer","width=1000, height=700, menubar=no,status=yes,scrollbars=no");
	     fm.action="forward_test.do";
	     fm.target="viewer";
	     fm.method="post";
	     fm.submit();
	}
</script>

</head>
<body>
<div id="container">
	
	<h1>
		<jsp:include page="../board/header.jsp"/>  
	</h1>

	
	<div id="content-container">
	<div id="content" style="width:100%;">
		<div id="box2">
			<font color="white" size="4"  style="background-color: indigo;font-weight: bold">보안코딩테스트</font>
			<br/>
			<ul id="lists">
				<li class="menu" no="1">인코딩</li>
				<li class="menu" no="2">정규식</li>
				<li class="menu" no="3" >SQL 인젝션</li>
				<li class="menu" no="4" >명령어 인젝션</li>
				<li class="menu" no="5" >XPath 인젝션</li>
				<li class="menu" no="6" >XSS</li>
				<li class="menu" no="7" >암호화</li>
				<li class="menu" no="8" >오픈리다이렉트</li>
				<li class="menu" no="9" >보안쿠키</li>
				<li class="menu" no="10" >인증</li>
				<li class="menu" no="11" >HTTP응답분할</li>
				<li class="menu" no="12" >접근제어</li>
				<li class="menu" no="13" >예외처리</li>
				<li class="menu" no="14" >정수오버플로우</li>
			</ul>
		</div>
    
    	<div id="box3">
     		<div class="result"  style="font-weight:bold;">==> 실행결과<==</div>
     		<div class="result"  id="result"></div>
     		<hr/>
     		<br/>
     		 
     		<div id="labs">
     
     			<div class="hint"  id="div0">
       				<pre class="showLabs">
<font color="green" size="6">보안 코딩 테스트</font><br/>
<font color="blue" size="4">왼쪽 메뉴를 선택하세요 !!</font>
       				</pre>
     			</div>
     
     
    <div class="hint"  id="div1">
     <form id="form1"  action="encode_test.do">
       <pre class="showLabs">
 (1) 인코딩 테스트<br/>
     <input type="text" name="data"  id="data1" size="40"> <input type="button"  id="button1" value="실행" > 

     <input type="radio"  name="type" value="0" checked="checked"> BASE64 인코딩     <input type="radio"  name="type"  value="1"> BASE64 디코딩
     <input type="radio"  name="type" value="2" > URL 인코딩        <input type="radio"  name="type"  value="3"> URL 디코딩
     <input type="radio"  name="type" value="4" > HTML 인코딩       <input type="radio"  name="type"  value="5"> HTML 디코딩
       </pre>
     </form>
     </div>
 <div class="hint"  id="div2">
     <form id="form2"  action="reg_test.do">
        <pre class="showLabs">
 (2) 정규식 테스트<br/>
     <input type="text" name="data"  id="data2"  size="70"> <input type="button"  id="button2" value="실행" >
        </pre>
     </form>
 </div>
  <div class="hint"  id="div3"> 
     <form action="sql_test.do"  id="form4"> 
        <pre class="showLabs">
 (3-1) MySQL 인젝션(인증우회)<br/>
       ID: <input type="text" name="id"  id="data4-1">  PASSWORD: <input type="password" name="passwd"  id="data4-2"> <input type="button"  id="button4"  value="실행"  >  
         </pre>
     </form>
  
      <form action="sql_test_b.do"  id="form4"> 
        <pre class="showLabs">
 (3-2) MySQL 인젝션<br/>
       ID: <input type="text" name="id"  id="data4-1" size="60"> <input type="submit"  id="button4"  value="실행"  >
         </pre>
     </form>
  
     <form action="sql_test_b2.do"  id="form4"> 
        <pre class="showLabs">
 (3-3) MS-SQL 인젝션<br/>  
       ID: <input type="text" name="id"  id="data4-1" size="60"> <input type="submit"  id="button4"  value="실행"  >
        </pre>
     </form>
  </div>
  <div class="hint" id="div4">
     <form action="command_test.do"  id="form5">
        <pre>
  (4) Command 인젝션  <br/>
      <select  name="data"  id="data5">
         <option value="type">--- show File1.txt ---</option>
         <option value="dir">--- show Dir ---</option>
      </select> <input type="button"   id="button5" value="실행"  >
       </pre>
     </form>
  </div> 
  <div class="hint" id="div5">
     <form action="xpath_test.do"  id="form6">
        <pre>
  (5) XPath 인젝션  <br/>
      이름: <input type="text" name="name"  id="data6" size="50">  <input type="button"   id="button6" value="실행"  >          
          </pre>
     </form>
  </div> 
   <div class="hint" id="div6">
     <form action="xss_test.do"  id="form3">
        <pre>
  (6-1) Reflective XSS  <br/>
        <input type="text" name="data"  id="data3" size="50"> <input type="button"   id="button3"  value="실행"  >
        &lt;script&gt;alert("xss");&lt;/script&gt;   
        </pre>
     </form>
     <form action="xss_test_b.do"  id="form20">
        <pre>
  (6-2) Stored XSS  <br/>
        <input type="text" name="data"  id="data20" size="50"> <input type="button"   id="button20"  value="실행"  > 입력값: 1 or 2   
        </pre>
     </form>
     <form action="xss_test_c.do"  id="form21">
        <pre>
  (6-3) DOM XSS  <br/>
        <input type="text" name="data"  id="data21" size="50"> <input type="submit"     value="실행"  >
        &lt;script&gt;alert("xss");&lt;/script&gt;    
        </pre>
     </form>
  </div>
   <div class="hint"  id="div7">
      <form action="encrypt_test.do"  id="form7">
         <pre>
  (7) 암호화   <br/>
      <input type="text" name="data"  id="data7" size="30">  <input type="button" id="button7" value="실행"  > 

      <input type="radio"  name="type" value="0" checked="checked"> SHA-256 암호화  
      <input type="radio"  name="type" value="1"> AES 암호화      <input type="radio"  name="type" value="2"> AES 복호화          
      <input type="radio"  name="type" value="3"> RSA 암호화      <input type="radio"  name="type" value="4"> RSA 복호화          



          </pre>
      </form>
  </div>
    <div class="hint"  id="div8">
       <form  name="form8" id="form8">
          <pre>
  (8) Redirect/Forward <br/>
      <select  name="data"  id="data8">
             <option value="http://www.naver.com">--- 네이버 ---</option>
             <option value="http://www.nate.com">--- 네이트 ---</option>
             <option value="http://www.daum.net">--- 다음 ---</option>
       </select> <input type="button"  value="이동"  onClick="postPopUp('form8')"> 
          </pre>
        </form>
     </div>
      <div class="hint" id="div9">
       <form action="secure_cookie_test.do"  id="form9">
          <pre>
  (9) 보안 쿠키   <br/>
      <input type="text" name="data"  id="data9" size="30"> <input type="button" id="button9" value="실행"  >
 
      <input type="radio"  name="type" value="0" checked="checked"> 쿠키요청  <input type="radio"  name="type" value="1"> 쿠키전송         
          </pre>
        </form>
      </div>
    <div class="hint" id="div10">
     <form action="authenticator_test.do"  id="form10"> 
         <pre>
  (10) 인증(Authentication)   <br/> 
       ID: <input type="text" name="id"  id="data10-1">  PASSWORD: <input type="password" name="passwd"  id="data10-2">  <input type="button"  id="button10"  value="실행"  >
          </pre>
     </form>
  </div>
    <div class="hint" id="div11">
     <form action="http_split_test.do"  id="form11"> 
        <pre>
  (11) HTTP응답분할 <br/>
       <input type="text" name="data"  id="data11" size="60"> <input type="button"  id="button11"  value="실행"  >
         </pre>
     </form>
  </div>
   <div class="hint"  id="div12">
       <form action="access_control_test.do"  id="form12">
          <pre>
  (12) 접근제어 <br/>
       <select  name="action"  id="data12">
               <option value="view">-- 정보조회 --</option>
               <option value="edit">-- 고객ID 생성 --</option>     
               <option value="modify">-- 고객이름 등록/변경 --</option>           
          </select> <input type="text" name="name"  id="data11" size="20"> <input type="button" id="button12" value="실행"  >
          </pre>
        </form>
     </div>
     <div class="hint"  id="div13">
       <form action="exception_test.do"  id="form13">
       <pre>
  (13) 예외처리   <br/>
       <input type="text" name="data"  id="data13" size="30">  <input type="button" id="button13" value="실행"  > 
     
       <input type="radio"  name="type" value="0" checked="checked"> 오류메시지를 통한 정보 노출 
       <input type="radio"  name="type" value="1"> 오류 상황 대응 부재 
       <input type="radio"  name="type" value="2"> 부적절한 예외처리         
          </pre>
        </form>
     </div>
     <div class="hint"  id="div14">
       <form action=" int_overflow_test.do"  id="form14">
          <pre>
  (14) 정수 오버플로우 <br/>
       <input type="text" name="data"  id="data14" size="40"> <input type="button" id="button14" value="실행"  > 
       
       -2147483648 to 2147483647
          </pre>
        </form>
     </div>
     


</div>
</div>

		<div id="footer">
			 <jsp:include page="../board/footer.jsp"/> 
		</div>

</div>
</div>
</div>
     
 <script type="text/javascript"> 
 $( 
   function() { 
 	  $('#button1').click( 
	    	     function() { 
	    	    	
// 	    	    	 var formData={data:Base64.encode(form1.data.value)};
                     var formData = $("#form1").serializeArray();  
 	    	    	 var URL = $("#form1").attr("action");  
 	    	    	 $('#result').empty(); 
  	    	         $.post(URL,  
     	    			   formData,   
  	    			       function(data, textStatus, jqXHR)     {        	    		             
	    	    		           $('#result').append(data); 
	    	    		        } 
	     	    	 ).fail(function(jqXHR, textStatus, errorThrown) {   
	    	    		    	   $('#result').append("요청처리 실패"); 
	    	    	  }); 
	    }); 
 
 	 $('#button2').click( 
    	     function() { 
    	    	 var formData = $("#form2").serializeArray();  
	    	     var URL = $("#form2").attr("action");  
	    	     $('#result').empty(); 
	    	     $.post(URL,  
 	    			   formData,   
	    			       function(data, textStatus, jqXHR)     {        	    		             
    	    		           $('#result').append(data); 
    	    		        } 
     	    	 ).fail(function(jqXHR, textStatus, errorThrown) {   
    	    		    	   $('#result').append("요청처리 실패"); 
    	    	  }); 
    }); 

 	 $('#button3').click( 
    	     function() { 
    	    	 var formData = $("#form3").serializeArray();  
	    	     var URL = $("#form3").attr("action");  
	    	     $('#result').empty(); 
	    	     $.post(URL,  
 	    			   formData,   
	    			       function(data, textStatus, jqXHR)     {  
	    	        	       var uri_dec = decodeURIComponent(data);
    	    		           $('#result').append(uri_dec); 
    	    		        } 
     	    	 ).fail(function(jqXHR, textStatus, errorThrown) {   
    	    		    	   $('#result').append("요청처리 실패"); 
    	    	  }); 
    }); 
 	 
 	$('#button4').click( 
    	     function() { 
    	    	 var formData = $("#form4").serializeArray();  
	    	     var URL = $("#form4").attr("action");  
	    	     $('#result').empty(); 
	    	     $.post(URL,  
 	    			   formData,   
	    			       function(data, textStatus, jqXHR)     {        	    		             
    	    		           $('#result').append(data); 
    	    		        } 
     	    	 ).fail(function(jqXHR, textStatus, errorThrown) {   
    	    		    	   $('#result').append("요청처리 실패"); 
    	    	  }); 
    }); 
 	
 	$('#button5').click( 
   	     function() { 
   	    	 var formData = $("#form5").serializeArray();  
	    	 var URL = $("#form5").attr("action");  
	    	 $('#result').empty(); 
	    	 $.post(URL,  
	    			   formData,   
	    			       function(data, textStatus, jqXHR)     {        	    		             
   	    		           $('#result').append(data); 
   	    		        } 
    	    	 ).fail(function(jqXHR, textStatus, errorThrown) {   
   	    		    	   $('#result').append("요청처리 실패"); 
   	    	  }); 
   }); 
 	
   $('#button6').click( 
 		   function() { 
 		   	    	 var formData = $("#form6").serializeArray();  
 			    	 var URL = $("#form6 ").attr("action");  
 			    	 $('#result').empty(); 
 			    	 $.post(URL,formData,   
 			    			function(data, textStatus, jqXHR)     {        	    		             
 		   	    		           $('#result').append(data); 
 		   	    		    } 
 		    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
 		   	    		    	   $('#result').append("요청처리 실패"); 
 		   	    	         }); 
 		   });
 	
 	$('#button7').click( 
 		   function() { 
 		   	    	 var formData = $("#form7").serializeArray();  
 			    	 var URL = $("#form7").attr("action");  
 			    	 $('#result').empty(); 
 			    	 $.post(URL,formData,   
 			    			function(data, textStatus, jqXHR)     {        	    		             
 		   	    		           $('#result').append(data); 
 		   	    		    } 
 		    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
 		   	    		    	   $('#result').append("요청처리 실패"); 
 		   	    	         }); 
 		   });
 	
 	$('#button8').click( 
	   function() { 
	   	    	 var formData = $("#form8").serializeArray();  
		    	 var URL = $("#form8").attr("action");  
		    	 $('#result').empty(); 
		    	 $.post(URL,formData,   
		    			function(data, textStatus, jqXHR)     {  
		    		           window.open(data);
// 	   	    		           $('#result').append(data); 
	   	    		    } 
	    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
	   	    		    	   $('#result').append("요청처리 실패"); 
	   	    	         }); 
	   });
 	
 	$('#button9').click( 
  		   function() { 
  		   	    	 var formData = $("#form9").serializeArray();  
  			    	 var URL = $("#form9").attr("action");  
  			    	 $('#result').empty(); 
  			    	 $.post(URL,formData,   
  			    			function(data, textStatus, jqXHR)     {        	    		             
  		   	    		           $('#result').append(data); 
  		   	    		    } 
  		    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
  		   	    		    	   $('#result').append("요청처리 실패"); 
  		   	    	         }); 
  		   });
 	
 	$('#button10').click( 
 		   function() { 
 		   	    	 var formData = $("#form10").serializeArray();  
 			    	 var URL = $("#form10").attr("action");  
 			    	 $('#result').empty(); 
 			    	 $.post(URL,formData,   
 			    			function(data, textStatus, jqXHR)     {        	    		             
 		   	    		           $('#result').append(data); 
 		   	    		    } 
 		    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
 		   	    		    	   $('#result').append("요청처리 실패"); 
 		   	    	         }); 
 		   });
 	
 	$('#button11').click( 
  		   function() { 
  		   	    	 var formData = $("#form11").serializeArray();  
  			    	 var URL = $("#form11").attr("action");  
  			    	 $('#result').empty(); 
  			    	 $.post(URL,formData,   
  			    			function(data, textStatus, jqXHR)     {        	    		             
  		   	    		           $('#result').append(data); 
  		   	    		    } 
  		    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
  		   	    		    	   $('#result').append("요청처리 실패"); 
  		   	    	         }); 
  		   });
 	
 	$('#button12').click( 
   		   function() { 
   		   	    	 var formData = $("#form12").serializeArray();  
   			    	 var URL = $("#form12").attr("action");  
   			    	 $('#result').empty(); 
   			    	 $.post(URL,formData,   
   			    			function(data, textStatus, jqXHR)     {        	    		             
   		   	    		           $('#result').append(data); 
   		   	    		    } 
   		    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
   		   	    		    	   $('#result').append("요청처리 실패"); 
   		   	    	         }); 
   		   });
 	
 	$('#button13').click( 
    		   function() { 
    		   	    	 var formData = $("#form13").serializeArray();  
    			    	 var URL = $("#form13").attr("action");  
    			    	 $('#result').empty(); 
    			    	 $.post(URL,formData,   
    			    			function(data, textStatus, jqXHR)     {        	    		             
    		   	    		           $('#result').append(data); 
    		   	    		    } 
    		    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
    		   	    		    	   $('#result').append("요청처리 실패"); 
    		   	    	         }); 
    		   });
 	$('#button14').click( 
 		   function() { 
 		   	    	 var formData = $("#form14").serializeArray();  
 			    	 var URL = $("#form14").attr("action");  
 			    	 $('#result').empty(); 
 			    	 $.post(URL,formData,   
 			    			function(data, textStatus, jqXHR)     {        	    		             
 		   	    		           $('#result').append(data); 
 		   	    		    } 
 		    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
 		   	    		    	   $('#result').append("요청처리 실패"); 
 		   	    	         }); 
 		   });
 	$('#button20').click( 
 		   function() { 
 		   	    	 var formData = $("#form20").serializeArray();  
 			    	 var URL = $("#form20").attr("action");  
 			    	 $('#result').empty(); 
 			    	 $.post(URL,formData,   
 			    			function(data, textStatus, jqXHR)     {        	    		             
 		   	    		           $('#result').append(data); 
 		   	    		    } 
 		    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
 		   	    		    	   $('#result').append("요청처리 실패"); 
 		   	    	         }); 
 		   });
 	$('#button21').click( 
 		   function() { 
 		   	    	 var formData = $("#form21").serializeArray();  
 			    	 var URL = $("#form21").attr("action");  
 			    	 $('#result').empty(); 
 			    	 $.post(URL,formData,   
 			    			function(data, textStatus, jqXHR)     {     			    	
 		   	    		           document.write(unescape(data));
 		   	    		    } 
 		    	    	   ).fail(function(jqXHR, textStatus, errorThrown) {   
 		   	    		    	   $('#result').append("요청처리 실패"); 
 		   	    	         }); 
 		   });
 	
});

    	    	
</script>
 <!--  	var uri = "http://w3schools.com/my test.asp?name=st책le&car=saab"; -->
 <!--  	var uri_enc = encodeURIComponent(uri); -->
 <!--  	var uri_dec = decodeURIComponent(uri_enc); -->
 <!--  	var res = uri_enc + "<br>" + uri_dec; -->
			


</body>
</html>
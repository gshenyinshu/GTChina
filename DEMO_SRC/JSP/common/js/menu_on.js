function chImgOver(obj){
  var imgsrc=obj.src;
  var imgdir=imgsrc.substring(0,imgsrc.lastIndexOf("/"));
  var imgname=imgsrc.substring(imgsrc.lastIndexOf("/"),imgsrc.lastIndexOf("."));
  var imgext=imgsrc.substring(imgsrc.lastIndexOf("."),imgsrc.length);

  imgname = imgname + "_on";

  obj.src=imgdir+imgname+imgext;
  return true;
}

function chImgOut(obj){
  var imgsrc=obj.src;
  var imgdir=imgsrc.substring(0,imgsrc.lastIndexOf("/"));
  var imgname=imgsrc.substring(imgsrc.lastIndexOf("/"),imgsrc.lastIndexOf("."));
  var imgext=imgsrc.substring(imgsrc.lastIndexOf("."),imgsrc.length);

  imgname = imgname.substring(0, imgname.length-3);

  obj.src=imgdir+imgname+imgext;
  return true;
}

 
 

/* -----------------------------------------------------------------------------
* Function : goLink( goName )
* Comment  : 화면에서 처리되는 링크들
* Param    : goName - 가고 싶은 페이지 이름
----------------------------------------------------------------------------- */
function goLink( goName ){
    var url = null ;
    if(goName=="login"){
        url = "" ;
    }else if(goName=="logout"){
        var rst = confirm("로그아웃 하시겠습니까?  "); 
        if(!rst) return ;
        //url = "/payment/cyber_login.do?login=N"; 
        url = "/payment/login_check.do?login=N";
    }
    location.href = url ;
}


	function goPageAction(linkPage,menu_id){
		
		
		document.appendChild( document.createElement( "<form method=\"post\" name=\"formObj_temp\"/>" ) );
		document.formObj_temp.appendChild( document.createElement( '<input type="hidden" name="menu_num"/>'  ) );
		formObj_temp.menu_num.value=menu_id;
		formObj_temp.method="post" ;	
		formObj_temp.action = linkPage;
		formObj_temp.submit();
	
	}
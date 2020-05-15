/******************************************************************************
* Title       : ��������
* Description : �ش� ������ ��ũ��Ʈ�� �߰�����,�����Ұ� ��������
* File Name   : /common/js/common.js
* Copyright   : Copyright (c) 2004
* Company     : CyberImagination
* @author     : Sang-Mi Lee
******************************************************************************/

function goExcel()
{
	document.excelform.excel.value=document.all.excelDiv.innerHTML;
	//alert("excel : "+ document.excelform.excel.value);
	
	document.excelform.taret =excelFrame;
	document.excelform.action="/common/excel.do";
	document.excelform.submit();
}



/* -----------------------------------------------------------------------------
* Function : openWindow(uri,w,h,sc,rs, windowname)
* Comment  : ������ �˾����� ����
* Param    : �˻����- �����͸� ������ ��
* Param    : f      - �����͸� ������ ��
* Param    : zip1   - �����ȣ1 ������ ��
* Param    : zip2   - �����ȣ2 ������ ��
* Param    : add    - �ּ� ������ ��
----------------------------------------------------------------------------- */
function common_setZipcode(f, zip1, zip2, add){ 
    var url = "/customer/zipcode.do";
    url += "?formName="+f
        +  "&zip1="+zip1  
        +  "&zip2="+zip2  
        +  "&add=" +add  ;
    common_openWindow(url,476,231,"no","no", "ZipCodePopUp") ;
}
/* -----------------------------------------------------------------------------
* Function : common_maxStr( object )
* Comment  : �׳� ���ڿ� ���� üũ(byteüũ �ƴ�)
* Param    : object - �˻��� ��ü
* Param    : max    - �˻��� ���ڱ���
* Return   : true max�� �������, false  max�ʰ�
----------------------------------------------------------------------------- */
function common_maxStr( object , max ){

    if( object.value.length > max ){
        alert(max+"�� �̻� �Է��� �� �����ϴ�.") ;
        object.value = object.value.substring( 0 , max );
        return false ;
    }
    return true ;
}
/* -----------------------------------------------------------------------------
* Function : common_maxLength( object )
* Comment  : ������� �ִ� byte��ŭ üũ �� �ʰ��ϸ� �޼��� ���
* Param    : object - �˻��� ��ü
* Param    : max    - �˻��� ���ڱ���
* Return   : true max�� �������, false  max�ʰ�
----------------------------------------------------------------------------- */
function common_maxLength( object , max ){

    if( common_strlength(object.value)>max ){
        alert(max+"�� �̻� �Է��� �� �����ϴ�.\n(�ѱ��� 1��, ������ 2���Դϴ�.)") ;
        object.value = common_cutStr(object.value, max) ;
        return false ;
    }
    return true ;
}
/* -----------------------------------------------------------------------------
* Function : common_cutStr( str, cnt )
* Comment  : ���ϴ� ���ڱ��� cnt��ŭ  �ڸ���.
* Param    : str    - �˻��� ���ڿ�
* Param    : cnt    - �˻��� ���ڿ�
* Return   : rstStr - ���ϴ� ���ڱ��� ��ŭ�� ���ڿ�
----------------------------------------------------------------------------- */
function common_cutStr(str, cnt){
	var str_len=0;
    var rstStr = "" ;
	for(i = 0 ; i < str.length; i++){
        if (str.charAt(i) < unescape("%80"))
            str_len++   ;
        else
            str_len = str_len + 2;

        if(str_len<=cnt){
            rstStr += str.charAt(i) ;
        }else{
            break ;
        }
	}
	return rstStr ;
}
/* -----------------------------------------------------------------------------
* Function : common_strlength( object )
* Comment  : ������� �ִ� byte��ŭ üũ �� �ʰ��ϸ� �޼��� ���
* Param    : str    - �˻��� ���ڿ�
* Return   : str_len- ���� ����
----------------------------------------------------------------------------- */
function common_strlength( str ){
	var str_len=0;
	for(i = 0 ; i < str.length; i++){
		if (str.charAt(i) < unescape("%80"))
			str_len++;
		else
			str_len = str_len + 2;
	}
	return str_len
}
/* -----------------------------------------------------------------------------
* Function : openWindow(uri,w,h,sc,rs, windowname)
* Comment  : ������ �˾����� ����
* Param    : url        - �������̸�
* Param    : w          - ����
* Param    : h          - ����
* Param    : sc         - â ��ũ�ѿ���(no or yes)
* Param    : rs         - resize����(no or yes)
* Param    : windowname - â�̸�
----------------------------------------------------------------------------- */
function common_openWindow(url,w,h,sc,rs, windowname){ 
    var wct = (screen.width - w) / 2;
    var hct= (screen.height - h) / 2;
    var winObj = window.open(   url,windowname, 
                                ('scrollbars='+sc
                                +',resizable='+rs
                                +', width='+w
                                + ',height='+h
                                +',top=' +hct
                                +',left='+wct));
    winObj.focus() ;
}
/* -----------------------------------------------------------------------------
* Function : openWindow(uri,w,h,sc,rs, windowname)
* Comment  : ������ �˾����� ����
* Param    : url        - �������̸�
* Param    : t          - ��ܳ���
* Param    : l          - ���ʳ���
* Param    : w          - ����
* Param    : h          - ����
* Param    : sc         - â ��ũ�ѿ���(no or yes)
* Param    : rs         - resize����(no or yes)
* Param    : windowname - â�̸�
----------------------------------------------------------------------------- */
function common_openFree(url,t,l,w,h,sc,rs, windowname){ 
    if(t==null) t = (screen.width - w) / 2;
	if(l==null) l = (screen.height - h) / 2;

    var winObj = window.open(url,windowname, 
                                ('scrollbars='+sc
                                    +',resizable='+rs
                                    +', width='+w
                                    + ',height='+h
                                    +',top=' +t
                                    +',left='+l)
                            );
    winObj.focus() ;
}
/* -----------------------------------------------------------------------------
* Function : common_noKey()
* Comment  : ����Ű�������� ������ ��� false��Ų��
----------------------------------------------------------------------------- */
function common_noKey(){
    if(event.keyCode < 48 || event.keyCode >57 ){ 
        event.returnValue=false;
        return ;
    }
}
/* -----------------------------------------------------------------------------
* Function : common_korean( obj )
* Comment  : �ѱ��Է¸��½�ũ��
* Param    : obj - �̺�Ʈ�� �Ͼ ��ü
----------------------------------------------------------------------------- */
function common_korean( obj ){ 
    var i; 
    var ch; 
    var str = obj.value ;
    for (i=0;i<str.length;i++) { 
	    ch = escape(str.charAt(i));        //ISO-Latin-1 ���ڼ����� ���� 
        if (common_strCharByte(ch) == 2) { 
            alert("�ѱ��� �Է��� �� �����ϴ�.");
            obj.value = "";
            obj.focus();
            return false;
        }
    }
} 
/* -----------------------------------------------------------------------------
* Function : common_strCharByte(chStr)
* Comment  : �ѱ۰˻�
* Param    : chStr - �����ڵ�
* Return   : 1-���� 2-�ѱ�
----------------------------------------------------------------------------- */
function common_strCharByte(chStr) { 
    var y = "%u";
    var z = "%";

    if (chStr == null)
        chStr = "";

        if (chStr.indexOf(y) != -1) { 
            if (chStr.substring(2,4) == '00') {
			    return 1; 
            }else{
                return 2;        //�ѱ� 
            }
        }else if (chStr.indexOf(z) != -1) { 
            if (parseInt(chStr.substring(1,3), 16) > 127) {
                return 2;        //�ѱ� 
        }else {
            return 1; 
        }
    } else { 
        return 1; 
    } 
} 
/* -----------------------------------------------------------------------------
* Function : common_isEmail(s)
* Comment  : e-mail�ּ� üũ
* param    : s - �̸��� ���ڿ�
* Return   : true:���� false:����
----------------------------------------------------------------------------- */
function common_isEmail(s) {
	if (s.indexOf(" ") != -1)
		return false;
	else if (s.indexOf("@") == -1)
		return false;
	else if (s.indexOf("@") == 0)
		return false;
	else if (s.indexOf("@") == (s.length-1))
		return false;
	var arrayString = s.split("@");

	if (arrayString[1].indexOf(".") == -1)
		return false;
	else if (arrayString[1].indexOf(".") == 0)
		return false;
	else if (arrayString[1].charAt(arrayString[1].length-1) == ".") {
		return false;
	}
	return true;
}
/* -----------------------------------------------------------------------------
* Function : common_Empty(obj)
* Comment  : �˻��� ��ü�̸��� �˻� ���� �Ѱ��ָ� �� üũ
* param    : obj - �˻��� �� �̸�
* Return   : true-���� false-����
----------------------------------------------------------------------------- */
function common_Empty(obj) {
    if(obj.disabled==false && common_Trim(obj.value).length==0){
        return false ;
    }
    return true ;
}
/* -----------------------------------------------------------------------------
* Function : common_Trim(s)
* Comment  : ����, ������ ��� ���� �������
* Param    : s - �˻繮�ڿ�
* Return   : s - ���������� ���ڿ�
----------------------------------------------------------------------------- */
function common_Trim(s) {
	var tmpstr = common_LTrim(s);
	return common_RTrim(tmpstr);
}
/* -----------------------------------------------------------------------------
* Function : common_LTrim(s)
* Comment  : ���� ���� �������
* Param    : s - �˻繮�ڿ�
* Return   : tmpstr - ���������� ���ڿ�
----------------------------------------------------------------------------- */
function common_LTrim(s) {
	while (1) {
		if ( s.substring(0, 1) != " " ) {
			break;
		}
		s = s.substring(1, s.length);
	}
	return s;
}
/* -----------------------------------------------------------------------------
* Function : common_RTrim(s)
* Comment  : ������ ���� �������
* Param    : s - �˻繮�ڿ�
* Return   : s - ���������� ���ڿ�
----------------------------------------------------------------------------- */
function common_RTrim(s) {
	while (1) {
		if ( s.substring(s.length - 1, s.length) != " " ) {
			break;
		}
		s = s.substring(0, s.length - 1);
	}
	return s;
}
/* -----------------------------------------------------------------------------
* Function : showLayer(divName)
* Comment  : div layer �� �����ش�.
* Param    : divName - div�̸�
----------------------------------------------------------------------------- */
function showLayer(divName){
	document.all[divName].style.visibility = "visible";
}
/* -----------------------------------------------------------------------------
* Function : hideLayer(divName)
* Comment  : div layer �� �����.
* Param    : divName - div�̸�
----------------------------------------------------------------------------- */
function hideLayer(divName) {
	document.all[divName].style.visibility = "hidden"
}
/* -----------------------------------------------------------------------------
* Function : hideLayer(divName)
* Comment  : div layer �� ������ġ�� display �Ѵ�.
* Param    : divName - div�̸�
----------------------------------------------------------------------------- */
function showDiv(divName) {
	var OBJ ;
		OBJ = document.all[divName] ;
        if(OBJ.style.visibility=='hidden'){
            OBJ.style.pixelTop = event.clientY + document.body.scrollTop ;
            OBJ.style.pixelLeft = event.clientX ;
            OBJ.style.visibility = "visible";	
        }else{
            OBJ.style.visibility = "hidden";
        }
}
/* -----------------------------------------------------------------------------
* Function : common_isEmail(s)
* Comment  : e-mail�ּ� üũ
* Return   : true:���� false:����
----------------------------------------------------------------------------- */
function common_isEmail(s) {
	if (s.indexOf(" ") != -1)
		return false;
	else if (s.indexOf("@") == -1)
		return false;
	else if (s.indexOf("@") == 0)
		return false;
	else if (s.indexOf("@") == (s.length-1))
		return false;
	var arrayString = s.split("@"); //(works only in netscape3 and above.)
	//var retSize = customSplit(argvalue, "@", "arrayString");
	if (arrayString[1].indexOf(".") == -1)
		return false;
	else if (arrayString[1].indexOf(".") == 0)
		return false;
	else if (arrayString[1].charAt(arrayString[1].length-1) == ".") {
		return false;
	}
	return true;
}
/* -----------------------------------------------------------------------------
* Function : moneyFormat(number, control)
* Comment  : e-mail�ּ� üũ
* Param    : number  - 
* Param    : control - 
----------------------------------------------------------------------------- */
function moneyFormat(number, control) {
        if (number.substring(0,1) == '0' ||  number== '') {
            number = number.substring(1, number.length);
            control.value = '';
            return;
        }
        number = number.replace(/,/g , "");

        if(!isInteger(number)){
			alert("���ڸ� ��밡���մϴ�.");
            control.value = '';
            control.focus();
			return ;
		}
         
        if (number.length <= 3) {
            control.value = number.replace(/,/g , "");
            return; 
        }else{
            var mod = number.length%3;
            var output = (mod == 0 ? '' : (number.substring(0,mod)));
            
            for (z=0 ; z < Math.floor(number.length/3) ; z++) {
                if ((mod ==0) && (z ==0)){
                    output+= number.substring(mod+3*z,mod+3*z+3);
                }else{
                    output+= ',' + number.substring(mod+3*z,mod+3*z+3);
                }
            }
           control.value = output;
         }
}
/* -----------------------------------------------------------------------------
* Function : isInteger(s)
* Comment  : �������� �ƴ��� üũ
* Param    : s  - ����
----------------------------------------------------------------------------- */
function isInteger(s) {
	if (s.length > 0) {
		sNum = s;
		for (i=0; i<sNum.length; i++) {
			if (sNum.charAt(i) < '0' || sNum.charAt(i) > '9') {
				return false;
			}
		}
		return true;
	} else {
		return false;
	}
}


/* -----------------------------------------------------------------------------
* Function : pop
* Comment  : 
----------------------------------------------------------------------------- */
function pop(pop,width,height,flag){
    if(flag==0) flag = "no" ;
    else  flag = "yes" ;
    common_openWindow(pop,width,height,flag,"no", width+""+height+""+flag) ;
}
/* -----------------------------------------------------------------------------
* Function : pop2
* Comment  : 
----------------------------------------------------------------------------- */
function pop2(pop,width,height,flag){
    if(flag==0) flag = "no" ;
    else  flag = "yes" ;
    common_openFree(pop,0,0,width,height,flag,"no", width+""+height+""+flag) ;
	
}
/* -----------------------------------------------------------------------------
* Function : pop3
* Comment  : (����) ������ �˾����� ����
----------------------------------------------------------------------------- */
function pop3(){
	var url = "contract_pop.jsp";	
	window.open(url,"MeiWindow",
                'left=60,top=60,Width=476,Height=291,'
                +'toolbar=0,location=0,directories=0,'
                +'status=1,menubar=0,titlebar=0,scrollbars=0,resizable=0');	
}
/* -----------------------------------------------------------------------------
* Function : pop4
* Comment  : (����) ������ �˾����� ����
----------------------------------------------------------------------------- */
function pop4()
{
	var url = "poplist.jsp";	
	window.open(url,"MeiWindow",'left=60,top=60,Width=520,Height=220,toolbar=0,location=0,directories=0,status=1,menubar=0,titlebar=0,scrollbars=0,resizable=0');
	
}
/* -----------------------------------------------------------------------------
* Function : PHCC_list()
* Comment  : ?
----------------------------------------------------------------------------- */
function PHCC_list(){
	var url = "poplist.jsp";	
	window.open(url,"MeiWindow",
                'left=60,top=60,Width=476,Height=300,'
                +'toolbar=0,location=0,directories=0,'
                +'status=1,menubar=0,titlebar=0,scrollbars=0,resizable=0');
	
}
/* -----------------------------------------------------------------------------
* Function : popWindow()
* Comment  : ?
----------------------------------------------------------------------------- */
function popWindow(pop,name,width,height,flag)
{
	var url = pop;
	var name = name;
	var wd = width;
	var he = height;

    if (flag == "0" ){
		window.open(url, 
                    name,
                    "toolbar=0,menubar=0,scrollbars=no,resizable=no,width=" + wd +",height=" + he + ";");
	} else {
		window.open(url, name,"toolbar=0,menubar=0,scrollbars=yes,resizable=no,width=" + wd +",height=" + he + ";");
	}
}

function setSize( width, name ) {
	var oCalcHeighter = null;
	var height = 0;
	if ( ( oCalcHeighter = document.getElementById( name ) ) != null ) {
		height = oCalcHeighter.height + 30;
		width += 16;
		if ( height > 600 ) {
			height = 600;
		}
		window.resizeTo( width, height );
	}
}

function setLocationSize( name ) {
	setSize( 486, name );
}

function setCookie( name, value, expiredays ) {
    var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

function getCookie( name ) {
	var from_idx = document.cookie.indexOf(name+'=');
	if (from_idx != -1) {
		from_idx += name.length + 1
		to_idx = document.cookie.indexOf(';', from_idx)

		if (to_idx == -1) {
			to_idx = document.cookie.length;
		}

		return unescape(document.cookie.substring(from_idx, to_idx));
	}
}


function pop_open1(pop,width,height)
{
	var url = pop;
	var wd = width;
	var he = height;

	var eventCookie=getCookie("Show");
	if (eventCookie != "false") {
		window.open(url,'',"toolbar=0,menubar=0,scrollbars=no,resizable=no,width=" + wd +",height=" + he + ", top=0, left=0;")
	}
	//�˾�â�� �ּ�, ���� �����ο� �־�� �Ѵ�.
}

function pop_open2(pop,width,height)
{
	var url = pop;
	var wd = width;
	var he = height;

	var eventCookie=getCookie("human");
	if (eventCookie != "false") {
		window.open(url,'',"toolbar=0,menubar=0,scrollbars=no,resizable=no,left=390,width=" + wd +",height=" + he + ", top=0, left=400;")
	}
	//�˾�â�� �ּ�, ���� �����ο� �־�� �Ѵ�.
}


/**********************************************************************************
	Layer Show Hide
***********************************************************************************/

function LayerSH(LayerName,Status) {
ns4 = (document.layers)?true:false
ie4 = (document.all)?true:false

	if (ns4) {
		LayerN = document.layers[LayerName]
		if (Status == 'show') LayerN.visibility = 'show';
		if (Status == 'hide') LayerN.visibility = 'hidden';
	}
	if (ie4) {
		LayerN = document.all[LayerName].style
		if (Status == 'show') {
		LayerN.visibility = 'visible';
		LayerN.display = 'block';
		}
		if (Status == 'hide') {
		LayerN.visibility = 'hidden';
		LayerN.display = 'none';
		}
	}
}

function preload(imgObj,imgSrc) {
	if (document.images) {
		eval(imgObj+' = new Image()')
		eval(imgObj+'.src = "'+imgSrc+'"')
	}
}
function imgChg(imgName,imgObj) {
	if (document.images) {
		document.images[imgName].src = eval(imgObj+".src")
	}
}




	/**
	 *  �ڸ��� üũ(�μ� �� ��)(20040701 ������ �߰�)
	 */
	function valid_check_by( textObj, textName, minlen, maxlen )
	{
		var tempObj = textObj.value;
		var len 	= tempObj.length;
		var count = 0;
		if ( len < minlen || len > maxlen ) {
			alert ( textName + ' ' + maxlen + ' �ڷ� �Է��ϼž� �մϴ�' );
			textObj.focus();
			return false;
		}
		if ( count == len )	{
			return false;
		}
		return true;
	}


	/**
	 *  �ڸ��� üũ(�μ� �� ��)(20040701 ������ �߰�)
	 */
	function valid_check( textObj, textName, minlen, maxlen )
	{
		var tempObj = textObj.value;
		var len 	= tempObj.length;
		var count = 0;
		if ( len < minlen || len > maxlen ) {
			alert ( textName + ' ' + minlen + ' ~ ' + maxlen + ' ���̳��� �Է��ϼž� �մϴ�' );
			textObj.focus();
			return false;
		}
		if ( count == len )	{
			return false;
		}
		return true;
	}
	

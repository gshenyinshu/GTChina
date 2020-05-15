/*
 �ý��� : �޷� ���α׷�
 �ۼ��� : 2001�� 4�� 02��
 �ۼ��� : �ۺ���
 ���ϸ� : calendar.js
 �ý��� ���� : �޷���ȸ �� ��¥����Լ�
 ���� : 0.1
 �����̷� :
 	1. �����ۼ� - 2001/04/02
    2. ��� ��ȭ ���� - �̻��
*/


var gNow = new Date();
var ggWinCal;

Calendar.Months = ["1","2","3","4","5","6","7","8","9","10","11","12"];

// ������ Month days..
Calendar.DOMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
// ���� Month days..
Calendar.lDOMonth= [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

// �޷� Ŭ���� ����
function Calendar(pWinCal, pMonth, pYear, pFormat)
{
	if ((pMonth == null) && (pYear == null))	return;

	if (pWinCal == null)
		this.gWinCal = ggWinCal;
	else
		this.gWinCal = pWinCal;

	if (pMonth == null) {
		this.gMonthName = null;
		this.gMonth = null;
	} else {
		this.gMonthName = Calendar.getMonth(pMonth);
		this.gMonth = new Number(pMonth);
	}

	this.gYear = pYear;
	this.gFormat = pFormat;
//	this.gReturnItem = pItem;
}

Calendar.getMonth = CalendarGetMonth;
Calendar.getDaysofmonth = CalendarGetDaysofmonth;
Calendar.calcMonthYear = CalendarCalcMonthYear;
Calendar.print = CalendarPrint;

//��
function CalendarGetMonth(monthNo)
{
	return Calendar.Months[monthNo];
}

//���� �ϼ�
function CalendarGetDaysofmonth(monthNo, pYear)
{
	//���� Check
	if ((pYear % 4) == 0) {								//���� 4�� ���� �������� 0�̸� ����
		if ((pYear % 100) == 0 && (pYear % 400) != 0)	//���� 100���� ���� �������� 0�̰� ���� 400���� ������������ 0�� �ƴϸ� ���
			return Calendar.DOMonth[monthNo];

		return Calendar.lDOMonth[monthNo];
	} else
		return Calendar.DOMonth[monthNo];
}

//��� ���� ���
function CalendarCalcMonthYear(pMonth, pYear, incr)
{
	var retArr = new Array();

	if (incr == -1) {
		// ������/��
		if (pMonth == 0) {
			retArr[0] = 11;
			retArr[1] = parseInt(pYear) - 1;
		}
		else {
			retArr[0] = parseInt(pMonth) - 1;
			retArr[1] = parseInt(pYear);
		}
	} else if (incr == 1) {
		// ������/��
		if (pMonth == 11) {
			retArr[0] = 0;
			retArr[1] = parseInt(pYear) + 1;
		}
		else {
			retArr[0] = parseInt(pMonth) + 1;
			retArr[1] = parseInt(pYear);
		}
	}

	return retArr;
}

//�޷��μ�
function CalendarPrint()
{
	ggWinCal.print();
}

//new Calendar();

//�޷� HTML �ڵ� ����
Calendar.prototype.getMonthlyCalendarCode = function()
{
	var vCode = "";
	var vHeader_Code = "";
	var vData_Code = "";

	// �޷� ���̺�
	vCode = vCode + "<table border=0 bgcolor='#6FA2CB' cellpadding=0 cellspacing=1 width=183>";// bordercolorlight='#72B6CB',  bordercolor='#FFFFFF'
	vHeader_Code = this.calHeader();
	vData_Code = this.calData();
	vCode = vCode + vHeader_Code + vData_Code;
	//alert( vCode );
	vCode = vCode + "</table>";

	return vCode;
}

//�޷��� �����ش�.
Calendar.prototype.show = function()
{
	var vCode = "";

	// ������/��
	var prevMMYYYY = Calendar.calcMonthYear(this.gMonth, this.gYear, -1);
	var prevMM = prevMMYYYY[0];
	var prevYYYY = prevMMYYYY[1];
	//������/��
	var nextMMYYYY = Calendar.calcMonthYear(this.gMonth, this.gYear, 1);
	var nextMM = nextMMYYYY[0];
	var nextYYYY = nextMMYYYY[1];

	var head = "<b>"+this.gYear + "��&nbsp;" + this.gMonthName+"</b>";

	var prevYear = "\"Build('" +this.gMonth+"','"+(parseInt(this.gYear)-1)+"','"+this.gFormat+"'"+")\" ";

	var prevMonth = "\"Build('" +prevMM + "', '" + prevYYYY + "', '" + this.gFormat + "'" + ")\" ";

	var nextYear = "\"Build('" +this.gMonth+"','"+(parseInt(this.gYear)+1)+"','"+this.gFormat+"'"+")\" ";

	var nextMonth = "\"Build('" +nextMM+"','"+nextYYYY+"','"+this.gFormat+"'"+")\" ";


	// Setup the page...
	var str = "<table width=183 border=0 cellspacing=0  cellpadding=0 bgcolor=#FFFFFF><!--#F2FDFF-->"+"\n"+
	"  <!--tr>"+"\n"+
	"    <td class=font2><img src=\"/image/cal04.gif\" width=154 heignt=9></td>"+"\n"+
	"  </tr-->"+"\n"+
	"  <!--tr>"+"\n"+
	"  <tr>"+"\n"+
	"    <td align=center>"+"\n"+
	"      <table border=0 width=183 cellpadding=0 cellspacing=1 bgcolor='#DBDBDB'>"+"\n"+
	"        <tr>"+"\n"+
	"  	     <td width=183 align=center>"+"\n"+
	"            <table height=17 align=center border=0 width='100%' cellpadding=0 cellspacing=0 bgcolor='#FFFFFF'>"+"\n"+
	"              <tr>"+"\n"+
	"                <td height=5></td>"+"\n"+
	"              </tr>"+"\n"+
	"              <tr>"+"\n"+
	"                <td width=6></td>"+"\n"+
	"                <td width=15>"+"\n"+
	"                <span style='cursor:hand' onclick="+prevYear+" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('Image10','','/img/common/arrows_1.gif',1)\">"+"\n"+	
	"                <img name=Image10 border=0 src=\"/img/common/arrows_1.gif\"  align=absmiddle></span>"+"\n"+
	"                </td>"+"\n"+
	"                <td width=5></td>"+"\n"+
	"                <td width=15>"+"\n"+
	"                <span style='cursor:hand' onclick="+prevMonth+" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('Image11','','/img/common/arrows_2.gif',1)\">"+"\n"+
	"                <img name=Image11 border=0 src=\"/img/common/arrows_2.gif\" align=absmiddle></span>"+"\n"+
	"                </td>"+"\n"+
	"                <td width=10></td>"+"\n"+
	"                <td width=79 align=center>"+"\n"+
	"                <font color=#00578E class=font2>"+this.gYear+"</font><font class=font2>��</font>&nbsp;<font color=#FF9600 class=font2>"+this.gMonthName+"</font><font class=font2>��</font>"+"\n"+
	"                </td>"+"\n"+
	"                <td width=10></td>"+"\n"+
	"                <td width=15>"+"\n"+
	"                <span style='cursor:hand' onclick="+nextMonth+" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('Image12','','/img/common/arrows_3.gif',1)\">"+"\n"+	
	"                <img name=Image12 border=0 src=\"/img/common/arrows_3.gif\" align=absmiddle></span>"+"\n"+
	"                </td>"+"\n"+
	"                <td width=5></td>"+"\n"+
	"                <td width=15>"+"\n"+
	"                <span style='cursor:hand' onclick="+nextYear+" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage('Image9','','/img/common/arrows_4.gif',1)\">"+"\n"+
	"                <img name=Image9 border=0 src=\"/img/common/arrows_4.gif\" align=absmiddle></span>"+"\n"+
	"                </td>"+"\n"+
	"                <td width=6></td>"+"\n"+
	"              </tr>"+"\n"+
	"              <tr>"+"\n"+
	"                <td colspan=11 height=5></td>"+"\n"+
	"              </tr>"+"\n"+
	"            </table>"+"\n"+
	"          </td>"+"\n"+
	"        </tr>"+"\n"+
	"      </table>"+"\n"+
	"    </td>"+"\n"+
	"  </tr>"+"\n"+
	"  <tr>"+"\n"+
	"    <td align=center valign=middle>"+"\n"+
	this.getMonthlyCalendarCode()+"\n"+	// �޷�ǥ��
	"    </td>"+"\n"+
	"  </tr>"+"\n"+
	"</table>"+"\n";
	document.all['writeDal'].innerHTML = str;
}

//document ��ü�� ���ڿ� ���
Calendar.prototype.wwrite = function(wtext)
{   alert(wtext);
    document.all['writeDal'].innerHTML = wtext;
//    document.write(wtext);
//	this.gWinCal.document.write(wtext);
}


//�޷��ش� HTML�ڵ� ����
Calendar.prototype.calHeader = function()
{
	var vCode = "<tr bgcolor='#59A3E0' class=datacenter>"+"\n"+
	"<td width=25 height=20 class=font>��</td>"+"\n"+
	"<td width=25 height=20 class=font>��</td>"+"\n"+
	"<td width=25 height=20 class=font>ȭ</td>"+"\n"+
	"<td width=25 height=20 class=font>��</td>"+"\n"+
	"<td width=25 height=20 class=font>��</td>"+"\n"+
	"<td width=25 height=20 class=font>��</td>"+"\n"+
	"<td width=25 height=20 class=font>��</td>"+"\n"+
	"</tr>"+"\n";
	return vCode;
}

//�޷� ���� HTML�ڵ� ����
Calendar.prototype.calData = function()
{
	var vDate = new Date();
	vDate.setDate(1);
	vDate.setMonth(this.gMonth);
	vDate.setFullYear(this.gYear);

	var vFirstDay=vDate.getDay();
	var vDay=1;
	var vLastDay=Calendar.getDaysofmonth(this.gMonth, this.gYear);
	var vOnLastDay=0;
	var vCode = "";

	//ù��° �ֳ����� ���ۿ��� ���� �������� ä���.
	vCode = vCode + "<tr class=datacenter>";
	for (i=0; i<vFirstDay; i++)
		vCode = vCode + "<TD " + this.writeWeekendString(i, false) + ">&nbsp; </TD>"+"\n";

	// ù��°���� ���ڸ� ǥ��
	for (j=vFirstDay; j<7; j++)
	{
		vCode = vCode + "<TD " + this.writeWeekendString(j, true) + this.formatDay(vDay) +
		    "onclick=\"returnLast('"+this.formatData(vDay)+"');\" >" +vDay+"</TD>\n";
		vDay=vDay + 1;
	}
	vCode = vCode + "</TR>\n";

	// ���������� ���ڸ� ǥ��
	for (k=2; k<7; k++) {
		vCode = vCode + "<TR class=datacenter>\n";

		for (j=0; j<7; j++) {
			vCode = vCode + "<TD " + this.writeWeekendString(j,true) + this.formatDay(vDay) +
			"onclick=\"returnLast('"+this.formatData(vDay)+"');\" >"+vDay+"</TD>\n";
			vDay=vDay + 1;

			if (vDay > vLastDay) {
				vOnLastDay = 1;
				break;
			}
		}

		if (j == 6)
			vCode = vCode + "</TR>\n";
		if (vOnLastDay == 1)
			break;
	}

	// ���������� ���� ������ �������� ǥ��
	for (m=1; m<(7-j); m++) {
		vCode = vCode + "<TD " + this.writeWeekendString(j+m, false) + ">&nbsp;</TD>\n";
	}

	return vCode;
}

//���糯¥�� ���� Bold ǥ�� ó��
Calendar.prototype.formatDay = function(vday)
{
	var vNowDay = gNow.getDate();
	var vNowMonth = gNow.getMonth();
	var vNowYear = gNow.getFullYear();

	if (vday == vNowDay && this.gMonth == vNowMonth && this.gYear == vNowYear)
		return (" style='font-weight:bold' ");
	else
		return ("");
}


// ���� ������ ����.
Calendar.prototype.writeWeekendString = function(vday, bhand)
{
	var ret= "";
	var id = "gen"; //����
	var overcolor = "#88CBFF";
	var outcolor  = "#FFFFFF";

	if (vday == 0){
		id = "sun"; //��
		outcolor = "FFF7F7";
	}
	else if(vday == 6){
		id = "sat"; //��
		outcolor = "#EFFDFF";
	}

	if(bhand){
		ret = "id=h" + id;
		ret = ret + " onmouseover=SetTdColor('"+overcolor+"')"+
				    " onmouseout=SetTdColor('"+outcolor+"') ";
	}
	else
		ret = " id="+ id + " ";

	return ret;
}

//��¥ ���� ó��
Calendar.prototype.formatData = function(p_day)
{
	var vData;
	var vMonth = 1 + this.gMonth;
	vMonth = (vMonth.toString().length < 2) ? "0" + vMonth : vMonth;
	var vMon = Calendar.getMonth(this.gMonth).substr(0,3).toUpperCase();
	var vFMon = Calendar.getMonth(this.gMonth).toUpperCase();
	var vY4 = new String(this.gYear);
	var vY2 = new String(this.gYear.substr(2,2));
	var vDD = (p_day.toString().length < 2) ? "0" + p_day : p_day;

	switch (this.gFormat) {
		case "YYYY\/MM\/DD" :
			vData = vY4 + "\/" + vMonth + "\/" + vDD;
			break;
		case "YY\/MM\/DD" :
			vData = vY2 + "\/" + vMonth + "\/" + vDD;
			break;
		case "YYYY-MM-DD" :
			vData = vY4 + "-" + vMonth + "-" + vDD;
			break;
		case "YY-MM-DD" :
			vData = vY2 + "-" + vMonth + "-" + vDD;
			break;

		case "YYYY\/MON\/DD" :
			vData = vY4 + "\/" + vMon + "\/" + vDD;
			break;
		case "YY\/MON\/DD" :
			vData = vY2 + "\/" + vMon + "\/" + vDD;
			break;
		case "YYYY-MON-DD" :
			vData = vY4 + "-" + vMon + "-" + vDD;
			break;
		case "YY-MON-DD" :
			vData = vY2 + "-" + vMon + "-" + vDD;
			break;

		case "YYYY\/MONTH\/DD" :
			vData = vY4 + "\/" + vFMon + "\/" + vDD;
			break;
		case "YY\/MONTH\/DD" :
			vData = vY2 + "\/" + vFMon + "\/" + vDD;
			break;
		case "YYYY-MONTH-DD" :
			vData = vY4 + "-" + vFMon + "-" + vDD;
			break;
		case "YY-MONTH-DD" :
			vData = vY2 + "-" + vFMon + "-" + vDD;
			break;

		case "YYYY\/MM\/DD" :
			vData = vY4 + "\/" + vMonth + "\/" + vDD;
			break;
		case "YY\/MM\/DD\/" :
			vData = vY2 + "\/" + vMonth + "\/" + vDD;
			break;
		case "YYYY-DD-MM" :
			vData = vY4 + "-" + vMonth + "-" + vDD;
			break;
		case "YY-MM-DD" :
			vData = vY2 + "-" + vMonth + "-" + vDD;
			break;
		case "YYYYMMDD" :
			vData = vY4 + vMonth + vDD;
			break;
		default :
			vData = vY4 + "-" + vMonth + "-" + vDD;
	}

	return vData;
}
//�޷»���
function Build(pMonth, pYear, pFormat)
{
	var pWinCal = ggWinCal;
	gCal = new Calendar(pWinCal, pMonth, pYear, pFormat);

	gCal.show();
}


function ShowCalendar()
{
	alert( "test") ;
}

//�޷»���
function Build(pMonth, pYear, pFormat)
{
	var pWinCal = ggWinCal;
	gCal = new Calendar(pWinCal, pMonth, pYear, pFormat);

	gCal.show();
    reSize();
}

// �޷�ȭ���� �����ش�.
function ShowCalendar()
{
	/*
	  parameters:
		pMonth : 0-11 for Jan-Dec; 12 for All Months.
		pYear	: 4-digit year
		pFormat: Date format (yyy/mm/dd/, yy/dd/mm/, ...)
		pItem	: Return Item.
	*/


	if (arguments[1] == "" || arguments[1] == null)
		pYear = new String(gNow.getFullYear().toString());
	else
		pYear = arguments[1];

	if (arguments[2] == null)
		pMonth = new String(gNow.getMonth());
	else {
		pMonth = parseInt(arguments[2])-1;
	}

	if (arguments[3] == null)
		pFormat = "YYYY-MM-DD";
	else
		pFormat = arguments[3];

	ggWinCal = self;
	Build(pMonth, pYear, pFormat);
}


//- ���� ��¥ ��� �Լ�
var MinMilli = 1000 * 60;         	//Initialize variables.
var HrMilli = MinMilli * 60;
var DyMilli = HrMilli * 24;

//From ��¥ To ��¥ �ϼ����(��¥������ '/')
function CountIntervalDays(/* fromDate, toDate */)
{
	var fromDate = arguments[0];
	var toDate = arguments[1];

	var interT, fromT, toT;          	//Declare variables.

	fromT = Date.parse(FormatDate(fromDate));    	//Parse fromDate.

	if(toDate == null)					//toDate�� null�� ��� ����������̿� �ϼ����
	{
		d = new Date();
		toT = (new Date(d.getYear(), d.getMonth(), d.getDate())).getTime();
   	}
	else
		toT = Date.parse(FormatDate(toDate));     //Parse toDate.

	if (toT >= fromT)
	  interT = toT - fromT;
	else
	  interT = fromT - toT;

	r = Math.round(interT / DyMilli) + 1;

	return(r);                       	//Return difference.
}

//��¥���� �Ⱓ�� ����Ϸ� ���
function CountIntervalDate(/* fromDate, toDate */)
{
	var fromDate = arguments[0];
	var toDate = arguments[1];

	var fromT, toT, fromY, fromM, fromD, toY, toM, toD;	//Declare variables.

	fromT = Date.parse(FormatDate(fromDate)); 	//Parse fromDate.

	if(toDate == null)						//toDate�� null�� ��� ����������̿� �ϼ����
	{
		d = new Date();
		toT = (new Date(d.getYear(), d.getMonth(), d.getDate())).getTime();
   	}
	else
		toT = Date.parse(FormatDate(toDate));     		//Parse toDate.

	if (toT >= fromT)
	{
		d = new Date();
		d.setTime(toT);
		toY = d.getFullYear();
		toM = d.getMonth()+1;
		toD = d.getDate();
		d.setTime(fromT);
		fromY = d.getFullYear();
		fromM = d.getMonth()+1;
		fromD = d.getDate();
	}
	else
	{
		d = new Date();
		d.setTime(fromT);
		toY = d.getFullYear();
		toM = d.getMonth()+1;
		toD = d.getDate();
		d.setTime(toT);
		fromY = d.getFullYear();
		fromM = d.getMonth()+1;
		fromD = d.getDate();
	}

	return GetIntervalDate(fromY, fromM, fromD, toY, toM, toD);
}

// ����� ���
function GetIntervalDate(fromY, fromM, fromD, toY, toM, toD)
{
/* [ From year/month/date To year/month/date ( From 1999/12/31 To 2001/03/20 ) ]

��� : �� - �� > 2001 - 1999 = 2
���� : �� - �� > �����ϰ��( 3-12 = -9 ) ������� -1�� �ϰ�(2-1=1) 12���� ����(12-9=3)

�ϼ� : �� - �� > ����� ��� �ϼ�+1
               > �����ϰ��( 20-31= -11) �������� -1�� �ϰ�(3-1=2)
                 (To month �����ϼ�-From date �ϼ�) + To date �ϼ� + 1 [ {28(29)-31 = 0} + 20 +1 = 21 ]
                  --------------------------------
                              |
                               ---> �����ϰ�� 0 ���� ó��
               > ���� 1����, �ϼ� 0ó���� ���������� 12 �̸� ��� ������ ���� 0 ó��
                  - From date�� �״��� ù°�� �Ǵ� ������ �����̰�, �ϼ��� To month�� �ϼ��� �������
                  - From date - To date = 1 �ΰ��

��갪 > 1�� 2���� 21�� */

    var y, m, d, ret = "";
    var bIncrease = false;

	fromY = parseInt(fromY);
	fromM = parseInt(fromM);
	fromD = parseInt(fromD);
	toY	  = parseInt(toY);
	toM   = parseInt(toM);
	toD   = parseInt(toD);

    y = toY - fromY;
    m = toM - fromM;
    d = toD - fromD;

    if (m < 0) {
    	y = y - 1;
    	m = 12 + m;
    }

    if (d < 0) {
		m = m - 1;
		prevD = GetPreviousDaysofmonth(toY, toM) - fromD;
		if (prevD < 0)	prevD = 0;
		d = prevD + toD + 1;
    }
    else
		d = d + 1;

	if ( fromD == 1 || fromD == parseInt(CalendarGetDaysofmonth(fromM-1, fromY)) ) //from month �ϼ�
	{
		if ( d == parseInt(CalendarGetDaysofmonth(toM-1, toY))) //To month �ϼ��� �����ϼ� ��
			bIncrease = true;
	}

	if (fromD - toD == 1)	//
		bIncrease = true;

	if (bIncrease) {		//������ ����
		m += 1;
		if ( m == 12) {
			y += 1;
			m = 0;
		}
		d = 0;
	}

	if (y > 0)	ret =  ""+y+"��";
	if (m > 0)	ret += " "+m+"����";
	if (d > 0)	ret += " "+d+"��"

    return ret;
}

//���ϼ� ���
function GetPreviousDaysofmonth(y, m){
	m = m - 1;
	if (m == 0) {
	   m = 12;
	   y = y - 1;
	}
	var days = parseInt(CalendarGetDaysofmonth(m-1, y));
	if(days < 0)	days = 0;

	return days;
}

// ��¥�� �ϼ��� ����ó��(��¥������ '-')
function AddDays(/* days, fromDate */){
	var days = arguments[0];			//�����ϼ�
	var fromDate = arguments[1];

	var curTime;  	    	//Declare variables

	if(days == null)	days = 0;
	else				days = parseInt(days);

	if(fromDate == null)					//fromDate�� null�� ��� ���糯¥���� ����
		curTime = (new Date()).getTime();
	else
		curTime = Date.parse(FormatDate(fromDate));     //Parse toDate.

	var newTime = curTime + (days * DyMilli);
	var newDate = new Date();
	newDate.setTime(newTime);

	var formatDate = ""+newDate.getYear()+'-'+(newDate.getMonth()+1)+'-'+newDate.getDate();

	return(formatDate);                    //Return date
}

// ��¥�� ������ ����ó��(��¥������ '-.')
function AddMonths(/* months, fromDate */)
{
	var months   = arguments[0];			//�����ϼ�
	var fromDate = arguments[1];

	var yy = arguments[1].substring(0,4);
	var mm = arguments[1].substring(5,7);
	var dd = arguments[1].substring(8,10);

	mm = eval(mm) + eval(months);
	if (mm > 13) { 
		yy = eval(yy) + (eval(mm)-eval(mm)%12)/12	
		mm = eval(mm) % 12;
		if (mm == 0) {
			mm = 12;
			yy = yy - 1;
		}
	}

	var sd = CalendarGetDaysofmonth(mm-1,yy);
	if (sd < dd) dd = sd;
	if (mm < 10) mm = "0" + mm;
			
	var formatDate = yy+'-'+mm+'-'+dd;
	return(formatDate);                    //Return date
}

//���ڸ� ���� �޸� Format(��ȭ���ڿ��� ��ȯ)
function FormatCurrency(pstr)
{
	var formatStr = "";
	var str = pstr.toString();

	if(str != null && str.length > 0)
	{
		iLen = str.length;
		iMod = iLen % 3;

		if(iMod > 0)
		{
			formatStr = str.substring(0, iMod);
			if(iLen > 3) formatStr += ",";
		}

		for(i=iMod; i<str.length; i+=3)
		{
			formatStr += str.substring(i, i+3);
			if (i+3 < iLen) formatStr += ",";
		}
	}

	return(formatStr);	//return comma distribute
}

//��¥ ���� üũ�� "YYYY-MM-DD"�������� ��ȯ�Ͽ� ����
function FormatDate(sDate)
{
	sDate = sDate.replace(/\./g, "-");// YYYY.MM.DD ������ YYYY/MM/DD�� ��ȯ
	sDate = sDate.replace(/\\/g, "-");	// YYYY-MM-DD ������ YYYY/MM/DD�� ��ȯ

	if(sDate.length == 8 && !isNaN(sDate))	//YYYYMMDD ������ YYYY/MM/DD�� ��ȯ
	{
		sDate = sDate.substring(0, 4) +"-"+ sDate.substring(4, 6) +"-"+ sDate.substring(6, 8);
	}
	return sDate;
}

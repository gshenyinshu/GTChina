/**
 * Title       : FormatUtil
 * Description : 
 * Copyright   : 
 * Company     : 
 * @author      Lee Sang Mi
 * @version 1.0
 */

package gtone.changeminer.common.utility;

import java.math.BigDecimal;

public  class FormatUtil {

	/**
	*	일반적인 숫자 형식을 단위 숫자 형식으로 바꿔준다.
	*
	*	@param value 받아들이는 숫자
	*	@param thousandSep 천단위로 할 경우 그 구분자 (보통 , 이다)
	*	@param decimalPoint 소수점을 나타낸다 (보통 . 이다)
	*	@param numDecimals 소수점 이하 자릿수를 나타낸다.
	*	@return 변화시킨 단위 숫자 형식의 스트링
	*
	*	ex) (100000, ',', '.', 0) => 100,000
	*		(1000000.1577, ',', '.', 3) => 1,000,000.158
	*		(10, ',', '.', 4) => 10.0000
	*/
	public static String formatBigDecimal(  BigDecimal value, 
                                            char thousandSep, 
                                            char decimalPoint, 
                                            int numDecimals) {
		
		try {
			
	   		if (numDecimals >= 0 && value.scale() != numDecimals) {
	   			
		  		value = value.setScale(numDecimals, BigDecimal.ROUND_HALF_UP);
	   		}
	   
	   		String stringValue = value.toString();
	   		int origLen = stringValue.length();
	   		int decPoint = stringValue.indexOf('.');
	   		int thousandSepCount;
	   		boolean hasDecPoint;
	   		boolean isNegative;
	   		int mag;
	   
	   		if (decPoint < 0) {
	   			
		  		decPoint = origLen;
		  		hasDecPoint = false;
	   		}else {
	   			
		  		////// Eliminate trailing zeros
		  		hasDecPoint = true;
		  		if (numDecimals == -1) {
		  			
			 		while (stringValue.charAt(origLen - 1) == '0') {
			 			
						origLen--;
			 		}
			 		
			 		if (stringValue.charAt(origLen - 1) == '.') {
			 			
						origLen--;
						hasDecPoint = false;
			 		}  
		  		}     
	   		}
	   
	   		if (stringValue.charAt(0) == '-') {
	   			
		  		isNegative = true;      
		  		thousandSepCount = (decPoint-2) / 3;
		  		mag = decPoint - 2;
	   		} 
	   		else {
	   			
		  		isNegative = false;
		  		thousandSepCount = (decPoint-1) / 3;
		  		mag = decPoint - 1;
	   		}  
	   
	   		StringBuffer buf = new StringBuffer(origLen + thousandSepCount);
	   		int srcIndex = 0;
	
	   		if (isNegative) 	{ 
	   			
		  		srcIndex++;
		  		buf.append('-');
	   		}  
	   
	   		////// Kopiere Vorkommastellen und fuege Tausendertrenner ein wo noetig.
	   		while (srcIndex < decPoint) {
	   			
		  		buf.append(stringValue.charAt(srcIndex));
		  		srcIndex++;
		  		
		  		if (mag > 0 && mag % 3 == 0) 
		  			buf.append(thousandSep);
		  		
		  		mag--;
	   		}
	   
	   		////// Kopiere Nachkommastellen
	   		if (hasDecPoint) {
	   			
		  		srcIndex++;
		  		buf.append(decimalPoint);
		  		
		  		while(srcIndex < origLen) {
		  			
			 		buf.append(stringValue.charAt(srcIndex));
			 		srcIndex++;
		  		}
	   		}
	   		
	   		return buf.toString();
	   	}catch(Exception e) {}//////System.out.println(e);}

   		return "";
	}
	
	/**
	*	문자 숫자 형식을 단위 숫자 형식으로 바꿔준다.
	*
	*	@param value 받아들이는 숫자
	*	@return 변화시킨 단위 숫자 형식의 스트링
	*
	*	ex) ("100000") => 100,000
	*/
	public static String formatBigDecimal(String value) {
		
		return formatBigDecimal(value, 0);
	}
	
	/**
	*	문자 숫자 형식을 단위 숫자 형식으로 바꿔준다.문자열길이가 0이면 0으로 줌
	*
	*	@param value 받아들이는 숫자
	*	@return 변화시킨 단위 숫자 형식의 스트링
	*
	*	ex) ("100000") => 100,000
	*/
	public static String format(String value) {
		if ( value==null || value.trim().length()==0 )
            value = "0" ;
		return formatBigDecimal(value, 0);
	}

	/**
	*	문자 숫자 형식을 단위 숫자 형식으로 바꿔준다.
	*
	*	@param value 받아들이는 숫자
	*	@param numDecimals 소수점 이하 자릿수를 나타낸다.
	*	@return 변화시킨 단위 숫자 형식의 스트링
	*
	*	ex) ("100000") => 100,000
	*		(1000000.1577, 3) => 1,000,000.158
	*/
	public static String formatBigDecimal(String value,  int numDecimals) {
		
		if ( value == null)
			return "";
		
		String bit = "";

		if (value.startsWith("+")) {
			bit = value.substring(0, 1);
			value = value.substring(1);
		}
					
		if ( (value.trim().equals("")) || (!isNumber(value)) )
			return value;
				
		value = value.trim();
		
		String data = formatBigDecimal(new BigDecimal(value.trim()), ',', '.', numDecimals);
		
		return bit + data;
	}

	/**
	*	소수점이 없는 문자열로 반환
	*
	*	@param value 받아들이는 숫자
	*	@param numDecimals 소수점 이하 자릿수를 나타낸다.
	*	@return 변화시킨 단위 숫자 형식의 스트링
	*
	*	ex) ("100000") => 100,000
	*		(1000000.1577, 3) => 1000000.158
	*/
	public static String formatDecimal(String value,  int numDecimals) {
		
		if ( value == null)
			return "";
		
		String bit = "";

		if (value.startsWith("+")) {
			bit = value.substring(0, 1);
			value = value.substring(1);
		}
					
		if ( (value.trim().equals("")) || (!isNumber(value)) )
			return value;				
		value = value.trim();

        String data = value ;
        BigDecimal value2 = new BigDecimal(value.trim()) ;

	   	if (numDecimals >= 0 && value2.scale() != numDecimals) {	   		
			value2 = value2.setScale(numDecimals, BigDecimal.ROUND_HALF_UP);
            data = value2.toString() ;
	   	}
		return bit + data;
	}
    
	/**
	* 스트링을 소수점 두자리로 만들어서 넘겨준다.
	*
	* @param in 바꿀 숫자
	* @param i 소수점 이하 자릿수
	* @return 바꾼 숫자
	*/
	public static String comma(String in, int i) {
		
		if (in.trim().equals("")) return "";
		
		String tmp = String.valueOf((double)Integer.parseInt(in) / Math.pow((double)10, (double)i));
		
		return tmp;
	}
	
	/**
	* 숫자인지 아닌지를 체크해준다.<br>
	* 글자와 특수문자를 제외한 모든 것은 숫자로 간주한다.
	*
	* @param c char
	* @return number:true otherwise:false
	*/
	public static boolean isNumber(char c) {
    		
    		if (c>='0' && c<='9')
    			return true;
    		else if ((c>='a' && c<='z') || (c>='A' && c<='Z') || (c>=' ' && c<='/') || (c>=':' && c<='@') || (c>='[' && c<='`') || (c>='{' && c<='~'))
    			return false;
    		else
    			return true;
    }
    
    /**
	* 숫자인지 아닌지를 체크해준다.<br>
	* 글자와 특수문자를 제외한 모든 것은 숫자로 간주한다.
	*
	* @param c char
	* @return number:true otherwise:false
	*/
	private static boolean isNumberInternal(char c) {
		
		
		if (c>='0' && c<='9')
			return true;
		else if ((c>='a' && c<='z') || (c>='A' && c<='Z') || (c>=' ' && c<='/') || (c>=':' && c<='@') || (c>='[' && c<='`') || (c>='{' && c<='~')) {
			if ( c == '.')
				return true;
			else
				return false;
		}
		else
			return false;
	}
    
    	
	/**
	* 숫자인지 아닌지를 체크해준다.<br>
	* 글자와 특수문자를 제외한 모든 것은 숫자로 간주한다.
	*
	* @param c String
	* @return number:true otherwise:false
	*/
	public static boolean isNumber(String c) {
		
		boolean isNum = false;
		
		if ( c == null)
			return false;

		if ( c.trim().equals("") )
			return false;
			
		char[] c_arr = c.trim().toCharArray();
		int i=0;
		if (c_arr[0] == '-' || c_arr[0] == '+')
			i=1;
		for( ; i<c_arr.length; i++) {
			isNum = isNumberInternal(c_arr[i]);
			if ( !isNum )
				return isNum;
		}
		return isNum;		
	}
	
	/**
	 * Minus 인지 확인한다.
	 *
	 * @param data 확인할 데이터
	 * @return boolean true : 마이너스, false : 숫자가 아니거나 마이너스 데이터가 아님
	 */
	public static boolean isMinus(String data) {
		boolean isMinus = false;
		
		if ( isNumber(data)) {
			if ( data.startsWith("-"))
				isMinus = true;
		}
		return isMinus;
	}
	
	
	
	
	/**
	 * 입력받은 date (문자열 20010606) 를
	 * 원하는 formart으로 출력한다.
	 * <p>
	 * 
	 * @param date  날짜 또는 시간
	 * @param formate 형식 예) yyyy-MM-dd HH:mm:ss, yyyy/mm/dd
	 * @return 입력받은 시간의 정규화된 문자열
	 */
	public static String getDateString( String time, String seperator ) {
	   
	   if ( time == null ) return "";
		
		String transtime = "";
		int len = 4;
		//////System.out.println( time.length() );
		if ( time.length() < 3 ) return time;		
		
		if ( time.length() == 4 ) len = 4;
		else if ( time.length() == 6 ) len = 6;
		else if ( time.length() == 8 ) len = 8;
			
		String[] transchar = new String[len];
		
		for ( int i =0 ;i < len ; i++ ) 
		{
			transchar[i] = time.substring(i,i+1);
		}
		
		transtime = 	          transchar[0]
					+ transchar[1]
					+ seperator 
					+ transchar[2]
					+ transchar[3]; 
					
		if ( len == 4 ){
			transtime = 	    transchar[0]
					  + transchar[1]
					  + seperator 
					  + transchar[2]
					  + transchar[3]; 
		} else if ( len == 6  ) {			
			transtime = 	    transchar[0]
					  + transchar[1]
					  + transchar[2]
					  + transchar[3] 
			 		  + seperator
					  + transchar[4]
					  + transchar[5];
		} else if ( len == 8 ) {
			transtime = 	    transchar[0]
					  + transchar[1]
					  + transchar[2]
					  + transchar[3] 
 		   			  + seperator
					  + transchar[4]
					  + transchar[5]
   		 			  + seperator
					  + transchar[6]
					  + transchar[7];
		}	
		return transtime;
	}
	
	/**
	 * 입력받은 date (문자열 20010606) 를
	 * 원하는 formart으로 출력한다.
	 * <p>
	 * 
	 * @param date  날짜 또는 시간
	 * @param formate 형식 예) yyyy-MM-dd HH:mm:ss, yyyy/mm/dd
	 * @return 입력받은 시간의 정규화된 문자열
	 */
	public static String getDateString(String date)
	{
		try
		{
		    String format = ".";	
		    return getDateString( date , format );
		}
		catch(Exception e)
		{
		    return "error";
		}

	}

	


	/**
	 * replace to yyyy년mm월dd일 from yyyymmdd
	 * @param s date string you want to check.
	 * @return String yyyy년mm월dd일
	 */
	public static String replaceKRType(String s) {

		if ( s == null )  {
			System.err.println("date string to check is null");
			return null;
		}

		try {
			if ( anyframe.util.DateTime.isValid(s) == false )  {
				System.err.println("date string to check is null");
				return null;
			}
		} catch ( Exception ex )  {
			System.err.println(ex.getMessage());
			return null;
		}

		int mm = Integer.parseInt(s.substring(4,6));
		int dd = Integer.parseInt(s.substring(6,8));

        return s.substring(0,4)+"년"+mm+"월"+dd+"일";

	}


	/**
	 * replace to yyyy년mm월dd일 from yyyymmdd
	 * @param s date string you want to check.
	 * @return String yyyy년mm월dd일
	 */
	public static String replaceKRMonthType(String s) {

		if ( s == null )  {
			System.err.println("date string to check is null");
			return null;
		}

		try {
			if ( anyframe.util.DateTime.isValid(s, "yyyymm") == false )  {
				System.err.println("date string to check is null");
				return null;
			}
		} catch ( Exception ex )  {
			System.err.println(ex.getMessage());
			return null;
		}

		int mm = Integer.parseInt(s.substring(4,6));

        return s.substring(0,4)+"년"+mm+"월";
	}
}

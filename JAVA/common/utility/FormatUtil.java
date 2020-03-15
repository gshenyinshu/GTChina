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
	*	�3�1�0�5�3�4�3�7 �2�0�3�1 �6�8�2�8�3�5 �9�3�3�1 �2�0�3�1 �6�8�2�8�3�7�0�9 �0�1�8�5�3�9�9�9.
	*
	*	@param value �0�8�2�3�9�1�3�3�8�9 �2�0�3�1
	*	@param thousandSep �4�3�9�3�3�1�0�9 �6�7 �7�4�3�7 �8�9 �7�9�1�9�3�1 (�1�5�5�8 , �3�3�9�9)
	*	@param decimalPoint �2�1�2�1�3�9�3�5 �8�1�5�3�8�3�9�9 (�1�5�5�8 . �3�3�9�9)
	*	@param numDecimals �2�1�2�1�3�9 �3�3�6�9 �3�1�0�4�2�1�0�7 �8�1�5�3�8�3�9�9.
	*	@return �1�3�6�1�2�7�5�9 �9�3�3�1 �2�0�3�1 �6�8�2�8�3�5 �2�1�5�7�0�6
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
	*	�0�1�3�1 �2�0�3�1 �6�8�2�8�3�5 �9�3�3�1 �2�0�3�1 �6�8�2�8�3�7�0�9 �0�1�8�5�3�9�9�9.
	*
	*	@param value �0�8�2�3�9�1�3�3�8�9 �2�0�3�1
	*	@return �1�3�6�1�2�7�5�9 �9�3�3�1 �2�0�3�1 �6�8�2�8�3�5 �2�1�5�7�0�6
	*
	*	ex) ("100000") => 100,000
	*/
	public static String formatBigDecimal(String value) {
		
		return formatBigDecimal(value, 0);
	}
	
	/**
	*	�0�1�3�1 �2�0�3�1 �6�8�2�8�3�5 �9�3�3�1 �2�0�3�1 �6�8�2�8�3�7�0�9 �0�1�8�5�3�9�9�9.�0�1�3�1�2�9�8�3�3�3�7�5 0�3�3�0�5 0�3�7�0�9 �3�1
	*
	*	@param value �0�8�2�3�9�1�3�3�8�9 �2�0�3�1
	*	@return �1�3�6�1�2�7�5�9 �9�3�3�1 �2�0�3�1 �6�8�2�8�3�5 �2�1�5�7�0�6
	*
	*	ex) ("100000") => 100,000
	*/
	public static String format(String value) {
		if ( value==null || value.trim().length()==0 )
            value = "0" ;
		return formatBigDecimal(value, 0);
	}

	/**
	*	�0�1�3�1 �2�0�3�1 �6�8�2�8�3�5 �9�3�3�1 �2�0�3�1 �6�8�2�8�3�7�0�9 �0�1�8�5�3�9�9�9.
	*
	*	@param value �0�8�2�3�9�1�3�3�8�9 �2�0�3�1
	*	@param numDecimals �2�1�2�1�3�9 �3�3�6�9 �3�1�0�4�2�1�0�7 �8�1�5�3�8�3�9�9.
	*	@return �1�3�6�1�2�7�5�9 �9�3�3�1 �2�0�3�1 �6�8�2�8�3�5 �2�1�5�7�0�6
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
	*	�2�1�2�1�3�9�3�3 �2�3�8�9 �0�1�3�1�2�9�0�9 �0�5�6�5
	*
	*	@param value �0�8�2�3�9�1�3�3�8�9 �2�0�3�1
	*	@param numDecimals �2�1�2�1�3�9 �3�3�6�9 �3�1�0�4�2�1�0�7 �8�1�5�3�8�3�9�9.
	*	@return �1�3�6�1�2�7�5�9 �9�3�3�1 �2�0�3�1 �6�8�2�8�3�5 �2�1�5�7�0�6
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
	* �2�1�5�7�0�6�3�5 �2�1�2�1�3�9 �9�3�3�1�0�5�0�9 �0�7�9�1�2�5�1�9 �8�9�7�3�3�9�9�9.
	*
	* @param in �0�1�8�5 �2�0�3�1
	* @param i �2�1�2�1�3�9 �3�3�6�9 �3�1�0�4�2�1
	* @return �0�1�8�1 �2�0�3�1
	*/
	public static String comma(String in, int i) {
		
		if (in.trim().equals("")) return "";
		
		String tmp = String.valueOf((double)Integer.parseInt(in) / Math.pow((double)10, (double)i));
		
		return tmp;
	}
	
	/**
	* �2�0�3�1�3�7�3�1 �2�3�9�5�3�1�0�7 �4�7�5�9�6�7�3�9�9�9.<br>
	* �8�7�3�1�2�5 �5�8�2�1�0�1�3�1�0�7 �3�1�3�1�6�3 �0�7�9�7 �7�6�3�1 �2�0�3�1�0�9 �7�9�3�5�6�3�9�9.
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
	* �2�0�3�1�3�7�3�1 �2�3�9�5�3�1�0�7 �4�7�5�9�6�7�3�9�9�9.<br>
	* �8�7�3�1�2�5 �5�8�2�1�0�1�3�1�0�7 �3�1�3�1�6�3 �0�7�9�7 �7�6�3�1 �2�0�3�1�0�9 �7�9�3�5�6�3�9�9.
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
	* �2�0�3�1�3�7�3�1 �2�3�9�5�3�1�0�7 �4�7�5�9�6�7�3�9�9�9.<br>
	* �8�7�3�1�2�5 �5�8�2�1�0�1�3�1�0�7 �3�1�3�1�6�3 �0�7�9�7 �7�6�3�1 �2�0�3�1�0�9 �7�9�3�5�6�3�9�9.
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
	 * Minus �3�7�3�1 �6�2�3�7�6�3�9�9.
	 *
	 * @param data �6�2�3�7�6�7 �9�9�3�3�5�5
	 * @return boolean true : �0�3�3�3�8�3�2�1, false : �2�0�3�1�7�5 �2�3�9�1�7�7�8�1 �0�3�3�3�8�3�2�1 �9�9�3�3�5�5�7�5 �2�3�9�7
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
	 * �3�0�0�4�0�8�3�1 date (�0�1�3�1�2�9 20010606) �0�7
	 * �3�9�6�9�8�9 formart�3�7�0�9 �4�9�0�4�6�3�9�9.
	 * <p>
	 * 
	 * @param date  �8�9�3�9 �9�1�8�9 �2�7�7�9
	 * @param formate �6�8�2�8 �2�9) yyyy-MM-dd HH:mm:ss, yyyy/mm/dd
	 * @return �3�0�0�4�0�8�3�1 �2�7�7�9�3�5 �3�4�8�1�6�1�9�1 �0�1�3�1�2�9
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
	 * �3�0�0�4�0�8�3�1 date (�0�1�3�1�2�9 20010606) �0�7
	 * �3�9�6�9�8�9 formart�3�7�0�9 �4�9�0�4�6�3�9�9.
	 * <p>
	 * 
	 * @param date  �8�9�3�9 �9�1�8�9 �2�7�7�9
	 * @param formate �6�8�2�8 �2�9) yyyy-MM-dd HH:mm:ss, yyyy/mm/dd
	 * @return �3�0�0�4�0�8�3�1 �2�7�7�9�3�5 �3�4�8�1�6�1�9�1 �0�1�3�1�2�9
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
	 * replace to yyyy�8�3mm�3�3dd�3�1 from yyyymmdd
	 * @param s date string you want to check.
	 * @return String yyyy�8�3mm�3�3dd�3�1
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

        return s.substring(0,4)+"�8�3"+mm+"�3�3"+dd+"�3�1";

	}


	/**
	 * replace to yyyy�8�3mm�3�3dd�3�1 from yyyymmdd
	 * @param s date string you want to check.
	 * @return String yyyy�8�3mm�3�3dd�3�1
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

        return s.substring(0,4)+"�8�3"+mm+"�3�3";
	}
}

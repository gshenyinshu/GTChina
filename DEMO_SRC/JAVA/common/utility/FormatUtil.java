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
	*	�Ϲ����� ���� ������ ���� ���� �������� �ٲ��ش�.
	*
	*	@param value �޾Ƶ��̴� ����
	*	@param thousandSep õ������ �� ��� �� ������ (���� , �̴�)
	*	@param decimalPoint �Ҽ����� ��Ÿ���� (���� . �̴�)
	*	@param numDecimals �Ҽ��� ���� �ڸ����� ��Ÿ����.
	*	@return ��ȭ��Ų ���� ���� ������ ��Ʈ��
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
	*	���� ���� ������ ���� ���� �������� �ٲ��ش�.
	*
	*	@param value �޾Ƶ��̴� ����
	*	@return ��ȭ��Ų ���� ���� ������ ��Ʈ��
	*
	*	ex) ("100000") => 100,000
	*/
	public static String formatBigDecimal(String value) {
		
		return formatBigDecimal(value, 0);
	}
	
	/**
	*	���� ���� ������ ���� ���� �������� �ٲ��ش�.���ڿ����̰� 0�̸� 0���� ��
	*
	*	@param value �޾Ƶ��̴� ����
	*	@return ��ȭ��Ų ���� ���� ������ ��Ʈ��
	*
	*	ex) ("100000") => 100,000
	*/
	public static String format(String value) {
		if ( value==null || value.trim().length()==0 )
            value = "0" ;
		return formatBigDecimal(value, 0);
	}

	/**
	*	���� ���� ������ ���� ���� �������� �ٲ��ش�.
	*
	*	@param value �޾Ƶ��̴� ����
	*	@param numDecimals �Ҽ��� ���� �ڸ����� ��Ÿ����.
	*	@return ��ȭ��Ų ���� ���� ������ ��Ʈ��
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
	*	�Ҽ����� ���� ���ڿ��� ��ȯ
	*
	*	@param value �޾Ƶ��̴� ����
	*	@param numDecimals �Ҽ��� ���� �ڸ����� ��Ÿ����.
	*	@return ��ȭ��Ų ���� ���� ������ ��Ʈ��
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
	* ��Ʈ���� �Ҽ��� ���ڸ��� ���� �Ѱ��ش�.
	*
	* @param in �ٲ� ����
	* @param i �Ҽ��� ���� �ڸ���
	* @return �ٲ� ����
	*/
	public static String comma(String in, int i) {
		
		if (in.trim().equals("")) return "";
		
		String tmp = String.valueOf((double)Integer.parseInt(in) / Math.pow((double)10, (double)i));
		
		return tmp;
	}
	
	/**
	* �������� �ƴ����� üũ���ش�.<br>
	* ���ڿ� Ư�����ڸ� ������ ��� ���� ���ڷ� �����Ѵ�.
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
	* �������� �ƴ����� üũ���ش�.<br>
	* ���ڿ� Ư�����ڸ� ������ ��� ���� ���ڷ� �����Ѵ�.
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
	* �������� �ƴ����� üũ���ش�.<br>
	* ���ڿ� Ư�����ڸ� ������ ��� ���� ���ڷ� �����Ѵ�.
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
	 * Minus ���� Ȯ���Ѵ�.
	 *
	 * @param data Ȯ���� ������
	 * @return boolean true : ���̳ʽ�, false : ���ڰ� �ƴϰų� ���̳ʽ� �����Ͱ� �ƴ�
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
	 * �Է¹��� date (���ڿ� 20010606) ��
	 * ���ϴ� formart���� ����Ѵ�.
	 * <p>
	 * 
	 * @param date  ��¥ �Ǵ� �ð�
	 * @param formate ���� ��) yyyy-MM-dd HH:mm:ss, yyyy/mm/dd
	 * @return �Է¹��� �ð��� ����ȭ�� ���ڿ�
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
	 * �Է¹��� date (���ڿ� 20010606) ��
	 * ���ϴ� formart���� ����Ѵ�.
	 * <p>
	 * 
	 * @param date  ��¥ �Ǵ� �ð�
	 * @param formate ���� ��) yyyy-MM-dd HH:mm:ss, yyyy/mm/dd
	 * @return �Է¹��� �ð��� ����ȭ�� ���ڿ�
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
	 * replace to yyyy��mm��dd�� from yyyymmdd
	 * @param s date string you want to check.
	 * @return String yyyy��mm��dd��
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

        return s.substring(0,4)+"��"+mm+"��"+dd+"��";

	}


	/**
	 * replace to yyyy��mm��dd�� from yyyymmdd
	 * @param s date string you want to check.
	 * @return String yyyy��mm��dd��
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

        return s.substring(0,4)+"��"+mm+"��";
	}
}

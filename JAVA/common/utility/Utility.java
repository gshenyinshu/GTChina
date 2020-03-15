/**
 * Title       : Utility
 * Description : MyLp.com Utility
 * Copyright   : Copyright (c) 2004
 * Company     : CyberImagination 
 * @author Dong-hyun Sohn
 * @version 1.0
 */

package gtone.changeminer.common.utility;

import java.io.*;
import java.text.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import anyframe.data.DataSet;

public  class Utility
{
	public static int getThisYear()
	{
		Calendar cal = Calendar.getInstance();
		return cal.get(cal.YEAR);
	}

	public static int getThisMonth()
	{
		String today = getToday();
		return Integer.parseInt(today.substring(5,7));
	}

	public static String replaceStr(String line, String oldString, String newString)
	{
		for(int index = 0;(index = line.indexOf(oldString, index)) >= 0; index += newString.length())
			line = line.substring(0, index) + newString + line.substring(index + oldString.length());
		return line ;
	}
	public static String replaceStr(String line, String oldString, int newInt)
	{
		return replaceStr(line, oldString, String.valueOf(newInt));
	}
	
	//////	javascript, jdk1.4's str.split(d);
	public static String[] split(String str, String d)
	{
		ArrayList list = new ArrayList();

		int dLen = d.length();

		if (str.indexOf(d) == -1)
			list.add(str);
		else
			while (str.indexOf(d) != -1)
			{
				list.add(str.substring(0, str.indexOf(d)));
				str = str.substring(str.indexOf(d) + dLen);
				if (str.indexOf(d) == -1)
					list.add(str);
			}
		
		String[] array = new String[list.size()];
		list.toArray(array);
		
		return array;
	}
	
	//////	oracle nvl()
	public static String nvl(String str, String def)
	{
		def = (def == null)? "": def;
		return (str == null || str.trim().equals(""))?def:str;
	}

	public static String nvl(String str, int def)
	{
		return nvl(str, String.valueOf(def));
	}

	public static String nvl(String str)
	{
		return nvl(str, "");
	}

	//////	nvl()handing
	public static int nvlToNumber(String str, int def)
	{
		return Integer.parseInt(nvl(str, String.valueOf(def)));
	}

	//////	number & boolean = 0 : false, 1 : true
	public static boolean toBoolean(String str)
	{
		try
		{
			int number = 0;
			if (str != null && !str.trim().equals(""))
				number = Integer.parseInt(str);

			return toBoolean(number);
		}
		catch (NumberFormatException ne)
		{
			return false;
		}
	}
	
	public static boolean toBoolean(int i)
	{
		if (i < 1)
			return false;
		else
			return true;
	}


	public static String toNumberFormat(String str)
	{
		if (str == null || str.trim().equals(""))
			return str;

		String pre  = str;
		String post = "";

		if (str.indexOf(".") != -1)
		{
			pre  = str.substring(0, str.indexOf("."));
			post = str.substring(str.indexOf(".") + 1);
		}
		pre = toMoneyType(pre, ",");

		return (post.trim().equals(""))?pre:(pre += "." + post);
	}

	public static String toMoneyType2(String str, String delim)
	{
		int mod = str.length() % 3;

		StringBuffer sb = new StringBuffer(str);
		for (int i = mod, j = 0; i < str.length(); i++)
			if (i > 0 && i % 3 == mod)
			{
				sb.insert(i + j, delim);
				j++;
			}

		return sb.toString();
	}

	public static String toMoneyType(String str, String delim)
	{
		DecimalFormat df = new DecimalFormat();
		DecimalFormatSymbols dfs = new DecimalFormatSymbols();

		dfs.setGroupingSeparator(delim.charAt(0));
		df.setGroupingSize(3);
		df.setDecimalFormatSymbols(dfs);

		return (df.format(Double.parseDouble(str))).toString();
	}
/*	//////
	public static void setDatasetFromRequest(DataSet input, HttpServletRequest request)
	{
		Enumeration enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements())
		{
			String name  = (String)enumeration.nextElement();
			String value = request.getParameter(name);
			input.put(name, value);
		}
	}
*/
	//////	request.getParameterNames() -> String[] names
	public static String[] getParameterNames(HttpServletRequest request)
	{
		Enumeration enumeration = request.getParameterNames();
		ArrayList list = new ArrayList();
		while (enumeration.hasMoreElements())
			list.add(enumeration.nextElement());

		String[] names = new String[list.size()];
		list.toArray(names);

		return names;
	}

	public static String getToday()
	{
		return getToday("yyyy-MM-dd HH:mm");
	}
	
	public static String getToday(String format)
	{
/*		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date         date = new Date();

		return format.format(date);
*/
		Calendar   calendar   = Calendar.getInstance();
		DateFormat dateFormat = new SimpleDateFormat(format);

		return dateFormat.format(calendar.getTime());
	}

	public static boolean over24Hours(String once)
	{
		String today = getToday();

		int year    = Integer.parseInt(once.substring(0,4));
		int month   = Integer.parseInt(once.substring(5,7));
		int day     = Integer.parseInt(once.substring(8,10));
		int hour    = Integer.parseInt(once.substring(11,13));
		int minute  = Integer.parseInt(once.substring(14,16));

		int nyear   = Integer.parseInt(today.substring(0,4));
		int nmonth  = Integer.parseInt(today.substring(5,7));
		int nday    = Integer.parseInt(today.substring(8,10));
		int nhour   = Integer.parseInt(today.substring(11,13));
		int nminute = Integer.parseInt(today.substring(14,16));

		if (  (nyear  - year)  * 12 * 31 * 24 * 60
			+ (nmonth - month) * 31 * 24 * 60
			+ (nday   - day)   * 24 * 60
			+ (nhour  - hour)  * 60
			+ nminute - minute                     < 24 * 60)
			return false;
		else
			return true;
	}
	
	public String toText(String str)
	{
		char[] chars = str.toCharArray();
		
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < chars.length; i++)
		{
			if (chars[i] == '%')
				buffer.append("&#37");

			else if (chars[i] == '<')
				buffer.append("&lt;");
			
			else if (chars[i] == '>')
				buffer.append("&gt;");
			
			else if (chars[i] == '&')
				buffer.append("&amp;");
			
			else
				buffer.append(chars[i]);
		}
		return buffer.toString();
	}

	public static String addComma(String org) {
	
		String oldStr = "0";
		String newStr  = "";
		
		if (org!=null){
			oldStr = org;
		}
	
		 
	
		int length = oldStr.length();
		int cntOfComma = length/3;
		int matchValue = length%3;
		
		if (matchValue == 0 ) {
			cntOfComma --;
			matchValue = 3;
		}
	
		for(int i = 0 ; i<=(cntOfComma*3) ; i = i+3){
			
			String temp = null;
			
			if (i == (cntOfComma)*3){
				temp = oldStr.substring(0,matchValue);
			} else {
				temp = ","+oldStr.substring(oldStr.length()-3-i, oldStr.length()-i);
			}
			
			newStr  = temp + newStr;
	   }
		
		return newStr;
	}
	
    public static String toTel(String str){
        String retVal = "";
        int dLen = 0;
        try{
            dLen = str.length();
            if (str.substring(0, 2).equals("02") && dLen == 9) {
                retVal = str.substring(0, 2) + "-" + str.substring(2, 5) + "-" + str.substring(5, dLen);
            } else if (str.substring(0, 2).equals("02") && dLen == 10) {
                retVal = str.substring(0, 2) + "-" + str.substring(2, 6) + "-" + str.substring(6, dLen);
            } else if (dLen == 10 && !str.substring(0, 2).equals("02")) {
                retVal = str.substring(0, 3) + "-" + str.substring(3, 6) + "-" + str.substring(6, dLen);
            } else  if (dLen == 11){
                retVal = str.substring(0, 3) + "-" + str.substring(3, 7) + "-" + str.substring(7, dLen);
            }    
        }catch(Exception e) { 
        }
        return retVal;
    }	


    /**
     * Comment 
     *
     * @param   String.
     * @param   Date format yyyymmdd
     * @return  String.
     */
    public static String replaceDate(String s) {
        String sY  = s.substring(0,4);
        String sM  = s.substring(4,6);
        String sD  = s.substring(6,8);
        
        return sY+"-"+sM+"-"+sD;
    }
    

    /**
     * Comment 
     *
     * @param   String.
     * @param   Date format yyyymmdd
     * @return  String.
     */
    public static String cut(String s, int len) {
        return cut(s, len, "...");
    }

    /**
     * Comment 
     *
     * @param   String.
     * @param   Date format yyyymmdd
     * @return  String.
     */
    public static String cut(String s, int len, String prefix) {
        if (s == null) return null;

        s = s.trim();
        if (s.equals("")) return s;

        int l = s.length();
        if (0 >= len) return "";
        if (l <  len) return s;

        return s.substring(0, len) + prefix;
    }

    /**
     * Comment 
     *
     * @param   String.
     * @param   Date format yyyymmdd
     * @return  String.
     */
    public static String replace(String s, String oldStr, String newStr) {
        int len = s.length() + (newStr.length() - oldStr.length()) *
            (s.length() / oldStr.length());
        StringBuffer r = new StringBuffer(len);

        int pos = 0;
        int index = 0;

        while ((pos = s.indexOf(oldStr, index)) != -1) {
            r.append(s.substring(index, pos));
            r.append(newStr);
            index = pos + oldStr.length();
        }
        r.append(s.substring(index));

        return r.toString();
    }
    
    
	/**
	 * Change phone number
	 * @param sPN : String
	 * @return String
	 */
    public static String changPhonNumber(String sPN) throws java.text.ParseException {
        String sFirst   = "";
        String sMiddle  = "";
        String sLast    = sPN.substring(sPN.length()-4,sPN.length());

        if (sPN.substring(0,2).equals("02")){
            if (sPN.length() == 9){
                sFirst  = sPN.substring(0,2);
                sMiddle = sPN.substring(2,5);
            }else{
                sFirst  = sPN.substring(0,2);
                sMiddle = sPN.substring(2,6);
            }
        }else{
            if (sPN.length() == 10){
                sFirst  = sPN.substring(0,3);
                sMiddle = sPN.substring(3,6);
            }else{
                sFirst  = sPN.substring(0,3);
                sMiddle = sPN.substring(3,7);
            }    
        }
        return sFirst+"-"+sMiddle+"-"+sLast;
    }
	/**
	 * Comment
	 * return days between two date strings with default defined format.("yyyy-MM-dd")
	 * @param String from date string(param)
	 * @param String to date string(param)
	 * @return int value
	 *           java.text.ParseException 
	 */
    public static int daysBetween(String from, String to) throws java.text.ParseException {
        return daysBetween(from, to, "yyyy-MM-dd");
    }

	/**
	 * Comment
	 * return days between two date strings with default defined format.("yyyy-MM-dd")
	 * @param String from date string(param)
	 * @param String to date string(param)
	 * @return int value
	 *           java.text.ParseException 
	 */

    public static int daysBetween(String from, String to, String format) throws java.text.ParseException {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
        java.util.Date d1 = check(from, format);
        java.util.Date d2 = check(to, format);

        long duration = d2.getTime() - d1.getTime();

        return (int)( duration/(1000 * 60 * 60 * 24) );
        ////// seconds in 1 day
    }

	/**
	 * Comment
	 * @param   s           String ex) "2003-02-02"
	 * @param   format      String ex) "yyyy-MM-dd"
     * @return  date        java.util.Date
	 */
	public static java.util.Date check(String s, String format) throws java.text.ParseException {
		if ( s == null )
			throw new java.text.ParseException("date string to check is null", 0);
		if ( format == null )
			throw new java.text.ParseException("format string to check date is null", 0);

		java.text.SimpleDateFormat formatter =
            new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
		java.util.Date date = null;
		try {
			date = formatter.parse(s);
		}
		catch(java.text.ParseException e) {
            throw new java.text.ParseException(" wrong date:\"" + s +
            "\" with format \"" + format + "\"", 0);
		}

		if ( ! formatter.format(date).equals(s) )
			throw new java.text.ParseException(
				"Out of bound date:\"" + s + "\" with format \"" + format + "\"",
				0
			);
        return date;
	}
	
	//////Comment
	public static String addDay(int addnum)
	{
		int curYear=0, curMonth= 0, curDate= 0;
		Calendar origin = Calendar.getInstance(); 
		origin.add(origin.DATE,addnum);
		curYear= origin.get(origin.YEAR);
		curMonth= origin.get(origin.MONTH)+1;
		curDate= origin.get(origin.DATE);
		
		String cur_Year =curYear + "";
		String cur_Month = curMonth + "";
			if (curMonth < 10){
				cur_Month = "0" + cur_Month;
			}
		String cur_Date = curDate + "";
			if (curDate < 10){
				cur_Date = "0" + curDate;
			}	
			String addDay = cur_Year + cur_Month + cur_Date;	
			return addDay;
	}




	/**
	* tag lib
	* @param src
	* @param pattern ex) a, font ...
	*/
	public static String delTag(String str, String pattern)
    {
        int addE = 0;        ////// comment
        int addS = 0;        ////// StringBuffer append  
        StringBuffer result = new StringBuffer();       
        String lowerStr = str.toLowerCase();            
        pattern = pattern.toLowerCase();                
        
        while((addE = lowerStr.indexOf("<"+pattern, addS)) >= 0){
            result.append(str.substring(addS, addE));
            addS = lowerStr.indexOf(">", addE) + 1;
            if ((addE = lowerStr.indexOf("</"+pattern+">", addS)) >= 0){
                result.append(str.substring(addS, addE));
                addS = addE + ("</"+pattern+">").length();
            }
        }
        result.append(str.substring(addS)); 
        return result.toString();
    }


	public static String delTagImg(String str, String pattern)
    {
        int addE = 0;        
        int addS = 0;        
        StringBuffer result = new StringBuffer();       
        String lowerStr = str.toLowerCase();            
        pattern = pattern.toLowerCase();                
        
        while((addE = lowerStr.indexOf("<"+pattern, addS)) >= 0)
        {
            result.append(str.substring(addS, addE));
            addS = lowerStr.indexOf(">", addE) + 1;
            if ((addE = lowerStr.indexOf(">", addS)) >= 0)
            {
                result.append(str.substring(addS, addE));
                addS = addE;
            }
        }
		

        result.append(str.substring(addS)); 
        return result.toString();
    }

	public static String selectToText(String html)
	{
	
		StringBuffer buffer = new StringBuffer();
		try
		{
		char[] chars = html.toCharArray();

		int selectStartIndex = html.length();
		int selectEndIndex   = html.length();
		for (int i = 0; i < chars.length; i++)
		{
			char c = chars[i];
			
			String tag = "";
			String optionHtml = "";
			String value = "";

			if (c == '<')
			{
				int endIndex  = html.indexOf(">", i);
				int endIndex2 = html.indexOf(" ", i);

				if (endIndex > endIndex2 && endIndex2 != -1)
					endIndex = endIndex2;

			//////	System.out.println("[" + (i + 1) + " - " + endIndex + "]");
				tag = html.substring(i + 1, endIndex);
			//////	System.out.println(tag);
			}

			if (tag.toLowerCase().equals("select"))
			{
				selectStartIndex = i;
				selectEndIndex = html.indexOf("</select>", i);

				optionHtml = html.substring(html.indexOf(">", i) + 1, selectEndIndex);
				value = getSelectedValue(optionHtml);

				selectEndIndex += 8;
			}
			else
			{
				selectStartIndex = html.length();
				selectEndIndex   = html.length();
			}

		//////	System.out.println("i : " + i + "	selectStartIndex : " + selectStartIndex + "	selectEndIndex : " + selectEndIndex + "	c : " + c);
			if (i < selectStartIndex || i > selectEndIndex)
			{
			//////	System.out.println("i : " + i + "	c : " + c);
				buffer.append(c);
			}

			else if (i == selectStartIndex)
				buffer.append(value);
		}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return buffer.toString();
	}

	static String getSelectedValue(String optionHtml)
	{
		String[] tempOptions = split(optionHtml, "</option>");
		String defaultValue = "";
		for (int i = 0; i < tempOptions.length - 1; i++)
		{
			String tempOption   = tempOptions[i];
			String attributeStr = tempOption.substring(0, tempOption.indexOf(">"));
			String value        = tempOption.substring(tempOption.indexOf(">") + 1).trim();

			if (i == 0 || attributeStr.indexOf("selected") != -1)
				defaultValue = value;
		}

		return defaultValue;
	}

	/**
	*
	* Parameters:
	* inDayForm  -  ex) yyyyMMdd -> 20080115 or yyyy-MM-dd -> 2008-01-15 
	* outDayForm - inDayForm 
	* day        - date
	*/
	public static String getMakeDay(String inDayForm, String outDayForm, String day) throws Exception
		{
	  //////DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Calendar   calendar   = Calendar.getInstance();
			DateFormat inDateFormat = new SimpleDateFormat(inDayForm);
			DateFormat outDateFormat = new SimpleDateFormat(outDayForm);
			ParsePosition pos = new ParsePosition ( 0 );
		Date transition_day = inDateFormat.parse(day, pos);
			return outDateFormat.format(transition_day);
	}
	
	
	public static String callLegacy(String PGM_ID) throws Exception
		{
	  
			return "COBOL_PGM";
	}
	
	
}

